create or replace procedure JRSG_Pro_Actualizar_Empleado (
    id_empleado_p in number,
    nombre_empleado_p in varchar2 default null,
    apellido1_empleado_p in varchar2 default null,
    apellido2_empleado_p in varchar2 default null,
    telefono_empleado_p in number default null,
    email_empleado_p in varchar2 default null,
    contrasena_p in varchar2 default null
) is
    contador number;
    begin
        -- Verificar si el cliente existe
        select count(*) into contador from JRSG_Empleado where id_empleado = id_empleado_p;

        if (contador > 0) then  -- Caso en el que existe (correcto).
            lock table JRSG_Empleado in row exclusive mode;
            
            update JRSG_Empleado set nombre_empleado = nombre_empleado_p,
                                    apellido1_empleado = apellido1_empleado_p,
                                    apellido2_empleado = apellido2_empleado_p,
                                    telefono_empleado = telefono_empleado_p,
                                    email_empleado = email_empleado_p,
                                    contrasena = contrasena_p where id_empleado = id_empleado_p;
            dbms_output.put_line ('Los datos del empleado con ID: ' || id_empleado_p || ' se han actualizado');
            commit; 

        else
            dbms_output.put_line ('Empleado con ID: ' || id_empleado_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;