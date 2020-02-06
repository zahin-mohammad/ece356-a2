INSERT INTO NewEmployee (empID, firstName, middleName, lastName, job, salary) 
    (
    SELECT DISTINCT Employee.empid, Employee.empName, Employee.empName, Employee.empName, Employee.job, Employee.salary 
    FROM Employee 
    );
