-- inserts de la tabla paciente
insert into paciente (edad, genero) values (20, 'M');
insert into paciente (edad, genero) values (21, 'F');
insert into paciente (edad, genero) values (21, 'M');
insert into paciente (edad, genero) values (21, 'F');
insert into paciente (edad, genero) values (27, 'M');
insert into paciente (edad, genero) values (28, 'F');
insert into paciente (edad, genero) values (32, 'M');
insert into paciente (edad, genero) values (33, 'F');
insert into paciente (edad, genero) values (34, 'M');
insert into paciente (edad, genero) values (37, 'M');
insert into paciente (edad, genero) values (38, 'F');
insert into paciente (edad, genero) values (39, 'M');
insert into paciente (edad, genero) values (39, 'F');
insert into paciente (edad, genero) values (54, 'M');
insert into paciente (edad, genero) values (57, 'F');
insert into paciente (edad, genero) values (58, 'M');
insert into paciente (edad, genero) values (58, 'F');
insert into paciente (edad, genero) values (59, 'M');

-- inserts de la tabla habitacion
insert into habitacion (habitacion) values ('Room 1');
insert into habitacion (habitacion) values ('Room 2');
insert into habitacion (habitacion) values ('Room 3');
insert into habitacion (habitacion) values ('Room 4');
insert into habitacion (habitacion) values ('Room 5');

-- inserts de la tabla logActividad
insert into logActividad (timestamp, actividad, idPaciente, idHabitacion) values ('2024-01-01 00:00:00', 'consulta general', 1, 1);
insert into logActividad (timestamp, actividad, idPaciente, idHabitacion) values ('2024-01-01 00:00:00', 'consulta general', 2, 2);
insert into logActividad (timestamp, actividad, idPaciente, idHabitacion) values ('2024-01-01 00:00:00', 'pediatria',        3, 3);
insert into logActividad (timestamp, actividad, idPaciente, idHabitacion) values ('2024-01-02 00:00:00', 'laboratorio',      4, 4);
insert into logActividad (timestamp, actividad, idPaciente, idHabitacion) values ('2024-01-02 00:00:00', 'laboratorio',      5, 5);
insert into logActividad (timestamp, actividad, idPaciente, idHabitacion) values ('2024-01-02 00:00:00', 'consulta general', 6, 3);
insert into logActividad (timestamp, actividad, idPaciente, idHabitacion) values ('2024-01-02 00:00:00', 'consulta general', 7, 4);
insert into logActividad (timestamp, actividad, idPaciente, idHabitacion) values ('2024-01-03 00:00:00', 'laboratorio',      8, 1);
insert into logActividad (timestamp, actividad, idPaciente, idHabitacion) values ('2024-01-03 00:00:00', 'laboratorio',      9, 2);
insert into logActividad (timestamp, actividad, idPaciente, idHabitacion) values ('2024-01-03 00:00:00', 'pediatria',       10, 3);

-- inserts de la tabla logHabitacion
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-01 00:00:00', 'ocupada', 1);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-01 00:00:00', 'libre',   2);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-01 00:00:00', 'ocupada', 3);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-01 00:00:00', 'libre',   1);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-01 00:00:00', 'ocupada', 3);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-01 00:00:00', 'libre',   2);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-02 00:00:00', 'ocupada', 4);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-02 00:00:00', 'ocupada', 5);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-02 00:00:00', 'libre',   4);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-02 00:00:00', 'libre',   5);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-02 00:00:00', 'ocupada', 3);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-02 00:00:00', 'ocupada', 3);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-02 00:00:00', 'ocupada', 3);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-02 00:00:00', 'libre',   4);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-03 00:00:00', 'libre',   5);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-03 00:00:00', 'libre',   1);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-03 00:00:00', 'ocupada', 2);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-03 00:00:00', 'ocupada', 3);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-03 00:00:00', 'libre',   4);
insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-03 00:00:00', 'libre',   5);

-- selects
select * from paciente;
select * from habitacion;
select * from logActividad;
select * from logHabitacion;

select count(*) from paciente;
select count(*) from habitacion;
select count(*) from logActividad;
select count(*) from logHabitacion;