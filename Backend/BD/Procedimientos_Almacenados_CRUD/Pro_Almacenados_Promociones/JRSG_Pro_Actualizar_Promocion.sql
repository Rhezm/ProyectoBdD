create or replace procedure JRSG_Pro_Actualizar_Promocion(
    id_promocion_p in number,
    nombre_promocion_p in varchar2 default null,
    descuento_p in number default null,
    fecha_inicio_p in date default null,
    fecha_fin_p in date default null
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Promocion where id_promocion = id_promocion_p;

        if (contador > 0) then
            lock table JRSG_Producto in row exclusive mode;

            update JRSG_Promocion set nombre_promocion = nombre_promocion_p,
                                    descuento = descuento_p,
                                    fecha_inicio = fecha_inicio_p,
                                    fecha_fin = fecha_fin_p where id_promocion = id_promocion_p;
            dbms_output.put_line ('Los datos de la promocion con ID: ' || id_promocion_p || ' se han actualizado');
            commit;
        else
            dbms_output.put_line ('Promocion con ID: ' || id_promocion_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  
    end;