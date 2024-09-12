-- Carga masiva de pacientes con plpgsql
do $$
declare
    i integer;
begin
-- for para insertar pacientes insert into paciente (edad, genero) values (i, 'M');
for i in 1..100 loop
    insert into paciente (edad, genero) values (i, 'M');
end loop;
end $$;

-- Carga masiva de habitaciones con plpgsql
do $$
declare
    i integer;
begin
-- for para insertar habitaciones insert into habitacion (habitacion) values ('Room ' || i);
for i in 1..10 loop
    insert into habitacion (habitacion) values ('newRoom ' || i);
end loop;
end $$;

select * from paciente;
select count(*) from paciente;
select * from habitacion;
select count(*) from habitacion;