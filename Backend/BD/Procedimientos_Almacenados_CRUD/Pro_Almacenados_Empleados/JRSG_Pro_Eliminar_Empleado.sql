create or replace procedure JRSG_Pro_Eliminar_Empleado (
    id_empleado_p in number
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Empleado where id_empleado = id_empleado_p;

        if (contador > 0) then
            lock table JRSG_Empleado in row exclusive mode;

            delete from JRSG_Empleado where id_empleado = id_empleado_p;
            dbms_output.put_line ('El empleado ID: '|| id_empleado_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Empleado ID: '|| id_empleado_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;

--- Compila correctamente en SQL Developer