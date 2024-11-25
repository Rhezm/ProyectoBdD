create or replace procedure JRSG_Pro_Crear_Promocion (
    nombre_promocion_p in varchar2,
    descuento_p in number,
    fecha_inicio_p in date,
    fecha_fin_p in date default null
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Promocion where nombre_promocion = nombre_promocion_p;

        if (contador > 0) then
            raise_application_error (-20001, 'La promocion: '|| nombre_promocion_p ||' ya esta ingresado en el sistema.');
        else
            lock table JRSG_Promocion in row exclusive mode;

            insert into JRSG_Promocion (id_promocion, nombre_promocion, descuento, fecha_inicio, fecha_fin)
            values (JRSG_Sec_Generar_ID_Promociones.nextval, nombre_promocion_p, descuento_p, fecha_inicio_p, fecha_fin_p);
            
            commit;
            dbms_output.put_line ('Promocion con ID: '|| JRSG_Sec_Generar_ID_Promociones.currval||' se creo correctamente.');
        end if;
        
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;