
create schema proyectoFinal;



-- ********************* creando tablas  *******************

create table proyectofinal.coche (
	id SERIAL primary key,
	id_modelo int not null,
	id_color int not null,
	matricula varchar(30),
	km float not null,
	id_poliza int not null,
	compra date
	
);
	

create table proyectofinal.modelo(
	id SERIAL primary key,
	modelo varchar(50),
	id_marca int not null
	
);

create table proyectofinal.marca(
	id SERIAL primary key,
	id_grupoEmpresarial int not null,
	marca varchar(50)
	
);

create table proyectofinal.revision(
	id SERIAL primary key,
	id_coche int,
	id_moneda int not null, 
	km_revision float not null,
	fecha_ingreso date,
	importe int not null
	
);

create table proyectofinal.grupoEmpresarial(
	id SERIAL primary key,
	nombre varchar(50)
);


create table proyectofinal.moneda(
	id SERIAL primary key,
	moneda varchar(50)
);

create table proyectofinal.poliza(
	id SERIAL primary key,
	numero varchar(20),
	id_aseguradora int not null,
	id_coche int,
	fecha_alta date,
	vencimiento date
);

create table proyectofinal.aseguradora(
	id SERIAL primary key,
	nombre varchar(50)
);

create table proyectofinal.color(
	id SERIAL primary key,
	color varchar(50)
);


create table proyectofinal.flota_vehicular(
matricula varchar(50),
grupoempresarial varchar(50),
marca varchar(50),
modelo varchar(50),
fecha_compra date,
color varchar(50),
aseguradora varchar(50),
poliza int,
fecha_alta_seguro date,
importe_revision float,
moneda varchar(50),
kms_revision float,
fecha_revision date,
kms_totales int

);



-- *********************************** Creando relaciones entre tablas **********************************
--alter table poliza  drop poliza
--alter table revision  add id_moneda int
--drop table poliza

alter table proyectofinal.coche add constraint fk_coche_modelo foreign key (id_modelo) references modelo(id);

alter table proyectofinal.coche add constraint fk_coche_color foreign key (id_color) references color(id);
alter table proyectofinal.modelo add constraint fk_modelo_marca foreign key (id_marca) references marca(id);
alter table proyectofinal.marca add constraint fk_marca_gpoEmpresarial foreign key (id_grupoEmpresarial) references grupoEmpresarial(id);
alter table proyectofinal.revision add constraint fk_revision_moneda foreign key (id_moneda) references moneda(id);
alter table proyectofinal.poliza add constraint fk_poliza_aseguradora foreign key (id_aseguradora) references aseguradora(id);
alter table proyectofinal.revision add constraint fk_revision_coche foreign key (id_coche) references coche(id);



--agregar datos 
insert into aseguradora (nombre) values ('Allianz'),('Axa'),('Mapfre'),('Generali');
insert into poliza (numero, id_aseguradora, fecha_alta,vencimiento) values 
(25786,1, '2009-06-01', '2011-06-01'),
(195443,2,'2010-04-17','2012-04-17'),
(110761,3,'2011-08-23','2013-08-23'),
(79841,4, '2001-04-05','2003-04-05'),
(112320,1, '2012-10-22','2014-10-22'),
(135515,2,'2020-04-13','2022-04-13');

insert into grupoempresarial (nombre) values  ('Renault-Nissan-Mitsubishi Alliance'), ('PSA Peugeot S.A.'),('Hyundai Motor Group');
insert into marca (id_grupoempresarial, marca) values (1,'Renault'), (2,'Citroën'),(3, 'Nissan'),(1,'Kia'),(2,'Hyundai'),(3,'Peugeot'),(1,'Renault'),(2,'Kia'),(3,'Hyundai'),(1,'Dacia');
insert into modelo (modelo, id_marca) values 
('Clio',2),
('DS4',3),
('Leaf',4),
('Rio',5),
('Tucson',6),
('206',7),
('Clio',8),
('Ceed',9),
('i30',10),
('Duster',10);

insert into moneda (moneda) values ('Peso Colombiano'),('Dolar'),('Euro'), ('Peso Mexicano');

insert into color (color) values ('blanco'),('azul'),('Gris Plateado'),('Rojo');

insert into coche (id_modelo,id_color,id_poliza,matricula,km,compra) values 
(3,1,1,'7343FRT', 35400,'1999-07-07'),
(4,2,2,'2438GSV',20321,'2000-09-07'),
(5,3,3,'2438GSV',30872,'2015-01-07'),
(6,4,4,'9666FZC',25821,'2020-03-07'),
(7,1,5,'7221BJG',40102,'2013-09-07'),
(8,2,6,'7221BJG',15922,'2010-10-07'),
(9,3,1,'7343FRT',80000,'2000-11-07'),
(10,4,2,'2438GSV',32101,'2001-01-07'),
(10,1,3,'2438GSV',45801,'2005-05-07'),
(9,1,4,'9666FZC',55723,'2019-04-07'),
(3,1,5,'7221BJG',30289,'2000-03-07'),
(4,3,6,'7221BJG',11000,'2017-11-07');



insert into revision (id_coche,km_revision, fecha_ingreso, importe, id_moneda) values 
(1,20564,'2020-07-07',1076032.5,1),
(2,10028,'2010-05-13',734.7,2),
(3,20312,'2016-05-17',460.0,3),
(4,10543,'2017-12-13',344330.4,1),
(5,18066,'2000-05-18',1162115.1,1),
(6,74499,'2012-06-28',11869.2,4),
(7,29564,'2020-07-07',1076032.5,1),
(8,12028,'2010-05-13',734.7,2),
(9,28312,'2016-05-17',460.0,3),
(10,19543,'2017-12-13',344330.4,1),
(11,12066,'2000-05-18',1162115.1,1),
(12,74499,'2012-06-28',11869.2,4);







--  ******************************** Consultas **************************

select 
	grupoempresarial.nombre as grupo_empresarial,
	marca.marca,
	modelo.modelo, 
	coche.compra as fecha_compra,
	coche.matricula,
	color.color,
	coche.km,
	aseguradora.nombre as aseguradora,
	poliza.numero as numero_poliza
from proyectofinal.grupoempresarial
join proyectofinal.marca on marca.id_grupoempresarial = grupoempresarial.id
join proyectofinal.modelo on modelo.id_marca = marca.id 
join proyectofinal.coche on modelo.id = coche.id_modelo 
join proyectofinal.color on coche.id_color = color.id
join proyectofinal.poliza on coche.id_poliza = poliza.id
join proyectofinal.aseguradora on poliza.id_aseguradora = aseguradora.id 


