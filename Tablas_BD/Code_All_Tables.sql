/* Tablas solo con PK*/
create table JRSG_Proveedor (
    id_proveedor number,
    nombre_proveedor varchar2(100),
    direccion_proveedor varchar2(200),
    telefono_proveedor number,
    email_proveedor varchar2(100),

    constraint PK_JRSG_Proveedor primary key (id_proveedor)
); 

create table JRSG_Promocion (
    id_promocion number,
    descuento number,
    fecha_inicio date,
    fecha_fin date,

    constraint PK_JRSG_Promocion primary key (id_promocion)
);

create table JRSG_Tipo_Pago (
    id_tipo_pago number,
    nombre_metodo_pago varchar2(25),
    banco varchar2(30),
    num_cuenta number,

    constraint PK_JRSG_Tipo_Pago primary key (id_tipo_pago)
); 

create table JRSG_Cliente (
    id_cliente number,
    nombre_cliente varchar2(20),
    apellido1_cliente varchar2(20),
    apellido2_cliente varchar2(20),
    telefono_cliente number,
    direccion_cliente varchar2(100),
    email_cliente varchar2(50),

    constraint PK_JRSG_Cliente primary key (id_cliente)
); 

create table JRSG_Categoria (
    id_categoria number,
    nombre_categoria varchar2(50),

    constraint PK_JRSG_Categoria primary key (id_categoria)
); 

create table JRSG_Ubicacion_Bodega (
    id_ubicacion number,
    nro_estante number,
    nivel number,

    constraint PK_JRSG_Ubicacion_Bodega primary key (id_ubicacion)
); 

/* Tablas solo con una PK y una FK */
create table JRSG_Compra (
    id_compra number,
    id_proveedor number,
    cantidad_suministro number,
    fecha_suministro date,

    constraint PK_JRSG_Compra primary key (id_compra),
    constraint FK_JRSG_Proveedor foreign key (id_proveedor) references JRSG_Proveedor (id_proveedor)
); 

create table JRSG_Sucursal (
    id_sucursal number,
    id_ubicacion number,
    nombre_sucursal varchar2(50),
    direccion_sucursal varchar2(100),
    telefono_sucursal number,
    email_sucursal varchar2(60),

    constraint PK_JRSG_Sucursal primary key (id_sucursal),
    constraint FK_JRSG_Ubicacion_Bodega foreign key (id_ubicacion) references JRSG_Ubicacion_Bodega (id_ubicacion)
); 

create table JRSG_Inventario (
    id_inventario number,
    id_sucursal number,
    cantidad_PS number,

    constraint PK_JRSG_Inventario primary key (id_inventario),
    constraint FK_JRSG_Sucursal foreign key (id_sucursal) references JRSG_Sucursal (id_sucursal)
); 

create table JRSG_Empleado (
    id_empleado number,
    id_sucursal number,
    nombre_empleado varchar2(20),
    apellido1_empleado varchar2(20),
    apellido2_empleado varchar2(20),
    puesto varchar2(30),
    salario number,
    telefono_empleado number,
    email_empleado varchar2(50),

    constraint PK_JRSG_Empleado primary key (id_empleado),
    constraint FK_JRSG_Sucursal1 foreign key (id_sucursal) references JRSG_Sucursal (id_sucursal)
); 

create table JRSG_Venta (
    id_venta number,
    id_cliente number,
    fecha_venta date,
    cantidad_venta number,

    constraint PK_JRSG_Venta primary key (id_venta),
    constraint FK_JRSG_Cliente foreign key (id_cliente) references JRSG_Cliente (id_cliente)
); 

/* Tablas solo con una PK y dos FK*/
create table JRSG_Pago (
    id_pago number,
    id_venta number,
    id_tipo_pago number,
    fecha_pago date,
    monto_pago number,

    constraint PK_JRSG_Pago primary key (id_pago),
    constraint FK_JRSG_Venta foreign key (id_venta) references JRSG_Venta (id_venta),
    constraint FK_JRSG_Tipo_Pago foreign key (id_tipo_pago) references JRSG_Tipo_Pago (id_tipo_pago)
); 

create table JRSG_Producto (
    id_producto number,
    id_categoria number,
    id_promocion number,
    nombre_producto varchar2(60),
    descripcion_producto varchar2(200),
    precio number,

    constraint PK_JRSG_Producto primary key (id_producto),
    constraint FK_JRSG_Categoria foreign key (id_categoria) references JRSG_Categoria (id_categoria),
    constraint FK_JRSG_Promocion foreign key (id_promocion) references JRSG_Promocion (id_promocion)
); 

/* Tablas solo con una PK y tres FK */
create table JRSG_Boleta (
    id_boleta number,
    id_cliente number,
    id_venta number,
    id_pago number,
    fecha_boleta date,

    constraint PK_JRSG_Boleta primary key (id_boleta),
    constraint FK_JRSG_Cliente1 foreign key (id_cliente) references JRSG_Cliente,
    constraint FK_JRSG_Venta1 foreign key (id_venta) references JRSG_Venta (id_venta),
    constraint FK_JRSG_Pago foreign key (id_pago) references JRSG_Pago (id_pago)
); 

/* Tablas dos PK y dos FK */
create table JRSG_Detalle_Compra_Producto (
    id_compra number,
    id_producto number,

    constraint PK_JRSG_Detalle_Compra_Producto primary key (id_compra, id_producto),
    constraint FK_JRSG_Compra foreign key (id_compra) references JRSG_Compra (id_compra),
    constraint FK_JRSG_Producto foreign key (id_producto) references JRSG_Producto (id_producto)
);

create table JRSG_Detalle_Venta_Producto (
    id_venta number,
    id_producto number,

    constraint PK_JRSG_Detalle_Venta_Producto primary key (id_venta, id_producto),
    constraint FK_JRSG_Venta2 foreign key (id_venta) references JRSG_Venta (id_venta),
    constraint FK_JRSG_Producto1 foreign key (id_producto) references JRSG_Producto (id_producto)
); 

/* Tablas con tres PK y tres FK */
create table JRSG_Detalle_Inventario_Producto_Ubicacion (
    id_inventario number,
    id_producto number,
    id_ubicacion number,

    constraint PK_Detalle_Inventario_Producto_Ubicacion primary key (id_inventario, id_producto, id_ubicacion),
    constraint FK_JRSG_Inventario foreign key (id_inventario) references JRSG_Inventario (id_inventario),
    constraint FK_JRSG_Producto2 foreign key (id_producto) references JRSG_Producto (id_producto),
    constraint FK_JRSG_Ubicacion_Bodega1 foreign key (id_ubicacion) references JRSG_Ubicacion_Bodega (id_ubicacion)
);