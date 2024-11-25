create or replace procedure JRSG_Pro_Actualizar_Cliente (
    id_cliente_p in number,
    nombre_cliente_p in varchar2 default null,
    apellido1_cliente_p in varchar2 default null,
    apellido2_cliente_p in varchar2 default null,
    telefono_cliente_p in number default null,
    direccion_cliente_p in varchar2 default null,
    email_cliente_p in varchar2 default null,
    campo_actualizar number  -- variable que nos indica qué campo se modificará
) is
    contador number;
    begin
        -- Verificar si el cliente existe
        select count(*) into contador from JRSG_Cliente where id_cliente = id_cliente_p;

        if (contador > 0) then  -- Caso en el que existe (correcto).
            lock table JRSG_Cliente in row exclusive mode;
        
            case campo_actualizar
                when 2 then  -- Campo Nombre Cliente
                    update JRSG_Cliente set nombre_cliente = nombre_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('El nombre del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || nombre_cliente_p);
                when 3 then  -- Campo Apellido1 Cliente
                    update JRSG_Cliente set apellido1_cliente = apellido1_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('El primer apellido del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || apellido1_cliente_p);
                when 4 then  -- Campo Apellido2 Cliente
                    update JRSG_Cliente set apellido2_cliente = apellido2_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('El segundo apellido del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || apellido2_cliente_p);
                when 5 then  -- Campo Telefono Cliente
                    update JRSG_Cliente set telefono_cliente = telefono_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('El telefono del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || telefono_cliente_p);
                when 6 then  -- Campo Direccion Cliente
                    update JRSG_Cliente set direccion_cliente = direccion_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('La direccion del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || direccion_cliente_p);
                when 7 then  -- Campo Email Cliente
                    update JRSG_Cliente set email_cliente = email_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('El email del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || email_cliente_p);
                else
                    dbms_output.put_line ('Campo no válido.');
            end case;
            commit;  -- Confirmar cambios

        else
            dbms_output.put_line ('Cliente con ID: ' || id_cliente_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;