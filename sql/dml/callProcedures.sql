call PR1('1234567890123', 'Gerhard', 'Ardon', 'gerhardardon@gmail.com', '2002-02-24', 220, 'gbav556@');
call PR1('1234567890444', 'Eduardo', 'Cuevas', 'ecuevas@gmail.com', '2002-12-14', 225, 'ecuevas');
call PR1('1234567890555', 'Sebastian', 'Velasquez', 'sv@gmail.com', '2001-04-10', 210, 'sv');

UPDATE Usuario SET emailconf = FALSE WHERE cui = '1234567890444';
INSERT INTO Curso (code, idTutor, name, maxStudents, credits) VALUES (101, NULL, 'BASES 2', 30, 5);

call PR2('ecuevas@gmail.com', 101);
call PR2('gerhardardon@gmail.com', 101);

INSERT INTO Curso (code, idTutor, name, maxStudents, credits) VALUES (102, NULL, 'Software Avanzado', 30, 215);
UPDATE Usuario SET emailconf = TRUE WHERE cui = '1234567890444';
call PR2('ecuevas@gmail.com', 102);
call PR3('sv@gmail.com', 102);
call PR3('gerhardardon@gmail.com', 102);

