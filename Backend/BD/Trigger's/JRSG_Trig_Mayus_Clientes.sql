CREATE OR REPLACE TRIGGER JRSG_Trig_Mayus_Clientes
BEFORE INSERT ON JRSG_CLIENTE 
FOR EACH ROW
BEGIN
    :NEW.NOMBRE_CLIENTE := INITCAP(:NEW.NOMBRE_CLIENTE);
    :NEW.apellido1_cliente := INITCAP(:NEW.apellido1_cliente);
    :NEW.apellido2_cliente := INITCAP(:NEW.apellido2_cliente);
    :NEW.direccion_cliente := INITCAP(:NEW.direccion_cliente);
    :NEW.email_cliente := INITCAP(:NEW.email_cliente);
END;
