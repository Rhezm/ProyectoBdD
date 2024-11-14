/* Para poder modificar la tabla JRSG_Proveedor, en caso de cualquier cosa */
create table JRSG_Proveedor (
    id_proveedor number,
    nombre_proveedor varchar2(100),
    direccion_proveedor varchar2(200),
    telefono_proveedor number,
    email_proveedor varchar2(100),

    constraint PK_JRSG_Proveedor primary key (id_proveedor)
);