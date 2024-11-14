create table JRSG_Empleado (
    id_empleado number,
    id_sucursal number,
    nombre_empleado varchar2(20),
    apellido1_empleado varchar2(20),
    apellido2_empleado varchar2(20),
    puesto varchar2(30),
    salario number,
    telefono_empleado number,
    email_empleado varchar2(50),

    constraint PK_JRSG_Empleado primary key (id_empleado),
    constraint FK_JRSG_Sucursal1 foreign key (id_sucursal) references JRSG_Sucursal (id_sucursal)
);