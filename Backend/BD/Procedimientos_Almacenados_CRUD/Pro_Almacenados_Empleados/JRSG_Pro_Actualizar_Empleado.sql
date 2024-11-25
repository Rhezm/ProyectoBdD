create or replace procedure JRSG_Pro_Actualizar_Empleado (
    id_empleado_p in number,
    nombre_empleado_p in varchar2 default null,
    apellido1_empleado_p in varchar2 default null,
    apellido2_empleado_p in varchar2 default null,
    telefono_empleado_p in number default null,
    email_empleado_p in varchar2 default null,
    contrasena_p in varchar2 default null,
    campo_actualizar number  -- variable que nos indica qué campo se modificará
) is
    contador number;
    begin
        -- Verificar si el cliente existe
        select count(*) into contador from JRSG_Empleado where id_empleado = id_empleado_p;

        if (contador > 0) then  -- Caso en el que existe (correcto).
            lock table JRSG_Empleado in row exclusive mode;

            case campo_actualizar
                when 2 then  -- Campo Nombre Cliente
                    update JRSG_Empleado set nombre_empleado = nombre_empleado_p where id_empleado = id_empleado_p;
                    dbms_output.put_line ('El nombre del empleado con ID: ' || id_empleado_p || ' se ha actualizado a: ' || nombre_empleado_p);
                when 3 then  -- Campo Apellido1 Cliente
                    update JRSG_Empleado set apellido1_empleado = apellido1_empleado_p where id_empleado = id_empleado_p;
                    dbms_output.put_line ('El primer apellido del empleado con ID: ' || id_empleado_p || ' se ha actualizado a: ' || apellido1_empleado_p);
                when 4 then  -- Campo Apellido2 Cliente
                    update JRSG_Empleado set apellido2_empleado = apellido2_empleado_p where id_empleado = id_empleado_p;
                    dbms_output.put_line ('El segundo apellido del empleado con ID: ' || id_empleado_p || ' se ha actualizado a: ' || apellido2_empleado_p);
                when 5 then  -- Campo Telefono Cliente
                    update JRSG_Empleado set telefono_empleado = telefono_empleado_p where id_empleado = id_empleado_p;
                    dbms_output.put_line ('El telefono del empleado con ID: ' || id_empleado_p || ' se ha actualizado a: ' || telefono_empleado_p);
                when 6 then  -- Campo Email Cliente
                    update JRSG_Empleado set email_empleado = email_empleado_p where id_empleado = id_empleado_p;
                    dbms_output.put_line ('El email del empleado con ID: ' || id_empleado_p || ' se ha actualizado a: ' || email_empleado_p);
                when 7 then  -- Campo Contrasena Cliente
                    update JRSG_Empleado set contrasena = contrasena_p where id_empleado = id_empleado_P;
                    dbms_output.put_line ('La contrasena del empleado con ID: ' || id_empleado_p || ' se ha actualizado.');
                else
                    dbms_output.put_line ('Campo no válido.');
            end case;
            commit;  -- Confirmar cambios

        else
            dbms_output.put_line ('Empleado con ID: ' || id_empleado_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;