--basic --
select * from employee

select name,salary
from employee;

select name
from employee
where age>30;

select name
from department;

select e.name
from employee e join department d on e.department_id=d.department_id
where d.name='IT';

--string Matching--

select name
from employee
where name like 'J%';

select name
from employee
where name like '%e';

select name
from employee
where name like '%a%';

select name
from employee
where length(name)=9;

select name
from employee
where name like '_o%';

--Data Queries--

select *
from employee
where year(hire_date)=2020;

select *
from employee
where month(hire_date)=01;

select *
from employee
where year(hire_date)<2019;

select *
from employee
where hire_date>='2021-03-01';

select *
from employee
where hire_date>=DATEADD(year,-5,CURRENT_DATE);
--look after--
select *
from employee
where hire_date>=DATE_SUB(currdate,interval 2 YEAR);

--Aggregate Queries--


select name,sum(salary)
from employee
group by name;

select name,avg(salary)
from employee
group by name;

select min(salary)
from employee;

select department_id,count(emp_id)
from employee
group by department_id;


select department_id,avg(salary)
from employee
group by department_id;

--groupby--

select department_id,sum(salary)
from employee
group by department_id;

select department_id,avg(age)
from employee
group by department_id;

select year(hire_date),count(*)
from employee
group by year(hire_date);

select department_id,max(salary)
from employee
group by department_id;

select department_id,avg(salary)
from employee
group by department_id
order by avg(salary) DESC
limit 1;

--having Queries--

select department_id
from employee
group by department_id
having count(*)>2;

select department_id,avg(salary)
from employee
group by department_id
having avg(salary)>55000;

select year(hire_date),count(*)
from employee
group by year(hire_date)
having count(*)>1;

select department_id,sum(salary)
from employee
group by department_id
having sum(salary)<100000;

select department_id ,min(salary)
from employee
group by department_id
having min(salary)>5000;

--order by--

select *
from employee
order by salary;

select *
from employee
order by age DESC;

select *
from employee
order by hire_date;

select *
from employee
order by department_id,salary;

select department_id,SUM(salary)
from employee
group by department_id
order by sum(salary);

--joins--
select e.name as employeename ,d.name as departname
from employee e join department d on e.department_id=d.department_id;

select p.name as Projectname ,d.name as departname
from project p join department d on p.department_id=d.department_id;

select e.name as employeename ,p.name as Projectname
from employee e join project p on e.department_id=p.department_id;

select e.name as employeename ,d.name as departname
from employee e left join department d on e.department_id=d.department_id;

select e.name as employeename ,d.name as departname
from employee e right join department d on e.department_id=d.department_id;


select e.name
from employee e left join project p on e.department_id=p.department_id
where project_id is NULL;

select e.name,count(p.*)
from employee e  join project p on e.department_id=p.department_id
group by e.name;

select d.name as departname
from employee e  join department d on e.department_id=d.department_id
where emp_id is NULL;

select e.name
from employee e
where e.department_id=(select department_id from employee where name='John Doe') and e.name<>'John Doe';
--or--
select e2.name
from employee e1 join employee e2 on e1.department_id=e2.department_id where e1.name='John Doe' and e2.name<>'John Doe';

select d.name,avg(salary)
from employee e join department d on e.department_id=d.department_id
group by d.name
order by avg(salary) DESC
limit 1;

--Nested And Correlated Queries--
select *
from employee
where salary=(select max(salary) from employee);

select *
from employee
where salary >(select avg(salary) from employee);

select salary
from employee
order by salary desc
limit 1 offset 1;
--or--
select * from employee
where salary=(select salary from employee order by salary desc limit 1 offset 1);

select department_id ,count(*)
from employee
group by department_id
order by count(*) desc
limit 1;

select  e.name
from employee e join (select department_id,avg(salary) as avgerage from employee group by department_id) d on e.department_id=d.department_id
where e.salary>d.avgerage;

select salary
from employee
order by salary desc
limit 1 offset 2;

select e.*
from employee e
where e.age> (select max(e1.age) from  employee e1 join department d1 on e1.department_id=d1.department_id where d1.name='HR');


select d.*
from department d join (select  department_id,avg(salary)from employee group by department_id having avg(salary)>55000) e on d.department_id = e.department_id;

select e.name
from employee e join (select p.department_id,count(*)
from project p
group by p.department_id
having count(*)>=2) d on e.department_id=d.department_id;

select *
from employee
where hire_date=(select hire_date from employee where name='Jane Smith' )and name<> 'Jane Smith' ;

--combined  queries--
select sum(salary)
from employee
where year(hire_date)=2020;

select department_id,avg(salary)
from employee
group by department_id
order by avg(salary) desc;

select department_id,avg(salary),count(*) as emps
from employee
group by department_id
having avg(salary)>55000 and emps>1;

select *
from employee
where hire_date>=DATEADD(year,-5,CURRENT_DATE)
order by hire_date;

select department_id,count(*) as total_emp ,avg(salary)
from employee
group by department_id
having total_emp>2;

select e.name,e.salary
from employee e join (select department_id,avg(salary)  as average from employee group by department_id) d on e.department_id=d.department_id
where e.salary>d.average;

select name
from employee
where hire_date=(select min(hire_date) from employee);

select d.name,count(*) as projects
from department d join project p on d.department_id=p.department_id
group by d.name
order by projects;

select e1.name
from employee e1 join (select e.department_id,max(salary) as maxi
from employee e
group by e.department_id) d1 on e1.department_id=d1.department_id and e1.salary =d1.maxi;



select e.name,e.salary
from employee e join (select department_id,avg(age)  as average from employee group by department_id) d on e.department_id=d.department_id
where e.age>d.average;