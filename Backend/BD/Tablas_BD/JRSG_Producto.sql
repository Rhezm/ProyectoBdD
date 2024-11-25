create table JRSG_Producto (
    id_producto number,
    id_categoria number,
    id_promocion number,
    nombre_producto varchar2(60),
    descripcion_producto varchar2(200),
    precio number,
    precio_descuento number,
    stock number,

    constraint PK_JRSG_Producto primary key (id_producto),
    constraint FK_JRSG_Categoria foreign key (id_categoria) references JRSG_Categoria (id_categoria),
    constraint FK_JRSG_Promocion foreign key (id_promocion) references JRSG_Promocion (id_promocion)
); 