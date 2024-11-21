create or replace procedure JRSG_Pro_Mostrar_Ubicacion_Bodega (
    id_ubicacion_p in number
) is
    contador number;
    v_id_ubicacion JRSG_Ubicacion_Bodega.id_ubicacion%type;
    v_id_producto JRSG_Producto.id_producto%type;
    v_nombre_producto JRSG_Producto.nombre_producto%type;
    v_nro_estante JRSG_Ubicacion_Bodega.nro_estante%type;
    v_nivel JRSG_Ubicacion_Bodega.nivel%type;

    begin
        select count(*) into contador from JRSG_Ubicacion_Bodega where id_ubicacion = id_ubicacion_p;

        if (contador > 0) then
            select * into v_id_ubicacion, v_id_producto, v_nro_estante, v_nivel from JRSG_Ubicacion_Bodega where id_ubicacion = id_ubicacion_p;
            select nombre_producto into v_nombre_producto from JRSG_Producto where id_producto = v_id_producto;

            dbms_output.put_line('Informacion Ubicacion Bodega ID: ' || id_ubicacion_p || CHR(10) ||
                              'Numero estante: ' || v_nro_estante || CHR(10) ||
                              'Nivel: ' || v_nivel || CHR(10) ||
                              'Producto: ' || v_nombre_producto);
        else
            dbms_output.put_line ('Ubicacion Bodega ID: '|| id_ubicacion_p ||' no encontrado en el sistema.');
        end if;
        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;