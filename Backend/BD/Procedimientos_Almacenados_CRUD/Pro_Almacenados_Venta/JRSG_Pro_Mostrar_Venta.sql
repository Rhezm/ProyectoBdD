create or replace procedure JRSG_Pro_Mostrar_Venta (
    id_venta_p in number
)is
    contador number;
    v_id_cliente number;
    v_nombre_cliente varchar2(20);
    v_fecha_venta date;
begin
    select count(*) into contador from JRSG_Venta where id_venta = id_venta_p;

    if (contador > 0) then
        select id_cliente, fecha_venta into v_id_cliente, v_fecha_venta
        from JRSG_Venta where id_venta = id_venta_P;

        select nombre_cliente into v_nombre_cliente
        from JRSG_Cliente where id_cliente = v_id_cliente;

        dbms_output.put_line('Informacion Venta ID: ' || id_venta_p || CHR(10) ||
                            'Nombre Cliente: ' || v_nombre_cliente || CHR(10) ||
                            'Fecha Venta: ' || v_fecha_venta );
    else
        dbms_output.put_line ('No se han encontrado Ventas en el sistema.');
    end if;

    COMMIT;

    exception
        when others then
            raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
            
    ROLLBACK;
end;
