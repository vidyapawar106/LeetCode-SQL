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


# Solution Eight: Deleting Duplicate Emails
Hint: Try selecting the records you want to remove, then replace it with Delete keyword.
DELETE p1 FROM Person p1,    
    Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id


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
SELECT d.Name AS 'Department', e1.Name AS 'Employee', e1.Salary
FROM Employee e1
JOIN Department d ON e1.DepartmentId = d.Id
WHERE 3 > (SELECT COUNT(DISTINCT e2.Salary)
        FROM Employee e2
        WHERE e2.Salary > e1.Salary AND e1.DepartmentId = e2.DepartmentId);
        
        
# Solution Eleven: Big Countries
Select name, population, area from World
where area >= 3000000 or population >=25000000;
        

# Solution Twelve: Swap Salary
Update Salary
Set sex = CASE sex 
    WHEN 'm' THEN 'f'
    ELSE 'm'
    END;


# Solution Thirteen: Non Boring & Odd numbered Movies
Select * from Cinema 
Where description !='boring' and (id % 2) > 0
Order by rating DESC;


# Solution Fourteen: Rising Temperature
Select 
    w2.id
From
    Weather w1
    INNER JOIN
    Weather w2 ON w2.id = w1.id + 1 
Where
    w1.temperature < w2.temperature;

ALSO:  SELECT
    weather.id AS 'Id'
       FROM
          weather
              JOIN
          weather w ON DATEDIFF(weather.recordDate, w.recordDate) = 1
              AND weather.Temperature > w.Temperature;


# Solution Fifteen: Classes More Than 5 Students
Select class From Courses
Group by class
Having count(class)>=5;


# Solution Sixteen: Median Salary
Select id, company, salary
from
(
  Select id, company, salary, 
         row_number() Over(Partition by company order by salary) as      
         rno,
         count(*) Over(Partition by company) as cnt
  from Employee
) x
where rno in (Ceil(cnt/2), cnt/2 + 1)
;


# Solution Seventeen: Trips & users
Select 
t.Request_at 'Day', 
round(sum(case when t.Status = 'completed' then 0 else 1 end) / count(*), 2) 'Cancellation Rate'
from Trips t
inner join Users u 
on t.Client_Id = u.Users_Id and u.Banned = 'No'
where t.Request_at between '2013-10-01' and '2013-10-03'
group by t.Request_at








