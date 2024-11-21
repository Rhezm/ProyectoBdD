create or replace NONEDITIONABLE PROCEDURE JRSG_PRO_MOSTRAR_DETALLE_COMPRA(
    id_compra_c number
)IS
    v_id_compra number;
    v_id_producto number;
    v_cantidad number;
    v_nombre_producto varchar2(60);
    v_precio_compra number;
    v_precio_total number;
begin
    LOCK TABLE JRSG_DETALLE_COMPRA_PRODUCTO IN ROW EXCLUSIVE MODE;

    SELECT * INTO v_id_compra, v_id_producto, v_cantidad, v_nombre_producto, v_precio_compra, v_precio_total
    FROM JRSG_DETALLE_COMPRA_PRODUCTO
    WHERE id_compra = id_compra_c;

    COMMIT;
        dbms_output.put_line('Informacion Compra ID: ' || id_compra_c || CHR(10) ||
                  'ID Producto: ' || v_id_producto || CHR(10) || 
                  'Cantidad: ' || v_cantidad || CHR(10) || 
                  'Nombre Producto: ' || v_nombre_producto || CHR(10) ||
                  'Precio Compra: ' || v_precio_compra || CHR(10) ||
                  'Precio Total: ' || v_precio_total);

    exception
        when others then
            raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    ROLLBACK;

end;
