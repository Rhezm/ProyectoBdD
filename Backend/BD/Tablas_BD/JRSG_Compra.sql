create table JRSG_Compra ( 
    id_compra number,
    detalle_compra varchar2(100),
    monto_compra number,
    fecha_compra date,

    constraint PK_JRSG_Compra primary key (id_compra)
); 