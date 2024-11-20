create or replace procedure jrsg_pro_registrar_venta (
    p_id_cliente in number,       -- cliente que realiza la compra
    p_productos in sys_refcursor -- cursor con productos y cantidades
) as
    v_id_venta number;         -- id de la venta generada
    v_stock_actual number;     -- stock actual del producto
    v_id_producto number;      -- id del producto
    v_cantidad number;         -- cantidad solicitada del producto
begin
    lock table jrsg_venta in row exclusive mode;
    -- genera un nuevo id para la venta
    select seq_id_venta.nextval into v_id_venta 
    from dual;

    -- se registra la venta
    insert into jrsg_venta(id_venta, id_cliente, fecha_venta)
        values (v_id_venta, p_id_cliente, sysdate);
    commit;
    -- se procesa cada producto en el cursor
    loop
        fetch p_productos into v_id_producto, v_cantidad;  -- extraer datos de p_productos e insertarlos en v_id_producto y en v_cantidad
        exit when p_productos%notfound; -- sale cuando no queden productos

        -- verificar si hay stock suficiente
        select cantidad_ps into v_stock_actual -- cantidad_ps de tabla inventario
        from jrsg_inventario
        where id_producto = v_id_producto;

        if v_stock_actual >= v_cantidad then
            -- registrar el detalle de la venta
            insert into jrsg_detalle_venta_producto (id_venta, id_producto, cantidad)
                values (v_id_venta, v_id_producto, v_cantidad);
            commit;
           
            -- actualizar el inventario
            update inventario
            set cantidad_ps = cantidad_ps - v_cantidad
            where id_producto = v_id_producto;
        exception
        when VALUE_ERROR then 
            RAISE_APPLICATION_ERROR(-6502, 'Stock insuficiente para el producto ' || v_id_producto);
        rollback;
    end loop;

    close p_productos;  -- cerrar el cursor
    commit;

    dbms_output.put_line('venta registrada exitosamente con id: ' || v_id_venta);  -- mostrar mensaje de éxito

    exception
    when program_error then
        raise_application_error(-6501, 'error de programa');
    rollback;
end;
