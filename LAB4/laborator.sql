--**********************LABORATORUL 4**********************--
-- ex 5

select e.last_name, j.job_title
from employees e
     join jobs j on (e.job_id = j.job_id)
     join DEPARTMENTS d on (e.department_id = d.department_id)
where upper(department_name) = 'SALES';

--Ex 6

SELECT d.department_name, j.job_title, e.last_name
from employees e
  join departments d on (e.department_id = d.department_id)
  join jobs j on (e.job_id = j.job_id)
  join locations l on (d.location_id = l.location_id)
where l.city = 'Seattle';

--ex 7
SELECT e.last_name, to_char(e.hire_date, 'month yyyy')
from employees e, employees g
where g.last_name = 'Gates'
and e.department_id = g.department_id
and e.employee_id <> g.employee_id
and instr(e.last_name, 'a') > 0;

--ex8
SELECT distinct jh.employee_id, e.last_name, d.department_name
from job_history jh, job_history jh2, departments d, employees e
where months_between(jh.start_date, jh2.start_date) > 2
      and jh.department_id = jh2.department_id
      and jh.employee_id <> jh2.employee_id
      and (jh.department_id = d.department_id)
      and (e.employee_id = jh.employee_id);
      
-- ex 9
select e.last_name, e.salary, j.job_title, l.city, c.country_name
from employees e, employees m, jobs j, locations l, departments d, countries c
where m.last_name = 'King' and e.manager_id = m.employee_id and j.job_id = e.job_id and m.department_id = d.department_id and d.location_id = l.location_id and c.country_id = l.country_id;





--ex 10 - outer JOIN
select department_name, nvl(e.last_name, 'necunoscut')
from employees e right outer join departments d
     on (d.manager_id = e.employee_id);

select department_name, nvl(e.last_name, 'necunoscut')
from employees e, departments d
where d.manager_id = e.employee_id(+);