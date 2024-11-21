create table JRSG_Venta (
    id_venta number,
    id_cliente number,
    fecha_venta date,

    constraint PK_JRSG_Venta primary key (id_venta),
    constraint FK_JRSG_Cliente foreign key (id_cliente) references JRSG_Cliente (id_cliente)
);