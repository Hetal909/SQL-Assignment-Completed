use hr;
--  Display all information in the tables EMP and DEPT.
select * from employees;
select * from departments;

--  Display only the hire date and employee name for each employee.
select first_name, last_name, hire_date from employees;

--  Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title.
SELECT last_name||', '||job_id "Employee and Title"
FROM employees;

--  Display the hire date, name and department number for all clerks
select first_name, last_name, hire_date from employees 
where job_id like "SH_CLERK";

--  Create a query to display all the data from the EMP table. Separate each column by a comma.    Name the column THE OUTPUT
select employee_id||','||first_name||','|| last_name||','||email||','||phone_number||','||hire_date||','||job_id||','||salary||','||commission_pct the_output from employees;

--  Display the names and salaries of all employees with a salary greater than 2000. 
select first_name, last_name, salary from employees 
where salary > 2000;

--  Display the names and dates of employees with the column headers "Name" and "Start Date"
select first_name as "Name" , hire_date as "Start Date" from employees;

--  Display the names and hire dates of all employees in the order they were hired.
select first_name, last_name, hire_date from employees order by hire_date;

--  Display the names and salaries of all employees in reverse salary order
select first_name, last_name, salary from employees order by salary desc;

--  Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.
SELECT first_name, department_id
FROM employees WHERE job_id = "SA_MAN" ORDER BY salary DESC;

--  Display the last name and job title of all employees who do not have a manager
select last_name, job_id from employees where manager_id is NULL;

--  Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
select last_name , job_id, salary from employees where job_id in ("SA_RAP" , "ST_CLERK")
and salary not in (2500, 3500, 5000);


-- DATABASE HR
--  Display the maximum, minimum and average salary and commission earned. 
SELECT max(salary), min(salary), avg(salary), max(commission_pct), min(commission_pct), avg(commission_pct)
from employees;

--  Display the department number, total salary payout and total commission payout for each department. 
select department_id, sum(salary), sum(commission_pct) from employees group by department_id;

--  Display the department number and number of employees in each department. 
select department_id , sum(employee_id) from employees group by department_id;

--  Display the department number and total salary of employees in each department.
select department_id, sum(salary) from employees group by department_id;

--  Display the employee's name who doesn't earn a commission. Order the result set without using the column name 
select first_name , last_name, salary from employees where commission_pct is null;

--  Display the employees name, department id and commission. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately
SELECT first_name, salary,
CASE
 when commission_pct > 0 then commission_pct 
 else "No commision"
END
from employees;

-- Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately
SELECT first_name, salary,
CASE
    WHEN commission_pct > 0 THEN commission_pct* 2
    ELSE 'No Commission'
END
FROM employees;

--  Display the employee's name, department id who have the first name same as another employee in the same department
select first_name, last_name, department_id 
from employees
where first_name =
(select first_name from employees where department_id = first_name);

--  Display the sum of salaries of the employees working under each Manager. 
select employee_id, sum(salary) from employees
group by employee_id;

--  Select the Managers name, the count of employees working under and the department ID of the manager. 
select first_name, count(employee_id), department_id from employees
group by employee_id;

-- Select the employee name, department id, and the salary. Group the result with the manager name and the employee last name should have second letter 'a! 
select first_name, last_name, department_id , salary
from employees where last_name = "_a%";
 
 -- Display the average of sum of the salaries and group the result with the department id. Order the result with the department id. 
 select avg(salary), department_id from employees
 group by department_id;
 
 --  Select the maximum salary of each department along with the department id 
 select department_id , max(salary) from employees 
 group by department_id;
 
 --  Display the commission, if not null display 10% of salary, if null display a default value 1
 select commission_pct, salary ,
CASE
 when commission_pct is not null then salary = "10%"
 else "1"
END
from employees;


--  Write a query that displays the employee's last names only from the string's 2-5th
-- position with the first letter capitalized and all other letters lowercase, Give each column an
-- appropriate label. 
 select last_name,
 concat(upper(substring(last_name,2,1)) , lower(substring(last_name,3,3)))
 from employees;
 
--  Write a query that displays the employee's first name and last name along with a " in
-- between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.
select first_name, last_name, concat(first_name, "-" , last_name) as "name", hire_date from employees;


--  Write a query to display the employee's last name and if half of the salary is greater than ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of
-- 1500 each. Provide each column an appropriate label. 
select last_name, salary,
if ((salary/2) > "10,000" ,  "1500" + salary +
salary*"10"/"100", "1500" + salary + salary *"11.5"/"100")
as "Bonus salary"
from employees;


-- Display the employee's name if it is a palindrom

SELECT SUBSTRING(first_name,1,5) from employees  where 
          REVERSE (SUBSTRING(first_name,1,5)) = SUBSTRING(first_name,1,5);
          
-- Display First names of all employees with initcaps. 
SELECT
    CONCAT(
        SUBSTRING(first_name, 1, 1),
        LOWER(SUBSTRING(first_name, 2))
    ) AS desired_name
FROM employees;

-- From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column. 
select substring_index(substring_index(street_address, ' ', 2),' ',-1), street_address
from locations;

--  Display the names and job titles of all employees with the same job as Trenna. 
SELECT E.first_name, E.last_name, E.job_id from employees E
join employees S 
ON E.job_id = S.job_id AND S.first_name = "Trenna";

--  Display the names and department name of all employees working in the same city as Trenna
select E.first_name, E.department_id from employees E
join employees S
on E.department_id = S.department_id and S.first_name = "Trenna";

--  Display the name of the employee whose salary is the lowest. 
select min(salary) as "Lowest Salary" from employees
group by salary;

--  Display the names of all employees except the lowest paid.
select first_name from employees
where salary > (select min(salary) from employees);

-- Write a query to display the last name, department number, department name for all employees. 
SELECT 
	e.last_name, d.department_id, d.department_name
FROM 
	employees AS e
	JOIN departments AS d
	ON e.department_id = d.department_id;
    

-- ***
--  Write a query to display the last name, department number, department name for all employees. 
SELECT e.last_name, e.department_id, d.department_name
	FROM employees e, departments d
	WHERE e.department_id = d.department_id;
    

--  Create a unique list of all jobs that are in department 4. Include the location of the department in the output. 
select distinct job_id, location_id 
from employees, departments 
where employees.department_id  = departments.department_id
 and employees.department_id = 4; 

--  Write a query to display the employee last name,department name,location id and city of all employees who earn commission. 
SELECT e.last_name, d.department_name, d.location_id, l.city
	FROM employees e, departments d, locations l
	WHERE e.department_id = d.department_id
	AND
	d.location_id = l.location_id
	AND e.commission_pct IS NOT NULL;
    
--  Display the employee last name and department name of all employees who have an 'a' in their last name
 select last_name, department_name from employees, departments
 where last_name like "%a%";
 
 --  Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA. 
 
	SELECT 	e.last_name, e.job_id, e.department_id,d.department_name
	FROM 	employees e JOIN departments d
	ON 	(e.department_id = d.department_id)
	JOIN 	locations l
	ON 	(d.location_id = l.location_id)
	WHERE 	LOWER(l.city) = "ATLANTA";
    
    --  Display the employee last name and employee number along with their manager's last name and manager number. 
    SELECT	 w.last_name "Employee", w.employee_id "EMP#",
	         m.last_name "Manager", m.employee_id "Mgr#"
	FROM     employees w join employees m
	ON       (w.manager_id = m.employee_id);
   
   --  Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager).  
   SELECT	 w.last_name "Employee", w.employee_id "EMP#",
	         m.last_name "Manager", m.employee_id "Mgr#"
	FROM     employees w join employees m
	ON       (w.manager_id = m.employee_id);
    
    --  Create a query that displays employees last name,department number,and all the employees who work in the same department as a given employee. 
    select e.department_id department, e.last_name employee,
    c.last_name colleague
    from employees e join employees c
    on (e.department_id = c.department_id)
    WHERE e.employee_id <> c.employee_id
	ORDER BY e.department_id, e.last_name, c.last_name;
    
    --  Create a query that displays the name,job,department name,salary,grade for all employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C) 
    SELECT w.last_name, w.hire_date, m.last_name, m.hire_date
	FROM employees w JOIN employees m
	ON (w.manager_id = m.employee_id)
	WHERE salary>=50000=A, >=30000=B,<30000=C;
    
    --  Display the names and hire date for all employees who were hired before their managers along withe their manager names and hire date. Label the columns as Employee name, emp_hire_date,manager name,man_hire_date
    SELECT w.last_name, w.hire_date, m.last_name, m.hire_date
	FROM employees w JOIN employees m
	ON (w.manager_id = m.employee_id)
	WHERE w.hire_date < m.hire_date;
    
    
   --  Write a query to display the last name and hire date of any employee in the same department as SALES.   
   SELECT last_name, hire_date
	FROM employees
	WHERE department_id = (SELECT department_id
	FROM employees
	WHERE last_name= "SALES")
	AND last_name <> "SALES";
    

-- Create a query to display the employee numbers and last names of all employees who earn more than the average salary. Sort the results in ascending order of salary. 
select employee_id, last_name, salary from employees 
where salary > (select AVG(salary) from employees)
order by salary;

--  Write a query that displays the employee numbers and last names of all employees who work in a department with any employee whose last name contains a' u
select employee_id, last_name from employees
where department_id in (select department_id 
                        from employees 
                        where last_name like "a%u%");
                        
-- 4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA

select last_name, department_id, job_id, location_id
from employees
where location_id = (select location_id like "1700");


--  Display the last name and salary of every employee who reports to FILLMORE
select last_name, salary from employees
where manager_id = (select employee_id from employees where last_name = "FILLMORE");

--  Display the department number, last name, and job ID for every employee in the OPERATIONS department. 
select department_id , last_name , job_id from employees
where department_id = (select department_id from departments  where department_name = "OPERATIONS");

--  Modify the above query to display the employee numbers, last names, and salaries of all employees who earn more than the average salary and who work in a department with any employee with a 'u'in their name.
select employee_id, last_name, salary from employees 
where department_id in (select department_id from employees where last_name like "%u%")
and salary > (select avg(salary) from employees);

-- Display the names of all employees whose job title is the same as anyone in the sales dept. 
SELECT
	e.first_name, j.job_title, d.department_name
FROM
	employees AS e
	JOIN jobs AS j
	ON e.job_id = j.job_id
	JOIN departments AS d
	ON e.department_id = d.department_id
WHERE
	d.department_name = "sales";

-- Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise,
-- employees in department 2 are given a 10% raise, employees in departments 4 and 5 are
-- given a 15% raise, and employees in department 6 are not given a raise. 

--  Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries. 
select last_name , salary from employees
order by salary desc limit 3;

--  Display the names of all employees with their salary and commission earned. Employees with a null commission should have O in the commission column 
select first_name, salary, COALESCE(commission_pct,0) from employees;

--  Display the Managers (name) with top three salaries along with their salaries and department information.
select first_name, salary, department_id from employees
order by salary desc limit 3;


-- **ADVENTUREWORKS DATABASE**
use adventureworks;
--  Write a query to display employee numbers and employee name (first name, last name) of all the sales employees who received an amount of 2000 in bonus. 
SELECT employeeID, CONCAT(firstname, " ", lastname) AS Fullname, s.bonus
FROM employee AS e JOIN contact AS c ON e.contactid = c.contactid JOIN salesperson AS s ON c.modifieddate = s.ModifiedDate
WHERE s.bonus = 2000;

--  Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A



-- Write a query that displays all the products along with the Sales OrderID even if an order has never been placed for that product
SELECT product.productid, name, salesorderid
FROM product LEFT JOIN salesorderdetail ON product.productID = salesorderdetail.productId;

--  Find the subcategories that have at least two different prices less than $15.
SELECT p.name, s.UnitPrice
FROM productsubcategory AS p JOIN product as pp ON p.ProductSubcategoryID = pp.ProductSubcategoryID JOIN salesorderdetail as s ON pp.productid = s.productid
WHERE s.UnitPrice < 15;

-- A. Write a query to display employees and their manager details. Fetch employee id, employee first name, and manager id, manager name.
-- B. Display the employee id and employee name of employees who do not have manager. 
select EmployeeID, ManagerID , FirstName from employee , contact; 
select EmployeeID, ManagerID from employee
where ManagerID is null;


--  A. Display the names of all products of a particular subcategory 15 and the names of their vendors.
-- B. Find the products that have more than one vendor. 

SELECT p.name AS "Product_Name", p.ProductSubcategoryID, v.name AS "Vendor_Name"
FROM vendor AS v JOIN productvendor AS pv ON v.vendorid = pv.vendorid JOIN product AS p ON p.productid = pv.productid JOIN productsubcategory AS c ON c.ProductSubcategoryID = p.ProductSubcategoryID
WHERE p.ProductSubcategoryID = 15;

SELECT p.name, COUNT(v.vendorid) AS "Vendor_count"
FROM vendor AS v JOIN productvendor AS pv ON v.vendorid = pv.vendorid JOIN product AS p ON p.productid = pv.productid JOIN productsubcategory AS c ON c.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY p.name
HAVING Vendor_count > 1;


--  Display product number, description and sales of each product in the year 2001. 
SELECT p.name, p.ProductNumber, d.description, YEAR(o.modifieddate) 
FROM salesorderdetail AS o JOIN product AS p ON o.ProductID = p.ProductID JOIN productmodelproductdescriptionculture AS pd ON p.ProductModelID = pd.ProductModelID JOIN productdescription AS d ON d.ProductDescriptionID = pd.ProductDescriptionID
WHERE YEAR(o.modifieddate) = 2001;


-- use dates;
-- Find the date difference between the hire date and resignation_date for all the employees. Display in no. of days, months and year(1 year 3 months 5 days). Emp_ID Hire Date Resignation_Date
SELECT 
	CONCAT(FLOOR(DATEDIFF(resignation_date, hire_date)/365)," Year ",
		   FLOOR(DATEDIFF(resignation_date, hire_date)%365/30), " Month ",
           FLOOR(DATEDIFF(resignation_date, hire_date)%365%30), " Day") AS "Date"
FROM 
	empdates;
    
    
-- Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900) 
SELECT 
	DATE_FORMAT(hire_date, "%d / %m / %Y") AS hire_date,
    IF(resignation_date IS NULL, "DEC, 01th 1900", DATE_FORMAT(resignation_date, "%b  %D,  %Y ")) AS "Resignation_Date"    
FROM 
	empdates;
    
--  Calcuate experience of the employee till date in Years and months(example 1 year and 3 months)
SELECT 
	CONCAT(FLOOR(DATEDIFF(IF(resignation_date IS NULL, CURDATE(), resignation_date), hire_date)/365)," Year ",
		   FLOOR(DATEDIFF(IF(resignation_date IS NULL, CURDATE(), resignation_date), hire_date)%365/30), " Month ",
           FLOOR(DATEDIFF(IF(resignation_date IS NULL, CURDATE(), resignation_date), hire_date)%365%30), " Day") AS experience
FROM 
	empdates;
    

 
 
