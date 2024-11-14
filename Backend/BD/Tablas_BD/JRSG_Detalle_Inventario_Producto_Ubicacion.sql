create table JRSG_Detalle_Inventario_Producto_Ubicacion (
    id_inventario number,
    id_producto number,
    id_ubicacion number,

    constraint PK_Detalle_Inventario_Producto_Ubicacion primary key (id_inventario, id_producto, id_ubicacion),
    constraint FK_JRSG_Inventario foreign key (id_inventario) references JRSG_Inventario (id_inventario),
    constraint FK_JRSG_Producto2 foreign key (id_producto) references JRSG_Producto (id_producto),
    constraint FK_JRSG_Ubicacion_Bodega1 foreign key (id_ubicacion) references JRSG_Ubicacion_Bodega (id_ubicacion)
);