create table JRSG_Historial_Cargo ( --- Nueva Tabla
    inicio_fecha date,
    id_empleado number,
    id_cargo number,
    final_fecha date,

    constraint PK_JRSG_Historial_Cargo primary key (inicio_fecha, id_empleado),
    constraint FK_JRSG_Empleado foreign key (id_empleado) references JRGS_Empleado (id_empleado),
    constraint FK_JRSG_Cargo1 foreign key (id_cargo) references JRSG_Cargo (id_cargo)
);