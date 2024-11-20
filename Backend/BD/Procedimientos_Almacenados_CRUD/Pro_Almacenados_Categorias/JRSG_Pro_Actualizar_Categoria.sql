create or replace procedure JRSG_Pro_Actualizar_Categoria (
    id_categoria_p in number,
    nombre_categoria_p in varchar2
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Categoria where id_categoria = id_categoria_p;

        if (contador > 0) then
            lock table JRSG_Categoria in row exclusive mode;

            update JRSG_Categoria set nombre_categoria = nombre_categoria_p where id_categoria = id_categoria_p;
            dbms_output.put_line ('El nombre de la categoria con ID: ' || id_categoria_p|| ' se ha actualizado a: ' || nombre_categoria_p);
            commit;
        else
            dbms_output.put_line ('Categoria con ID: ' || id_categoria_p|| ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;

    --- Compilador correctamente en SQL Developer.