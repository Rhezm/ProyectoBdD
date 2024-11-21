create or replace procedure JRSG_Pro_Crear_Venta(
    id_cliente_v in number,
) is
    v_fecha_venta date;
    lock table JRSG_Venta in row exclusive mode;

    insert into JRSG_Venta (id_venta, id_cliente, fecha_venta_v)
    values (JRSG_Sec_Generar_ID_Venta.nextval, id_cliente_v, fecha_venta_v);

    commit;
        dbms_output.put_line ('Venta con ID: '|| JRSG_Sec_Generar_ID_Venta.currval ||' se creo correctamente.');

    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;    
end;
