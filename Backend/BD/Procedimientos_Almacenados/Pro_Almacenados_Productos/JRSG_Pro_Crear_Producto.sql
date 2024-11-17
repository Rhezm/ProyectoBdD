create or replace procedure JRSG_Pro_Crear_Producto (
    nombre_producto_p in varchar2,
    descripcion_producto_p in varchar2,
    precio_p in number,
    id_categoria_p in number
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Producto where nombre_producto = nombre_producto_p;

        if (contador > 0) then
            raise_application_error (-20001, 'El Producto de nombre: '|| nombre_producto_p ||' ya esta ingresado en el sistema.');
        else
            lock table JRSG_Producto in row exclusive mode;

            insert into JRSG_Producto (id_producto, id_categoria, id_promocion, nombre_producto, descripcion_producto, precio)
            values (JRSG_Sec_Generar_ID_Productos.nextval, id_categoria_p, null, nombre_producto_p, descripcion_producto_p, precio_p);
            
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
    --- Compila correctamente en SQL Developer
