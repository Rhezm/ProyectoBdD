create or replace NONEDITIONABLE procedure JRSG_Pro_Actualizar_Producto (
    id_producto_p in number,
    id_categoria_p in number default null, --- Columna 2
    id_promocion_p in number default null, --- Columna 3
    nombre_producto_p in varchar2 default null, --- Columna 4
    descripcion_producto_p in varchar2 default null, --- Columna 5
    precio_p in number default null, --- Columna 6
    precio_descuento_p in number default null, --- Columna 7
    stock_p in number default null --- Columna 8
)is
    contador number;

    begin
        select count(id_producto) into contador from JRSG_Producto;

        if (contador > 0) then
            lock table JRSG_Producto in row exclusive mode;

            update JRSG_Producto set id_categoria = id_categoria_p,
                                    id_promocion = id_promocion_p,
                                    nombre_producto = nombre_producto_p,
                                    descripcion_producto = descripcion_producto_p,
                                    precio = precio_p where id_producto = id_producto_p;
            dbms_output.put_line ('Los datos del producto con ID: ' || id_producto_p || ' se han actualizado');         
            commit;
        else
            dbms_output.put_line ('Producto con ID: ' || id_producto_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  
    end;