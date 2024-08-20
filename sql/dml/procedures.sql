-- PR1 Registro de usuarios'Gerhard', 'Ardon', 'gerhardardon@gmail.com', '2002-02-24', 210, 'gerhard556');
CREATE PROCEDURE PR1(
    Cui VARCHAR(13),
    Firstname VARCHAR(50),
    Lastname VARCHAR(50),
    Email2 VARCHAR(50),
    DateOfBirth DATE,
    Credits INT,
    Password VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar si el email ya existe en la tabla Persona
    IF EXISTS(SELECT 1 FROM Persona WHERE Persona.email = Email2) THEN
        RAISE EXCEPTION 'El email ya está en uso';
    END IF;

    -- Insertar en la tabla Persona
    INSERT INTO Persona(cui, fName, lName, email, birthdate, credits)
    VALUES(Cui, Firstname, Lastname, Email2, DateOfBirth, Credits);

    -- Insertar en la tabla Usuario
    INSERT INTO Usuario(cui, rol, passw, emailconf)
    VALUES(Cui, (SELECT id FROM Rol WHERE rol = 'S'), Password, TRUE);

END;
$$;

-- PR2 Cambio de Roles 
CREATE PROCEDURE PR2(Email2 VARCHAR(50), codeCourse INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar si el email existe en la tabla Persona y si Emailconf es TRUE
    IF NOT EXISTS(SELECT 1 FROM Persona WHERE Persona.email = Email2 ) THEN
        RAISE EXCEPTION 'El email no existe';
    END IF;

    IF NOT EXISTS(select 1 from persona inner join usuario on persona.cui = usuario.cui where persona.email = Email2 and usuario.emailconf = TRUE)THEN
        RAISE EXCEPTION 'El email no está confirmado';
    END IF;

    -- Crear tutor
    INSERT INTO Usuario(cui, rol, passw, emailconf) VALUES ((SELECT cui FROM Persona WHERE Persona.email = Email2), 1, 'tutor', TRUE);
    -- Asignar tutor a curso
    UPDATE Curso SET idTutor = (SELECT id FROM Usuario WHERE Usuario.cui = (SELECT cui FROM Persona WHERE Persona.email = Email2)AND Usuario.rol = 1) WHERE code = codeCourse;
    -- Enviar notificación  
    INSERT INTO Notificacion(user_id, msg) VALUES ((SELECT id FROM Usuario WHERE Usuario.cui = (SELECT cui FROM Persona WHERE Persona.email = Email2) AND Usuario.rol = 2), 'Has sido asignado como tutor del curso ' || codeCourse);
END;
$$;

-- PR3 Asignacion de cursos
CREATE PROCEDURE PR3(Email2 VARCHAR(50), codeCourse INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar si el estudiante tiene los creditos suficientes
    IF NOT EXISTS(SELECT 1 FROM Persona WHERE Persona.email = Email2 AND Persona.credits >= (SELECT credits FROM Curso WHERE code = codeCourse)) THEN
        RAISE EXCEPTION 'No tienes los creditos suficientes';
    END IF;
    -- Asignar curso al estudiante
    INSERT INTO Asignacion(codeCourse, idStudent) VALUES (codeCourse, (SELECT id FROM Usuario WHERE Usuario.cui = (SELECT cui FROM Persona WHERE Persona.email = Email2) AND Usuario.rol = 2));
    -- Enviar notificación
    INSERT INTO Notificacion(user_id, msg) VALUES ((SELECT id FROM Usuario WHERE Usuario.cui = (SELECT cui FROM Persona WHERE Persona.email = Email2) AND Usuario.rol = 2), 'Has sido asignado al curso ' || codeCourse);
    INSERT INTO Notificacion(user_id, msg) VALUES ((SELECT idTutor FROM Curso WHERE code = codeCourse), 'Se ha asignado un estudiante al curso ' || codeCourse);
END;
$$;

-- PR4 