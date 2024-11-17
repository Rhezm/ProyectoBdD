create or replace procedure JRSG_Pro_Mostrar_Promocion (
    id_promocion_p in number
) is
    contador number;
    v_id_promocion JRSG_Promocion.id_producto%type;
    v_nombre_promocion JRSG_Promocion.nombre_promocion%type;
    v_descuento JRSG_Promocion.descuento%type;
    v_fecha_inicio JRSG_Promocion.fecha_inicio%type;
    v_fecha_fin JRSG_Promocion.fecha_fin%type;

    begin
        select count(*) into contador from JRSG_Promocion where id_promocion = id_promocion_p;

        if (contador > 0) then
            select * into v_id_promocion, v_nombre_promocion, v_descuento, v_fecha_inicio, v_fecha_fin
            from JRSG_Promocion where id_promocion = id_promocion_p;

            dbms_output.put_line('Informacion Promocion ID: ' || id_promocion_p || CHR(10) ||
                              'Nombre: ' || v_nombre_promocion || CHR(10) ||
                              'Descuento: ' || v_descuento || CHR(10) || 
                              'Fecha Inicio: ' || v_fecha_inicio || CHR(10) || 
                              'Fecha Fin: ' || v_fecha_fin);
        else
            dbms_output.put_line ('Promocion ID: '|| id_promocion_p ||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;