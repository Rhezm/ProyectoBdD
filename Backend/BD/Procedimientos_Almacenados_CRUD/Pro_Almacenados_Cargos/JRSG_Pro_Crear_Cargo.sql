create or replace procedure JRSG_Pro_Crear_Cargos (
    nombre_cargo_p in varchar2,
    salario_p in number
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Cargo where nombre_cargo = nombre_cargo_p;

        if (contador > 0) then
            raise_application_error (-20001, 'El cargo: '|| nombre_cargo_p ||' ya esta ingresado en el sistema.');
        else
            lock table JRSG_Cargo in row exclusive mode;

            insert into JRSG_Cargo (id_cargo, nombre_cargo, salario)
            values (JRSG_Sec_Generar_ID_Cargos.nextval, nombre_cargo_p, salario_p);
            
            commit;
            dbms_output.put_line ('Cargo con ID: '|| JRSG_Sec_Generar_ID_Cargos.currval ||' se creo correctamente.');
        end if;
        
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;
    --- Compila correctamente en SQL Developer