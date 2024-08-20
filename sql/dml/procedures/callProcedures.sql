-- PR1 creamos users
call PR1('1234567890123', 'Gerhard', 'Ardon', 'gerhardardon@gmail.com', '2002-02-24', 220, 'gbav556@');
call PR1('1234567890444', 'Eduardo', 'Cuevas', 'ecuevas@gmail.com', '2002-12-14', 225, 'ecuevas');
call PR1('1234567890555', 'Sebastian', 'Velasquez', 'sv@gmail.com', '2001-04-10', 210, 'sv');
call PR1('1234567890666', 'Juan', 'Perez', 'jp@gmail.com', '2001-06-20', 250, 'jp');

-- Camabiamos emailconf a FALSE
UPDATE Usuario SET emailconf = FALSE WHERE cui = '1234567890444';

-- PR5 creamos cursos
call PR5(775, 'Bases de Datos', 210);
call PR5(776, 'Sistemas Operativos', 220);
-- Err por codigo
call PR5('777e', 'Redes', 200);
-- Err por creditos
call PR5(777, 'Redes', '200e');
-- Err por nombre
call PR5(777, 'Redes1', 200);
call PR5(777, 'Redes', 200);

-- PR2 cambiamos roles
-- Err por emailconf 0 
call PR2('ecuevas@gmail.com', 777);
-- Err por email no existe
call PR2('fakeemail@gmail.com', 777);
call PR2('gerhardardon@gmail.com', 777);
call PR2('jp@gmail.com', 776);

-- PR3 asignamos estudiantes
-- Err creditos insuficientes 
call PR3('sv@gmail.com', 776);
call PR3('sv@gmail.com', 777);
call PR3('ecuevas@gmail.com', 777);

call PR3('ecuevas@gmail.com', 776);
call PR3('gerhardardon@gmail.com', 776);


