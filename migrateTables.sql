INSERT INTO NewEmployee (empID, firstName, middleName, lastName, job, salary) 
    (
    SELECT DISTINCT Employee.empid, Employee.empName, Employee.empName, Employee.empName, Employee.job, Employee.salary 
    FROM Employee 
    );

INSERT INTO NewDepartment (deptID, deptName) 
    (
    SELECT DISTINCT Department.deptID, Department.deptName
    FROM Department 
    );
-- regex for street number ([1-9][^\s,A-z]\S)
-- regex for street name ([^1-9\s][A-z]+\s[A-z]+)
INSERT INTO NewPostalCode (postalCode, cityName, provName) 
    (
    SELECT DISTINCT 
    REGEXP_SUBSTR(Department.location,""),
    REGEXP_SUBSTR(Department.location, ""),
    REGEXP_SUBSTR(Department.location, "")
    FROM Department 
    );

INSERT INTO NewEmployeeDepartment (empID, deptID) 
    (
    SELECT DISTINCT Employee.empid, Employee.deptID
    FROM Employee 
    );
