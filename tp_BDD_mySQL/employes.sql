CREATE DATABASE employes;

USE employes;

-- CREATION DES DONNEES ET DES TABLES


CREATE TABLE departement (

deptno TINYINT,
dname VARCHAR(50), 
loc VARCHAR(100),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

CREATE TABLE emp (
empno INT PRIMARY KEY  , 
ename VARCHAR(50) NOT NULL , 
job VARCHAR(100) NOT null,
mgr INT ,
hiredate DATE NOT NULL , 
sal INT NOT NULL ,
comm INT, 
deptno TINYINT NOT NULL
);

ALTER TABLE emp ADD CONSTRAINT fk_dept FOREIGN KEY (deptno) REFERENCES departement(deptno);

INSERT INTO departement (deptno, dname, loc) VALUES 
(10, "ACCOUNTING", "NEW YORK"),
(20, "RESEARCH", "DALLAS"),
(30, "SALES", "CHICAGO"),
(40, "OPETATIONS", "BOSTON");

TRUNCATE TABLE emp;

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES 
(7369, "SMITH", "CLERK", 7902, "1980-12-17", 800,NULL, 20),
(7499, "ALLEN", "SALESMAN", 7698, "1981-02-20", 1600, 300, 30),
(7521, "WARD", "SALESMAN", 7698, "1981-02-22", 1250, 500, 30),
(7566, "JONES", "MANAGER", 7839, "1981-04-02", 2975, NULL, 20),
(7654, "MARTIN", "SALESMAN", 7698, "1981-09-28", 1250, 1400, 30),
(7698, "BLAKE", "MANAGER", 7839,"1981-05-01", 2850, NULL,30),
(7782, "CLARK", "MANAGER", 7839, "1981-06-09", 2450, NULL, 10),
(7788, "SCOTT", "ANALYST", 7566, "1982-12-09", 3000,NULL , 20),
(7839, "KING", "PRESIDENT",NULL,"1981-11-17", 5000,NULL, 10),
(7844, "TURNER", "SALESMAN", 7698, "1981-09-08", 1500, 0, 30),
(7876, "ADAMS", "CLERK", 7788, "1983-01-12", 1100,NULL, 20),
(7900, "JAMES", "CLERK", 7698, "1981-12-03", 950,NULL, 30),
(7902, "FORD", "ANALYST", 7566, "1981-12-03", 3000,NULL, 20),
(7934, "MILLER", "CLERK", 7782, "1982-01-23", 1300,NULL, 10);


-- REQUETE LIER AU TABLE 


SELECT ename, job, sal FROM emp WHERE job LIKE 'manager' AND sal > 2800;

SELECT * FROM emp WHERE job LIKE 'manager' AND deptno <> 30; -- NE PAS METTRE D'ETOILE! SAUF EN EXERCICES !

SELECT ename, sal FROM emp WHERE sal BETWEEN 1200 AND 1400;

SELECT ename FROM emp WHERE deptno IN (10,30) ORDER BY ename ASC;  

SELECT  emp.ename, emp.sal, departement.dname FROM emp NATURAL JOIN departement WHERE deptno = 30 ORDER BY sal ASC;

SELECT ename, job, sal FROM emp ORDER BY job ASC, sal DESC;

SELECT DISTINCT job FROM emp;

SELECT departement.dname FROM emp INNER JOIN departement ON emp.deptno=departement.deptno WHERE emp.ename="Allen";--  Exemple de REQUETE pour Fusionner 2 TABLES !

SELECT departement.dname, emp.ename, emp.job, emp.sal FROM emp NATURAL JOIN departement ORDER BY departement.dname, emp.sal DESC;--  Autre maniere de syntaxe [ligne au dessus]
