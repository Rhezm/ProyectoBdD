create or replace procedure JRSG_Pro_Crear_Ubicacion_Bodega (
    id_producto_p in number default null,
    nro_estante_p in number,
    nivel_p in number
)is
    contador number;
    v_nombre_producto JRSG_Producto.nombre_producto%type;
    begin
        select count(*) into contador from JRSG_Ubicacion_Bodega where nro_estante = nro_estante_p and nivel = nivel_p;

        if (contador > 0 and id_producto_p is not null) then
            select nombre_producto into v_nombre_producto from JRSG_Producto where id_producto = id_producto_p;

            raise_application_error (-20001, 'La ubicacion en bodega: '|| CHR(10) ||
                                    'Numero estante: ' || nro_estante_p || CHR(10) ||
                                    'Nivel: ' || nivel_p || CHR(10) ||
                                    'Producto: ' || v_nombre_producto || CHR(10) ||
                                    ' ya esta ingresado en el sistema.');
        elsif (contador > 0 and id_producto_p is null) then
            raise_application_error (-20001, 'La ubicacion en bodega: '|| CHR(10) ||
                                    'Numero estante: ' || nro_estante_p || CHR(10) ||
                                    'Nivel: ' || nivel_p || CHR(10) ||
                                    ' ya esta ingresado en el sistema.');
        else
            lock table JRSG_Ubicacion_Bodega in row exclusive mode;

            insert into JRSG_Ubicacion_Bodega (id_ubicacion, id_producto, nro_estante, nivel)
            values (JRSG_Sec_Generar_ID_Ubicacion_Bodegas.nextval, id_producto_p, nro_estante_p, nivel_p);
            
            commit;
            if (id_producto_p is null) then
                dbms_output.put_line ('Ubicacion Bodega: ' || CHR(10) ||
                                    'Numero estante: ' || nro_estante_p || CHR(10) ||
                                    'Nivel: ' || nivel_p || CHR(10) ||
                                    'Se ingreso correctamente al sistema.');
            else
                select nombre_producto into v_nombre_producto from JRSG_Producto where id_producto = id_producto_p;
                dbms_output.put_line ('Ubicacion Bodega: ' || CHR(10) ||
                                    'Numero estante: ' || nro_estante_p || CHR(10) ||
                                    'Nivel: ' || nivel_p || CHR(10) ||
                                    'Producto: ' || v_nombre_producto || CHR(10) ||
                                    'Se ingreso correctamente al sistema.');
            end if;
        end if;
        
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;
    --- Compila correctamente en SQL Developer