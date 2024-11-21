create table JRSG_Ubicacion_Bodega (
    id_ubicacion number,
    id_producto number,
    nro_estante number,
    nivel number,

    constraint PK_JRSG_Ubicacion_Bodega primary key (id_ubicacion),
    constraint FK_JRSG_Producto2 foreign key (id_producto) references JRSG_Producto
); 
