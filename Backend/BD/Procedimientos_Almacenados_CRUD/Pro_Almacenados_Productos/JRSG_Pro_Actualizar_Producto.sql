create or replace NONEDITIONABLE procedure JRSG_Pro_Actualizar_Producto (
    id_producto_p in number,
    id_categoria_p in number default null, --- Columna 2
    id_promocion_p in number default null, --- Columna 3
    nombre_producto_p in varchar2 default null, --- Columna 4
    descripcion_producto_p in varchar2 default null, --- Columna 5
    precio_p in number default null, --- Columna 6
    precio_descuento_p in number default null, --- Columna 7
    stock_p in number default null, --- Columna 8
    campo_actualizar in number --- Recibe el numero de la columna.
)is
    contador number;

    v_id_categoria JRSG_Categoria.id_categoria%type;
    v_nombre_categoria JRSG_Categoria.nombre_categoria%type;

    v_id_promocion JRSG_Promocion.id_promocion%type;
    v_nombre_promocion JRSG_Promocion.nombre_promocion%type;

    begin
        select count(id_producto) into contador from JRSG_Producto;

        if (id_categoria_p is not null) then
            select id_categoria, nombre_categoria into v_id_categoria, v_nombre_categoria from JRSG_Categoria where id_categoria = id_categoria_p;
        end if;

        if (id_promocion_p is not null) then
            select id_promocion, nombre_promocion into v_id_promocion, v_nombre_promocion from JRSG_Promocion where id_promocion = id_promocion_p;
        end if;

        if (contador > 0) then
            lock table JRSG_Producto in row exclusive mode;

            case campo_actualizar
                when 2 then
                    update JRSG_Producto set id_categoria = id_categoria_p where id_producto = id_producto_p;
                    dbms_output.put_line ('La categoria del producto con ID: ' || id_producto_p|| ' se ha actualizado a: ' || id_categoria_p || ' nombre: ' || v_nombre_categoria);
                when 3 then
                    update JRSG_Producto set id_promocion = id_promocion_p where id_producto = id_producto_p;
                    dbms_output.put_line ('La promocion del producto con ID: ' || id_producto_p|| ' se ha actualizado a: ' || id_promocion_p || ' nombre: ' || v_nombre_promocion);
                when 4 then  
                    update JRSG_Producto set nombre_producto = nombre_producto_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El nombre del producto con ID: ' || id_producto_p|| ' se ha actualizado a: ' || nombre_producto_p);
                when 5 then  
                    update JRSG_Producto set descripcion_producto = descripcion_producto_p where id_producto = id_producto;
                    dbms_output.put_line ('La descripcion del producto con ID: ' || id_producto_p|| ' se ha actualizado a: ' || descripcion_producto_p);
                when 6 then  
                    update JRSG_Producto set precio = precio_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El precio del producto con ID: ' || id_producto_p || ' se ha actualizado a: ' || precio_p);
                when 7 then
                    update JRSG_Producto set precio_descuento = precio_descuento_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El precio descuento del producto con ID: ' || id_producto_p || ' se ha actualizado a: ' || precio_descuento_p);
                when 8 then
                    update JRSG_Producto set stock = stock_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El stock del producto con ID: ' || id_producto_p || ' se ha actualizado a: ' || stock_p);
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
            rollback;  
    end;