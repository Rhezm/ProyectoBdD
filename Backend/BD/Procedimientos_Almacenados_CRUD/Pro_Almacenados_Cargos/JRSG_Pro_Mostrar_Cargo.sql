create or replace procedure JRSG_Pro_Mostrar_Cargo (
    id_cargo_p in number
) is
    contador number;
    v_id_cargo JRSG_Cargo.id_cargo%type;
    v_nombre_cargo JRSG_Cargo.nombre_cargo%type;
    v_salario JRSG_Cargo.salario%type;
    begin
        select count(*) into contador from JRSG_Cargo where id_cargo = id_cargo_p;

        if (contador > 0) then
            select * into v_id_cargo, v_nombre_cargo, v_salario
            from JRSG_Cargo where id_cargo = id_cargo_p;

            dbms_output.put_line('Informacion Cargo ID: ' || id_cargo_p || CHR(10) ||
                              'Nombre: ' || v_nombre_cargo || CHR(10) ||
                              'Salario: ' || v_salario);

        else
            dbms_output.put_line ('Cargo ID: '|| id_cargo_p ||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;

--- Compila correctamente en SQL Developer