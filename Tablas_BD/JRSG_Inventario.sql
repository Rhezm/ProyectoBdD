create table JRSG_Inventario (
    id_inventario number,
    id_sucursal number,
    cantidad_PS number,

    constraint PK_JRSG_Inventario primary key (id_inventario),
    constraint FK_JRSG_Sucursal foreign key (id_sucursal) references JRSG_Sucursal (id_sucursal)
);