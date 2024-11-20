create or replace procedure JRSG_Pro_Crear_Compra (
    detalle_compra_p in varchar2,
    monto_compra_p in number,
    fecha_compra_p in date
) is
    begin
        lock table JRSG_Compra in row exclusive mode;
        
        insert into JRSG_Compra (id_compra, detalle_compra, monto_compra, fecha_compra) 
        values (JRSG_Sec_Generar_ID_Compras.nextval, detalle_compra_p, monto_compra_p, fecha_compra_p);

        commit;
        dbms_output.put_line ('La orden de compra ID: ' || JRSG_Sec_Generar_ID_Compras.currval || ' se realizo correctamente');

        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;