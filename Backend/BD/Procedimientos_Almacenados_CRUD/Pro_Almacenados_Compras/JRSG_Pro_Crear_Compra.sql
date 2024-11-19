create or replace procedure JRSG_Pro_Crear_Compra (
    id_proveedor_p in number,
    cantidad_compra_p in number,
    precio_compra_p in number,
    descripcion_compra_p in varchar2 default null,
    fecha_compra in date
) is
    begin
        lock table JRSG_Compra in row exclusive mode;
        
        insert into JRSG_Compra (id_compra, id_proveedor, precio_compra, descripcion_compra, fecha_compra) 
        values (JRSG_Sec_Generar_ID_Compras.nextval, id_proveedor_p, precio_compra_p, descripcion_compra_p, fecha_compra_p);

        commit;
        dbms_output.put_line ('La orden de compra ID: ' || JRGS_Sec_Generar_ID_Compras.currval || ' se realizo correctamente');

        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;