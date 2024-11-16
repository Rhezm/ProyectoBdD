create sequence genera_id_boleta
    increment by 1
    maxvalue 999999
    minvalue 1
    nocache 
nocycle;

---------------------------------------------------------------------------------------------
 
create or replace function f_jrsg_genera_boleta (
    p_id_venta in number   -- id de la venta para generar la boleta
) return number   -- retorna el id de la boleta generada
as
    v_id_boleta number;         -- id generado para la boleta
    v_id_cliente number;        -- id del cliente asociado a la venta
    v_fecha_venta date;         -- fecha de la venta
    v_monto_total number;       -- monto total de la venta
    v_valor_neto number;        -- valor neto (sin iva)
    v_total_iva number;         -- total del iva (19% del neto)
    v_id_pago number;           -- id del pago asociado a la venta
    v_tipo_pago varchar2(25);   -- método de pago utilizado
begin
    -- verificar si la venta existe
    select id_cliente, fecha_venta into v_id_cliente, v_fecha_venta
    from jrsg_venta
    where id_venta = p_id_venta;

    -- obtener el monto total y el id del pago asociado a la venta
    select p.id_pago, sum(dvp.cantidad * prod.precio) as "monto_total" into v_id_pago, v_monto_total
    from jrsg_detalle_venta_producto dvp
    join jrsg_producto prod on dvp.id_producto = prod.id_producto
    join jrsg_pago p on p.id_venta = dvp.id_venta
    where dvp.id_venta = p_id_venta
    group by p.id_pago;

    -- calcular el valor neto y el total del iva
    v_valor_neto := round(v_monto_total / 1.19, 1);  -- valor neto sin iva
    v_total_iva := round(v_monto_total - v_valor_neto, 2); -- iva (19%)

    -- obtener el método de pago
    select tp.nombre_metodo_pago into v_tipo_pago
    from jrsg_pago p
    join jrsg_tipo_pago tp on p.id_tipo_pago = tp.id_tipo_pago
    where p.id_pago = v_id_pago;

    -- generar un nuevo id para la boleta
    select genera_id_boleta.nextval into v_id_boleta 
    from dual;

    -- insertar la boleta con valores adicionales
    insert into jrsg_boleta (id_boleta, id_cliente, id_venta, id_pago, fecha_boleta, valor_neto, total_iva) 
        values (v_id_boleta, v_id_cliente, p_id_venta, v_id_pago, sysdate, v_valor_neto, v_total_iva);
    commit;

    -- retornar el id de la boleta generada
    return v_id_boleta;
    dbms_output.put_line('boleta generada exitosamente con id: ' || v_id_boleta);
    dbms_output.put_line('método de pago: ' || v_tipo_pago || ' | monto total: ' || v_monto_total);

exception
    when no_data_found then
        raise_application_error(+100, 'la venta con id ' || p_id_venta || ' no existe.');
    when program_error then
        raise_application_error(-6501, 'error de programa');
    rollback;
end;
