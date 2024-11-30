create or replace FUNCTION jrsg_Fun_Calcular_iva(valor NUMBER)
RETURN NUMBER
IS
    iva NUMBER;
BEGIN
    iva := valor / 1.19;
    RETURN iva;
END;
