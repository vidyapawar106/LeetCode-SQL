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
