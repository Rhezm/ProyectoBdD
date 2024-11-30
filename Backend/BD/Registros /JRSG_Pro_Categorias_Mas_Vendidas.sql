create or replace PROCEDURE jrsg_pro_categorias_mas_vendidas (
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
    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado' || sqlerrm);
    rollback;
END;
