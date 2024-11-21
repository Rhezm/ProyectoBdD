create or replace procedure JRSG_Pro_Mostrar_Pago(
    id_pago_p in number
)is
    contador number;
    v_id_pago number;
    v_id_venta number;
    v_id_tipo_pago number;
    v_fecha_pago date;
    v_monto_pago number;
begin
    select count(*) into contador from JRSG_PAGO where id_pago = id_pago_p;

    if (contador > 0) then
        select * into v_id_pago, v_id_venta, v_id_tipo_pago, v_fecha_pago, v_monto_pago
        from JRSG_PAGO where id_pago = id_pago_p;

        dbms_output.put_line('Informacion Pago ID: ' || v_id_pago || CHR(10) ||
                            'Canasta: ' || v_id_venta || CHR(10) ||
                            'Tipo de Pago: ' || v_id_tipo_pago || CHR(10) ||
                            'Fecha de Pago: ' || v_fecha_pago || CHR(10) ||
                            'Monto: ' || v_monto_pago );
    else
        dbms_output.put_line ('No se han encontrado Ventas en el sistema.');
    end if;

    COMMIT;

    exception
        when others then
            raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);

    ROLLBACK;
end;
