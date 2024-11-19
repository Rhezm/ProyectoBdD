create or replace procedure JRSG_Pro_Crear_Producto (
    id_categoria_p in number default null,
    id_promocion_p in number,
    nombre_producto_p in varchar2,
    descripcion_producto_p in varchar2,
    precio_p in number,
    precio_descuento_p in number default null,
    stock_p in number
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Producto where nombre_producto = nombre_producto_p;

        if (contador > 0) then
            raise_application_error (-20001, 'El Producto de nombre: '|| nombre_producto_p ||' ya esta ingresado en el sistema.');
        else
            lock table JRSG_Producto in row exclusive mode;

            insert into JRSG_Producto (id_producto, id_categoria, id_promocion, nombre_producto, descripcion_producto, precio, precio_descuento, stock)
            values (JRSG_Sec_Generar_ID_Productos.nextval, id_categoria_p, id_promocion_p, nombre_producto_p, descripcion_producto_p, precio_p, precio_descuento_p, stock_p);
            
            commit;
            dbms_output.put_line ('Producto con ID: '|| JRSG_Sec_Generar_ID_Productos.currval ||' se creo correctamente.');
        end if;
        
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;
    --- Actualizar en SQL Developer: Compilado correcto

    --- Cambio realizado
    /* En insert into solo debe usar la secuencia de generar los ID de su propia tabla.
    Se cambio JRSG_Sec_Generar_ID_Categorias por id_categoria_p
    Se cambio JRSG_Sec_Generar_ID_Promociones por id_promocion_p*/

    --- Se actualizo, se agrego stock_p