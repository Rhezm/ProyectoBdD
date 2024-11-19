create or replace procedure JRSG_Pro_Crear_Categoria (
    nombre_categoria_p in varchar2
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Categoria where nombre_categoria = nombre_categoria_p;

        if (contador > 0) then
            raise_application_error (-20001, 'La categoria: '|| nombre_categoria_p||' ya esta ingresado en el sistema.');
        else
            lock table JRSG_Categoria in row exclusive mode;

            insert into JRSG_Categoria (id_categoria, nombre_categoria)
            values (JRSG_Sec_Generar_ID_Categorias.nextval, nombre_categoria_p);
            
            commit;
            dbms_output.put_line ('Categoria con ID: '|| JRSG_Sec_Generar_ID_Categorias.currval ||' se creo correctamente.');
        end if;
        
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;
    --- Compila correctamente en SQL Developer