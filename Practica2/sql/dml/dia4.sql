-- Carga masiva de pacientes con plpgsql
do $$
declare
    i integer;
begin
-- for para insertar pacientes insert into paciente (edad, genero) values (i, 'M');
for i in 1..15 loop
    insert into paciente (edad, genero) values (57, 'M');
    insert into paciente (edad, genero) values (53, 'F');
    insert into paciente (edad, genero) values (54, 'M');
    insert into paciente (edad, genero) values (56, 'F');
    insert into paciente (edad, genero) values (55, 'M');
    insert into paciente (edad, genero) values (52, 'F');
    insert into paciente (edad, genero) values (51, 'M');
    insert into paciente (edad, genero) values (50, 'F');
    insert into paciente (edad, genero) values (49, 'M');
    insert into paciente (edad, genero) values (48, 'F');
end loop;
end $$;

-- Carga masiva de logHabitaciones con plpgsql
do $$
declare
    i integer;
begin
-- for para insertar habitaciones insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-01 00:00:00', 'ocupada', 1);
for i in 1..14 loop
    insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-01 00:00:00', 'ocupada', i);
    insert into logHabitacion (timestamp, status, idHabitacion) values ('2024-01-01 00:00:00', 'libre', i);
end loop;
end $$;

select * from logHabitacion;
select count(*) from logHabitacion;
select * from paciente;
select count(*) from paciente;