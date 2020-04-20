CREATE DATABASE main;
use main;
CREATE TABLE departamento (
	id_dep INT auto_increment PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE municipio (
	id_mun INT auto_increment PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL, 
    id_dep INT NOT NULL,
    foreign key (id_dep) references departamento(id_dep)
);

CREATE TABLE rol (
	id_rol INT auto_increment PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
CREATE TABLE permiso (
	id_permiso INT auto_increment PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE usuario (
	id_usuario INT auto_increment PRIMARY KEY,
    dpi VARCHAR(25) NOT NULL UNIQUE,  #se lo puse unique porque no debe haber ningun usuario con el mismo dpi
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento date not null,
    correo varchar(255) NOT NULL unique, #se lo puse unique porque no debe haber ningun usuario con el mismo correo
    contraseña VARCHAR(40) NOT NULL,
    id_sede int #puede ser null, un admin no tiene una sede específica. 
);

CREATE TABLE sede (
	id_sede INT auto_increment PRIMARY KEY,
    alias VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) not null, 
    id_mun INT not null,
    encargado INT NOT NULL UNIQUE, #un encargado puede estar a cargo solamente de una sede
    foreign key (encargado) references usuario(id_usuario),
    foreign key (id_mun) references municipio(id_mun)
);


ALTER TABLE usuario
ADD foreign key (id_sede) references sede(id_sede); #cada usuario es propio de una sede

CREATE TABLE autorizacion (
	id_usuario INT NOT NULL,
    id_permiso int NOT NULL,
    foreign key (id_usuario) references usuario(id_usuario),
    foreign key (id_permiso) references permiso(id_permiso),
    primary key (id_usuario, id_permiso) 
);


CREATE TABLE usuario_rol (
	id_rol INT NOT NULL,
    id_usuario int NOT NULL,
    foreign key (id_rol) references rol(id_rol),
    foreign key (id_usuario) references usuario(id_usuario),
    primary key (id_rol, id_usuario) 
);


CREATE TABLE bodega (
	id_bodega INT auto_increment PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) not null, 
    estado char(1) not null DEFAULT 'E' check (estado in ('E', 'D')),#ESTO ES PARA que estado puede ser Enabled o Disabled
    encargado INT NOT NULL unique, #un encargado de bodega puede estar a cargo solamente de una bodega
    id_sede int not null, 
    foreign key (encargado) references usuario(id_usuario),
    foreign key (id_sede) references sede(id_sede)
);


CREATE TABLE producto (
	id_producto int auto_increment primary key, 
    nombre VARCHAR(100) not null,
    descripcion varchar(200) not null,
    precio float not null
);

CREATE TABLE categoria (
	id_categoria int auto_increment primary key,
    nombre VARCHAR(100) not null
);


CREATE TABLE detalle_producto (
	id_producto INT NOT NULL,
    id_categoria int NOT NULL,
    foreign key (id_producto) references producto(id_producto),
    foreign key (id_categoria) references categoria(id_categoria),
    primary key (id_producto, id_categoria) 
);

CREATE TABLE inventario (
    id_producto int not null, 
    id_bodega int not null, 
    cantidad int not null,
    foreign key (id_producto) references producto(id_producto),
    foreign key (id_bodega) references bodega(id_bodega),
    primary key(id_producto, id_bodega)
);


CREATE TABLE log_inventario (
	id_log int auto_increment primary key,
    id_producto int not null, 
    id_bodega int not null,
    cantidad_nueva int not null,
    cantidad_antigua int not null,
    motivo VARCHAR(200) not null, 
    fecha datetime not null, 
    id_usuario int not null, 
    foreign key (id_usuario) references usuario(id_usuario),
    foreign key (id_producto, id_bodega) references inventario(id_producto, id_bodega)
);

CREATE TABLE cliente (
	id_cliente int auto_increment primary key,
    nombre varchar(100) not null, 
    nit varchar(15),  #puede ser null
    dpi VARCHAR(25) not null unique, 
    direccion VARCHAR(100) not null, 
    id_sede int not null, 
    foreign key (id_sede) references sede(id_sede)
);

CREATE TABLE venta (
	id_venta int auto_increment primary key, 
    id_cliente int not null, 
    vendedor int not null, 
    fecha_facturacion datetime not null, 
    subtotal float not null default 0.0, #este campo se va a ir modificando cada que se agrega algo en detalle_venta
    descuento float default 0.0 not null, #este campo se va a ir modificando cada que se agrega algo en detalle_venta
    cargo float default 0.0 not null, #este campo se va a ir modificando cada que se agrega algo en detalle_venta
    estado char(1) not null DEFAULT 'E' check( estado in ('E','P')), /*  los estados serán:	'E' -> entregada,
																		'P' -> pendiente*/
	entrega char(1)not null DEFAULT 'L' check (entrega in ('L', 'D')) /*puede ser: Local o a Domicilio.*/,
    repartidor int, #puede ser null ya que puede no solicitar entrega a domicilo 
    fecha_entrega datetime,  #puede ser null ya que puede o no solicitar entrega a domicilio. Cuando no solicite, la fecha_entrega será null porque basta con fecha_facturación
    foreign key (id_cliente) references cliente(id_cliente),
    foreign key (vendedor) references usuario(id_usuario),
    foreign key (repartidor) references usuario(id_usuario)
);


CREATE TABLE detalle_venta (
	id_producto INT NOT NULL,
    id_bodega int not null,
    id_venta int NOT NULL,
    cantidad int not null, 
    descuento_unitario float, # puede ser null :)
    foreign key (id_producto, id_bodega) references inventario(id_producto, id_bodega),
    foreign key (id_venta) references venta(id_venta),
    primary key (id_producto, id_bodega, id_venta) 
);


CREATE TABLE orden_transferencia (
	id_orden int auto_increment primary key, 
    solicitante int not null,  -- de aqui podemos sacar el id_sede origen.
    descripcion varchar(75), -- puede ser null
    estado char (1) default 'P' check (estado in ('A', 'P', 'E')),  /*Los estados pueden ser:
															-Aceptada
                                                            -Pendiente
                                                            -Entregada*/
	tipo_orden char(1) default 'I' not null check(tipo_orden in('I', 'E')), -- Interna o Externa
    sede_origen int not null, -- sede desde la que solicitamos productos. Sede de bodega_entrante.
	sede_destino int not null, -- sede a la que le vamos a solicitar productos. Sede de bodega_saliente.
    bodega_saliente int, -- puede ser null mientras no la acepten. Bodega desde la que vamos a extraer productos
    bodega_entrante int, -- puede ser null mientras no la acepten. Bodega a la que vamos a agregar productos
    fecha_orden datetime not null, 
    fecha_aceptada datetime, #este campo se setea cuando se acepta la orden de tranferencia. El estado pasa a ser 'A'.
    aceptante int,  #este campo se setea cuando alguien con permiso de visualizacion de ordenes, acepta la orden de transferencia
    fecha_entrega datetime,  #este campo se setea cuando el repartidor entrega la orden. El estado pasa a ser 'E'
    repartidor int, #este campo se setea cuando se acepta la orden de transferencia, inmediatamente le tiene que asignar a un repartidor
    foreign key (solicitante) references usuario (id_usuario),
    foreign key (aceptante) references usuario (id_usuario),
    foreign key (repartidor) references usuario (id_usuario),
    foreign key (sede_destino) references sede(id_sede),
    foreign key (sede_origen) references sede(id_sede),
    foreign key (bodega_saliente) references bodega(id_bodega),
    foreign key (bodega_entrante) references bodega(id_bodega)
);

CREATE TABLE detalle_orden (
	id_producto int not null,
    id_orden int not null,
    cantidad int default 0 not null,
    foreign key (id_producto) references producto(id_producto),
	foreign key (id_orden) references orden_transferencia(id_orden),
    primary key(id_producto, id_orden)
);

use main;
drop table detalle_orden;
drop table orden_transferencia;





