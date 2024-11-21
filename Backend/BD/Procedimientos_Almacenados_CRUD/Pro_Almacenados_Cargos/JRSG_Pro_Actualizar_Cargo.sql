create or replace procedure JRSG_Pro_Actualizar_Cargo (
    id_cargo_p in number,
    nombre_cargo_p in varchar2,
    salario_p in number
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Cargo where id_cargo = id_cargo_p;

        if (contador > 0) then
            lock table JRSG_Cargo in row exclusive mode;

            update JRSG_Cargo set nombre_cargo = nombre_cargo_p, salario = salario_p where id_cargo = id_cargo_p;
            dbms_output.put_line ('El cargo con ID: ' || id_cargo_p || ' se ha actualizado a:' || CHR(10) ||
                                'Nombre Cargo: ' || nombre_cargo_p || CHR(10) ||
                                'Salario: ' || salario_p);
            commit;
        else
            dbms_output.put_line ('Cargo con ID: ' || id_cargo_p|| ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;

    --- Compilador correctamente en SQL Developer.