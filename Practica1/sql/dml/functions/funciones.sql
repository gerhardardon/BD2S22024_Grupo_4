
-- Func_course_usuario

CREATE OR REPLACE FUNCTION Func_course_usuarios(p_codeCourse INT) RETURNS TABLE (
    id_student INT,
    student_name VARCHAR(100)
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.id, CONCAT(p.fName, ' ', p.lName)::VARCHAR(100) AS student_name
    FROM Asignacion a
    JOIN Usuario u ON a.idStudent = u.id
    JOIN Persona p ON u.cui = p.cui
    WHERE a.codeCourse = p_codeCourse;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM Func_course_usuarios(101);

-- Func_tutor_course

CREATE OR REPLACE FUNCTION Func_tutor_course() RETURNS TABLE (
    course_code INT,
    course_name VARCHAR(50),
    tutor_id INT,
    tutor_name VARCHAR(100)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.code AS course_code,
        c.name AS course_name,
        u.id AS tutor_id,
        CONCAT(p.fName, ' ', p.lName)::VARCHAR(100) AS tutor_name
    FROM 
        Curso c
    JOIN 
        Usuario u ON c.idTutor = u.id
    JOIN 
        Persona p ON u.cui = p.cui
    JOIN 
        Rol r ON u.rol = r.id
    WHERE 
        r.rol = 'T';
END;
$$ LANGUAGE plpgsql;

SELECT * FROM Func_tutor_course();

-- Func_notification_usuario

CREATE OR REPLACE FUNCTION Func_notification_usuarios(p_user_id INT) 
RETURNS TABLE (
    user_id INT,
    msg VARCHAR(200)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        n.user_id,
        n.msg
    FROM 
        Notificacion n
    WHERE 
        n.user_id = p_user_id;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM Func_notification_usuarios(1);

-- Func_usuario

CREATE OR REPLACE FUNCTION Func_usuarios() 
RETURNS TABLE (
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(50),
    dateofbirth DATE,
    credits INT,
    rolename tipo_rol
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.fName AS firstname,
        p.lName AS lastname,
        p.email,
        p.birthdate AS dateofbirth,
        p.credits,
        r.rol AS rolename
    FROM 
        Persona p
    JOIN 
        Usuario u ON p.cui = u.cui
    JOIN 
        Rol r ON u.rol = r.id;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM Func_usuarios();

-- Funcion historial

CREATE OR REPLACE FUNCTION Func_logger() RETURNS TABLE (
    Fecha DATE,
    Descripcion VARCHAR(700),
    accion VARCHAR(50)
) AS $$
BEGIN
    RETURN QUERY 
    SELECT h.Fecha::DATE, h.Descripcion, h.accion 
    FROM Historial h;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM Func_logger();
