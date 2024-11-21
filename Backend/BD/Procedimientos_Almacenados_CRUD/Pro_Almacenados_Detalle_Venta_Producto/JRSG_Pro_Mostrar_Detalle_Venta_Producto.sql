create or replace procedure JRSG_Pro_Mostrar_Detalle_Venta_Producto (
    id_venta_p in number,
    cantidad_p in number
) is
    v_id_producto JRSG_Producto.id_producto%type;
    v_nombre_producto JRSG_Producto.nombre_producto%type;
    begin
        lock table JRSG_Detalle_Venta_Producto in row exclusive mode;
        
        select id_producto, nombre_producto into v_id_producto, v_nombre_producto from JRSG_Detalle_Venta_Producto where id_venta = id_venta_p;
        
        dbms_output.put_line ('Informacion Venta ID: ' || id_venta_p || CHR(10) ||
                            'ID Producto: ' || v_id_producto || CHR(10) ||
                            'Cantidad: ' || cantidad_p || CHR(10) ||
                            'Producto: ' || v_nombre_producto);
        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
        ROLLBACK;
    end;