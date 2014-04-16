/*clauza with*/

WITH dept_costuri AS (
    SELECT department_name, SUM(salary) dept_cost
    FROM employees e, departments d
    WHERE e.department_id= d.department_id
    GROUP BY department_name)
SELECT * FROM
dept_costuri
WHERE dept_cost > (select avg(dept_cost) from dept_costuri)
ORDER BY department_name;

/*Afişaţi ierarhia şef-subaltern: codul, prenumele şi numele 
(pe aceeaşi coloană), codul job-ului şi data angajării, pornind 
de la subordonaţii direcţi ai lui Steven King care au cea mai mare vechime.
Rezultatul nu va conţine angajaţii în anul 1970. */

WITH emp_sk AS
  (SELECT employee_id, hire_date FROM employees
  WHERE manager_id = (SELECT employee_id
                      FROM employees
                      WHERE INITCAP(last_name) = 'King'
                      AND INITCAP(first_name) = 'Steven')
                      )
SELECT employee_id, INITCAP(first_name) ||’ ‘||UPPER(last_name), job_id, hire_date,manager_id
FROM employees
WHERE TO_CHAR(hire_date, 'yyyy') != 1970
START WITH employee_id IN (SELECT employee_id
                          FROM emp_sk
                          WHERE hire_date = (SELECT MIN(hire_date) FROM emp_sk))
CONNECT BY PRIOR employee_id = manager_id;



/*
Să se afişeze:
- suma salariilor, pentru job-urile care incep cu litera S;
- media generala a salariilor, pentru job-ul avand salariul maxim;
- salariul minim, pentru fiecare din celelalte job-uri.
*/

select  job_id, 
    case when job_id like 'S%' then sum(salary)
         when max(salary) =(select  max(salary) from employees)   then avg(salary)  
    else min(salary)
    end
from employees
group by job_id;


/*top cu exists*/

SELECT last_name, job_id, salary
FROM employees e
WHERE 5>(SELECT COUNT(*)
          FROM
          employees
          WHERE salary > e.salary)
ORDER BY salary DESC;



/*Afişaţi codul şi numele proiectelor 
la care au lucrat toţi angajaţii din departamentul 20 
tabele  projects p,  work w*/

select * from projects;
select * from work;


select p.project_id, p.project_name
from projects p, work w, employees e
where P.PROJECT_ID = W.PROJECT_ID 
and W.EMPLOYEE_ID = E.EMPLOYEE_ID
and e.department_id = 20
group by p.project_id, p.project_name
having count(distinct e.employee_id) = (select count(*)
                                        from employees
                                        where department_id = 20
                                        );

SELECT DISTINCT p.project_id, project_name
FROM projects p, work w
WHERE p.project_id=w.project_id
AND NOT EXISTS (SELECT 'X' FROM employees e WHERE department_id=20
                          AND NOT EXISTS (SELECT 'X'
                                          FROM work w1
                                          WHERE e.employee_id=w1.employee_id
                                          AND w.project_id=w1.project_id));
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
 