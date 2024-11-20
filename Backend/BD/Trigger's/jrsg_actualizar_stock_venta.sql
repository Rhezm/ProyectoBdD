CREATE OR REPLACE TRIGGER JRSG_trig_actualizar_stock
AFTER INSERT ON JRSG_Detalle_Venta_Producto
FOR EACH ROW
DECLARE
  v_stock_actual NUMBER;
BEGIN
  -- Actualizar el stock en la tabla Producto
  UPDATE Producto
  SET stock = stock - :NEW.cantidad
  WHERE id_producto = :NEW.id_producto;

  -- Obtener el stock actualizado para validación
  SELECT stock
  INTO v_stock_actual
  FROM JRSG_Producto
  WHERE id_producto = :NEW.id_producto;

  -- Validar que el stock no sea negativo
  IF v_stock_actual < 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Stock insuficiente para el producto con ID: ' || :NEW.id_producto);
  END IF;
END;
