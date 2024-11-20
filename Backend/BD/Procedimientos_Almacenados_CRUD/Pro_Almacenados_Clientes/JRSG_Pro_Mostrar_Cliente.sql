create or replace procedure JRSG_Pro_Mostrar_Cliente (
    id_cliente_p in number
) is
    contador number;
    v_id_cliente          JRSG_Cliente.id_cliente%type;
    v_nombre_cliente      JRSG_Cliente.nombre_cliente%type;
    v_apellido1_cliente   JRSG_Cliente.apellido1_cliente%type;
    v_apellido2_cliente   JRSG_Cliente.apellido2_cliente%type;
    v_telefono_cliente    JRSG_Cliente.telefono_cliente%type;
    v_direccion_cliente   JRSG_Cliente.direccion_cliente%type;
    v_email_cliente       JRSG_Cliente.email_cliente%type;
    begin
        select count(*) into contador from JRSG_Cliente where id_cliente = id_cliente_p;

        if (contador > 0) then
            select * into v_id_cliente, v_nombre_cliente, v_apellido1_cliente, v_apellido2_cliente, v_telefono_cliente, v_direccion_cliente, v_email_cliente
            from JRSG_Cliente where id_cliente = id_cliente_p;

            dbms_output.put_line('Informacion cliente ID: ' || id_cliente_p || CHR(10) ||
                              'Nombre: ' || v_nombre_cliente || CHR(10) ||
                              'Primer Apellido: ' || v_apellido1_cliente || CHR(10) || 
                              'Segundo Apellido: ' || v_apellido2_cliente || CHR(10) || 
                              'Telefono: ' || v_telefono_cliente || CHR(10) || 
                              'Direccion: ' || v_direccion_cliente || CHR(10) || 
                              'Email: ' || v_email_cliente);
        else
            dbms_output.put_line ('Cliente ID: '|| id_cliente_p ||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;

--- Compila correctamente en SQL Developer