DO $$
DECLARE
    r RECORD;
BEGIN
    -- Iterar sobre todos los procedimientos en la base de datos
    FOR r IN (SELECT routine_name, routine_schema
              FROM information_schema.routines
              WHERE routine_type = 'PROCEDURE'
              AND specific_schema NOT IN ('pg_catalog', 'information_schema')) 
    LOOP
        -- Generar y ejecutar el comando DROP PROCEDURE
        EXECUTE 'DROP PROCEDURE ' || r.routine_schema || '.' || r.routine_name || ' CASCADE';
    END LOOP;
END $$;
