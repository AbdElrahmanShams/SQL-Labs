CREATE SCHEMA LAB5;
USE LAB5;

CREATE TABLE DEPT (
  DNUMBER	INT NOT NULL,
  DNAME	 	VARCHAR(45) NOT NULL,
  FOUNDED 	DATE NOT NULL,
  MGR_SSN	INT NOT NULL,
  BUDGET	INT UNSIGNED NOT NULL,
  PRIMARY KEY (DNUMBER));
  
  CREATE TABLE EMPLOYEE (
  SSN	 	INT NOT NULL,
  ENAME	 	VARCHAR(45) NOT NULL,
  BDATE 	DATE NOT NULL,
  DNO		INT NOT NULL,
  SALARY	INT UNSIGNED NOT NULL,
  PRIMARY KEY (SSN));
  
  
ALTER TABLE DEPT ADD CONSTRAINT `DEPT-EMP-fk`
    FOREIGN KEY (MGR_SSN)
    REFERENCES EMPLOYEE (SSN)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;
    
    
ALTER TABLE EMPLOYEE ADD CONSTRAINT `EMP-DEPT-fk`
    FOREIGN KEY (DNO)
    REFERENCES DEPT (DNUMBER)
    ON UPDATE NO ACTION
    ON DELETE RESTRICT;