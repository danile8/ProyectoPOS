create database proyecto_pos;
ALTER SCHEMA `proyecto_pos`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci;
use proyecto_pos;

create table boleta(
	id_boleta int auto_increment,
    fecha date not null,
    monto int not null,
    estado varchar(10),
    forma_pago varchar(10),
    constraint pk_boleta primary key (id_boleta)
);

create table producto(
	id_producto int not null auto_increment,
    nombre varchar(70) not null,
    precio int not null,
    descripcion varchar(100),
	url_imagen varchar(100),
    disponibilidad boolean,
    constraint pk_producto primary key (id_producto)
);

create table item_boleta(
	id_item_boleta int auto_increment,
	id_boleta int,
    id_producto int not null,
    cantidad int not null,
    constraint pk_item_boleta primary key (id_item_boleta),
	constraint fk_boleta foreign key (id_boleta) references boleta(id_boleta),
    constraint fk_producto foreign key (id_producto) references producto(id_producto)
);

-- productos
INSERT INTO `proyecto_pos`.`producto` (`nombre`, `precio`, `descripcion`, `url_imagen`, `disponibilidad`) VALUES ('Cocaloca 1 LT retornable', '1990', 'Bebida de fantasía', 'https://bit.ly/3lavmli', 1);
INSERT INTO `proyecto_pos`.`producto` (`nombre`, `precio`, `descripcion`, `url_imagen`, `disponibilidad`) VALUES ('Galletas triton 10 un.', '990', 'Galleta sabor chocolate', 'https://bit.ly/2JcCUGx', 1);
INSERT INTO `proyecto_pos`.`producto` (`nombre`, `precio`, `descripcion`, `url_imagen`, `disponibilidad`) VALUES ('Chocolate trensito 300 g', '1490', 'Chocolate sucedaneo a base de manteca', 'https://bit.ly/3m4FDk6', 1);
INSERT INTO `proyecto_pos`.`producto` (`nombre`, `precio`, `descripcion`, `url_imagen`, `disponibilidad`) VALUES ('Pan ideal 20 un.', '2390', 'Bolsa de pan de molde', 'https://bit.ly/364tbeo', 1);

-- boletas
INSERT INTO `proyecto_pos`.`boleta` (`fecha`, `monto`, `estado`, `forma_pago`) VALUES ('2020-10-16', '1990', 'emitida', 'efectivo');
INSERT INTO `proyecto_pos`.`boleta` (`fecha`, `monto`, `estado`, `forma_pago`) VALUES ('2020-10-17', '1980', 'emitida', 'efectivo');
INSERT INTO `proyecto_pos`.`boleta` (`fecha`, `monto`, `estado`, `forma_pago`) VALUES ('2020-10-18', '7170', 'emitida', 'debito');
INSERT INTO `proyecto_pos`.`boleta` (`fecha`, `monto`, `estado`, `forma_pago`) VALUES ('2020-10-19', '5960', 'emitida', 'credito');

-- item boleta
INSERT INTO `proyecto_pos`.`item_boleta` (`id_boleta`, `id_producto`, `cantidad`) VALUES ('1', '1', '1');
INSERT INTO `proyecto_pos`.`item_boleta` (`id_boleta`, `id_producto`, `cantidad`) VALUES ('2', '2', '2');
INSERT INTO `proyecto_pos`.`item_boleta` (`id_boleta`, `id_producto`, `cantidad`) VALUES ('3', '4', '3');
INSERT INTO `proyecto_pos`.`item_boleta` (`id_boleta`, `id_producto`, `cantidad`) VALUES ('4', '1', '1');
INSERT INTO `proyecto_pos`.`item_boleta` (`id_boleta`, `id_producto`, `cantidad`) VALUES ('4', '2', '1');
INSERT INTO `proyecto_pos`.`item_boleta` (`id_boleta`, `id_producto`, `cantidad`) VALUES ('4', '3', '2');

select boleta.id_boleta, nombre, cantidad 
from producto 
join item_boleta on producto.id_producto=item_boleta.id_producto 
join boleta on boleta.id_boleta=item_boleta.id_boleta;

select boleta.id_boleta, sum(cantidad) as "total productos", sum(precio*cantidad) as "total boleta", fecha
from producto 
join item_boleta on producto.id_producto=item_boleta.id_producto 
join boleta on boleta.id_boleta=item_boleta.id_boleta
group by boleta.id_boleta
order by fecha asc
