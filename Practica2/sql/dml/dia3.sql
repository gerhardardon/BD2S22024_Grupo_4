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