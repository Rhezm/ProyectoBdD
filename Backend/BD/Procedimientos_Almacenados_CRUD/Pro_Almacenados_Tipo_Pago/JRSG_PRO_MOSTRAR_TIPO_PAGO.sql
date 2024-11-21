CREATE OR REPLACE PROCEDURE JRSG_PRO_MOSTRAR_TIPO_PAGO(
    id_tipo_pago_tp number
)IS
    contador number;
    v_id_tipo_pago number;
    v_nombre_metodo_pago varchar2(25);
    v_banco varchar2(30);
    v_num_cuenta number;
begin
    select count(*) into contador from JRSG_TIPO_PAGO where id_tipo_pago = id_tipo_pago_tp;

    if (contador > 0) then
        lock table JRSG_TIPO_PAGO in row exclusive mode;
        
        SELECT * INTO v_id_tipo_pago, v_nombre_metodo_pago, v_banco, v_num_cuenta
        FROM JRSG_TIPO_PAGO
        WHERE ID_TIPO_PAGO = ID_TIPO_PAGO_TP;
            dbms_output.put_line('Informacion Tipo Pago ID: ' || v_id_tipo_pago || CHR(10) ||
                              'Metodo Pago: ' || v_nombre_metodo_pago || CHR(10) ||
                              'Banco: ' || v_banco || CHR(10) || 
                              'Numero Cuenta: ' || v_num_cuenta);
        commit;
    else
        dbms_output.put_line ('El Tipo de Pago ID: '|| id_tipo_pago_tp ||' no se encontro en el sistema.');
    end if;

    exception
        when others then
            raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
    rollback;
end;
