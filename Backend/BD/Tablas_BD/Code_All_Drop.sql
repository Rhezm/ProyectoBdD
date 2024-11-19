drop table JRSG_Detalle_Producto_Ubicacion;
drop table JRSG_Detalle_Venta_Producto;
drop table JRSG_Detalle_Compra_Producto;
drop table JRSG_Historial_Cargo;
drop table JRSG_Boleta;
drop table JRSG_Producto;
drop table JRSG_Pago;
drop table JRSG_Venta;
drop table JRSG_Empleado;
drop table JRSG_Compra;
drop table JRSG_Cargo;
drop table JRSG_Ubicacion_Bodega;
drop table JRSG_Categoria;
drop table JRSG_Cliente;
drop table JRSG_Tipo_Pago;
drop table JRSG_Promocion;
drop table JRSG_Proveedor;

drop sequence JRSG_Sec_Generar_ID_Categorias;
drop sequence JRSG_Sec_Generar_ID_Clientes;
drop sequence JRSG_Sec_Generar_ID_Productos;
drop sequence JRSG_Sec_Generar_ID_Promociones;
drop sequence JRSG_Sec_Generar_ID_Proveedores;
drop sequence JRGS_Sec_Generar_ID_Compras;
drop sequence JRSG_Sec_Generar_ID_Tipo_Pagos;
drop sequence JRSG_Sec_Generar_ID_Pagos;
drop sequence JRSG_Sec_Generar_ID_Boletas;
drop sequence JRSG_Sec_Generar_ID_Ventas;
drop sequence JRSG_Sec_Generar_ID_Empleados;
drop sequence JRSG_Sec_Generar_ID_Ubicacion_Bodega;


drop procedure JRSG_Pro_Actualizar_Categoria;
drop procedure JRSG_Pro_Crear_Categoria;
drop procedure JRSG_Pro_Mostrar_Categoria;
drop procedure JRSG_Pro_Eliminar_Categoria;

drop procedure JRSG_Pro_Actualizar_Cliente;
drop procedure JRSG_Pro_Crear_Cliente;
drop procedure JRSG_Pro_Mostrar_Cliente;
drop procedure JRSG_Pro_Eliminar_Cliente;

drop procedure JRSG_Pro_Actualizar_Producto;
drop procedure JRSG_Pro_Crear_Producto;
drop procedure JRSG_Pro_Mostrar_Producto;
drop procedure JRSG_Pro_Eliminar_Producto;
