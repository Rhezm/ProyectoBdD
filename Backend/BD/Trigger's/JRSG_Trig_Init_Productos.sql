CREATE OR REPLACE TRIGGER JRSG_Trig_Mayus_Productos
BEFORE INSERT ON JRSG_PRODUCTO 
FOR EACH ROW
BEGIN
    :NEW.nombre_producto := INITCAP(:NEW.nombre_producto);
    :NEW.descripcion_producto := INITCAP(:NEW.descripcion_producto);
END;
