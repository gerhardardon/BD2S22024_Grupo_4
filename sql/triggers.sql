-- Tabla

CREATE TABLE IF NOT EXISTS Historial (
    Fecha DATETIME NOT NULL,
    Descripcion VARCHAR(700) NOT NULL,
    accion VARCHAR(50) NOT NULL
);

-- TRIGGERS INSERT

DELIMITER $$
CREATE TRIGGER insert_rol AFTER INSERT ON Rol
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un insert en la tabla Rol', 'INSERT');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER insert_persona AFTER INSERT ON Persona
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un insert  en la tabla Persona', 'INSERT');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER insert_usuario AFTER INSERT ON Usuario
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un insert  en la tabla Usuario', 'INSERT');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER insert_notificacion AFTER INSERT ON Notificacion
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un insert  en la tabla Notificacion', 'INSERT');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER insert_curso AFTER INSERT ON Curso
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un insert  en la tabla Curso', 'INSERT');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER insert_asignacion AFTER INSERT ON Asignacion
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un insert en la tabla Asignacion', 'INSERT');
END $$
DELIMITER ;

-- TRIGGERS UPDATE

DELIMITER $$
CREATE TRIGGER update_rol AFTER UPDATE ON Rol
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un update en la tabla Rol', 'UPDATE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER update_persona AFTER UPDATE ON Persona
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un update en la tabla Persona', 'UPDATE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER update_usuario AFTER UPDATE ON Usuario
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un update en la tabla Usuario', 'UPDATE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER update_notificacion AFTER UPDATE ON Notificacion
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un update en la tabla Notificacion', 'UPDATE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER update_curso AFTER UPDATE ON Curso
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un update en la tabla Curso', 'UPDATE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER update_asignacion AFTER UPDATE ON Asignacion
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado una acción en la tabla Asignacion', 'UPDATE');
END $$
DELIMITER ;

-- TRIGGERS DELETE

DELIMITER $$
CREATE TRIGGER delete_rol AFTER DELETE ON Rol
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un delete en la tabla rol', 'DELETE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER delete_persona AFTER DELETE ON Persona
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un delete en la tabla Persona', 'DELETE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER delete_usuario AFTER DELETE ON Usuario
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un delete en la tabla Usuario', 'DELETE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER delete_notificacion AFTER DELETE ON Notificacion
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un delete en la tabla Notificacion', 'DELETE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER delete_curso AFTER DELETE ON Curso
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un delete en la tabla Curso', 'DELETE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER delete_asignacion AFTER DELETE ON Asignacion
FOR EACH ROW
BEGIN
    SELECT NOW() INTO @fecha;
    INSERT INTO Historial(fecha, Des, accion)
    VALUES(@fecha, 'Se ha realizado un delete en la tabla Asignacion', 'DELETE');
END $$
DELIMITER ;
