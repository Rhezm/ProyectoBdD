create or replace procedure JRSG_Pro_Actualizar_Cliente (
    id_cliente_p in number,
    nombre_cliente_p in varchar2 default null,
    apellido1_cliente_p in varchar2 default null,
    apellido2_cliente_p in varchar2 default null,
    telefono_cliente_p in number default null,
    email_cliente_p in varchar2 default null
) is
    contador number;
    begin
        -- Verificar si el cliente existe
        select count(*) into contador from JRSG_Cliente where id_cliente = id_cliente_p;

        if (contador > 0) then  -- Caso en el que existe (correcto).
            lock table JRSG_Cliente in row exclusive mode;

            update JRSG_Cliente set nombre_cliente = nombre_cliente_p,
                                    apellido1_cliente = apellido1_cliente_p,
                                    apellido2_cliente = apellido2_cliente_p,
                                    telefono_cliente = telefono_cliente_p,
                                    email_cliente = email_cliente_p where id_cliente = id_cliente_p;
            dbms_output.put_line ('Los datos del cliente con ID: ' || id_cliente_p || ' se han actualizado');
            commit; 
        else
            dbms_output.put_line ('Cliente con ID: ' || id_cliente_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;
