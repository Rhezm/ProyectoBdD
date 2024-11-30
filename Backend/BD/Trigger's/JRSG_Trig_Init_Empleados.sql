CREATE OR REPLACE TRIGGER JRSG_Trig_Init_Empleados
BEFORE INSERT ON JRSG_EMPLEADO 
FOR EACH ROW
BEGIN
    :NEW.nombre_empleado := INITCAP(:NEW.nombre_empleado);
    :NEW.apellido1_empleado := INITCAP(:NEW.apellido1_empleado);
    :NEW.apellido2_empleado := INITCAP(:NEW.apellido2_empleado);
    :NEW.email_empleado := INITCAP(:NEW.email_empleado);
END;
