create table TB_Nueva_Venta_JRSG (
    codigo_producto number,
    nombre_producto varchar2(100),
    cantidad_producto number,
    precio_producto number,
    stock_producto number,
);

create table TB_Clientes_JRSG (
    id_cliente number,
    rut_cliente number,
    nombre_cliente varchar2(80),
    apellido1_cliente varchar2(50),
    apellido2_cliente varchar2(50),
    telefono_cliente number, 
    email_cliente varchar2(150)
);

create table TB_Proveedores_JRSG (
    id_proveedor number,
    nombre_proveedor varchar2(150),
    telefono_proveedor number,
    email_proveedor varchar2(150)
);

create table TB_Venta_JRSG (
    id_venta number,
    id_cliente number,
    metodo_pago varchar2(20),
    total_venta number,
    sucursal number
);

create table TB_Configuracion_JRSg (
    
)
