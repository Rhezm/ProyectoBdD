create table JRSG_Cliente (
    id_cliente number,
    nombre_cliente varchar2(20),
    apellido1_cliente varchar2(20),
    apellido2_cliente varchar2(20),
    telefono_cliente number,
    direccion_cliente varchar2(100),
    email_cliente varchar2(50),

    constraint PK_JRSG_Cliente primary key (id_cliente)
);