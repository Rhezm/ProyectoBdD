create or replace procedure JRSG_Pro_Crear_Cliente (
    nombre_cliente_p in varchar2,
    apellido1_cliente_p in varchar2,
    apellido2_cliente_p in varchar2,
    telefono_cliente_p in number,
    direccion_cliente_p in varchar2,
    email_cliente_p in varchar2
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Cliente 
            where (telefono_cliente = telefono_cliente_p and email_cliente = email_cliente_p);
        
        if (contador > 0) then
            raise_application_error (-20001, 'El cliente con correo: '|| email_cliente_p ||' o telefono: '|| telefono_cliente_p ||' ya existe en el sistema.');
        else
            lock table JRSG_Cliente in row exclusive mode;

            insert into JRSG_Cliente (id_cliente, nombre_cliente, apellido1_cliente, apellido2_cliente, telefono_cliente, direccion_cliente, email_cliente)
            values (JRSG_Sec_Generar_ID_Clientes.nextval, nombre_cliente_p, apellido1_cliente_p, apellido2_cliente_p, telefono_cliente_p, direccion_cliente_p, email_cliente_p);

            commit;
            dbms_output.put_line ('Cliente con ID: '|| JRSG_Sec_Generar_ID_Clientes.currval ||' se creo correctamente.');
        end if;

        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;