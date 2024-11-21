create or replace procedure JRSG_Pro_Actualizar_Ubicacion_Bodega (
    id_ubicacion_p in number,
    id_producto_p in number,
    nro_estante_p in number,
    nivel_p in number
)is
    contador number;
    contador1 number;
    v_nombre_producto JRSG_Producto.nombre_producto%type;
    begin
        select count(*) into contador from JRSG_Ubicacion_Bodega where id_ubicacion = id_ubicacion_p;
        select count(*) into contador1 from JRSG_Producto where id_producto = id_producto_p;
        
        if (contador > 0 and contador1 = 0) then
            lock table JRSG_Ubicacion_Bodega in row exclusive mode;

            update JRSG_Ubicacion_Bodega set id_producto = id_producto_p,
                                            nro_estante = nro_estante_p,
                                            nivel = nivel_p where id_ubicacion = id_ubicacion_p;
            dbms_output.put_line ('La ubicacion bodega: ' || id_ubicacion_p || ' se ha actualizado a: ' || CHR(10) ||
                                'Numero estante: ' || nro_estante_p || CHR(10) ||
                                'Nivel: ' || nivel_p);
            commit;
        elsif (contador > 0 and contador1 > 0) then
            lock table JRSG_Ubicacion_Bodega in row exclusive mode;
            select nombre_producto into v_nombre_producto from JRSG_Producto where id_producto = id_producto_p;

            update JRSG_Ubicacion_Bodega set id_producto = id_producto_p,
                                            nro_estante = nro_estante_p,
                                            nivel = nivel_p where id_ubicacion = id_ubicacion_p;
            dbms_output.put_line ('La ubicacion bodega: ' || id_ubicacion_p || ' se ha actualizado a: ' || CHR(10) ||
                                'Numero estante: ' || nro_estante_p || CHR(10) ||
                                'Nivel: ' || nivel_p || CHR(10) ||
                                'Producto: ' || v_nombre_producto);
            commit;
        else
            dbms_output.put_line ('Ubicacion Bodega ID: ' || id_ubicacion_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;

    --- Compilador correctamente en SQL Developer.