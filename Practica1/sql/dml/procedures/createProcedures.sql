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
    -- Verificar si el campo firstname tiene solo letras
    IF NOT Firstname ~ '^[a-zA-Z]+$' THEN
        RAISE EXCEPTION 'El campo letras debe contener solo letras';
    END IF;

    -- Verificar si el campo lastname tiene solo letras
    IF NOT Lastname ~ '^[a-zA-Z]+$' THEN
        RAISE EXCEPTION 'El campo letras debe contener solo letras';
    END IF;

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

-- PR5 Creacion de cursos
CREATE PROCEDURE PR5(codeCourse INT, courseName VARCHAR(50), courseCredits INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar si el campo courseName tiene solo letras
    IF NOT courseName ~ '^[A-Za-z\s]+$' THEN
        RAISE EXCEPTION 'El campo courseName debe contener solo letras';
    END IF;

    -- verificar si el campo courseCredits tiene solo numeros
    IF NOT courseCredits::TEXT ~ '^[0-9]+$' THEN
        RAISE EXCEPTION 'El campo courseCredits debe contener solo numeros';
    END IF;

    -- Verificar si el campo codeCourse tiene solo numeros
    IF NOT codeCourse::TEXT ~ '^[0-9]+$' THEN
        RAISE EXCEPTION 'El campo codeCourse debe contener solo numeros';
    END IF;

    -- Verificar si el curso ya existe
    IF EXISTS(SELECT 1 FROM Curso WHERE Curso.code = codeCourse) THEN
        RAISE EXCEPTION 'El curso ya existe';
    END IF;


    -- Crear curso
    INSERT INTO Curso(code, name, maxStudents, credits) VALUES (codeCourse, courseName, 110, courseCredits);
END;
$$;

-- PR6 Validar campos
CREATE PROCEDURE PR6(letras VARCHAR(50), numeros INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar si el campo letras tiene solo letras
    IF NOT letras ~ '^[A-Za-z\s]+$' THEN
        RAISE EXCEPTION 'El campo letras debe contener solo letras';
    END IF;

    -- Verificar si el campo numeros tiene solo numeros
    IF NOT numeros::TEXT ~ '^[0-9]+$' THEN
        RAISE EXCEPTION 'El campo numeros debe contener solo numeros';
    END IF;
END;
$$;