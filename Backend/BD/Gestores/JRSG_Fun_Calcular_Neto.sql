create or replace FUNCTION jrsg_Fun_Calcular_neto(valor NUMBER)
RETURN NUMBER
IS
    neto NUMBER;
BEGIN
    neto := valor * (1 - 0.19 / 1.19);
    RETURN neto;
END;
