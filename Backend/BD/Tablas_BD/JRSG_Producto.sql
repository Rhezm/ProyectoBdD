create table JRSG_Producto (
    id_producto number,
    id_categoria number,
    nombre_producto varchar2(60),
    descripcion_producto varchar2(200),
    precio number,
    stock number,

    constraint PK_JRSG_Producto primary key (id_producto),
    constraint FK_JRSG_Categoria foreign key (id_categoria) references JRSG_Categoria (id_categoria)
); 
