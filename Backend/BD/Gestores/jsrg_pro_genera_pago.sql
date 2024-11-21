create procedure generarpago
    @id_venta int,
    @id_tipo_pago int,
    @fecha_pago date
as
begin
    begin try
        -- declarar variables para almacenar el monto total
        declare @monto_pago numeric(10, 2);

        -- verificar si la venta existe
        if not exists (select 1 from venta where id_venta = @id_venta)
        begin
            throw 50000, 'la venta especificada no existe.', 1;
        end

        -- verificar si el tipo de pago existe
        if not exists (select 1 from tipo_pago where id_tipo_pago = @id_tipo_pago)
        begin
            throw 50001, 'el tipo de pago especificado no existe.', 1;
        end

        -- calcular el monto total del pago sumando los precios de los productos
        select @monto_pago = sum(dvp.cantidad * p.precio)
        from detalle_venta_producto dvp
        inner join producto p on dvp.id_producto = p.id_producto
        where dvp.id_venta = @id_venta;

        -- verificar si se encontró un monto válido
        if @monto_pago is null
        begin
            throw 50002, 'no se encontraron productos asociados a la venta especificada.', 1;
        end

        -- insertar el pago en la tabla
        insert into pago (id_venta, id_tipo_pago, fecha_pago, monto_pago)
        values (@id_venta, @id_tipo_pago, @fecha_pago, @monto_pago);

        print 'pago registrado exitosamente.';
    end try
    begin catch
        -- manejo de errores
        declare @errormessage nvarchar(4000);
        declare @errorseverity int;
        declare @errorstate int;

        select 
            @errormessage = error_message(),
            @errorseverity = error_severity(),
            @errorstate = error_state();

        raiserror (@errormessage, @errorseverity, @errorstate);
    end catch
end;
go
