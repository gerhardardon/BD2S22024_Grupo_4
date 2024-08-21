-- Tabla

CREATE TABLE IF NOT EXISTS Historial (
    Fecha TIMESTAMP NOT NULL,
    Descripcion VARCHAR(700) NOT NULL,
    accion VARCHAR(50) NOT NULL
);

-- TRIGGERS INSERT

CREATE OR REPLACE FUNCTION insert_rol_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un insert en la tabla Rol', 'INSERT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_rol AFTER INSERT ON Rol
FOR EACH ROW EXECUTE FUNCTION insert_rol_func();

CREATE OR REPLACE FUNCTION insert_persona_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un insert en la tabla Persona', 'INSERT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_persona AFTER INSERT ON Persona
FOR EACH ROW EXECUTE FUNCTION insert_persona_func();

CREATE OR REPLACE FUNCTION insert_usuario_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un insert en la tabla Usuario', 'INSERT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_usuario AFTER INSERT ON Usuario
FOR EACH ROW EXECUTE FUNCTION insert_usuario_func();

CREATE OR REPLACE FUNCTION insert_notificacion_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un insert en la tabla Notificacion', 'INSERT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_notificacion AFTER INSERT ON Notificacion
FOR EACH ROW EXECUTE FUNCTION insert_notificacion_func();

CREATE OR REPLACE FUNCTION insert_curso_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un insert en la tabla Curso', 'INSERT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_curso AFTER INSERT ON Curso
FOR EACH ROW EXECUTE FUNCTION insert_curso_func();

CREATE OR REPLACE FUNCTION insert_asignacion_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un insert en la tabla Asignacion', 'INSERT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_asignacion AFTER INSERT ON Asignacion
FOR EACH ROW EXECUTE FUNCTION insert_asignacion_func();

-- TRIGGERS UPDATE

CREATE OR REPLACE FUNCTION update_rol_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un update en la tabla Rol', 'UPDATE');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_rol AFTER UPDATE ON Rol
FOR EACH ROW EXECUTE FUNCTION update_rol_func();

CREATE OR REPLACE FUNCTION update_persona_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un update en la tabla Persona', 'UPDATE');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_persona AFTER UPDATE ON Persona
FOR EACH ROW EXECUTE FUNCTION update_persona_func();

CREATE OR REPLACE FUNCTION update_usuario_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un update en la tabla Usuario', 'UPDATE');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_usuario AFTER UPDATE ON Usuario
FOR EACH ROW EXECUTE FUNCTION update_usuario_func();

CREATE OR REPLACE FUNCTION update_notificacion_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un update en la tabla Notificacion', 'UPDATE');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_notificacion AFTER UPDATE ON Notificacion
FOR EACH ROW EXECUTE FUNCTION update_notificacion_func();

CREATE OR REPLACE FUNCTION update_curso_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un update en la tabla Curso', 'UPDATE');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_curso AFTER UPDATE ON Curso
FOR EACH ROW EXECUTE FUNCTION update_curso_func();

CREATE OR REPLACE FUNCTION update_asignacion_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un update en la tabla Asignacion', 'UPDATE');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_asignacion AFTER UPDATE ON Asignacion
FOR EACH ROW EXECUTE FUNCTION update_asignacion_func();

-- TRIGGERS DELETE

CREATE OR REPLACE FUNCTION delete_rol_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un delete en la tabla rol', 'DELETE');
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_rol AFTER DELETE ON Rol
FOR EACH ROW EXECUTE FUNCTION delete_rol_func();

CREATE OR REPLACE FUNCTION delete_persona_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un delete en la tabla Persona', 'DELETE');
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_persona AFTER DELETE ON Persona
FOR EACH ROW EXECUTE FUNCTION delete_persona_func();

CREATE OR REPLACE FUNCTION delete_usuario_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un delete en la tabla Usuario', 'DELETE');
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_usuario AFTER DELETE ON Usuario
FOR EACH ROW EXECUTE FUNCTION delete_usuario_func();

CREATE OR REPLACE FUNCTION delete_notificacion_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un delete en la tabla Notificacion', 'DELETE');
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_notificacion AFTER DELETE ON Notificacion
FOR EACH ROW EXECUTE FUNCTION delete_notificacion_func();

CREATE OR REPLACE FUNCTION delete_curso_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un delete en la tabla Curso', 'DELETE');
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_curso AFTER DELETE ON Curso
FOR EACH ROW EXECUTE FUNCTION delete_curso_func();

CREATE OR REPLACE FUNCTION delete_asignacion_func() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Historial(Fecha, Descripcion, accion)
    VALUES(NOW(), 'Se ha realizado un delete en la tabla Asignacion', 'DELETE');
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_asignacion AFTER DELETE ON Asignacion
FOR EACH ROW EXECUTE FUNCTION delete_asignacion_func();
