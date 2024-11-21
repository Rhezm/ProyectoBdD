create or replace procedure JRSG_Pro_Mostrar_Empleado (
    id_empleado_p in number
) is
    contador number;
    v_id_empleado          JRSG_Empleado.id_empleado%type;
    v_id_cargo             JRSG_Empleado.id_cargo%type;
    v_nombre_empleado      JRSG_Empleado.nombre_empleado%type;
    v_apellido1_empleado   JRSG_Empleado.apellido1_empleado%type;
    v_apellido2_empleado   JRSG_Empleado.apellido2_empleado%type;
    v_telefono_empleado    JRSG_Empleado.telefono_empleado%type;
    v_email_empleado       JRSG_Empleado.email_empleado%type;
    v_nombre_cargo         JRSG_Cargo.nombre_cargo%type;

    begin
        select count(*) into contador from JRSG_empleado where id_empleado = id_empleado_p;

        if (contador > 0) then
            select * into v_id_empleado, v_id_cargo, v_nombre_empleado, v_apellido1_empleado, v_apellido2_empleado, v_telefono_empleado, v_email_empleado
            from JRSG_Empleado where id_empleado = id_empleado_p;

            select nombre_cargo into v_nombre_cargo from JRSG_Cargo where id_cargo = v_id_cargo;

            dbms_output.put_line('Informacion cliente ID: ' || id_empleado_p || CHR(10) ||
                              'Nombre: ' || v_nombre_empleado || CHR(10) ||
                              'Primer Apellido: ' || v_apellido1_empleado || CHR(10) || 
                              'Segundo Apellido: ' || v_apellido2_empleado || CHR(10) || 
                              'Telefono: ' || v_telefono_empleado || CHR(10) || 
                              'Email: ' || v_email_empleado || CHR(10) ||
                              'Cargo: ' || v_nombre_cargo);
        else
            dbms_output.put_line ('Empleado ID: '|| id_empleado_p ||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;

--- Compila correctamente en SQL Developer