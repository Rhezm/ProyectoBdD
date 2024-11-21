create or replace procedure JRSG_Pro_Mostrar_Producto (
    id_producto_p in number
) is
    contador number;
    v_id_producto JRSG_Producto.id_producto%type;
    v_id_categoria JRSG_Producto.id_categoria%type;      
    v_id_promocion JRSG_Producto.id_promocion%type;
    v_nombre_producto JRSG_Producto.nombre_producto%type;
    v_descripcion_producto JRSG_Producto.descripcion_producto%type;
    v_precio JRSG_Producto.precio%type;
    v_precio_descuento JRSG_Producto.precio_descuento%type;
    v_stock JRSG_Producto.stock%type;
    v_proveedor JRSG_Producto.proveedor%type;
    begin
        select count(*) into contador from JRSG_Producto where id_producto = id_producto_p;

        if (contador > 0) then
            select * into v_id_producto, v_id_categoria, v_id_promocion, v_nombre_producto, v_descripcion_producto, v_precio, v_precio_descuento, v_stock, v_proveedor
            from JRSG_Producto where id_producto = id_producto_p;

            dbms_output.put_line('Informacion Producto ID: ' || id_producto_p || CHR(10) ||
                              'Nombre: ' || v_nombre_producto || CHR(10) ||
                              'Categoria: ' || v_id_categoria || CHR(10) || 
                              'Promocion: ' || v_id_promocion || CHR(10) || 
                              'Descripcion: ' || v_descripcion_producto || CHR(10) || 
                              'Precio: ' || v_precio || CHR(10) ||
                              'Precio Descuento: ' || v_precio_descuento || CHR(10) ||
                              'Stock: ' || v_stock || CHR(10) ||
                              'Proveedor: ' || v_proveedor);
        else
            dbms_output.put_line ('Producto ID: '|| id_producto_p||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;

--- Se agrgeo v_stock por el stock en la tabla producto.