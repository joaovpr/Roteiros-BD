--ROTEIRO 04 BANCO DE DADOS

-- JOAO VITOR PATRICIO ROMAO - 118211058




--Q1
SELECT * FROM department;

--Q2
SELECT * FROM dependent;

--Q3
SELECT * FROM dept_locations;

--Q4
SELECT * FROM employee;

--Q5
SELECT * FROM project;

--Q6
SELECT * FROM works_on;

--Q7
SELECT fname,lname FROM employee WHERE sex = 'M';

--Q8
SELECT fname FROM employee WHERE sex = 'M' AND superssn IS NULL;

--Q9
SELECT e.fname, s.fname FROM employee AS e, employee AS s WHERE e.superssn = s.ssn; 

--Q10
SELECT e.fname FROM employee AS e, employee AS s WHERE e.superssn = s.ssn AND s.fname = 'Franklin'; 

--Q11
SELECT d.dname, l.dlocation FROM department AS d, dept_locations AS l WHERE d.dnumber = l.dnumber; 

--Q12
SELECT d.dname FROM department AS d, dept_locations AS l WHERE d.dnumber = l.dnumber AND l.dlocation LIKE 'S%'; 

--Q13
SELECT e.fname, e.lname, d.dependent_name FROM employee AS e, dependent AS d WHERE e.superssn = d.essn; 

--Q14
SELECT fname||' '||minit||' '||lname FROM employee WHERE salary > 50000;

--Q15
SELECT p.pname, d.dname FROM project AS p, department AS d WHERE d.dnumber = p.dnum;

--Q16
SELECT p.pname, g.fname FROM project AS p, department AS d, employee As g WHERE d.mgrssn = g.ssn AND d.dnumber = p.dnum AND pnumber > 30;

--Q17
SELECT p.pname, f.fname FROM project AS P, works_on AS w,employee AS f WHERE w.essn = f.ssn AND p.pnumber = w.pno;

--Q18 
SELECT f.fname, d.dependent_name,  d.relationship FROM works_on AS w, employee AS f, dependent AS d  WHERE w.essn = f.ssn AND d.essn = f.ssn AND w.pno = 91;
