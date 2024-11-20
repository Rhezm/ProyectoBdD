create table JRSG_Empleado ( --- Se actualizo, se agrego id_cargo
    id_empleado number,
    id_cargo number,
    nombre_empleado varchar2(20),
    apellido1_empleado varchar2(20),
    apellido2_empleado varchar2(20),
    telefono_empleado number,
    email_empleado varchar2(50),

    constraint PK_JRSG_Empleado primary key (id_empleado),
    constraint FK_JRSG_Cargo foreign key (id_cargo) references JRSG_Cargo (id_cargo)
); 