INSERT INTO Rol (rol) VALUES ('T');
INSERT INTO Rol (rol) VALUES ('S');

INSERT INTO Persona (cui, fName, lName, email, birthdate, credits) VALUES ('1234567890123', 'Juan', 'Pérez', 'juan.perez@example.com', '1990-01-01', 30);
INSERT INTO Persona (cui, fName, lName, email, birthdate, credits) VALUES ('2345678901234', 'María', 'Gómez', 'maria.gomez@example.com', '1992-02-02', 40);
INSERT INTO Persona (cui, fName, lName, email, birthdate, credits) VALUES ('3456789012345', 'Carlos', 'López', 'carlos.lopez@example.com', '1994-03-03', 50);
INSERT INTO Persona (cui, fName, lName, email, birthdate, credits) VALUES ('4567890123456', 'Ana', 'Martínez', 'ana.martinez@example.com', '1996-04-04', 60);
INSERT INTO Persona (cui, fName, lName, email, birthdate, credits) VALUES ('5678901234567', 'Luis', 'Ramírez', 'luis.ramirez@example.com', '1998-05-05', 70);
INSERT INTO Persona (cui, fName, lName, email, birthdate, credits) VALUES ('6789012345678', 'Laura', 'Fernández', 'laura.fernandez@example.com', '2000-06-06', 80);

INSERT INTO Usuario (cui, rol, passw, emailconf) VALUES ('1234567890123', 1, 'password123', TRUE);
INSERT INTO Usuario (cui, rol, passw, emailconf) VALUES ('2345678901234', 2, 'password234', FALSE);
INSERT INTO Usuario (cui, rol, passw, emailconf) VALUES ('3456789012345', 2, 'password345', TRUE);
INSERT INTO Usuario (cui, rol, passw, emailconf) VALUES ('4567890123456', 1, 'password456', FALSE);
INSERT INTO Usuario (cui, rol, passw, emailconf) VALUES ('5678901234567', 1, 'password567', TRUE);
INSERT INTO Usuario (cui, rol, passw, emailconf) VALUES ('6789012345678', 2, 'password678', FALSE);

INSERT INTO Notificacion (user_id, msg) VALUES (1, 'Bienvenido a la plataforma, Juan.');
INSERT INTO Notificacion (user_id, msg) VALUES (2, 'María, tienes una nueva tarea.');
INSERT INTO Notificacion (user_id, msg) VALUES (3, 'Carlos, tu curso ha sido actualizado.');
INSERT INTO Notificacion (user_id, msg) VALUES (4, 'Ana, tu contraseña ha sido cambiada.');
INSERT INTO Notificacion (user_id, msg) VALUES (5, 'Luis, tu perfil ha sido verificado.');
INSERT INTO Notificacion (user_id, msg) VALUES (6, 'Laura, tienes un nuevo mensaje.');

INSERT INTO Curso (code, idTutor, name, maxStudents, credits) VALUES (101, 1, 'Matemáticas', 30, 5);
INSERT INTO Curso (code, idTutor, name, maxStudents, credits) VALUES (102, 1, 'Física', 25, 4);
INSERT INTO Curso (code, idTutor, name, maxStudents, credits) VALUES (103, 2, 'Química', 20, 3);
INSERT INTO Curso (code, idTutor, name, maxStudents, credits) VALUES (104, 2, 'Biología', 15, 2);
INSERT INTO Curso (code, idTutor, name, maxStudents, credits) VALUES (105, 1, 'Historia', 35, 4);
INSERT INTO Curso (code, idTutor, name, maxStudents, credits) VALUES (106, 2, 'Geografía', 20, 3);

INSERT INTO Asignacion (codeCourse, idStudent) VALUES (101, 2);
INSERT INTO Asignacion (codeCourse, idStudent) VALUES (102, 3);
INSERT INTO Asignacion (codeCourse, idStudent) VALUES (103, 4);
INSERT INTO Asignacion (codeCourse, idStudent) VALUES (104, 2);
INSERT INTO Asignacion (codeCourse, idStudent) VALUES (105, 5);
INSERT INTO Asignacion (codeCourse, idStudent) VALUES (106, 6);