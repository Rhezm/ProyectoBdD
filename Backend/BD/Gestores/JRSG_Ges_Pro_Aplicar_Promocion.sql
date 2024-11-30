create or replace procedure JRSG_pro_Aplicar_Promocion  
is
    v_descuento number;
    v_precio number;
    v_precio_descuento number;

    begin
        for p in (select id_producto, id_promocion, precio from JRSG_Producto where id_promocion is not null)

        loop
          select pro.descuento into v_descuento from JRSG_Promocion pro where pro.id_promocion = p.id_promocion;

          v_precio := p.precio;
          v_precio_descuento := v_precio - (v_precio * (v_descuento / 100));

          JRSG_Pro_Actualizar_Producto (p.id_producto, null, null, null, null, null, v_precio_descuento, null);
        end loop
        commit;
    end;