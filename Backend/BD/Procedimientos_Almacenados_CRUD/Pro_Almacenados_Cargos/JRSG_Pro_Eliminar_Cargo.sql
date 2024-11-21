create or replace procedure JRSG_Pro_Eliminar_Cargo (
    id_cargo_p in number
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Cargo where id_cargo = id_cargo_p;

        if (contador > 0) then
            lock table JRSG_Cargo in row exclusive mode;

            delete from JRSG_Cargo where id_cargo = id_cargo_p;
            dbms_output.put_line ('El Cargo ID: '|| id_cargo_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Cargo ID: '|| id_cargo_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;

--- Compila correctamente en SQL Developer