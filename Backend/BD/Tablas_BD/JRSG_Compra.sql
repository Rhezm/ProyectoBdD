create table JRSG_Compra ( --- Se actualizo, se agrego catidad_compra, precio_compra, descripcion_compra y fecha_compra.
    id_compra number,
    id_proveedor number,
    cantidad_compra number,
    precio_compra number,
    descripcion_compra varchar2(100),
    fecha_compra date

    constraint PK_JRSG_Compra primary key (id_compra),
    constraint FK_JRSG_Proveedor foreign key (id_proveedor) references JRSG_Proveedor (id_proveedor)
);