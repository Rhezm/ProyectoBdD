create or replace procedure JRSG_Pro_Actualizar_Promocion(
    id_promocion_p in number,
    nombre_promocion_p in varchar2 default null,
    descuento_p in number default null,
    fecha_inicio_p in date default null,
    fecha_fin_p in date default null,
    campo_actualizar in number
)is
    contador number;
    begin
        select count(id_promocion) into contador from JRSG_Promocion;

        if (contador > 0) then
            lock table JRSG_Producto in row exclusive mode;

            case campo_actualizar
                when 2 then  -- Campo Nombre Cliente
                    update JRSG_Promocion set nombre_promocion = nombre_promocion_p where id_promocion = id_promocion_p;
                    dbms_output.put_line ('El nombre de la promocion con ID: ' || id_promocion_p || ' se ha actualizado a: ' || nombre_promocion_p);
                when 3 then  -- Campo Apellido1 Cliente
                    update JRSG_Promocion set descuento = descuento_p where id_promocion = id_promocion_p;
                    dbms_output.put_line ('El descuento de la promocion con ID: ' || id_promocion_p || ' se ha actualizado a: ' || descuento_p);
                when 4 then  -- Campo Apellido2 Cliente
                    update JRSG_Promocion set fecha_inicio = fecha_inicio_p where id_promocion = id_promocion_p;
                    dbms_output.put_line ('Fecha de inicio de la promocion con ID: ' || id_promocion_p || ' se ha actualizado a: ' || fecha_inicio_p);
                when 5 then
                    update JRSG_Promocion set fecha_fin = fecha_fin_p where id_promocion = id_promocion_p;
                    dbms_output.put_line ('Fecha de fin de la promocion con ID: ' || id_promocion_p || ' se ha actualizado a: ' || fecha_fin_p);
                else
                    dbms_output.put_line ('Campo no válido.');
            end case;
            commit;
        else
            dbms_output.put_line ('Promocion con ID: ' || id_promocion_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;

    --- Se actulizo, se agrego el case 7 por la nueva columna stock en la tabla producto.
