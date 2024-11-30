create table JRSG_Detalle_Venta_Producto ( --- Se actualizo, se agrego cantidad.
    id_venta number,
    id_producto number,
    cantidad number,

    constraint PK_JRSG_Detalle_Venta_Producto primary key (id_producto, id_venta),
    constraint FK_JRSG_Venta2 foreign key (id_venta) references JRSG_Venta (id_venta),
    constraint FK_JRSG_Producto1 foreign key (id_producto) references JRSG_Producto (id_producto)
);
