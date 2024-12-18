create or replace procedure JRSG_Pro_Actualizar_Compra (
    id_compra_p in number,
    monto_compra_p in number,
    fecha_compra_p in date
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Compra where id_compra = id_compra_p;

        if (contador > 0) then
            lock table JRSG_Compra in row exclusive mode;

            update JRSG_Compra set monto_compra = monto_compra_p,
                                    fecha_compra = fecha_compra_p where id_compra = id_compra_p;

            dbms_output.put_line ('Compra ID: ' || id_compra_p || ' se ha actualizado correctamente.');
            commit;
        end if;

        exception
                when others then
                    raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
                rollback;  -- Revertir cambios en caso de error
    end;