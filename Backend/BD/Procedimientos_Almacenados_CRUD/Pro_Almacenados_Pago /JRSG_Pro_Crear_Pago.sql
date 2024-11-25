CREATE OR REPLACE PROCEDURE JRSG_Pro_Crear_Pago (
    id_venta_P number,
    id_tipo_pago_P number,
    fecha_pago_p date,
    monto_pago_p number
)IS
    contador number;
begin
    select count(*) into contador from JRSG_PAGO where id_venta = id_venta_p;

    if (contador > 0 ) then
        raise_application_error (-20001, 'La canasta que desea pagar '|| id_venta_p || ' ya fue vendida.');
    else
        LOCK TABLE JRSG_PAGO in row exclusive mode;

        insert into JRSG_PAGO (id_venta, id_tipo_pago, fecha_pago, monto_pago)
            values (JRSG_Sec_Generar_ID_PAGOS.nextval,  id_tipo_pago_P, fecha_pago_p, monto_pago_p);

        commit;
            dbms_output.put_line ('Se realizo el Pago correctamente.');

    end if;

    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;    
end;
