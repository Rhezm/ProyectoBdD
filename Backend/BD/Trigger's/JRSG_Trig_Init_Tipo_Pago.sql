create or replace NONEDITIONABLE TRIGGER JRSG_Trig_Init_Tipo_Pago
BEFORE INSERT ON JRSG_TIPO_PAGO
FOR EACH ROW
BEGIN
    :NEW.nombre_metodo_pago := INITCAP(:NEW.nombre_metodo_pago);
    :NEW.banco := INITCAP(:NEW.banco);
END;
