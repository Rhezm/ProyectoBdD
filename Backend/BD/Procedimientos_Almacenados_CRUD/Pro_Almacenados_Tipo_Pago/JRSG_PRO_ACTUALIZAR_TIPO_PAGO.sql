create or replace NONEDITIONABLE PROCEDURE JRSG_PRO_ACTUALIZAR_TIPO_PAGO(
    id_tipo_pago_tp number,
    nombre_metodo_pago_tp varchar2,
    banco_tp varchar2,
    num_cuenta_tp number
)IS
contador number;
begin
    LOCK TABLE JRSG_TIPO_PAGO IN ROW EXCLUSIVE MODE;

    UPDATE JRSG_TIPO_PAGO SET
        nombre_metodo_pago = nombre_metodo_pago_tp, 
        banco = banco_tp, 
        num_cuenta = num_cuenta_tp
        WHERE id_tipo_pago = id_tipo_pago_tp;

    commit;
        dbms_output.put_line ('Se actualizo el numero de cuenta: '|| num_cuenta_tp ||' correctamente.');

    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;
end;
