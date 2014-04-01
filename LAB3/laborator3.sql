--Laboratorul 3 - Join de tabele
SELECT e.employee_id, e.last_name, d.department_name
FROM EMPLOYEES e, departments d
WHERE e.department_id = d.department_id;

SELECT last_name, department_name, city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id and e.COMMISSION_PCT is not null;

SELECT last_name, j.job_title as "job_actual"
FROM employees e, jobs j, job_history jh, jobs j2
WHERE e.job_id = j.job_id and e.employee_id = jh.employee_id and jh.job_id = j2.job_id and j2.job_title = 'Stock Clerk';

-- nvl(arg1, arg2) = arg1 daca arg1 is not null, arg2 altfel
SELECT e1.LAST_NAME as "Nume", (e2.salary + nvl(e2.commission_pct, 0)*e2.salary) - (e1.salary + nvl(e1.commission_pct, 0)*e1.salary) as "dif"
FROM employees e1, employees e2
WHERE e1.manager_id = e2.employee_id;

--sa se afiseze numele departamentelor in care 
--salariati angajati naintea sefului departamentului

SELECT DISTINCT d.department_name 
FROM departments d, EMPLOYEES e, EMPLOYEES m
WHERE d.MANAGER_ID = m.EMPLOYEE_ID AND d.DEPARTMENT_ID = e.DEPARTMENT_ID and e.hire_date < m.HIRE_DATE;


-- ex9 - lab2
SELECT last_name, department_name, city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id and e.hire_date >= to_date('03-Jan-1990', 'dd-mon-yyyy');

SELECT to_char(sysdate, 'dd-mm-yy hh:mm') FROM dual;

---LAB 3
--Ex1
SELECT TO_NUMBER('100.00', '9G999D99') from dual;
SELECT TO_NUMBER('1,300.23', '9G999D999' ) FROM DUAL;

SELECT TO_CHAR (13598.98, '099G999D999' ) FROM DUAL;

SELECT TO_CHAR (13598.98, '099G999D999' , ' NLS_NUMERIC_CHARACTERS = '',.'' ' )
FROM DUAL;

--DATE, TIMESTAMP, Interval

SELECT SYSTIMESTAMP FROM dual; --TIMESTAMP
SELECT CAST (SYSDATE AS TIMESTAMP) FROM dual;

SELECT CURRENT_TIMESTAMP FROM dual; --TIMESTAMP WITH TIME ZONE 

SELECT CAST (SYSDATE AS TIMESTAMP WITH TIME ZONE) FROM dual;

SELECT CAST (SYSDATE AS TIMESTAMP WITH LOCAL TIME ZONE) FROM dual;

SELECT TO_TIMESTAMP('03-02-2014 10:30:50.45', 'dd-mm-yyyy hh24:mi:ss.ff') from dual;

SELECT TO_TIMESTAMP_TZ('03-02-2014 10:30:50.45 03:30', 'dd-mm-yyyy hh24:mi:ss.ff
TZH:TZM') from dual;

SELECT 'X'
FROM DUAL
WHERE FROM_TZ(TO_TIMESTAMP('03-02-2014 10:30:50.45', 'dd-mm-yyyy
hh24:mi:ss.ff'),'2:00') =
TO_TIMESTAMP_TZ('03-02-2014 09:30:50.45 01:00', 'dd-mm-yyyy hh24:mi:ss.ff TZH:TZM');

SELECT sysdate + INTERVAL '3-2' YEAR TO MONTH from dual;


SELECT TO_CHAR(sysdate + INTERVAL '1' YEAR - INTERVAL '1 1:05' DAY TO MINUTE,
'dd/mm/yyyy hh24:mi') 
FROM DUAL;

SELECT systimestamp + INTERVAL '1 1:05:30.40' DAY TO SECOND FROM DUAL;

--functii pentru prelucrarea caracterelor
/*Ex 2: S? se afi?eze pentru angaja?ii cu prenumele Steven, codul, numele ?i denumirea
departamentului în care lucreaz?. C?utarea trebuie s? nu fie case-sensitive, iar eventualele blank-uri
care preced sau urmeaz? numelui trebuie ignorate.
*/

SELECT e.first_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE trim(both ' ' from upper(first_name)) = upper('Steven') AND e.department_id = d.department_id;

/*Ex 3 - Scrie?i o cerere care are urm?torul rezultat pentru fiecare angajat: <titlu job>
<prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3 ori mai mare>.
Eticheta?i coloana 'Salariu ideal'. Pentru concatenare, utiliza?i atât func?ia CONCAT cât ?i
operatorul || */

SELECT concat(j.job_title, concat(' ' || first_name, ' ' || last_name)) || concat(' doreste sa castige ', salary * 3) as "Salariu Ideal"
FROM employees e, jobs j
where e.job_id = j.job_id;


/*Ex 4 -  Scrie?i o cerere prin care s? se afi?eze prenumele salariatului cu prima litera majuscul?
?i toate celelalte litere minuscule, numele acestuia cu majuscule ?i lungimea numelui, pentru
angaja?ii al c?ror nume începe cu J sau M sau care au a treia liter? din nume A. Rezultatul va fi
ordonat descresc?tor dup? lungimea numelui. Se vor eticheta coloanele corespunz?tor. Se cer 2
solu?ii (cu operatorul LIKE ?i func?ia SUBSTR).
*/

SELECT initcap(first_name), upper(last_name), length(last_name)
FROM EMPLOYEES
WHERE upper(last_name) like 'J%' or upper(last_name) like 'M%'
or upper(last_name) like '__A%'
order by 3 desc;

/*EX 5 - : S? se afi?eze pentru to?i angaja?ii al c?ror nume se termin? cu litera 'e', codul, numele,
lungimea numelui ?i pozi?ia din nume în care apare prima dat? litera 'a'. Utiliza?i alias-uri
corespunz?toare pentru coloane. 
*/
SELECT employee_id "cod angajat", last_name "Nume", length(last_name) "lg Nume", instr(last_name, 'a')
FROM employees
WHERE LOWER(SUBSTR(last_name, -1)) ='e';

/*Exerci?iul 6: S? se afi?eze numele ?i data angaj?rii salaria?ilor precum ?i o coloan? care va con?ine
c?te un caracter '*' pentru fiecare 1000 zile lucrate.*/

SELECT last_name, hire_date, lpad(' ' , ((sysdate-hire_date) / 1000), '*') 
FROM EMPLOYEES;

/*
Exerci?iul 20: S? se afi?eze numele angaja?ilor ?i coloana id are se con?in? codul angajatului
concatenat cu codul departamentului dac? este cunoscut codul departamentului, sau codul
angajatului daca nu este ?tiut departamentul.
*/
SELECT last_name as "NUME", nvl2(department_id, employee_id || ' ' || department_id, employee_id)
FROM employees;

--Ex 16
SELECT last_name, nvl(TO_CHAR(commission_pct), 'Fara comision ') "Comision"
from EMPLOYEES;


--DECODE
--Ex 18
SELECT d.department_id, d.department_name, l.city
FROM departments d, locations l
WHERE d.location_id = l.location_id ORDER BY decode(l.city, 'Seatle', 1, 2) desc, l.city, d.department_name;

-- ex 9
SELECT concat(last_name, ' ' || first_name) "nume prenume",
       hire_date, next_day( add_months(hire_date, 6), 'Monday') "negociere"
from employees;

--ex 10
select last_name,
       round(months_between(sysdate, hire_date)) "luni lucrate"
from employees;

--ex 13
select to_date('31-12-2014', 'dd-mm-yyyy') - sysdate "day"
from dual;

--ex14 
select to_char(sysdate + 5/(60*24), 'hh24:mi') from dual;

-- ex 19
select last_name, first_name, 
case when 
     round(months_between(to_date('01-01-2000','dd-mm-yyyy'), hire_date))<100
     and round(months_between(to_date('01-01-2000','dd-mm-yyyy'), hire_date))>0
        then round(months_between(to_date('01-01-2000','dd-mm-yyyy'), hire_date))*10
     when 
        round(months_between(to_date('01-01-2000','dd-mm-yyyy'), hire_date))>100
        and round(months_between(to_date('01-01-2000','dd-mm-yyyy'), hire_date))>0
     then round(months_between(to_date('01-01-2000','dd-mm-yyyy'), hire_date))*5
else 0
end "spor"
from employees;
