create or replace procedure JRSG_Pro_Eliminar_Promocion (
    id_promocion_p in number
    --- ver la opcion de eliminar un cliente mediante la opcion de que campo usar, ya sea 
    --- ID, email o telefono, en caso de que la persona que quiera eliminar le cliente no se acuerde
    --- del ID pero si del telefono o email, etc.
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Promocion where id_promocion = id_promocion_p;

        if (contador > 0) then
            lock table JRSG_Promocion in row exclusive mode;

            delete from JRSG_Promocion where id_promocion = id_promocion_p;
            dbms_output.put_line ('La Promocion ID: '|| id_promocion_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Promocion ID: '|| id_promocion_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;

