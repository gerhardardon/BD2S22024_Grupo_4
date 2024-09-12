CREATE TABLE paciente(
    id SERIAL PRIMARY KEY,
    edad INT NOT NULL,
    genero VARCHAR(50) NOT NULL
);

CREATE TABLE habitacion(
    id SERIAL PRIMARY KEY,
    habitacion VARCHAR(50) NOT NULL
);

CREATE TABLE logActividad(
    id SERIAL PRIMARY KEY,
    timestamp VARCHAR(50) NOT NULL,
    actividad VARCHAR(50) NOT NULL,
    idPaciente INT REFERENCES paciente(id),
    idHabitacion INT REFERENCES habitacion(id)
);

CREATE TABLE logHabitacion(
    id SERIAL PRIMARY KEY,
    timestamp VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    idHabitacion INT REFERENCES habitacion(id)
);