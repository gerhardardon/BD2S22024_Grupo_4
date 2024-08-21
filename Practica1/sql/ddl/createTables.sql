-- Tabla Rol
-- Se crea tipo_rol T = tutor, S = student
CREATE TYPE tipo_rol AS ENUM ('T', 'S'); 

CREATE TABLE Rol(
    id SERIAL PRIMARY KEY,
    rol tipo_rol NOT NULL UNIQUE
);

-- Tabla Persona
CREATE TABLE Persona(
    cui VARCHAR(13) PRIMARY KEY,
    fName VARCHAR(50) NOT NULL,
    lName VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    credits INT NOT NULL
);

-- Tabla Usuario
CREATE TABLE Usuario(
    id SERIAL PRIMARY KEY,
    cui VARCHAR(13) REFERENCES Persona(cui),
    rol INT REFERENCES Rol(id),
    passw VARCHAR(50) NOT NULL,
    emailconf BOOLEAN NOT NULL
);

-- Tabla Notificacion
CREATE TABLE Notificacion(
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Usuario(id),
    msg VARCHAR(200) NOT NULL
);

-- Tabla Curso
CREATE TABLE Curso(
    code INT PRIMARY KEY,
    idTutor INT REFERENCES Usuario(id),
    name VARCHAR(50) NOT NULL,
    maxStudents INT NOT NULL,
    credits INT NOT NULL
);

-- Tabla Asignacion
CREATE TABLE Asignacion(
    id SERIAL PRIMARY KEY,
    codeCourse INT REFERENCES Curso(code),
    idStudent INT REFERENCES Usuario(id)
);

