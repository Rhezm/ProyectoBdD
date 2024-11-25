create or replace procedure JRSG_Pro_Crear_Empleado (
    nombre_empleado_p in varchar2,
    apellido1_empleado_p in varchar2,
    apellido2_empleado_p in varchar2,
    telefono_empleado_p in number,
    email_empleado_p in varchar2,
    contrasena_p in varchar2
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Empleado
            where (telefono_empleado = telefono_empleado_p and email_empleado = email_empleado_p);
        
        if (contador > 0) then
            raise_application_error (-20001, 'El empleado con correo: '|| email_empleado_p ||' o telefono: '|| telefono_empleado_p ||' ya existe en el sistema.');
        else
            lock table JRSG_Empleado in row exclusive mode;

            insert into JRSG_Empleado (id_empleado, nombre_empleado, apellido1_empleado, apellido2_empleado, telefono_empleado, email_empleado, contrasena)
            values (JRSG_Sec_Generar_ID_Empleados.nextval, nombre_empleado_p, apellido1_empleado_p, apellido2_empleado_p, telefono_empleado_p, email_empleado_p, contrasena_p);

            commit;
            dbms_output.put_line ('Empleado con ID: '|| JRSG_Sec_Generar_ID_Empleados.currval ||' se creo correctamente.');
        end if;

        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;

--- Compila correctamente en SQL Developer