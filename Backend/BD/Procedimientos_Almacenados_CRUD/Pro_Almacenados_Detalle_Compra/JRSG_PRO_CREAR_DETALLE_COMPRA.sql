create or replace NONEDITIONABLE PROCEDURE JRSG_PRO_CREAR_DETALLE_COMPRA(
    id_producto_p in number,
    cantidad_c in number,
    precio_compra_p in number
) is
    v_precio_total number;
    v_nombre_producto varchar2(60);
    v_stock_actual number;
    v_stock_actualizado number;
begin
    lock table JRSG_DETALLE_COMPRA_PRODUCTO in row exclusive mode;
    
    v_precio_total := precio_compra_p * cantidad_c;

    --tomamos el nombre de la id_producto
    SELECT nombre_producto into v_nombre_producto 
    FROM JRSG_PRODUCTO
    WHERE id_producto = id_producto_p;

    insert into JRSG_DETALLE_COMPRA_PRODUCTO (id_compra, id_producto, cantidad, nombre_producto, precio_compra, precio_total)
        values (JRSG_Sec_Generar_ID_Compras.currval, id_producto_p, cantidad_c, v_nombre_producto, precio_compra_p, v_precio_total);

    UPDATE JRSG_PRODUCTO SET 
        STOCK = STOCK + cantidad_c
        WHERE id_producto = id_producto_p;

    commit;
    dbms_output.put_line ('Se agrego el Producto: ' || v_nombre_producto || CHR(10) ||
                        'A la orden de compra ID: ' || JRSG_Sec_Generar_ID_Compras.currval);
    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;    
end;
