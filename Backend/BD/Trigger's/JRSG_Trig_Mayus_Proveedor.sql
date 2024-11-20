CREATE OR REPLACE TRIGGER JRSG_TRIG_MAYUS_CLIENTES
BEFORE INSERT ON JRSG_CLIENTE 
FOR EACH ROW
BEGIN
    :NEW.NOMBRE_CLIENTE := UPPER(:NEW.NOMBRE_CLIENTE);
    :NEW.apellido1_cliente := UPPER(:NEW.apellido1_cliente);
    :NEW.apellido2_cliente := UPPER(:NEW.apellido2_cliente);
    :NEW.direccion_cliente := UPPER(:NEW.direccion_cliente);
    :NEW.email_cliente := UPPER(:NEW.email_cliente);
END;
