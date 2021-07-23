# Solution One: Combine Two Tables
select Firstname, LastName, City, State
From Person
Left Join Address ON Person.PersonId = Address.PersonId;


# Solution Two: Second Highest Salary
select max(Salary) as SecondHighestSalary From Employee
where Salary < (select max(Salary) From Employee);


# Solution Three: Nth Highest Salary
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
SET N = N - 1;
  RETURN (
      # Write your MySQL query statement below.
      
      select Salary from Employee
      Order by Salary Desc
      LIMIT N, 1
  );
END


# Solution Four: Rank Scores
SELECT
     Score,
    Dense_RANK() OVER (
        ORDER BY Score Desc
    ) 'Rank'
FROM
    Scores;


# Solution Five: Customers Who Never Order
select Name as 'Customers' from Customers
left join Orders on Orders.CustomerId = Customers.Id
where Orders.CustomerId IS NULL;


# Solution Six: Consecutive Numbers
SELECT DISTINCT l1.Num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num
;


# Solution Seven: Employees Earning More Than Their Managers
SELECT
    a.Name AS 'Employee'
FROM
    Employee AS a,
    Employee AS b
WHERE
    a.ManagerId = b.Id
        AND a.Salary > b.Salary
;


# Solution Eight: Duplicate Emails
Select Email from Person
group by Email
having Count(Email) > 1


# Solution Nine: Department Highest Salary
Select Department.Name as 'Department', Employee.Name as 'Employee', Salary
from Employee
join Department on Employee.DepartmentId = Department.Id
where (Employee.DepartmentId , Salary) 
IN (
    Select DepartmentId, max(Salary) from Employee
    group by DepartmentId
);


# Solution Ten: Department Top Three Salaries
