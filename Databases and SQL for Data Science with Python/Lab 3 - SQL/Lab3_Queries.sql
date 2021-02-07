-- Query 1------
;
select F_NAME , L_NAME
from EMPLOYEES
where ADDRESS LIKE '%Elgin,IL%' ;

--Query 2--
;
select F_NAME , L_NAME
from EMPLOYEES
where B_DATE LIKE '197%' ;

---Query3--
;
select *
from EMPLOYEES
where (SALARY BETWEEN 60000 and 70000)  and DEP_ID = 5 ;

--Query4A--
;
select F_NAME, L_NAME, DEP_ID 
from EMPLOYEES
order by DEP_ID;

--Query4B--
;
select F_NAME, L_NAME, DEP_ID 
from EMPLOYEES
order by DEP_ID desc, L_NAME desc;

--Query5A--
;
select DEP_ID, COUNT(*)
from EMPLOYEES
group by DEP_ID;

  -- chris_1 - for deps not having any employee
  select dep_name, dept_id_dep, count(emp_id) as counts
  from departments
  left outer join employees em on  dept_id_dep = em.dep_id
  group by(dept_id_dep, dep_name)
  order by counts;

  -- chris_2
  select dep_name,
    (select count(*)
    from   employees
    where  dep_id = dep.dept_id_dep) as cnt
  from   departments dep;

--Query5B--
;
select DEP_ID, COUNT(*), AVG(SALARY)
from EMPLOYEES
group by DEP_ID;

  -- chris_1
  select dep_name, dept_id_dep, count(emp_id) as counts, avg(salary)
  from departments
  left outer join employees em on  dept_id_dep = em.dep_id
  group by(dept_id_dep, dep_name)
  order by counts;

  -- chris_2
  select dep_name,
  (select count(*)
  from   employees
  where  dep_id = dep.dept_id_dep) as cnt,
  (select avg(salary)
  from   employees
  where  dep_id = dep.dept_id_dep) as salary
  from   departments dep;

--Query5C--
;
select DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
from EMPLOYEES
group by DEP_ID;

--Query5D--
;
select DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
from EMPLOYEES
group by DEP_ID
order by AVG_SALARY;

--Query5E--
;
select DEP_ID, COUNT(*) AS "NUM_EMPLOYEES", AVG(SALARY) AS "AVG_SALARY"
from EMPLOYEES
group by DEP_ID
having count(*) < 4
order by AVG_SALARY;
--5E alternative: if you want to use the label
select DEP_ID, NUM_EMPLOYEES, AVG_SALARY from
  ( select DEP_ID, COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY from EMPLOYEES group by DEP_ID)
  where NUM_EMPLOYEES < 4
order by AVG_SALARY;

--BONUS Query6--
;
select D.DEP_NAME , E.F_NAME, E.L_NAME
from EMPLOYEES as E, DEPARTMENTS as D
where E.DEP_ID = D.DEPT_ID_DEP
order by D.DEP_NAME, E.L_NAME desc ;