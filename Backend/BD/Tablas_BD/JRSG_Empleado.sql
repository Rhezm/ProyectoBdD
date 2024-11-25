create table JRSG_Empleado (
    id_empleado number,
    nombre_empleado varchar2(20),
    apellido1_empleado varchar2(20),
    apellido2_empleado varchar2(20),
    telefono_empleado number,
    email_empleado varchar2(50),
    contrasena varchar2(18),

    constraint PK_JRSG_Empleado primary key (id_empleado)
); 