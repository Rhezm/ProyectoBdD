CREATE OR REPLACE TRIGGER JRSG_TRIG_MAYUS_PRODUCTOS
BEFORE INSERT ON JRSG_PRODUCTO 
FOR EACH ROW
BEGIN
    :NEW.nombre_producto := UPPER(:NEW.nombre_producto);
    :NEW.descripcion_producto := UPPER(:NEW.descripcion_producto);
    :NEW.proveedor := UPPER(:NEW.proveedor);
END;
