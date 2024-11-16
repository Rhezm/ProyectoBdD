create or replace procedure JRSG_Pro_Actualizar_Producto (
    id_producto_p in number,
    id_categoria_p in number default null, --- modificar: se tiene que hacer mediante las operaciones de esa tabla-
    id_promocion_p in number default null, --- Modificar: se tiene que hacer mediante las operaciones de esa tabla.
    nombre_producto_p in varchar2 default null,
    descripcion_producto_p in varchar2 default null,
    precio_p in number default null,
    campo_actualizar in number
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Producto where id_producto = id_producto_p;

        if (contador > 0) then
            lock table JRSG_Producto in row exclusive mode;

            case campo_actualizar
                when 2 then  -- Campo Nombre Cliente
                    update JRSG_Producto set nombre_producto = nombre_producto_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El nombre del producto con ID: ' || id_producto_p|| ' se ha actualizado a: ' || nombre_producto_p);
                when 3 then  -- Campo Apellido1 Cliente
                    update JRSG_Producto set descripcion_producto = descripcion_producto_p where id_producto = id_producto;
                    dbms_output.put_line ('La descripcion del producto con ID: ' || id_producto_p|| ' se ha actualizado a: ' || descripcion_producto_p);
                when 4 then  -- Campo Apellido2 Cliente
                    update JRSG_Producto set precio = precio_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El precio del producto con ID: ' || id_producto_p || ' se ha actualizado a: ' || precio_p);
                else
                    dbms_output.put_line ('Campo no válido.');
            end case;
            commit;
        else
            dbms_output.put_line ('Producto con ID: ' || id_producto_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;