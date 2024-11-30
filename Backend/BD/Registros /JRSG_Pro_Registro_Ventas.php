create or replace PROCEDURE jrsg_pro_registro_ventas(
  p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_cursor FOR
    SELECT dvp.id_venta AS a, p.nombre_producto AS aa, dvp.cantidad AS aaa, v.fecha_venta AS aaaa
    FROM jrsg_detalle_venta_producto dvp
    INNER JOIN jrsg_venta v ON dvp.id_venta = v.id_venta
    INNER JOIN jrsg_producto p ON dvp.id_producto = p.id_producto
    GROUP BY dvp.id_venta, p.nombre_producto, dvp.cantidad, v.fecha_venta
    ORDER BY dvp.id_venta;
END