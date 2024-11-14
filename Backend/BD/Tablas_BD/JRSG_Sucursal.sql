create table JRSG_Sucursal (
    id_sucursal number,
    id_ubicacion number,
    nombre_sucursal varchar2(50),
    direccion_sucursal varchar2(100),
    telefono_sucursal number,
    email_sucursal varchar2(60),

    constraint PK_JRSG_Sucursal primary key (id_sucursal),
    constraint FK_JRSG_Ubicacion_Bodega foreign key (id_ubicacion) references JRSG_Ubicacion_Bodega (id_ubicacion)
);