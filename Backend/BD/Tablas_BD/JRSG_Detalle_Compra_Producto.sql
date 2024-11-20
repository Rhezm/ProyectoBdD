create table JRSG_Detalle_Compra_Producto (
    id_compra number,
    id_producto number,
    cantidad number,
    nombre_producto varchar2(60),
    precio_compra number,
    precio_total number,

    constraint PK_JRSG_Detalle_Compra_Producto primary key (id_compra, id_producto),
    constraint FK_JRSG_Compra foreign key (id_compra) references JRSG_Compra (id_compra),
    constraint FK_JRSG_Producto foreign key (id_producto) references JRSG_Producto (id_producto)
);
