create or replace procedure JRSG_Pro_Eliminar_Compra (
    id_compra_p in number
) is
    contador number;
    begin
        select count(id_compra) into contador from JRSG_Compra;

        if (contador > 0) then
            lock table JRSG_Compra in row exclusive mode;

            delete from JRSG_Compra where id_compra = id_compra_p;
            dbms_output.put_line ('La Compra ID: '|| id_compra_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Compra ID: '|| id_compra_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;
