create or replace procedure JRSG_Pro_Mostrar_Categoria (
    id_categoria_p in number
) is
    contador number;
    v_id_categoria JRSG_Categoria.id_categoria%type;
    v_nombre_categoria JRSG_Categoria.nombre_categoria%type;
    begin
        select count(*) into contador from JRSG_Categoria where id_categoria = id_categoria_p;

        if (contador > 0) then
            select * into v_id_categoria, v_nombre_categoria
            from JRSG_Categoria where id_categoria = id_categoria_p;

            dbms_output.put_line('Informacion Categoria ID: ' || id_categoria_p || CHR(10) ||
                              'Nombre: ' || v_nombre_categoria);

        else
            dbms_output.put_line ('Categoria ID: '|| id_categoria_p ||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;

--- Compila correctamente en SQL Developer