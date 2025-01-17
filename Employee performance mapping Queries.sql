# Q1 Create a database named employee, then import data_science_team.csv, proj_table.csv, and emp_record_table.csv into the employee database.

Create Database employee;
USE Employee;

# Q2 Create the ER Diagram for the given Employee Database


# Q3 Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table.

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table;

# Q4 Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING based on the employee rating:

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2
OR EMP_RATING > 4
OR EMP_RATING BETWEEN 2 AND 4;
  
# Q5   Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department and give the resultant column alias as NAME

SELECT EMP_ID, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME, DEPT 
FROM emp_record_table
WHERE DEPT = 'Finance';

# Q6 Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).

SELECT MANAGER_ID, COUNT(EMP_ID) AS Reporters
FROM emp_record_table
GROUP BY MANAGER_ID
HAVING COUNT(EMP_ID) > 0;

# USE WITHOUT HAVING FUNCTION

SELECT MANAGER_ID, COUNT(*) AS REPORT_COUNT
FROM emp_record_table
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID;

# Q7 Write a query to list down all the employees from the Healthcare and Finance departments using UNION.

SELECT * FROM emp_record_table WHERE DEPT = 'Healthcare'
UNION
SELECT * FROM emp_record_table WHERE DEPT = 'Finance';

# Q8 Write a query to list down employee details grouped by department, including employee rating and maximum rating for the department.

SELECT DEPT, EMP_ID, FIRST_NAME, LAST_NAME, ROLE, EMP_RATING,
MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS Max_Dept_Rating
FROM emp_record_table;

# Q9 Write a query to calculate the minimum and maximum salary of the employees in each role.

SELECT ROLE, MIN(SALARY) AS Min_Salary, MAX(SALARY) AS Max_Salary
FROM emp_record_table
GROUP BY ROLE;

# Q10 Write a query to assign ranks to each employee based on their experience.

SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, 
       RANK() OVER (ORDER BY EXP DESC) AS EXPERIENCE_RANK
FROM emp_record_table;

# Q11 Write a query to create a view that displays employees in various countries whose salary is more than six thousand.

CREATE VIEW High_Earners AS
SELECT EMP_ID, FIRST_NAME, SALARY
FROM emp_record_table
WHERE SALARY > 6000;

# Q12 Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.

SELECT * FROM emp_record_table
WHERE EXP > 10;

# Q13 Write a query to create a stored procedure to retrieve the details of employees whose experience is more than three years.

CREATE PROCEDURE get_experienced_employees()
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM emp_record_table
WHERE EXP > 3;

# Q14 Write a query using stored functions in the project table to check whether the job profile assigned to each 
# employee in the data science team matches the organization’s set standard.

SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP,
CASE 
    WHEN EXP <= 2 THEN 'JUNIOR DATA SCIENTIST'
    WHEN EXP BETWEEN 2 AND 5 THEN 'ASSOCIATE DATA SCIENTIST'
    WHEN EXP BETWEEN 5 AND 10 THEN 'SENIOR DATA SCIENTIST'
    WHEN EXP BETWEEN 10 AND 12 THEN 'LEAD DATA SCIENTIST'
    WHEN EXP BETWEEN 12 AND 16 THEN 'MANAGER'
    ELSE 'OTHER'
END AS JOB_PROFILE
FROM data_science_team;

# Q15 Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’

CREATE INDEX index_first_name ON emp_record_table(FIRST_NAME(50)) ;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE
FROM emp_record_table
WHERE FIRST_NAME = 'Eric';

# Q16 Write a query to calculate the bonus for all the employees, 
# based on their ratings and salaries. (Formula: 5% of salary * employee rating).

SELECT EMP_ID, FIRST_NAME, LAST_NAME, SALARY, EMP_RATING,
(0.05 * SALARY * EMP_RATING) AS BONUS
FROM emp_record_table;

# Q17 Write a query to calculate the average salary distribution based on the continent and country.

SELECT CONTINENT, COUNTRY, AVG(SALARY) AS AVERAGE_SALARY
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;


