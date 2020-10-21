--Q1
SELECT COUNT(sex) FROM employee WHERE sex = 'F';

--Q2
SELECT AVG(salary) FROM employee WHERE sex = 'M' AND address LIKE '%, TX';

--Q3
SELECT s.superssn AS super, COUNT(s.ssn) AS qtd FROM employee AS s GROUP BY s.superssn ORDER BY COUNT(*) ASC;

--Q4
SELECT n.fname AS super, COUNT(*) AS qtd FROM (employee AS n JOIN employee AS e ON n.ssn = e.superssn) GROUP BY n.ssn ORDER BY COUNT(*) ASC;

--Q5
SELECT n.fname AS super, COUNT(*) AS qtd FROM (employee AS n RIGHT OUTER JOIN employee AS e ON n.ssn = e.superssn) GROUP BY n.ssn ORDER BY COUNT(*) ASC;

--Q6
SELECT MIN(COUNT) AS qtd FROM(SELECT COUNT(*) FROM works_on GROUP BY pno) AS q;

--Q7
SELECT pno AS projpno, qtd AS qtd FROM (SELECT pno, COUNT(*) FROM works_on GROUP BY pno) AS pnc JOIN (SELECT MIN(COUNT(*))AS qtd FROM(SELECT COUNT(*) FROM works_on GROUP BY pno)t)AS mini ON pnc.COUNT = mini.qtd;

--Q8
SELECT p.pno AS num, AVG(s.salary) As salario FROM works_on AS p JOIN employee AS s ON (p.essn = s.ssn) GROUP BY p.pno;

--Q9
SELECT p.pno AS num, n.pname AS nome, AVG(s.salary) As salario FROM project AS n JOIN works_on AS p JOIN employee AS s ON (p.essn = s.ssn) ON (n.pnumber = p.pno) GROUP BY p.pno, n.pname ORDER BY AVG(s.salary) ASC;

--Q10
SELECT f.fname, f.salary FROM employee AS f WHERE f.salary > ALL(SELECT salary FROM works_on AS p JOIN employee AS f ON (p.essn = f.ssn AND p.pno = 92));

--Q11
SELECT f.ssn, COUNT(p.pno) FROM employee AS f LEFT OUTER JOIN works_on AS p ON (f.ssn = p.essn) GROUP BY f.ssn ORDER BY COUNT(p.pno) ASC;

--Q12
SELECT pno AS p, COUNT AS f FROM (SELECT pno, COUNT(*) FROM employee AS f LEFT OUTER JOIN works_on AS p ON (f.ssn = p.essn) GROUP BY pno) AS qtd WHERE qtd.count < 5;        

--Q13
SELECT fname FROM 
    (SELECT x.ssn FROM(
        SELECT f.ssn FROM(
            SELECT w.essn FROM (SELECT pnumber FROM project WHERE plocation = 'Sugarland') AS projeto,works_on AS w WHERE w.pno = projeto.pnumber
                ) AS s, employee AS f WHERE s.essn = f.ssn) AS x, dependent AS d WHERE x.ssn = d.essn GROUP BY x.ssn
) AS sn, employee AS f WHERE sn.ssn = f.ssn;       

--Q14
SELECT dept.dname FROM department AS dept WHERE NOT EXISTS(SELECT * FROM project AS proj WHERE proj.dnum = dept.dnumber);

--Q15



