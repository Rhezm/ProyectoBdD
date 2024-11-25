create or replace NONEDITIONABLE PROCEDURE JRSG_Pro_Eliminar_Tipo_Pago (
    id_tipo_pago_tp number
)IS
contador number;
begin
    select count(*) into contador from JRSG_TIPO_PAGO where id_tipo_pago = id_tipo_pago_tp;

    if (contador > 0) then
        lock table JRSG_TIPO_PAGO in row exclusive mode;

        delete from JRSG_TIPO_PAGO where id_tipo_pago = id_tipo_pago_tp;
        dbms_output.put_line ('El Tipo de Pago ID: '|| id_tipo_pago_tp ||' se elimino correctamente del sistema.');
        commit;
    else
        dbms_output.put_line ('El Tipo de Pago ID: '|| id_tipo_pago_tp ||' no se encontro en el sistema.');
    end if;

    exception
        when others then
            raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
    rollback;
end;
