create or replace procedure JRSG_Pro_Crear_Detalle_Venta_Producto (
    id_producto_p in number,
    cantidad_p in number
) is
    v_nombre_producto JRSG_Producto.nombre_producto%type;

    begin
      lock table JRSG_Detalle_Venta_Producto in row exclusive mode;
        select nombre_producto into v_nombre_producto from JRSG_Producto where id_producto = id_producto_p;

        insert into JRSG_Detalle_Venta_Producto (id_venta, id_producto, cantidad, nombre_producto)
        values (JRSG_Sec_Generar_ID_Ventas.currval, id_producto_p, cantidad_p, v_nombre_producto);

        commit;
        dbms_output.put_line ('Se agrego el Producto: ' || id_producto_p || CHR(10) ||
                        'A la orden de venta ID: ' || JRSG_Sec_Generar_ID_Ventas.currval);
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;