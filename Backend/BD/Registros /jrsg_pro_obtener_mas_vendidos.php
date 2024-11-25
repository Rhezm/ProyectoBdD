create or replace PROCEDURE jrsg_pro_obtener_mas_vendidos (
  p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_cursor FOR
    SELECT p.id_producto AS a, p.nombre_producto AS aa, SUM(dvp.cantidad) AS total_vendido
    FROM jrsg_detalle_venta_producto dvp
    INNER JOIN jrsg_producto p ON dvp.id_producto = p.id_producto
    GROUP BY p.id_producto, p.nombre_producto
    ORDER BY total_vendido DESC
    FETCH FIRST 10 ROWS ONLY;
  CLOSE p_cursor;
END;

