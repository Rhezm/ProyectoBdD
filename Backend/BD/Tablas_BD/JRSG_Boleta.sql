create table JRSG_Boleta ( --- Se actualizo
    id_boleta number,
    id_cliente number,
    id_venta number,
    id_pago number,
    fecha_boleta date,
    valor_neto number,
    total_IVA number,

    constraint PK_JRSG_Boleta primary key (id_boleta),
    constraint FK_JRSG_Cliente1 foreign key (id_cliente) references JRSG_Cliente,
    constraint FK_JRSG_Venta1 foreign key (id_venta) references JRSG_Venta (id_venta),
    constraint FK_JRSG_Pago foreign key (id_pago) references JRSG_Pago (id_pago)
);