create or replace NONEDITIONABLE procedure JRSG_Pro_Crear_Venta (
    id_cliente_v in number
) is
    v_fecha_venta date;
begin
    lock table JRSG_Venta in row exclusive mode;
    
    v_fecha_venta := SYSDATE;

    insert into JRSG_Venta (id_venta, id_cliente, fecha_venta)
    values (JRSG_Sec_Generar_ID_Ventas.nextval, id_cliente_v, v_fecha_venta);

    commit;
        dbms_output.put_line ('Venta con ID: '|| JRSG_Sec_Generar_ID_Ventas.currval ||' se creo correctamente.');

    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;    
end;
