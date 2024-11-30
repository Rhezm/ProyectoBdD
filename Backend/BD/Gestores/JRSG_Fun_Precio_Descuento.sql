create or replace FUNCTION jrsg_Fun_precio_descuento(valor NUMBER, descuento NUMBER)
RETURN NUMBER
IS
    valor_final NUMBER;
BEGIN
    valor_final := valor - (valor * descuento / 100);
    RETURN valor_final;
END;
