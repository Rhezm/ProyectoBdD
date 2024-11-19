create or replace procedure JRSG_Pro_Eliminar_Cliente (
    id_cliente_p in number
    --- ver la opcion de eliminar un cliente mediante la opcion de que campo usar, ya sea 
    --- ID, email o telefono, en caso de que la persona que quiera eliminar le cliente no se acuerde
    --- del ID pero si del telefono o email, etc.
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Cliente where id_cliente = id_cliente_p;

        if (contador > 0) then
            lock table JRSG_Cliente in row exclusive mode;

            delete from JRSG_Cliente where id_cliente = id_cliente_p;
            dbms_output.put_line ('El cliente ID: '|| id_cliente_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Cliente ID: '|| id_cliente_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;

--- Compila correctamente en SQL Developer