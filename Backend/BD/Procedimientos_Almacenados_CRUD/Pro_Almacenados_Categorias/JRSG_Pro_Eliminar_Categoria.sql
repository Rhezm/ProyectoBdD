create or replace procedure JRSG_Pro_Eliminar_Categoria (
    id_categoria_p in number
    --- ver la opcion de eliminar un cliente mediante la opcion de que campo usar, ya sea 
    --- ID, email o telefono, en caso de que la persona que quiera eliminar le cliente no se acuerde
    --- del ID pero si del telefono o email, etc.
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Categoria where id_categoria = id_categoria_p;

        if (contador > 0) then
            lock table JRSG_Categoria in row exclusive mode;

            delete from JRSG_Categoria where id_categoria = id_categoria_p;
            dbms_output.put_line ('La Categoria ID: '|| id_categoria_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Categoria ID: '|| id_categoria_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;

--- Compila correctamente en SQL Developer