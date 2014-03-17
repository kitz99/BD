--LABORATORUL 5

-- lab 4 - ex 8
SELECT e.employee_id, e.last_name
FROM employees e join job_history jh
     on(e.employee_id = jh.employee_id)
     join job_history jh2
     on (jh.department_id = jh2.department_id)
WHERE months_between(jh.start_date, jh2.start_date) > 2 AND jh.employee_id <> jh2.employee_id;

-- lab 4 - ex 9
select e.last_name, e.salary, job_title, city, c.country_name
from employees e join employees m
     on(e.manager_id = m.employee_id)
     join departments d on (e.DEPARTMENT_ID = d.department_id)
     join jobs j  on (e.job_id = j.job_id)
     join locations l on (d.location_id = l.location_id)
     join countries c on (l.country_id = c.country_id)
where e.LAST_NAME = 'King';


-- exemplul 4 - outer join
SELECT last_name, department_name, location_id
FROM employees e
LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT last_name, department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;


-- ex 10
select department_name, nvl(e.last_name, 'necunoscut') as "Manager"
from employees e right outer join departments d
     on (d.manager_id = e.employee_id);
----------SAU--------
select department_name, nvl(e.last_name, 'necunoscut')
from employees e, departments d
where d.manager_id = e.employee_id(+);

-- ex 11
select e.last_name, loc.CITY
from employees e, departments d, locations loc
where e.department_id = d.department_id(+) and 
      d.location_id = loc.location_id(+);
   
   
select e.last_name, loc.CITY
from employees e left join departments d on (e.DEPARTMENT_ID = d.DEPARTMENT_ID) 
      left join locations loc on (d.location_id = loc.location_id);
 
 
 -- ex 12
 select e.last_name, nvl(j2.job_title, j.job_title), nvl(j2.min_salary, j.min_salary)
 from employees e, job_history jh, jobs j, jobs j2 
 where e.employee_id = jh.employee_id(+) and
       e.job_id = j.job_id and
       jh.job_id = j2.job_id(+); 
       
       
---------------------- LABORATORUL 5 ----------------------
-----------------------------------------------------------


