create or replace procedure JRSG_Pro_Mostrar_Compra (
    id_compra_p in number
) is
    contador number;
    v_id_compra JRSG_Compra.id_compra%type;
    v_id_proveedor JRSG_Compra.id_proveedor%type;
    v_cantidad_compra JRSG_Compra.cantidad_compra%type;
    v_precio_compra JRSG_Compra.precio_compra%type;
    v_descripcion_compra JRSG_Compra.descripcion_compra%type;
    v_fecha_compra JRSG_Compra.fecha_compra%type;

    begin
        select count(*) into contador from JRSG_Compra where id_compra = id_compra_p;

        if (contador > 0) then
            select * into v_id_compra, v_id_proveedor, v_cantidad_compra, v_precio_compra, v_descripcion_compra, v_fecha_compra
            from JRSG_Compra where id_compra = id_compra_p;

            dbms_output.put_line('Informacion Compra ID: ' || id_compra_p || CHR(10) ||
                              'Proveedor: ' || v_id_proveedor || CHR(10) ||
                              'Cantidad Compra: ' || v_cantidad_compra || CHR(10) || 
                              'Descripcion Compra: ' || v_descripcion_compra || CHR(10) || 
                              'Fecha Compra: ' || v_fecha_compra);
        else
            dbms_output.put_line ('Promocion ID: '|| id_compra_p ||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;