-- Active: 1759912603258@@127.0.0.1@3306@mysql
DROP DATABASE IF EXISTS BHANU_AND_RECREATION;
CREATE DATABASE BHANU_AND_RECREATION;
USE BHANU_AND_RECREATION;

CREATE TABLE EMP(EMP_ID INT NOT NULL,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(50),
AGE INT,
GENDER VARCHAR(10),
BIRTH_DATE DATE,
PRIMARY KEY(EMP_ID));
CREATE TABLE EMP_SAL(EMP_ID INT NOT NULL,
FIRST_NAME VARCHAR(50)NOT NULL,
LAST_NAME VARCHAR(50)NOT NULL,
OCCUPATION VARCHAR(50),
SALARY INT,
DEPT_ID INT);
INSERT INTO EMP(EMP_ID,FIRST_NAME,LAST_NAME,AGE,GENDER,BIRTH_DATE)VALUES
(1,'LESLIE','KNOPE',44,'FEMALE','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');

INSERT INTO EMP_SAL (EMP_ID,FIRST_NAME,LAST_NAME,OCCUPATION,SALARY,DEPT_ID)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);
CREATE TABLE EMP_DEP (
DEP_ID INT NOT NULL AUTO_INCREMENT,
 DEP_NAME varchar(50) NOT NULL,
  PRIMARY KEY (DEP_ID)
);

INSERT INTO EMP_DEP (DEP_NAME)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');



select *
from emp;

select *
from emp_sal;

select *
from emp_dep;


-- INNER JOINS:  
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.AGE,d.DEP_NAME
FROM EMP e
INNER JOIN EMP_SAL s ON e.EMP_ID = s.EMP_ID
INNER JOIN EMP_DEP d ON s.DEPT_ID = d.DEP_ID
ORDER BY e.EMP_ID;


-- LEFT JOIN:
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, IFNULL(d.DEP_NAME, 'No Department') AS DEP_NAME
FROM EMP e
LEFT JOIN EMP_SAL s ON e.EMP_ID = s.EMP_ID
LEFT JOIN EMP_DEP d ON s.DEPT_ID = d.DEP_ID
ORDER BY e.EMP_ID;


-- RIGHT JOIN:
SELECT IFNULL(e.EMP_ID, 0) AS EMP_ID, IFNULL(e.FIRST_NAME, 'No Employee') AS FIRST_NAME,
       IFNULL(e.LAST_NAME, '') AS LAST_NAME,d.DEP_ID, d.DEP_NAME
FROM EMP_DEP d
RIGHT JOIN EMP_SAL s ON d.DEP_ID = s.DEPT_ID
RIGHT JOIN EMP e ON s.EMP_ID = e.EMP_ID
ORDER BY d.DEP_ID;


-- FULL JOINS:
-- LEFT side: all employees
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME,e.AGE,e.GENDER,e.BIRTH_DATE,d.DEP_ID,IFNULL(d.DEP_NAME, 'No Department') AS DEP_NAME
FROM EMP e
LEFT JOIN EMP_SAL s ON e.EMP_ID = s.EMP_ID
LEFT JOIN EMP_DEP d ON s.DEPT_ID = d.DEP_ID

UNION

-- RIGHT side: all departments
SELECT IFNULL(e.EMP_ID, 0) AS EMP_ID, IFNULL(e.FIRST_NAME, 'No Employee') AS FIRST_NAME,
       IFNULL(e.LAST_NAME, '') AS LAST_NAME,e.AGE,e.GENDER,e.BIRTH_DATE,d.DEP_ID,d.DEP_NAME
FROM EMP_DEP d
LEFT JOIN EMP_SAL s ON d.DEP_ID = s.DEPT_ID
LEFT JOIN EMP e ON s.EMP_ID = e.EMP_ID
WHERE s.EMP_ID IS NULL;