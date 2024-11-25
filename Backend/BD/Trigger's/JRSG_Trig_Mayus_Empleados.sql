CREATE OR REPLACE TRIGGER JRSG_Trig_Mayus_Empleados
BEFORE INSERT ON JRSG_EMPLEADO 
FOR EACH ROW
BEGIN
    :NEW.nombre_empleado := UPPER(:NEW.nombre_empleado);
    :NEW.apellido1_empleado := UPPER(:NEW.apellido1_empleado);
    :NEW.apellido2_empleado := UPPER(:NEW.apellido2_empleado);
    :NEW.email_empleado := UPPER(:NEW.email_empleado);
END;
