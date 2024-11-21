create or replace procedure JRSG_Pro_Eliminar_Ubicacion_Bodega (
    id_ubicacion_p in number

) is
    contador number;
    begin
        select count(*) into contador from JRSG_Ubicacion_Bodega where id_ubicacion = id_ubicacion_p;

        if (contador > 0) then
            lock table JRSG_Ubicacion_Bodega in row exclusive mode;

            delete from JRSG_Ubicacion_Bodega where id_ubicacion = id_ubicacion_p;
            dbms_output.put_line ('La Ubicacion Bodega ID: '|| id_ubicacion_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Ubicacion Bodega ID: '|| id_ubicacion_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;

--- Compila correctamente en SQL Developer