create or replace NONEDITIONABLE TRIGGER JRSG_TRIG_MAYUS_TIPO_PAGO
BEFORE INSERT ON JRSG_TIPO_PAGO
FOR EACH ROW
BEGIN
    :NEW.nombre_metodo_pago := UPPER(:NEW.nombre_metodo_pago);
    :NEW.banco := UPPER(:NEW.banco);
END;
