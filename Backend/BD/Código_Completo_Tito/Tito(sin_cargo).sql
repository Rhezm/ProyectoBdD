/* Tablas solo con PK*/

create table JRSG_Promocion (
    id_promocion number,
    nombre_promocion varchar2(25),
    descuento number,
    fecha_inicio date,
    fecha_fin date,

    constraint PK_JRSG_Promocion primary key (id_promocion)
);

create table JRSG_Tipo_Pago (
    id_tipo_pago number,
    nombre_metodo_pago varchar2(25),
    banco varchar2(30),
    num_cuenta number,

    constraint PK_JRSG_Tipo_Pago primary key (id_tipo_pago)
); 

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

create table JRSG_Categoria (
    id_categoria number,
    nombre_categoria varchar2(50),

    constraint PK_JRSG_Categoria primary key (id_categoria)
);

create table JRSG_Compra ( 
    id_compra number,
    monto_compra number,
    fecha_compra date,

    constraint PK_JRSG_Compra primary key (id_compra)
);  

/* Tablas solo con una PK y una FK */

create table JRSG_Empleado ( --- Se actualizo
    id_empleado number,
    id_cargo number,
    nombre_empleado varchar2(20),
    apellido1_empleado varchar2(20),
    apellido2_empleado varchar2(20),
    telefono_empleado number,
    email_empleado varchar2(50),
    contrasena varchar2(18),

    constraint PK_JRSG_Empleado primary key (id_empleado)
); 


create table JRSG_Venta (
    id_venta number,
    id_cliente number,
    fecha_venta date,

    constraint PK_JRSG_Venta primary key (id_venta),
    constraint FK_JRSG_Cliente foreign key (id_cliente) references JRSG_Cliente (id_cliente)
); 

/* Tablas solo con una PK y dos FK*/
create table JRSG_Pago (
    id_pago number,
    id_venta number,
    id_tipo_pago number,
    fecha_pago date,
    monto_pago number,

    constraint PK_JRSG_Pago primary key (id_pago),
    constraint FK_JRSG_Venta foreign key (id_venta) references JRSG_Venta (id_venta),
    constraint FK_JRSG_Tipo_Pago foreign key (id_tipo_pago) references JRSG_Tipo_Pago (id_tipo_pago)
); 

create table JRSG_Producto ( --- Se actualizo
    id_producto number,
    id_categoria number,
    id_promocion number,
    nombre_producto varchar2(60),
    descripcion_producto varchar2(200),
    precio number,
    precio_descuento number,
    stock number,
    proveedor varchar2(50),

    constraint PK_JRSG_Producto primary key (id_producto),
    constraint FK_JRSG_Categoria foreign key (id_categoria) references JRSG_Categoria (id_categoria),
    constraint FK_JRSG_Promocion foreign key (id_promocion) references JRSG_Promocion (id_promocion)
);

create table JRSG_Ubicacion_Bodega (
    id_ubicacion number,
    id_producto number,
    nro_estante number,
    nivel number,

    constraint PK_JRSG_Ubicacion_Bodega primary key (id_ubicacion),
    constraint FK_JRSG_Ubicacion_Bodega_Id_Producto foreign key(id_producto) references JRSG_PRODUCTO(id_producto)
);
/* Tablas dos PK y dos FK */

create table JRSG_Detalle_Compra_Producto (
    id_compra number,
    id_producto number,
    cantidad number,
    nombre_producto varchar2(60),
    precio_compra number,
    precio_total number,

    constraint PK_JRSG_Detalle_Compra_Producto primary key (id_compra, id_producto),
    constraint FK_JRSG_Compra foreign key (id_compra) references JRSG_Compra (id_compra),
    constraint FK_JRSG_Producto foreign key (id_producto) references JRSG_Producto (id_producto)
);

create table JRSG_Detalle_Venta_Producto ( --- Se actualizo
    id_producto number,
    id_venta number,
    cantidad number,

    constraint PK_JRSG_Detalle_Venta_Producto primary key (id_producto, id_venta),
    constraint FK_JRSG_Venta2 foreign key (id_venta) references JRSG_Venta (id_venta),
    constraint FK_JRSG_Producto1 foreign key (id_producto) references JRSG_Producto (id_producto)
); 

create table JRSG_Detalle_Producto_Ubicacion ( --- Se Actualizo 
    id_producto number,
    id_ubicacion number,

    constraint PK_Detalle_Producto_Ubicacion primary key (id_producto, id_ubicacion),
    constraint FK_JRSG_Producto2 foreign key (id_producto) references JRSG_Producto (id_producto),
    constraint FK_JRSG_Ubicacion_Bodega1 foreign key (id_ubicacion) references JRSG_Ubicacion_Bodega (id_ubicacion)
);

/* Una PK y Cuatro FK */
create table JRSG_Boleta ( --- Se actualizo
    id_boleta number,
    id_cliente number,
    id_venta number,
    id_pago number,
    id_empleado number,
    fecha_boleta date,
    valor_neto number,
    total_IVA number,

    constraint PK_JRSG_Boleta primary key (id_boleta),
    constraint FK_JRSG_Cliente1 foreign key (id_cliente) references JRSG_Cliente,
    constraint FK_JRSG_Venta1 foreign key (id_venta) references JRSG_Venta (id_venta),
    constraint FK_JRSG_Pago foreign key (id_pago) references JRSG_Pago (id_pago),
    constraint FK_JRSG_Empleado foreign key (id_empleado) references JRSG_Empleado (id_empleado)
); 


------SECUENCIAS------------------------
create sequence JRSG_Sec_Generar_ID_Boletas
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Categorias
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Clientes
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Compras
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Empleados
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Pagos
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Productos
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Promociones
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Proveedores
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Tipo_Pagos
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Ubicacion_Bodegas
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Generar_ID_Ventas
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
create sequence JRSG_Sec_Genera_ID_Boleta
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle;
/*    
create sequence JRSG_Sec_Generar_ID_Detalle_Compra_Producto
    start with 1 
    increment by 1
    minvalue 1
    maxvalue 1000
    nocache
    nocycle; */
-------------TRIGGER'S----------------------------------------------------------
-------TRIGGER MAYUSCULAS CLIENTES
CREATE OR REPLACE TRIGGER JRSG_TRIG_MAYUS_CLIENTES
BEFORE INSERT ON JRSG_CLIENTE 
FOR EACH ROW
BEGIN
    :NEW.NOMBRE_CLIENTE := UPPER(:NEW.NOMBRE_CLIENTE);
    :NEW.apellido1_cliente := UPPER(:NEW.apellido1_cliente);
    :NEW.apellido2_cliente := UPPER(:NEW.apellido2_cliente);
    :NEW.direccion_cliente := UPPER(:NEW.direccion_cliente);
    :NEW.email_cliente := UPPER(:NEW.email_cliente);
END;

-------TRIGGER MAYUSCULAS EMPLEADOS
CREATE OR REPLACE TRIGGER JRSG_TRIG_MAYUS_EMPLEADOS
BEFORE INSERT ON JRSG_EMPLEADO 
FOR EACH ROW
BEGIN
    :NEW.nombre_empleado := UPPER(:NEW.nombre_empleado);
    :NEW.apellido1_empleado := UPPER(:NEW.apellido1_empleado);
    :NEW.apellido2_empleado := UPPER(:NEW.apellido2_empleado);
    :NEW.email_empleado := UPPER(:NEW.email_empleado);
END;

-------TRIGGER MAYUSCULAS PRODUCTOS
CREATE OR REPLACE TRIGGER JRSG_TRIG_MAYUS_PRODUCTOS
BEFORE INSERT ON JRSG_PRODUCTO 
FOR EACH ROW
BEGIN
    :NEW.nombre_producto := UPPER(:NEW.nombre_producto);
    :NEW.descripcion_producto := UPPER(:NEW.descripcion_producto);
    :NEW.proveedor := UPPER(:NEW.proveedor);
END;

------TRIGGER PARA ACTUALIZAR STOCK
CREATE OR REPLACE TRIGGER JRSG_trig_actualizar_stock
AFTER INSERT ON JRSG_Detalle_Venta_Producto
FOR EACH ROW
DECLARE
  v_stock_actual NUMBER;
BEGIN
  -- Actualizar el stock en la tabla Producto
  UPDATE JRSG_Producto
  SET stock = stock - :NEW.cantidad
  WHERE id_producto = :NEW.id_producto;

  -- Obtener el stock actualizado para validación
  SELECT stock INTO v_stock_actual
  FROM JRSG_Producto
  WHERE id_producto = :NEW.id_producto;

  -- Validar que el stock no sea negativo
  IF v_stock_actual < 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Stock insuficiente para el producto con ID: ' || :NEW.id_producto);
  END IF;
END;

-------------------------------------// REQUERIMIENTOS \\-------------------------------------

-- 1.- Control de acceso, a través de un usuario y una contraseña, considerando distintos...
-- ...usuarios con distintos perfiles, asegurando confidencialidad de la información.

-- USAR UN "HASH" PARA ENCRIPTAR LA CONSTRASEÑA.

---------------------------------------------------------------------------------------------------------------

-- 2.- 10 mantenedores, siendo cada uno de estos la definición de operadores CRUD
-- ..(Manejan información en términos de Creación de Datos (Insert), Lectura de datos
-- ..(Select), Actualización de datos (Update) y Borrado de Datos (Delete)). Donde debe
-- ..asegurar, que para aumentar la persistencia de los datos, se debe trabajar la
-- ..concurrencia y asegurar integridad de la información, todo a través de cursores en caso
-- ..de los select y procedimientos almacenados que sean capaces de llevar a cabo las
-- ..operaciones, donde también será necesario el uso de funciones y secuencias. Por
-- ..último, la aplicación en términos de programación debe llamar a los últimos
-- ..mencionados para realizar operaciones.


----------------------CREAR-MOSTRAR-VENTA---------------------------------------------------------------------
-----CREAR VENTA
create or replace procedure JRSG_Pro_Crear_Venta (
    id_cliente_v in number
) is
    v_fecha_venta date;
begin
    lock table JRSG_Venta in row exclusive mode;
    
    v_fecha_venta := SYSDATE;

    insert into JRSG_Venta (id_venta, id_cliente, fecha_venta)
    values (JRSG_Sec_Generar_ID_Ventas.nextval, id_cliente_v, v_fecha_venta);

    commit;
        dbms_output.put_line ('Venta con ID: '|| JRSG_Sec_Generar_ID_Ventas.currval ||' se creo correctamente.');

    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;    
end;

-----MOSTRAR-VENTA----------------------------------------------------------------------------------------------------
create or replace procedure JRSG_Pro_Mostrar_Venta (
    id_venta_p in number
)is
    contador number;
    v_id_cliente number;
    v_nombre_cliente varchar2(20);
    v_fecha_venta date;
begin
    select count(*) into contador from JRSG_Venta where id_venta = id_venta_p;

    if (contador > 0) then
        select id_cliente, fecha_venta into v_id_cliente, v_fecha_venta
        from JRSG_Venta where id_venta = id_venta_P;

        select nombre_cliente into v_nombre_cliente
        from JRSG_Cliente where id_cliente = v_id_cliente;

        dbms_output.put_line('Informacion Venta ID: ' || id_venta_p || CHR(10) ||
                            'Nombre Cliente: ' || v_nombre_cliente || CHR(10) ||
                            'Fecha Venta: ' || v_fecha_venta );
    else
        dbms_output.put_line ('No se han encontrado Ventas en el sistema.');
    end if;

    COMMIT;

    exception
        when others then
            raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
            
    ROLLBACK;
end;

----------------------CREAR-ACTUALIZAR-MOSTRAR-ELIMINAR-CLIENTES-----------------------------------------------
--- CREAR-CLIENTE
create or replace procedure JRSG_Pro_Crear_Cliente (
    nombre_cliente_p in varchar2,
    apellido1_cliente_p in varchar2,
    apellido2_cliente_p in varchar2,
    telefono_cliente_p in number,
    direccion_cliente_p in varchar2,
    email_cliente_p in varchar2
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Cliente 
            where (telefono_cliente = telefono_cliente_p and email_cliente = email_cliente_p);
        
        if (contador > 0) then
            raise_application_error (-20001, 'El cliente con correo: '|| email_cliente_p ||' o telefono: '|| telefono_cliente_p ||' ya existe en el sistema.');
        else
            lock table JRSG_Cliente in row exclusive mode;

            insert into JRSG_Cliente (id_cliente, nombre_cliente, apellido1_cliente, apellido2_cliente, telefono_cliente, direccion_cliente, email_cliente)
            values (JRSG_Sec_Generar_ID_Clientes.nextval, nombre_cliente_p, apellido1_cliente_p, apellido2_cliente_p, telefono_cliente_p, direccion_cliente_p, email_cliente_p);

            commit;
            dbms_output.put_line ('Cliente con ID: '|| JRSG_Sec_Generar_ID_Clientes.currval ||' se creo correctamente.');
        end if;

        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;

--- ACTUALIZAR-CLIENTE

create or replace procedure JRSG_Pro_Actualizar_Cliente (
    id_cliente_p in number,
    nombre_cliente_p in varchar2 default null,
    apellido1_cliente_p in varchar2 default null,
    apellido2_cliente_p in varchar2 default null,
    telefono_cliente_p in number default null,
    direccion_cliente_p in varchar2 default null,
    email_cliente_p in varchar2 default null,
    campo_actualizar number  -- variable que nos indica qué campo se modificará
) is
    contador number;
    begin
        -- Verificar si el cliente existe
        select count(id_cliente) into contador from JRSG_CLIENTE;

        if (contador > 0) then  -- Caso en el que existe (correcto).
            lock table JRSG_Cliente in row exclusive mode;
        
            case campo_actualizar
                when 2 then  -- Campo Nombre Cliente
                    update JRSG_Cliente set nombre_cliente = nombre_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('El nombre del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || nombre_cliente_p);
                when 3 then  -- Campo Apellido1 Cliente
                    update JRSG_Cliente set apellido1_cliente = apellido1_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('El primer apellido del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || apellido1_cliente_p);
                when 4 then  -- Campo Apellido2 Cliente
                    update JRSG_Cliente set apellido2_cliente = apellido2_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('El segundo apellido del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || apellido2_cliente_p);
                when 5 then  -- Campo Telefono Cliente
                    update JRSG_Cliente set telefono_cliente = telefono_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('El telefono del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || telefono_cliente_p);
                when 6 then  -- Campo Direccion Cliente
                    update JRSG_Cliente set direccion_cliente = direccion_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('La direccion del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || direccion_cliente_p);
                when 7 then  -- Campo Email Cliente
                    update JRSG_Cliente set email_cliente = email_cliente_p where id_cliente = id_cliente_p;
                    dbms_output.put_line ('El email del cliente con ID: ' || id_cliente_p || ' se ha actualizado a: ' || email_cliente_p);
                else
                    dbms_output.put_line ('Campo no válido.');
            end case;
            commit;  -- Confirmar cambios

        else
            dbms_output.put_line ('Cliente con ID: ' || id_cliente_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;

---ELIMINAR-CLIENTE
create or replace procedure JRSG_Pro_Eliminar_Cliente (
    id_cliente_p in number
    --- ver la opcion de eliminar un cliente mediante la opcion de que campo usar, ya sea 
    --- ID, email o telefono, en caso de que la persona que quiera eliminar le cliente no se acuerde
    --- del ID pero si del telefono o email, etc.
) is
    contador number;
    begin
        select count(id_cliente) into contador from JRSG_Cliente;

        if (contador > 0) then
            lock table JRSG_Cliente in row exclusive mode;

            delete from JRSG_Cliente where id_cliente = id_cliente_p;
            dbms_output.put_line ('El cliente ID: '|| id_cliente_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Cliente ID: '|| id_cliente_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;

---MOSTRAR-CLIENTE
create or replace procedure JRSG_Pro_Mostrar_Cliente (
    id_cliente_p in number
)is
    contador number;
    v_id_cliente          JRSG_Cliente.id_cliente%type;
    v_nombre_cliente      JRSG_Cliente.nombre_cliente%type;
    v_apellido1_cliente   JRSG_Cliente.apellido1_cliente%type;
    v_apellido2_cliente   JRSG_Cliente.apellido2_cliente%type;
    v_telefono_cliente    JRSG_Cliente.telefono_cliente%type;
    v_direccion_cliente   JRSG_Cliente.direccion_cliente%type;
    v_email_cliente       JRSG_Cliente.email_cliente%type;
begin
    select count(id_cliente) into contador from JRSG_Cliente;

    if (contador > 0) then
        select * into v_id_cliente, v_nombre_cliente, v_apellido1_cliente, v_apellido2_cliente, v_telefono_cliente, v_direccion_cliente, v_email_cliente
        from JRSG_Cliente where id_cliente = id_cliente_p;

        dbms_output.put_line('Informacion cliente ID: ' || id_cliente_p || CHR(10) ||
                            'Nombre: ' || v_nombre_cliente || CHR(10) ||
                            'Primer Apellido: ' || v_apellido1_cliente || CHR(10) || 
                            'Segundo Apellido: ' || v_apellido2_cliente || CHR(10) || 
                            'Telefono: ' || v_telefono_cliente || CHR(10) || 
                            'Direccion: ' || v_direccion_cliente || CHR(10) || 
                            'Email: ' || v_email_cliente);
    else
        dbms_output.put_line ('Cliente ID: '|| id_cliente_p ||' no encontrado en el sistema.');
    end if;

    exception
        when others then
            raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
end;

----------------PROCEDIMIENTOS COMPRA------------------------------------------------------------------------

------CREAR COMPRA
create or replace NONEDITIONABLE procedure JRSG_Pro_Crear_Compra (
    monto_compra_p in number default null
) is
    v_fecha_compra date;
begin
    lock table JRSG_Compra in row exclusive mode;
    
    v_fecha_compra := SYSDATE;
    
    insert into JRSG_Compra(id_compra, monto_compra, fecha_compra) 
        values (JRSG_Sec_Generar_ID_Compras.nextval, monto_compra_p, v_fecha_compra);

    commit;
    dbms_output.put_line ('La orden de compra ID: ' || JRSG_Sec_Generar_ID_Compras.currval || ' se realizo correctamente');

    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;    
end;
------ELIMINAR COMPRA
create or replace procedure JRSG_Pro_Eliminar_Compra (
    id_compra_p in number
) is
    contador number;
    begin
        select count(id_compra) into contador from JRSG_Compra;

        if (contador > 0) then
            lock table JRSG_Compra in row exclusive mode;

            delete from JRSG_Compra where id_compra = id_compra_p;
            dbms_output.put_line ('La Compra ID: '|| id_compra_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Compra ID: '|| id_compra_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;
------ACTUALIZAR COMPRA
create or replace procedure JRSG_Pro_Actualizar_Compra (
    id_compra_p in number,
    monto_compra_p in number,
    fecha_compra_p in date
) is
    contador number;
    begin
        select count(id_compra) into contador from JRSG_Compra;

        if (contador > 0) then
            lock table JRSG_Compra in row exclusive mode;

            update JRSG_Compra set  monto_compra = monto_compra_p,
                                    fecha_compra = fecha_compra_p where id_compra = id_compra_p;

            dbms_output.put_line ('Compra ID: ' || id_compra_p || ' se ha actualizado correctamente.');
            commit;
        end if;

        exception
                when others then
                    raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
        rollback;  -- Revertir cambios en caso de error
    end;
------MOSTRAR COMPRA
create or replace procedure JRSG_Pro_Mostrar_Compra (
    id_compra_p in number
) is
    contador number;
    v_id_compra JRSG_Compra.id_compra%type;
    v_monto_compra JRSG_Compra.monto_compra%type;
    v_fecha_compra JRSG_Compra.fecha_compra%type;

    begin
        select count(*) into contador from JRSG_Compra where id_compra = id_compra_p;

        if (contador > 0) then
            select * into v_id_compra, v_monto_compra, v_fecha_compra
            from JRSG_Compra where id_compra = id_compra_p;
            
            commit;
            dbms_output.put_line('Informacion Compra ID: ' || id_compra_p || CHR(10) ||
                              'Monto Compra: ' || v_monto_compra || CHR(10) || 
                              'Fecha Compra: ' || v_fecha_compra);
        else
            dbms_output.put_line ('La compra id: '|| id_compra_p ||' no se encuentra en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
        rollback;
    end;

--------------------------PROCEDIMIENTO PRODUCTO----------------------------------------------------

-------CREAR PRODUCTO
create or replace procedure JRSG_Pro_Crear_Producto (
    id_categoria_p in number default null,
    id_promocion_p in number,
    nombre_producto_p in varchar2,
    descripcion_producto_p in varchar2,
    precio_p in number,
    precio_descuento_p in number default null,
    stock_p in number,
    proveedor_p in varchar2 default null
)is
    contador number;
    begin
        select count(nombre_producto) into contador from JRSG_Producto;

        if (contador > 0) then
            raise_application_error (-20001, 'El Producto de nombre: '|| nombre_producto_p ||' ya esta ingresado en el sistema.');
        else
            lock table JRSG_Producto in row exclusive mode;

            insert into JRSG_Producto (id_producto, id_categoria, id_promocion, nombre_producto, descripcion_producto, precio, precio_descuento, stock, proveedor)
            values (JRSG_Sec_Generar_ID_Productos.nextval, id_categoria_p, id_promocion_p, nombre_producto_p, descripcion_producto_p, precio_p, precio_descuento_p, stock_p, proveedor_p);
            
            commit;
            dbms_output.put_line ('Producto con ID: '|| JRSG_Sec_Generar_ID_Productos.currval ||' se creo correctamente.');
        end if;
        
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;
--------ACTUALIZAR PRODUCTO
create or replace procedure JRSG_Pro_Actualizar_Producto (
    id_producto_p in number,
    id_categoria_p in number default null, --- modificar: se tiene que hacer mediante las operaciones de esa tabla-
    id_promocion_p in number default null, --- Modificar: se tiene que hacer mediante las operaciones de esa tabla.
    nombre_producto_p in varchar2 default null, --- Columna 4
    descripcion_producto_p in varchar2 default null, --- Columna 5
    precio_p in number default null, --- Columna 6
    precio_descuento_p in number default null, --- Columna 7
    stock_p in number default null, --- Columna 8
    proveedor_p in varchar2 default null, --- Columna 9
    campo_actualizar in number
)is
    contador number;
    begin
        select count(id_producto) into contador from JRSG_Producto;

        if (contador > 0) then
            lock table JRSG_Producto in row exclusive mode;

            case campo_actualizar
                when 4 then  -- Campo Nombre Cliente
                    update JRSG_Producto set nombre_producto = nombre_producto_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El nombre del producto con ID: ' || id_producto_p|| ' se ha actualizado a: ' || nombre_producto_p);
                when 5 then  -- Campo Apellido1 Cliente
                    update JRSG_Producto set descripcion_producto = descripcion_producto_p where id_producto = id_producto;
                    dbms_output.put_line ('La descripcion del producto con ID: ' || id_producto_p|| ' se ha actualizado a: ' || descripcion_producto_p);
                when 6 then  -- Campo Apellido2 Cliente
                    update JRSG_Producto set precio = precio_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El precio del producto con ID: ' || id_producto_p || ' se ha actualizado a: ' || precio_p);
                when 7 then
                    update JRSG_Producto set precio_descuento = precio_descuento_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El precio descuento del producto con ID: ' || id_producto_p || ' se ha actualizado a: ' || precio_descuento_p);
                when 8 then
                    update JRSG_Producto set stock = stock_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El stock del producto con ID: ' || id_producto_p || ' se ha actualizado a: ' || stock_p);
                when 9 then
                    update JRSG_Producto set proveedor = proveedor_p where id_producto = id_producto_p;
                    dbms_output.put_line ('El proveedor del producto con ID: ' || id_producto_p || ' se ha actualizado a: ' || proveedor_p);
                else
                    dbms_output.put_line ('Campo no válido.');
            end case;
            commit;
        else
            dbms_output.put_line ('Producto con ID: ' || id_producto_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;

--------ELIMINAR PRODUCTO
create or replace procedure JRSG_Pro_Eliminar_Producto (
    id_producto_p in number
    --- ver la opcion de eliminar un cliente mediante la opcion de que campo usar, ya sea 
    --- ID, email o telefono, en caso de que la persona que quiera eliminar le cliente no se acuerde
    --- del ID pero si del telefono o email, etc.
) is
    contador number;
    begin
        select count(id_producto) into contador from JRSG_Producto;

        if (contador > 0) then
            lock table JRSG_Producto in row exclusive mode;

            delete from JRSG_Producto where id_producto = id_producto_p;
            dbms_output.put_line ('El Producto ID: '|| id_producto_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Producto ID: '|| id_producto_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;

--------MOSTRAR PRODUCTO
create or replace procedure JRSG_Pro_Mostrar_Producto (
    id_producto_p in number
) is
    contador number;
    v_id_producto JRSG_Producto.id_producto%type;
    v_id_categoria JRSG_Producto.id_categoria%type;      
    v_id_promocion JRSG_Producto.id_promocion%type;
    v_nombre_producto JRSG_Producto.nombre_producto%type;
    v_descripcion_producto JRSG_Producto.descripcion_producto%type;
    v_precio JRSG_Producto.precio%type;
    v_precio_descuento JRSG_Producto.precio_descuento%type;
    v_stock JRSG_Producto.stock%type;
    v_proveedor JRSG_Producto.proveedor%type;
    begin
        select count(id_producto) into contador from JRSG_Producto;

        if (contador > 0) then
            select * into v_id_producto, v_id_categoria, v_id_promocion, v_nombre_producto, v_descripcion_producto, v_precio, v_precio_descuento, v_stock, v_proveedor
            from JRSG_Producto where id_producto = id_producto_p;

            dbms_output.put_line('Informacion Producto ID: ' || id_producto_p || CHR(10) ||
                              'Nombre: ' || v_nombre_producto || CHR(10) ||
                              'Categoria: ' || v_id_categoria || CHR(10) || 
                              'Promocion: ' || v_id_promocion || CHR(10) || 
                              'Descripcion: ' || v_descripcion_producto || CHR(10) || 
                              'Precio: ' || v_precio || CHR(10) ||
                              'Precio Descuento: ' || v_precio_descuento || CHR(10) ||
                              'Stock: ' || v_stock || CHR(10) ||
                              'Proveedor: ' || v_proveedor);
        else
            dbms_output.put_line ('Producto ID: '|| id_producto_p||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;


-----------PROCEDIMIENTOS PROMOCIÓN-------------------------------------------------------------------------------------

----------CREAR PROMOCION
create or replace procedure JRSG_Pro_Crear_Promocion (
    nombre_promocion_p in varchar2,
    descuento_p in number,
    fecha_inicio_p in date,
    fecha_fin_p in date default null
)is
    contador number;
    begin
        select count(nombre_promocion) into contador from JRSG_Promocion;

        if (contador > 0) then
            raise_application_error (-20001, 'La promocion: '|| nombre_promocion_p ||' ya esta ingresado en el sistema.');
        else
            lock table JRSG_Promocion in row exclusive mode;

            insert into JRSG_Promocion (id_promocion, nombre_promocion, descuento, fecha_inicio, fecha_fin)
            values (JRSG_Sec_Generar_ID_Promociones.nextval, nombre_promocion_p, descuento_p, fecha_inicio_p, fecha_fin_p);
            
            commit;
            dbms_output.put_line ('Promocion con ID: '|| JRSG_Sec_Generar_ID_Promociones.currval||' se creo correctamente.');
        end if;
        
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;

---------ACTUALIZAR PROMOCION
create or replace procedure JRSG_Pro_Actualizar_Promocion(
    id_promocion_p in number,
    nombre_promocion_p in varchar2 default null,
    descuento_p in number default null,
    fecha_inicio_p in date default null,
    fecha_fin_p in date default null,
    campo_actualizar in number
)is
    contador number;
    begin
        select count(id_promocion) into contador from JRSG_Promocion;

        if (contador > 0) then
            lock table JRSG_Producto in row exclusive mode;

            case campo_actualizar
                when 2 then  -- Campo Nombre Cliente
                    update JRSG_Promocion set nombre_promocion = nombre_promocion_p where id_promocion = id_promocion_p;
                    dbms_output.put_line ('El nombre de la promocion con ID: ' || id_promocion_p || ' se ha actualizado a: ' || nombre_promocion_p);
                when 3 then  -- Campo Apellido1 Cliente
                    update JRSG_Promocion set descuento = descuento_p where id_promocion = id_promocion_p;
                    dbms_output.put_line ('El descuento de la promocion con ID: ' || id_promocion_p || ' se ha actualizado a: ' || descuento_p);
                when 4 then  -- Campo Apellido2 Cliente
                    update JRSG_Promocion set fecha_inicio = fecha_inicio_p where id_promocion = id_promocion_p;
                    dbms_output.put_line ('Fecha de inicio de la promocion con ID: ' || id_promocion_p || ' se ha actualizado a: ' || fecha_inicio_p);
                when 5 then
                    update JRSG_Promocion set fecha_fin = fecha_fin_p where id_promocion = id_promocion_p;
                    dbms_output.put_line ('Fecha de fin de la promocion con ID: ' || id_promocion_p || ' se ha actualizado a: ' || fecha_fin_p);
                else
                    dbms_output.put_line ('Campo no válido.');
            end case;
            commit;
        else
            dbms_output.put_line ('Promocion con ID: ' || id_promocion_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;
 
---------ELIMINAR PROMOCION
create or replace procedure JRSG_Pro_Eliminar_Promocion (
    id_promocion_p in number
    --- ver la opcion de eliminar un cliente mediante la opcion de que campo usar, ya sea 
    --- ID, email o telefono, en caso de que la persona que quiera eliminar le cliente no se acuerde
    --- del ID pero si del telefono o email, etc.
) is
    contador number;
    begin
        select count(id_promocion) into contador from JRSG_Promocion;

        if (contador > 0) then
            lock table JRSG_Promocion in row exclusive mode;

            delete from JRSG_Promocion where id_promocion = id_promocion_p;
            dbms_output.put_line ('La Promocion ID: '|| id_promocion_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Promocion ID: '|| id_promocion_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;
 
---------MOSTRAR PROMOCION
create or replace procedure JRSG_Pro_Mostrar_Promocion (
    id_promocion_p in number
) is
    contador number;
    v_id_promocion JRSG_Promocion.id_promocion%type;
    v_nombre_promocion JRSG_Promocion.nombre_promocion%type;
    v_descuento JRSG_Promocion.descuento%type;
    v_fecha_inicio JRSG_Promocion.fecha_inicio%type;
    v_fecha_fin JRSG_Promocion.fecha_fin%type;

    begin
        select count(id_promocion) into contador from JRSG_Promocion;

        if (contador > 0) then
            select * into v_id_promocion, v_nombre_promocion, v_descuento, v_fecha_inicio, v_fecha_fin
            from JRSG_Promocion where id_promocion = id_promocion_p;

            dbms_output.put_line('Informacion Promocion ID: ' || id_promocion_p || CHR(10) ||
                              'Nombre: ' || v_nombre_promocion || CHR(10) ||
                              'Descuento: ' || v_descuento || CHR(10) || 
                              'Fecha Inicio: ' || v_fecha_inicio || CHR(10) || 
                              'Fecha Fin: ' || v_fecha_fin);
        else
            dbms_output.put_line ('Promocion ID: '|| id_promocion_p ||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;

-------------------PROCEDIMIENTOS DE CATEGORIA--------------------------------------------------------------------

--------------CREAR CATEGORIA
create or replace procedure JRSG_Pro_Crear_Categoria (
    nombre_categoria_p in varchar2
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Categoria where nombre_categoria = nombre_categoria_p;

        if (contador > 0) then
            raise_application_error (-20001, 'La categoria: '|| nombre_categoria_p||' ya esta ingresado en el sistema.');
        else
            lock table JRSG_Categoria in row exclusive mode;

            insert into JRSG_Categoria (id_categoria, nombre_categoria)
            values (JRSG_Sec_Generar_ID_Categorias.nextval, nombre_categoria_p);
            
            commit;
            dbms_output.put_line ('Categoria con ID: '|| JRSG_Sec_Generar_ID_Categorias.currval ||' se creo correctamente.');
        end if;
        
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;
--------------ACUTALIZAR CATEGORIA
create or replace procedure JRSG_Pro_Actualizar_Categoria (
    id_categoria_p in number,
    nombre_categoria_p in varchar2
)is
    contador number;
    begin
        select count(*) into contador from JRSG_Categoria where id_categoria = id_categoria_p;

        if (contador > 0) then
            lock table JRSG_Categoria in row exclusive mode;

            update JRSG_Categoria set nombre_categoria = nombre_categoria_p where id_categoria = id_categoria_p;
            dbms_output.put_line ('El nombre de la categoria con ID: ' || id_categoria_p|| ' se ha actualizado a: ' || nombre_categoria_p);
            commit;
        else
            dbms_output.put_line ('Categoria con ID: ' || id_categoria_p|| ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;
--------------ELIMINAR CATEGORIA
create or replace procedure JRSG_Pro_Eliminar_Categoria (
    id_categoria_p in number
    --- ver la opcion de eliminar un cliente mediante la opcion de que campo usar, ya sea 
    --- ID, email o telefono, en caso de que la persona que quiera eliminar le cliente no se acuerde
    --- del ID pero si del telefono o email, etc.
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Categoria where id_categoria = id_categoria_p;

        if (contador > 0) then
            lock table JRSG_Categoria in row exclusive mode;

            delete from JRSG_Categoria where id_categoria = id_categoria_p;
            dbms_output.put_line ('La Categoria ID: '|| id_categoria_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Categoria ID: '|| id_categoria_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;
--------------MOSTRAR CATEGORIA
create or replace procedure JRSG_Pro_Mostrar_Categoria (
    id_categoria_p in number
) is
    contador number;
    v_id_categoria JRSG_Categoria.id_categoria%type;
    v_nombre_categoria JRSG_Categoria.nombre_categoria%type;
    begin
        select count(*) into contador from JRSG_Categoria where id_categoria = id_categoria_p;

        if (contador > 0) then
            select * into v_id_categoria, v_nombre_categoria
            from JRSG_Categoria where id_categoria = id_categoria_p;

            dbms_output.put_line('Informacion Categoria ID: ' || id_categoria_p || CHR(10) ||
                              'Nombre: ' || v_nombre_categoria);

        else
            dbms_output.put_line ('Categoria ID: '|| id_categoria_p ||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;
---------------------PROCEDIMIENTO TIPO_PAGO------------------------------------------------------------------
------CREAR TIPO_PAGO
CREATE OR REPLACE PROCEDURE JRSG_PRO_CREAR_TIPO_PAGO(
    nombre_metodo_pago_tp varchar2,
    banco_tp varchar2,
    num_cuenta_tp number
)IS
contador number;
begin
    select count(num_cuenta) into contador from JRSG_TIPO_PAGO where num_cuenta = num_cuenta_tp;

    if (contador > 0) then
        raise_application_error (-20001, 'El numero de cuenta: '|| num_cuenta_tp ||' ya existe en el sistema.');
    else
        LOCK TABLE JRSG_TIPO_PAGO IN ROW EXCLUSIVE MODE;

        INSERT INTO JRSG_TIPO_PAGO(ID_TIPO_PAGO, nombre_metodo_pago, banco, num_cuenta)
            VALUES(JRSG_SEC_GENERAR_ID_TIPO_PAGOS.NEXTVAL, nombre_metodo_pago_tp, banco_tp, num_cuenta_tp);
        
        commit;
        dbms_output.put_line ('Se ingreso el numero de cuenta: '|| num_cuenta_tp ||' correctamente.');
    end if;

    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;
end;
------ACTUALIZAR TIPO_PAGO
create or replace NONEDITIONABLE PROCEDURE JRSG_PRO_ACTUALIZAR_TIPO_PAGO(
    id_tipo_pago_tp number,
    nombre_metodo_pago_tp varchar2,
    banco_tp varchar2,
    num_cuenta_tp number
)IS
contador number;
begin
    LOCK TABLE JRSG_TIPO_PAGO IN ROW EXCLUSIVE MODE;

    UPDATE JRSG_TIPO_PAGO SET
        nombre_metodo_pago = nombre_metodo_pago_tp, 
        banco = banco_tp, 
        num_cuenta = num_cuenta_tp
        WHERE id_tipo_pago = id_tipo_pago_tp;

    commit;
        dbms_output.put_line ('Se actualizo el numero de cuenta: '|| num_cuenta_tp ||' correctamente.');

    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;
end;
------ELIMINAR TIPO_PAGO
create or replace NONEDITIONABLE PROCEDURE JRSG_PRO_ELIMINAR_TIPO_PAGO(
    id_tipo_pago_tp number
)IS
contador number;
begin
    select count(*) into contador from JRSG_TIPO_PAGO where id_tipo_pago = id_tipo_pago_tp;

    if (contador > 0) then
        lock table JRSG_TIPO_PAGO in row exclusive mode;

        delete from JRSG_TIPO_PAGO where id_tipo_pago = id_tipo_pago_tp;
        dbms_output.put_line ('El Tipo de Pago ID: '|| id_tipo_pago_tp ||' se elimino correctamente del sistema.');
        commit;
    else
        dbms_output.put_line ('El Tipo de Pago ID: '|| id_tipo_pago_tp ||' no se encontro en el sistema.');
    end if;

    exception
        when others then
            raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
    rollback;
end;

------MOSTRAR TIPO_PAGO
CREATE OR REPLACE PROCEDURE JRSG_PRO_MOSTRAR_TIPO_PAGO(
    id_tipo_pago_tp number
)IS
    contador number;
    v_id_tipo_pago number;
    v_nombre_metodo_pago varchar2(25);
    v_banco varchar2(30);
    v_num_cuenta number;
begin
    select count(*) into contador from JRSG_TIPO_PAGO where id_tipo_pago = id_tipo_pago_tp;

    if (contador > 0) then
        lock table JRSG_TIPO_PAGO in row exclusive mode;
        
        SELECT * INTO v_id_tipo_pago, v_nombre_metodo_pago, v_banco, v_num_cuenta
        FROM JRSG_TIPO_PAGO
        WHERE ID_TIPO_PAGO = ID_TIPO_PAGO_TP;
            dbms_output.put_line('Informacion Tipo Pago ID: ' || v_id_tipo_pago || CHR(10) ||
                              'Metodo Pago: ' || v_nombre_metodo_pago || CHR(10) ||
                              'Banco: ' || v_banco || CHR(10) || 
                              'Numero Cuenta: ' || v_num_cuenta);
        commit;
    else
        dbms_output.put_line ('El Tipo de Pago ID: '|| id_tipo_pago_tp ||' no se encontro en el sistema.');
    end if;

    exception
        when others then
            raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
    rollback;
end;
---------------------PROCEDIMIENTO PAGO------------------------------------------------------------------
------CREAR PAGO
CREATE OR REPLACE PROCEDURE JRSG_CREAR_PAGO(
    id_venta_P number,
    id_tipo_pago_P number,
    fecha_pago_p date,
    monto_pago_p number
)IS
    contador number;
begin
    select count(*) into contador from JRSG_PAGO where id_venta = id_venta_p;

    if (contador > 0 ) then
        raise_application_error (-20001, 'La canasta que desea pagar '|| id_venta_p || ' ya fue vendida.');
    else
        LOCK TABLE JRSG_PAGO in row exclusive mode;

        insert into JRSG_PAGO (id_venta, id_tipo_pago, fecha_pago, monto_pago)
            values (JRSG_Sec_Generar_ID_PAGOS.nextval,  id_tipo_pago_P, fecha_pago_p, monto_pago_p);

        commit;
            dbms_output.put_line ('Se realizo el Pago correctamente.');

    end if;

    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;    
end;
------MOTRAR PAGO
create or replace procedure JRSG_Pro_Mostrar_Pago(
    id_pago_p in number
)is
    contador number;
    v_id_pago number;
    v_id_venta number;
    v_id_tipo_pago number;
    v_fecha_pago date;
    v_monto_pago number;
begin
    select count(*) into contador from JRSG_PAGO where id_pago = id_pago_p;

    if (contador > 0) then
        select * into v_id_pago, v_id_venta, v_id_tipo_pago, v_fecha_pago, v_monto_pago
        from JRSG_PAGO where id_pago = id_pago_p;

        dbms_output.put_line('Informacion Pago ID: ' || v_id_pago || CHR(10) ||
                            'Canasta: ' || v_id_venta || CHR(10) ||
                            'Tipo de Pago: ' || v_id_tipo_pago || CHR(10) ||
                            'Fecha de Pago: ' || v_fecha_pago || CHR(10) ||
                            'Monto: ' || v_monto_pago );
    else
        dbms_output.put_line ('No se han encontrado Ventas en el sistema.');
    end if;

    COMMIT;

    exception
        when others then
            raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);

    ROLLBACK;
end;

------------PROCEDIMIENTOS DETALLE_COMPRA_PRODUCTO----------------------------------------------------------------------
----CREAR DETALLE_COMPRA
create or replace PROCEDURE JRSG_PRO_CREAR_DETALLE_COMPRA(
    id_producto_p in number,
    cantidad_c in number,
    precio_compra_p in number
) is
    v_precio_total number;
    v_nombre_producto varchar2(60);
    v_stock_actual number;
    v_stock_actualizado number;
begin
    lock table JRSG_DETALLE_COMPRA_PRODUCTO in row exclusive mode;
    
    v_precio_total := precio_compra_p * cantidad_c;

    --tomamos el nombre de la id_producto
    SELECT nombre_producto into v_nombre_producto 
    FROM JRSG_PRODUCTO
    WHERE id_producto = id_producto_p;

    insert into JRSG_DETALLE_COMPRA_PRODUCTO (id_compra, id_producto, cantidad, nombre_producto, precio_compra, precio_total)
        values (JRSG_Sec_Generar_ID_Compras.currval, id_producto_p, cantidad_c, v_nombre_producto, precio_compra_p, v_precio_total);

    UPDATE JRSG_PRODUCTO SET 
        STOCK = STOCK + cantidad_c
        WHERE id_producto = id_producto_p;

    commit;
    dbms_output.put_line ('Se agrego el Producto: ' || v_nombre_producto || CHR(10) ||
                        'A la orden de compra ID: ' || JRSG_Sec_Generar_ID_Compras.currval);
    exception
        when storage_error then
            raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
        when others then
            raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
    rollback;    
end;
----MOSTRAR DETALLE_COMPRA
create or replace PROCEDURE JRSG_PRO_MOSTRAR_DETALLE_COMPRA(
    id_compra_c number
)IS
    v_id_compra number;
    v_id_producto number;
    v_cantidad number;
    v_nombre_producto varchar2(60);
    v_precio_compra number;
    v_precio_total number;
begin
    LOCK TABLE JRSG_DETALLE_COMPRA_PRODUCTO IN ROW EXCLUSIVE MODE;

    SELECT * INTO v_id_compra, v_id_producto, v_cantidad, v_nombre_producto, v_precio_compra, v_precio_total
    FROM JRSG_DETALLE_COMPRA_PRODUCTO
    WHERE id_compra = id_compra_c;

    COMMIT;
        dbms_output.put_line('Informacion Compra ID: ' || id_compra_c || CHR(10) ||
                  'ID Producto: ' || v_id_producto || CHR(10) || 
                  'Cantidad: ' || v_cantidad || CHR(10) || 
                  'Nombre Producto: ' || v_nombre_producto || CHR(10) ||
                  'Precio Compra: ' || v_precio_compra || CHR(10) ||
                  'Precio Total: ' || v_precio_total);

    exception
        when others then
            raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    ROLLBACK;

end;
------------PROCEDIMIENTOS DETALLE_VENTA_PRODUCTO----------------------------------------------------------------------
----CREAR DETALLE_VENTA_PRODUCTO
create or replace procedure JRSG_Pro_Crear_Detalle_Venta_Producto (
    id_producto_p in number,
    cantidad_p in number
) is
    v_nombre_producto JRSG_Producto.nombre_producto%type;

    begin
      lock table JRSG_Detalle_Venta_Producto in row exclusive mode;
        select nombre_producto into v_nombre_producto from JRSG_Producto where id_producto = id_producto_p;

        insert into JRSG_Detalle_Venta_Producto (id_venta, id_producto, cantidad, nombre_producto)
        values (JRSG_Sec_Generar_ID_Ventas.currval, id_producto_p, cantidad_p, v_nombre_producto);

        commit;
        dbms_output.put_line ('Se agrego el Producto: ' || id_producto_p || CHR(10) ||
                        'A la orden de venta ID: ' || JRSG_Sec_Generar_ID_Ventas.currval);
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;

----MOSTRAR DETALLE_VENTA_PRODUCTO
create or replace procedure JRSG_Pro_Mostrar_Detalle_Venta_Producto (
    id_venta_p in number,
    cantidad_p in number
) is
    v_id_producto JRSG_Producto.id_producto%type;
    v_nombre_producto JRSG_Producto.nombre_producto%type;
    begin
        lock table JRSG_Detalle_Venta_Producto in row exclusive mode;
        
        select id_producto, nombre_producto into v_id_producto, v_nombre_producto from JRSG_Detalle_Venta_Producto where id_venta = id_venta_p;
        
        dbms_output.put_line ('Informacion Venta ID: ' || id_venta_p || CHR(10) ||
                            'ID Producto: ' || v_id_producto || CHR(10) ||
                            'Cantidad: ' || cantidad_p || CHR(10) ||
                            'Producto: ' || v_nombre_producto);
        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
        ROLLBACK;
    end;

------------PROCEDIMIENTOS EMPLEADO----------------------------------------------------------------------
----CREAR EMPLEADO
create or replace procedure JRSG_Pro_Crear_Empleado (
    nombre_empleado_p in varchar2,
    apellido1_empleado_p in varchar2,
    apellido2_empleado_p in varchar2,
    telefono_empleado_p in number,
    email_empleado_p in varchar2,
    contrasena_p in varchar2
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Empleado
            where (telefono_empleado = telefono_empleado_p and email_empleado = email_empleado_p);
        
        if (contador > 0) then
            raise_application_error (-20001, 'El empleado con correo: '|| email_empleado_p ||' o telefono: '|| telefono_empleado_p ||' ya existe en el sistema.');
        else
            lock table JRSG_Empleado in row exclusive mode;

            insert into JRSG_Empleado (id_empleado, nombre_empleado, apellido1_empleado, apellido2_empleado, telefono_empleado, email_empleado,contrasena)
            values (JRSG_Sec_Generar_ID_Empleados.nextval, nombre_empleado_p, apellido1_empleado_p, apellido2_empleado_p, telefono_empleado_p, email_empleado_p, contrasena_p);

            commit;
            dbms_output.put_line ('Empleado con ID: '|| JRSG_Sec_Generar_ID_Empleados.currval ||' se creo correctamente.');
        end if;

        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;lback;    
    end;
----ACTUALIZAR EMPLEADO
create or replace procedure JRSG_Pro_Actualizar_Empleado (
    id_empleado_p in number,
    nombre_empleado_p in varchar2 default null,
    apellido1_empleado_p in varchar2 default null,
    apellido2_empleado_p in varchar2 default null,
    telefono_empleado_p in number default null,
    email_empleado_p in varchar2 default null,
    contrasena_p in varchar2 default null,
    campo_actualizar number  -- variable que nos indica qué campo se modificará
) is
    contador number;
    begin
        -- Verificar si el cliente existe
        select count(*) into contador from JRSG_Empleado where id_empleado = id_empleado_p;

        if (contador > 0) then  -- Caso en el que existe (correcto).
            lock table JRSG_Empleado in row exclusive mode;

            case campo_actualizar
                when 2 then  -- Campo Nombre Cliente
                    update JRSG_Empleado set nombre_empleado = nombre_empleado_p where id_empleado = id_empleado_p;
                    dbms_output.put_line ('El nombre del empleado con ID: ' || id_empleado_p || ' se ha actualizado a: ' || nombre_empleado_p);
                when 3 then  -- Campo Apellido1 Cliente
                    update JRSG_Empleado set apellido1_empleado = apellido1_empleado_p where id_empleado = id_empleado_p;
                    dbms_output.put_line ('El primer apellido del empleado con ID: ' || id_empleado_p || ' se ha actualizado a: ' || apellido1_empleado_p);
                when 4 then  -- Campo Apellido2 Cliente
                    update JRSG_Empleado set apellido2_empleado = apellido2_empleado_p where id_empleado = id_empleado_p;
                    dbms_output.put_line ('El segundo apellido del empleado con ID: ' || id_empleado_p || ' se ha actualizado a: ' || apellido2_empleado_p);
                when 5 then  -- Campo Telefono Cliente
                    update JRSG_Empleado set telefono_empleado = telefono_empleado_p where id_empleado = id_empleado_p;
                    dbms_output.put_line ('El telefono del empleado con ID: ' || id_empleado_p || ' se ha actualizado a: ' || telefono_empleado_p);
                when 6 then  -- Campo Email Cliente
                    update JRSG_Empleado set email_empleado = email_empleado_p where id_empleado = id_empleado_p;
                    dbms_output.put_line ('El email del empleado con ID: ' || id_empleado_p || ' se ha actualizado a: ' || email_empleado_p);
                when 7 then  -- Campo Email Cliente
                    update JRSG_Empleado set contrasena = contrasena_p where id_empleado = id_empleado_P;
                    dbms_output.put_line ('La contraseña del empleado con ID: ' || id_empleado_p || ' se ha actualizado.');
                else
                    dbms_output.put_line ('Campo no válido.');
            end case;
            commit;  -- Confirmar cambios

        else
            dbms_output.put_line ('Empleado con ID: ' || id_empleado_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;
----ELIMINAR EMPLEADO
create or replace procedure JRSG_Pro_Eliminar_Empleado (
    id_empleado_p in number
) is
    contador number;
    begin
        select count(*) into contador from JRSG_Empleado where id_empleado = id_empleado_p;

        if (contador > 0) then
            lock table JRSG_Empleado in row exclusive mode;

            delete from JRSG_Empleado where id_empleado = id_empleado_p;
            dbms_output.put_line ('El empleado ID: '|| id_empleado_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Empleado ID: '|| id_empleado_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;
----MOSTRAR EMPLEADO
create or replace procedure JRSG_Pro_Mostrar_Empleado (
    id_empleado_p in number
) is
    contador number;
    v_id_empleado          JRSG_Empleado.id_empleado%type;
    v_nombre_empleado      JRSG_Empleado.nombre_empleado%type;
    v_apellido1_empleado   JRSG_Empleado.apellido1_empleado%type;
    v_apellido2_empleado   JRSG_Empleado.apellido2_empleado%type;
    v_telefono_empleado    JRSG_Empleado.telefono_empleado%type;
    v_email_empleado       JRSG_Empleado.email_empleado%type;
    v_contrasena_empleado       JRSG_Empleado.email_empleado%type;
    
    begin
        select count(*) into contador from JRSG_empleado where id_empleado = id_empleado_p;

        if (contador > 0) then
            select * into v_id_empleado, v_nombre_empleado, v_apellido1_empleado, v_apellido2_empleado, v_telefono_empleado, v_email_empleado, v_contrasena_empleado
            from JRSG_Empleado where id_empleado = id_empleado_p;

            dbms_output.put_line('Informacion cliente ID: ' || id_empleado_p || CHR(10) ||
                              'Nombre: ' || v_nombre_empleado || CHR(10) ||
                              'Primer Apellido: ' || v_apellido1_empleado || CHR(10) || 
                              'Segundo Apellido: ' || v_apellido2_empleado || CHR(10) || 
                              'Telefono: ' || v_telefono_empleado || CHR(10) || 
                              'Email: ' || v_email_empleado );
        else
            dbms_output.put_line ('Empleado ID: '|| id_empleado_p ||' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;

------------PROCEDIMIENTOS UBICACION_PRODUCTO----------------------------------------------------------------------
----CREAR UBICACION_PRODUCTO
create or replace procedure JRSG_Pro_Crear_Ubicacion_Bodega (
    id_producto_p in number default null,
    nro_estante_p in number,
    nivel_p in number
)is
    contador number;
    v_nombre_producto JRSG_Producto.nombre_producto%type;
    begin
        select count(*) into contador from JRSG_Ubicacion_Bodega where nro_estante = nro_estante_p and nivel = nivel_p;

        if (contador > 0 and id_producto_p is not null) then
            select nombre_producto into v_nombre_producto from JRSG_Producto where id_producto = id_producto_p;

            raise_application_error (-20001, 'La ubicacion en bodega: '|| CHR(10) ||
                                    'Numero estante: ' || nro_estante_p || CHR(10) ||
                                    'Nivel: ' || nivel_p || CHR(10) ||
                                    'Producto: ' || v_nombre_producto || CHR(10) ||
                                    ' ya esta ingresado en el sistema.');
        elsif (contador > 0 and id_producto_p is null) then
            raise_application_error (-20001, 'La ubicacion en bodega: '|| CHR(10) ||
                                    'Numero estante: ' || nro_estante_p || CHR(10) ||
                                    'Nivel: ' || nivel_p || CHR(10) ||
                                    ' ya esta ingresado en el sistema.');
        else
            lock table JRSG_Ubicacion_Bodega in row exclusive mode;

            insert into JRSG_Ubicacion_Bodega (id_ubicacion, id_producto, nro_estante, nivel)
            values (JRSG_Sec_Generar_ID_Ubicacion_Bodegas.nextval, id_producto_p, nro_estante_p, nivel_p);
            
            commit;
            if (id_producto_p is null) then
                dbms_output.put_line ('Ubicacion Bodega: ' || CHR(10) ||
                                    'Numero estante: ' || nro_estante_p || CHR(10) ||
                                    'Nivel: ' || nivel_p || CHR(10) ||
                                    'Se ingreso correctamente al sistema.');
            else
                select nombre_producto into v_nombre_producto from JRSG_Producto where id_producto = id_producto_p;
                dbms_output.put_line ('Ubicacion Bodega: ' || CHR(10) ||
                                    'Numero estante: ' || nro_estante_p || CHR(10) ||
                                    'Nivel: ' || nivel_p || CHR(10) ||
                                    'Producto: ' || v_nombre_producto || CHR(10) ||
                                    'Se ingreso correctamente al sistema.');
            end if;
        end if;
        
        exception
            when storage_error then
                raise_application_error (-6500, 'Error en el almacenamiento: No hay sufieciente espacio en el sistema.');
            when others then
                raise_application_error (-20004, 'Se ha producido un error inesperado.'|| sqlerrm);
        rollback;    
    end;
----ACTUALIZAR UBICACION_PRODUCTO
create or replace procedure JRSG_Pro_Actualizar_Ubicacion_Bodega (
    id_ubicacion_p in number,
    id_producto_p in number,
    nro_estante_p in number,
    nivel_p in number
)is
    contador number;
    contador1 number;
    v_nombre_producto JRSG_Producto.nombre_producto%type;
    begin
        select count(*) into contador from JRSG_Ubicacion_Bodega where id_ubicacion = id_ubicacion_p;
        select count(*) into contador1 from JRSG_Producto where id_producto = id_producto_p;
        
        if (contador > 0 and contador1 = 0) then
            lock table JRSG_Ubicacion_Bodega in row exclusive mode;

            update JRSG_Ubicacion_Bodega set id_producto = id_producto_p,
                                            nro_estante = nro_estante_p,
                                            nivel = nivel_p where id_ubicacion = id_ubicacion_p;
            dbms_output.put_line ('La ubicacion bodega: ' || id_ubicacion_p || ' se ha actualizado a: ' || CHR(10) ||
                                'Numero estante: ' || nro_estante_p || CHR(10) ||
                                'Nivel: ' || nivel_p);
            commit;
        elsif (contador > 0 and contador1 > 0) then
            lock table JRSG_Ubicacion_Bodega in row exclusive mode;
            select nombre_producto into v_nombre_producto from JRSG_Producto where id_producto = id_producto_p;

            update JRSG_Ubicacion_Bodega set id_producto = id_producto_p,
                                            nro_estante = nro_estante_p,
                                            nivel = nivel_p where id_ubicacion = id_ubicacion_p;
            dbms_output.put_line ('La ubicacion bodega: ' || id_ubicacion_p || ' se ha actualizado a: ' || CHR(10) ||
                                'Numero estante: ' || nro_estante_p || CHR(10) ||
                                'Nivel: ' || nivel_p || CHR(10) ||
                                'Producto: ' || v_nombre_producto);
            commit;
        else
            dbms_output.put_line ('Ubicacion Bodega ID: ' || id_ubicacion_p || ' no encontrado en el sistema.');
        end if;

        exception
            when others then
                raise_application_error(-20003, 'Error inesperado: ' || sqlerrm);
            rollback;  -- Revertir cambios en caso de error
    end;
----ELIMINAR UBICACION_PRODUCTO
create or replace procedure JRSG_Pro_Eliminar_Ubicacion_Bodega (
    id_ubicacion_p in number

) is
    contador number;
    begin
        select count(*) into contador from JRSG_Ubicacion_Bodega where id_ubicacion = id_ubicacion_p;

        if (contador > 0) then
            lock table JRSG_Ubicacion_Bodega in row exclusive mode;

            delete from JRSG_Ubicacion_Bodega where id_ubicacion = id_ubicacion_p;
            dbms_output.put_line ('La Ubicacion Bodega ID: '|| id_ubicacion_p ||' se elimino correctamente del sistema.');
            commit;
        else
            dbms_output.put_line ('Ubicacion Bodega ID: '|| id_ubicacion_p ||' no se encontro en el sistema.');
        end if;

        exception
            when others then
                raise_application_error (-20004, 'Error inesperado: '|| sqlerrm);
            rollback;
    end;
----MOSTRAR UBICACION_PRODUCTO
create or replace procedure JRSG_Pro_Mostrar_Ubicacion_Bodega (
    id_ubicacion_p in number
) is
    contador number;
    v_id_ubicacion JRSG_Ubicacion_Bodega.id_ubicacion%type;
    v_id_producto JRSG_Producto.id_producto%type;
    v_nombre_producto JRSG_Producto.nombre_producto%type;
    v_nro_estante JRSG_Ubicacion_Bodega.nro_estante%type;
    v_nivel JRSG_Ubicacion_Bodega.nivel%type;

    begin
        select count(*) into contador from JRSG_Ubicacion_Bodega where id_ubicacion = id_ubicacion_p;

        if (contador > 0) then
            select * into v_id_ubicacion, v_id_producto, v_nro_estante, v_nivel from JRSG_Ubicacion_Bodega where id_ubicacion = id_ubicacion_p;
            select nombre_producto into v_nombre_producto from JRSG_Producto where id_producto = v_id_producto;

            dbms_output.put_line('Informacion Ubicacion Bodega ID: ' || id_ubicacion_p || CHR(10) ||
                              'Numero estante: ' || v_nro_estante || CHR(10) ||
                              'Nivel: ' || v_nivel || CHR(10) ||
                              'Producto: ' || v_nombre_producto);
        else
            dbms_output.put_line ('Ubicacion Bodega ID: '|| id_ubicacion_p ||' no encontrado en el sistema.');
        end if;
        exception
            when others then
                raise_application_error (-20002, 'Error inesperado: '|| sqlerrm);
    end;

-----PROCEDIMIENTOS CREADOS:
-----CLIENTE(crud), EMPLEADO(crud), PRODUCTO(crud), COMPRAS(crud), CATEGORIA(crud), PROMOCION(crud), VENTAS(crear-mostrar), TIPO_PAGO(crud)
---- PAGO(crear-mostrar), UBICACION_PRODUCTO(crud), DETALLE_VENTA_PRODUCTO(crear-mostrar), DETALLE_COMPRA_PRODUCTO(crear-mostrar), (falta)BOLETA(mostrar)

-----TERMINO DE PROCEDIMIENTOS ALMACENADOS------------------------------------------------------------------------------

-- 3.- 5 Gestores, siendo estos los que, a partir de la información existente, son capaces de
-- ..generar nueva información en la base de datos, por ejemplo, si en una base de datos
-- ..existen clientes y productos. Se puede realizar una venta con los datos de los productos
-- ..asociado a un cliente en específico, registrando nueva información del cruce de estos
-- ..datos en la venta correspondiente. El manejo de información, se llevará también a cabo
-- ..a través de procedimientos almacenados, secuencias, funciones y cursores.

-----APLICAR PROMOCIÓN
create or replace procedure JRSG_Aplicar_Promocion 
is
    v_descuento number;
    v_precio number;
    v_precio_descuento number;
    campo_actu number := 7; --- Columna 7 en la Tabla JRSG_Producto

    begin
        for p in (select id_producto, id_promocion, precio from JRSG_Producto where id_promocion is not null)

        loop
          select pro.descuento into v_descuento from JRSG_Promocion pro where pro.id_promocion = p.id_promocion;

          v_precio := p.precio;
          v_precio_descuento := v_precio - (v_precio * v_descuento / 100);

          JRSG_Pro_Actualizar_Producto (p.id_producto, null, null, null, null, null, v_precio_descuento, null, null, campo_actu);
        end loop
        commit;
    end;

-----GENERAR BOLETA
create or replace function jrsg_func_genera_boleta (
    p_id_venta in number   -- id de la venta para generar la boleta
) return number   -- retorna el id de la boleta generada
as
    v_id_boleta number;         -- id generado para la boleta
    v_id_cliente number;        -- id del cliente asociado a la venta
    v_fecha_venta date;         -- fecha de la venta
    v_monto_total number;       -- monto total de la venta
    v_valor_neto number;        -- valor neto (sin iva)
    v_total_iva number;         -- total del iva (19% del neto)
    v_id_pago number;           -- id del pago asociado a la venta
    v_tipo_pago varchar2(25);   -- método de pago utilizado
begin
    -- verificar si la venta existe
    select id_cliente, fecha_venta into v_id_cliente, v_fecha_venta
    from jrsg_venta
    where id_venta = p_id_venta;

    -- obtener el monto total y el id del pago asociado a la venta
    select p.id_pago, sum(dvp.cantidad * prod.precio) as "monto_total" into v_id_pago, v_monto_total
    from jrsg_detalle_venta_producto dvp
    join jrsg_producto prod on dvp.id_producto = prod.id_producto
    join jrsg_pago p on p.id_venta = dvp.id_venta
    where dvp.id_venta = p_id_venta
    group by p.id_pago;

    -- calcular el valor neto y el total del iva
    v_valor_neto := round(v_monto_total / 1.19, 1);  -- valor neto sin iva
    v_total_iva := round(v_monto_total - v_valor_neto, 2); -- iva (19%)

    -- obtener el método de pago
    select tp.nombre_metodo_pago into v_tipo_pago
    from jrsg_pago p
    join jrsg_tipo_pago tp on p.id_tipo_pago = tp.id_tipo_pago
    where p.id_pago = v_id_pago;

    -- generar un nuevo id para la boleta
    select JRSG_Sec_Genera_ID_Boleta.nextval into v_id_boleta 
    from dual;

    -- insertar la boleta con valores adicionales
    insert into jrsg_boleta (id_boleta, id_cliente, id_venta, id_pago, fecha_boleta, valor_neto, total_iva) 
        values (v_id_boleta, v_id_cliente, p_id_venta, v_id_pago, sysdate, v_valor_neto, v_total_iva);
    commit;

    -- retornar el id de la boleta generada
    return v_id_boleta;
    dbms_output.put_line('boleta generada exitosamente con id: ' || v_id_boleta);
    dbms_output.put_line('método de pago: ' || v_tipo_pago || ' | monto total: ' || v_monto_total);

    exception
        when no_data_found then
            raise_application_error(+100, 'la venta con id ' || p_id_venta || ' no existe.');
        when program_error then
            raise_application_error(-6501, 'error de programa');
    rollback;
end;

------REGISTRAR VENTA ----------------( REVISAR ) ----------------
create or replace procedure jrsg_pro_registrar_venta (
    p_id_cliente in number,       -- cliente que realiza la compra
    p_productos in sys_refcursor -- cursor con productos y cantidades
) as
    v_id_venta number;         -- id de la venta generada
    v_stock_actual number;     -- stock actual del producto
    v_id_producto number;      -- id del producto
    v_cantidad number;         -- cantidad solicitada del producto
begin
    lock table jrsg_venta in row exclusive mode;
    -- genera un nuevo id para la venta
    select seq_id_venta.nextval into v_id_venta 
    from dual;

    -- se registra la venta
    insert into jrsg_venta(id_venta, id_cliente, fecha_venta)
        values (v_id_venta, p_id_cliente, sysdate);
    commit;
    -- se procesa cada producto en el cursor
    loop
        fetch p_productos into v_id_producto, v_cantidad;  -- extraer datos de p_productos e insertar los en v_id_producto y en v_cantidad
        exit when p_productos%notfound; -- sale cuando no queden productos

        -- verificar si hay stock suficiente
        select cantidad_ps into v_stock_actual -- cantidad_ps de tabla inventario
        from jrsg_inventario
        where id_producto = v_id_producto;

        if v_stock_actual >= v_cantidad then
            -- registrar el detalle de la venta
            insert into jrsg_detalle_venta_producto (id_venta, id_producto, cantidad)
                values (v_id_venta, v_id_producto, v_cantidad);
            commit;
           
            -- actualizar el inventario
            update inventario
            set cantidad_ps = cantidad_ps - v_cantidad
            where id_producto = v_id_producto;

        exception
        when VALUE_ERROR then 
            RAISE_APPLICATION_ERROR(-6502, 'Stock insuficiente para el producto ' || v_id_producto);
        rollback;
    end loop;

    close p_productos;  -- cerrar el cursor
    commit;

    dbms_output.put_line('venta registrada exitosamente con id: ' || v_id_venta);  -- mostrar mensaje de éxito

    exception
    when program_error then
        raise_application_error(-6501, 'error de programa');
    rollback;
end;

---------------------------------------------------------------------------------------------------------------

-- 4.- 3 Reportes, los cuales están definidos a través de consultas relevantes para el negocio,
-- ..cargados en tablas, las cuales responden, por ejemplo: En un sistema de ventas, me
-- ..gustaría saber qué productos se venden más mensualmente y cuáles menos. Esto para
-- ..que el cliente (dueño del negocio), sea capaz de abastecer sus bodegas.

---------------------------------------------------------------------------------------------------------------

-- 5.- Aparte de lo anteriormente mencionado debe ser capaz de monitorear su base de datos
-- ..con triggers que se encarguen de realizar labores de monitoreo y control de la misma,
-- ..en función de la necesidad del negocio.


