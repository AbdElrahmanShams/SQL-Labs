USE LAB5;

-- a stored function Count_Emp (Dnumber NUMBER) that returns the number of employees
-- working for the department Dnumber
DROP procedure IF EXISTS `Count_Emp`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Count_Emp`(IN Dnumber INT)
BEGIN

	SELECT count(DNO)
    FROM EMPLOYEE 
    WHERE DNO = Dnumber
    group by DNO;

END$$
DELIMITER ;


-- stored procedure that ensures that Year(DEPT.Founded) >=1960 for all departments; 
-- if a row violates this constraint then set its date to be ’01-JAN-1960’

DROP procedure IF EXISTS `Check_Founded`;

DELIMITER $$
USE `LAB5`$$
CREATE PROCEDURE `Check_Founded` ()
BEGIN

	UPDATE LAB5.DEPT 
	SET DEPT.FOUNDED = '1960-01-01' 
	WHERE datediff(FOUNDED, '1960-01-01') < 0;

END$$
DELIMITER ;



-- a trigger to ensure that no department has more than 8 employees
USE LAB5;
DROP TRIGGER NEW_EMP;
DELIMITER $$
CREATE TRIGGER NEW_EMP
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN

DECLARE CNT INT UNSIGNED;

SET CNT = (SELECT COUNT(DNO) 
			FROM EMPLOYEE
			WHERE DNO = NEW.DNO
            GROUP BY DNO);
            
IF CNT >= 8
THEN
	
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'THE DEPARTMENT CAN`T HAVE MORE THAN 8 EMPLOYEES';
    
END IF;
            

END$$
DELIMITER ;
-- on update cascade
DROP TRIGGER ON_UPDATE_CASCADE;
DELIMITER $$
CREATE TRIGGER ON_UPDATE_CASCADE 
AFTER UPDATE ON LAB5.DEPT 
FOR EACH ROW 
BEGIN 

	IF NEW.DNUMBER <> OLD.DNUMBER
    
THEN

	UPDATE EMPLOYEE SET DNO = NEW.DNUMBER WHERE EMPLOYEE.DNO = OLD.DNUMBER;

END IF;
END $$
DELIMITER ;


-- a trigger to ensure that whenever an employee is given a raise in salary, his department
-- manager's salary must be increased to be at least as much.
USE LAB5;
DROP TRIGGER SALARY_RAISE;
DELIMITER $$
CREATE TRIGGER SALARY_RAISE 
AFTER UPDATE ON EMPLOYEE 
FOR EACH ROW 
BEGIN 
DECLARE SAL INT UNSIGNED;
IF NEW.SALARY != OLD.SALARY THEN


SET SAL = (SELECT SALARY 
		FROM EMPLOYEE 
        WHERE SSN IN (SELECT MGR_SSN 
						FROM DEPT 
                        WHERE DNUMBER = NEW.DNO));

IF NEW.SALARY > SAL
THEN
	UPDATE EMPLOYEE 
    SET SALARY = NEW.SALARY 
    WHERE SSN IN (SELECT MGR_SSN 
					FROM DEPT 
					WHERE DNUMBER = NEW.DNO);

END IF;
END IF;	
END $$
DELIMITER ;


-- QUERIES

CALL `LAB5`.`Count_Emp`(123450);

-- CALL `LAB5`.`Check_Founded`();


UPDATE `LAB5`.`EMPLOYEE`
SET
`SALARY` = 15001
WHERE `SSN` = 246835;


