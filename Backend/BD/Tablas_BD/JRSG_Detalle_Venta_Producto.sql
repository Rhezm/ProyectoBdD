create table JRSG_Detalle_Venta_Producto ( --- Se actualizo, se agrego cantidad.
    id_producto number,
    id_venta number,
    cantidad number,
    nombre_producto varchar2(60),

    constraint PK_JRSG_Detalle_Venta_Producto primary key (id_producto, id_venta),
    constraint FK_JRSG_Venta2 foreign key (id_venta) references JRSG_Venta (id_venta),
    constraint FK_JRSG_Producto1 foreign key (id_producto) references JRSG_Producto (id_producto)
);
