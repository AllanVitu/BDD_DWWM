SELECT dname FROM dept NATURAL JOIN emp WHERE ename = 'ALLEN';
SELECT dname FROM dept INNER JOIN emp ON dept.DEPTNO = emp.DEPTNO WHERE ename = 'ALLEN';
SELECT dname, MAX(sal) FROM dept
NATURAL JOIN emp
GROUP BY dname ORDER BY max(sal) desc;


SELECT dname AS 'Service', job AS 'emploi', SUM(sal) + SUM(IFNULL(comm, 0)) AS 'Masse salariale', COUNT(empno) AS 'Nombre d\'employés', ROUND(AVG(sal), 2) AS 'Moyenne salaires' FROM dept
NATURAL JOIN emp
GROUP BY dname, job
HAVING COUNT(empno) >= 2; 


SELECT ename, dname, job, sal FROM emp, dept
WHERE dept.deptno = emp.deptno AND job = (SELECT job FROM emp WHERE ename = 'JONES') AND ename != 'JONES';


SELECT ename, sal, (SELECT ROUND(AVG(sal),2) FROM emp) AS 'Salaire Moyen' FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp);

DROP TABLE Projet;

CREATE TABLE projet
(num_proj SMALLINT(3) AUTO_INCREMENT PRIMARY KEY,
nom_proj VARCHAR(5) NOT NULL,
budget DECIMAL(15,2) NOT NULL);

ALTER TABLE projet AUTO_INCREMENT = 101;

INSERT INTO projet VALUES (num_proj, 'ALPHA', 96000),
(num_proj, 'BETA', 82000),
(num_proj, 'GAMMA', 15000);


ALTER TABLE emp ADD COLUMN num_proj SMALLINT(3) NOT NULL;

UPDATE emp SET num_proj = 101 WHERE deptno = 30 AND job = 'SALESMAN';
UPDATE emp SET num_proj = 102 WHERE (deptno = 30 AND job != 'SALESMAN') XOR deptno != 30;
ALTER TABLE emp ADD CONSTRAINT FK_projet FOREIGN KEY (num_proj) REFERENCES projet(num_proj);

UPDATE emp SET num_proj = 102 WHERE empno != ANY
(SELECT empno FROM emp WHERE deptno = 30 AND job = 'SALESMAN');

CREATE VIEW employe_proj AS SELECT emp.ename, emp.job, dept.dname, projet.nom_proj
FROM projet NATURAL  JOIN emp NATURAL JOIN dept;

SELECT * FROM employe_proj ORDER BY ename ASC;

SELECT * FROM employe_proj ORDER BY dname, nom_proj;

SELECT nom_proj, ename FROM employe_proj WHERE job= 'manager';

SET  lc_time_names='fr_FR';

SELECT ename, job, DATE_FORMAT(hiredate, '%a %d %b %Y' ) AS ' date d\'embauche' FROM emp WHERE deptno=20;

-- 
-- 
-- 
-- -- 2éme série
-- 
SELECT * FROM emp WHERE job LIKE 'manager' AND deptno IN (20,30);
-- 
SELECT* FROM emp WHERE job SOUNDS LIKE 'manajerrrrr' AND deptno IN (20,30);
-- 
SELECT* FROM emp where job <> 'manager' AND DATE_FORMAT (hiredate, '%y') = 81;  
-- 
SELECT* FROM emp WHERE  comm IS NOT NULL AND comm >0; 
-- 
SELECT ename, deptno, job, hiredate FROM emp ORDER BY deptno, job, hiredate DESC;
-- 
SELECT * FROM emp, dept WHERE emp.DEPTNO = dept.deptno AND dept.LOC sounds LIKE 'dallas';
-- 
SELECT empno, ename, job FROM emp WHERE empno NOT IN(SELECT DISTINCT mgr FROM emp WHERE mgr IS NOT NULL );
                            
SELECT ename, hiredate , (SELECT hiredate FROM emp WHERE ename='Blake') AS 'embauche blake'  FROM emp 	WHERE hiredate<(SELECT hiredate FROM emp WHERE ename='Blake');

SELECT * FROM emp WHERE hiredate= ( SELECT hiredate FROM emp WHERE ename='ford') AND ename <>'ford';

SELECT employe.ename AS 'Nom employe', employe.hiredate AS 'Date embauche employé', manager.ename AS 'Nom manager', manager.hiredate AS 'Date embauche manager'
FROM emp employe, emp manager
WHERE employe.hiredate < manager.hiredate AND employe.mgr = manager.empno;							      

SELECT empno, ename
FROM emp
WHERE ename != 'clark' AND mgr =								      
(SELECT mgr FROM emp WHERE ename = 'Clark');							      

SELECT * 
FROM emp
WHERE mgr =									      
(SELECT mgr FROM emp WHERE ename ='turner') 
AND job = 
(SELECT job FROM emp WHERE ename = 'turner')
AND ename != 'turner';								      
SELECT * FROM emp
WHERE (job, mgr) = (SELECT job, mgr FROM emp WHERE ename = 'Turner')
AND ename <> 'Turner';
SELECT ename FROM emp WHERE ename LIKE '%M%' AND ename LIKE '%A%';
SELECT ename FROM emp WHERE ename LIKE '%A%A%';
 
	
---	SELECT ename, hiredate FROM emp, dept WHERE hiredate IN (SELECT hiredate FROM emp, dept WHERE dept.deptno = emp.deptno AND
---	dname = 'sales') AND emp.deptno = dept.deptno AND dname = 'research';

--- SELECT ename, DAYNAME(hiredate) AS 'Jour de la semaine' FROM emp;

--- SELECT ename, SUBSTRING(DAYNAME(hiredate),1,3) AS 'Days of the week' FROM emp;

	SELECT ename, TIMESTAMPDIFF(MONTH, hiredate, NOW()) AS 'nombre de mois depuis embauche' FROM emp;

	SELECT * FROM emp WHERE hiredate <ALL(SELECT hiredate FROM emp WHERE deptno=10);	

	SELECT * FROM emp WHERE hiredate < (SELECT MIN(hiredate)   FROM emp WHERE deptno=10);	

	SELECT  job, AVG(sal) AS'salaire moyen le plus faible' FROM emp GROUP BY job HAVING AVG(sal)<= ALL  (SELECT AVG(sal) AS'salaire moyen' FROM emp GROUP BY job);
	SELECT job FROM emp WHERE AVG(sal) = (SELECT	LEAST((SELECT AVG(sal) FROM emp GROUP BY job))) GROUP BY job;

	SELECT deptno AS "Département", ROUND((COUNT(deptno)/(SELECT COUNT(empno) FROM emp)*100),2) AS "répartition" FROM  emp GROUP BY deptno;
