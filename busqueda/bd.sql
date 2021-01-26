
create database empleos;
use empleos;

create table ubicacion(
	id int not null identity(1,1) primary key,
	nombre varchar(50) not null
);

create table empleado(
	ci int not null primary key,
	nombreYApellido varchar(80) not null,
	idUbicacion int not null,
	foreign key(idUbicacion) references ubicacion(id)
	on update cascade on delete cascade
);

create table servicio(
	id int not null identity(1,1) primary key,
	nombre varchar(30) not null
);

create table detalleServicio(
	ciEmpleado int not null,
	idServicio int not null,
	primary key(ciEmpleado, idServicio),
	fecha date not null,
	descripcion varchar(100),
	calificacion tinyint,
	foreign key(ciEmpleado) references empleado(ci)
	on update cascade on delete cascade,
	foreign key(idServicio) references servicio(id)
	on update cascade on delete cascade
);


create table horario(
	ciEmpleado int not null,
	idServicio int not null,
	id int not null identity(1,1),
	primary key(ciEmpleado, idServicio, id),
	horaIni time(0),
	horaFin time(0),
	foreign key(ciEmpleado, idServicio) references detalleServicio(ciEmpleado, idServicio)
	on update cascade on delete cascade
);



insert into ubicacion values('Las Lomas');
insert into ubicacion values('Los Lotes');
insert into ubicacion values('Los Tusequis');
insert into ubicacion values('Av 4 de Septiembre');


insert into empleado values(111, 'Joaquin Chumacero', 1);
insert into empleado values(222, 'Tomas Lopez', 1);
insert into empleado values(333, 'Carlos Camacho', 2);
insert into empleado values(444, 'Arturo Gomez', 2);
insert into empleado values(555, 'Marco Soria', 2);
insert into empleado values(777, 'Fernando Chumacero', 3);
insert into empleado values(888, 'Agustin Soto', 3);
insert into empleado values(999, 'Pedro Mamani', 4);
insert into empleado values(101, 'Patricio Colque', 4);
insert into empleado values(102, 'Sandro Quintana', 4);

insert into servicio values('Jardineria');
insert into servicio values('Plomeria');
insert into servicio values('Electricista');
insert into servicio values('Carpinteria');


insert into detalleServicio values(101, 1, getDate(), 'Servicio optimo', 0);
insert into detalleServicio values(101, 2, getDate(), 'Servicio al instante', 0);
insert into detalleServicio values(102, 1, getDate(), 'Servicio garantizado', 0);
insert into detalleServicio values(111, 2, getDate(), 'Servicio con calidad', 0);
insert into detalleServicio values(222, 4, getDate(), 'Buen servicio', 0);
insert into detalleServicio values(333, 3, getDate(), 'Hago un trabajo muy bien', 0);
insert into detalleServicio values(444, 4, getDate(), 'Trabajo sin daños', 0);
insert into detalleServicio values(444, 1, getDate(), 'Hago un buen servicio', 0);
insert into detalleServicio values(555, 2, getDate(), 'Estoy para servirle', 0);
insert into detalleServicio values(777, 4, getDate(), 'Todo al instante', 0);
insert into detalleServicio values(888, 1, getDate(), 'Servicio agradable', 0);
insert into detalleServicio values(888, 4, getDate(), 'Servicio agradable', 0);
insert into detalleServicio values(999, 4, getDate(), 'El mejor en realizar un buen servicio', 0);


insert into horario values(101, 1, '08:30', '10:00');
insert into horario values(101, 2, '14:00', '18:00');
insert into horario values(102, 1, '08:00', '11:00');
insert into horario values(111, 2, '08:30', '11:00');
insert into horario values(222, 4, '08:00', '10:30');
insert into horario values(333, 3, '16:00', '19:00');
insert into horario values(444, 1, '08:30', '10:00');
insert into horario values(444, 4, '18:00', '21:00');
insert into horario values(555, 2, '07:30', '10:00');
insert into horario values(777, 4, '13:30', '17:30');
insert into horario values(888, 1, '07:00', '10:00');
insert into horario values(888, 4, '14:00', '18:00');
insert into horario values(999, 4, '14:00', '18:00');








select * from ubicacion;
select * from empleado;
select * from servicio;
select * from detalleServicio;
select * from horario;




select * from ubicacion;
select e.ci, e.nombreYApellido, u.nombre as 'zona' from empleado e, ubicacion u where e.idUbicacion = u.id;

--Mostrar todos los servicios
select s.nombre, e.nombreYApellido
from empleado e, detalleServicio ds, servicio s 
where e.ci  = ds.ciEmpleado and ds.idServicio = s.id;

--Mostrar el ci, nombre y descripción del trabajo el horario
select e.ci, e.nombreYApellido, ds.descripcion, h.horaIni, h.horaFin
from empleado e, detalleServicio ds, servicio s, horario h
where e.ci = ds.ciEmpleado and ds.idServicio = s.id and ds.ciEmpleado = h.ciEmpleado and ds.idServicio = h.idServicio and e.ci = 101;

--mostrar el servicio con paramatro nombre del servicio, nombre de la ubicación y el turno en que es ofrece el servicio
select s.nombre, e.nombreYApellido
from ubicacion u, empleado e, detalleServicio ds, servicio s, horario h
where u.id = e.idUbicacion and e.ci = ds.ciEmpleado and ds.idServicio = s.id
	  and ds.ciEmpleado = h.ciEmpleado and ds.idServicio = h.idServicio
	  and s.nombre = 'jardineria' and u.nombre = 'Av 4 de Septiembre' and dbo.getTurno(h.horaIni) = 'mañana';


--Actualizar la calificacion de un empleado
update detalleServicio set calificacion = 2 where ciEmpleado = 101 and idServicio = 1;


create function getTurno( @horaIni time(0)) returns varchar(8)
as
begin
 declare @turno varchar(8)
 if(@horaIni between '07:00' and '12:00')
	set @turno = 'mañana'
 else
	if(@horaIni between '12:00' and '18:00')
		set @turno = 'tarde'
	else
		set @turno = 'noche'
 return @turno
end

select dbo.getTurno('01:01');
