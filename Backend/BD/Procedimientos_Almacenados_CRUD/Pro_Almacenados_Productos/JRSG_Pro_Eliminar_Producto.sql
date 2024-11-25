create or replace procedure JRSG_Pro_Eliminar_Producto (
    id_producto_p in number
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Producto where id_producto = id_producto_p;

        if (contador > 0) then
            lock table JRSG_Producto in row exclusive mode;

            delete from JRSG_Producto where id_producto = id_producto_p;
            dbms_output.put_line ('El Producto ID: '|| id_producto_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Producto ID: '|| id_producto_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;

