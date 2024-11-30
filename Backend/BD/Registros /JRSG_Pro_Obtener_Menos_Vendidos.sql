create or replace PROCEDURE jrsg_pro_obtener_menos_vendidos (
  p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_cursor FOR
    SELECT p.id_producto AS a, p.nombre_producto AS aa, SUM(dvp.cantidad) AS total_vendido
    FROM jrsg_detalle_venta_producto dvp
    INNER JOIN jrsg_producto p ON dvp.id_producto = p.id_producto
    GROUP BY p.id_producto, p.nombre_producto
    ORDER BY total_vendido ASC
    FETCH FIRST 10 ROWS ONLY;
    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado' || sqlerrm);
    rollback;
END;
