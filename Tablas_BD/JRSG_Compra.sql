create table JRSG_Compra (
    id_compra number,
    id_proveedor number,
    cantidad_suministro number,
    fecha_suministro date,

    constraint PK_JRSG_Compra primary key (id_compra),
    constraint FK_JRSG_Proveedor foreign key (id_proveedor) references JRSG_Proveedor (id_proveedor)
);