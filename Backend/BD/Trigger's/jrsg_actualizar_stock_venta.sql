create or replace trigger trg_actualizar_stock_venta
after insert on jrsg_detalle_venta_producto
for each row
begin
  update jrsg_producto
  set stock = stock - :new.cantidad
  where id_producto = :new.id_producto;

  -- validar que el stock no sea negativo
  if (select stock from jrsg_producto where id_producto = :new.id_producto) < 0 then
    raise_application_error(-20003, 'stock insuficiente para el producto ' || :new.id_producto);
  end if;
end;

