create or replace procedure jrsg_pro_genera_pago(
	p_id_venta number,
	p_monto_pago number
)
as
begin
	select id_producto, p_monto_pago := sum(dvp.cantidad * p.precio)
	from jrsg_detalle_venta_producto
	inner join producto p on dvp.id_producto = p.id_producto
	where dvp.id_venta = p_id_venta;
end;
