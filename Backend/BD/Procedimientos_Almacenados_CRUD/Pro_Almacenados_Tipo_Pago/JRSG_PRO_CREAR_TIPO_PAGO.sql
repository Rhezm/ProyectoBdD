CREATE OR REPLACE PROCEDURE JRSG_PRO_CREAR_TIPO_PAGO(
    nombre_metodo_pago_tp varchar2,
    banco_tp varchar2,
    num_cuenta_tp number
)IS
contador number;
begin
    select count(num_cuenta) into contador from JRSG_TIPO_PAGO where num_cuenta = num_cuenta_tp;

    if (contador > 0) then
        raise_application_error (-20001, 'El numero de cuenta: '|| num_cuenta_tp ||' ya existe en el sistema.');
    else
        LOCK TABLE JRSG_TIPO_PAGO IN ROW EXCLUSIVE MODE;

        INSERT INTO JRSG_TIPO_PAGO(ID_TIPO_PAGO, nombre_metodo_pago, banco, num_cuenta)
            VALUES(JRSG_SEC_GENERAR_ID_TIPO_PAGOS.NEXTVAL, nombre_metodo_pago_tp, banco_tp, num_cuenta_tp);
        
        commit;
        dbms_output.put_line ('Se ingreso el numero de cuenta: '|| num_cuenta_tp ||' correctamente.');
    end if;

    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;
end;
