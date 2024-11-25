create or replace PROCEDURE JRSG_Pro_Categorias_Mas_Vendidas (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT c.id_categoria AS a, c.nombre_categoria AS aa, SUM(dvp.cantidad) AS total_vendido
        FROM jrsg_detalle_venta_producto dvp
        INNER JOIN jrsg_producto p ON dvp.id_producto = p.id_producto
        INNER JOIN jrsg_categoria c ON c.id_categoria = p.id_categoria
        GROUP BY c.id_categoria, c.nombre_categoria 
        ORDER BY total_vendido DESC
        FETCH FIRST 5 ROWS ONLY;
    CLOSE p_cursor;
END;
