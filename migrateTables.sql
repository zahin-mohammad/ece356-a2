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
-- regex for street number (\b\d+\b)
-- regex for street name ([A-z]+)(\s[A-z\b]+)
-- regex for city ([^A-z][\s]\b[A-z]+\b\,)
--  regex replace \,\s*
-- regex for postal .{7}$
-- regex for Province \b[A-z]+\b\,\s[A-Z][0-9]
--  regex replace .{4}$
INSERT INTO NewPostalCode (postalCode, cityName, provName) 
    (
    SELECT DISTINCT 
    REGEXP_SUBSTR(Department.location,".{7}$"),
    REGEXP_REPLACE(
        REGEXP_SUBSTR(Department.location, "(\, [A-z]+\,)"),
        "\,\s*",
        ""
    ),
    REGEXP_REPLACE
        (
        REGEXP_SUBSTR(Department.location, "([A-z]+\,)",1,3),
        "\,\s*",
        ""
        )
    FROM Department 
    );

INSERT INTO NewEmployeeDepartment (empID, deptID) 
    (
    SELECT DISTINCT Employee.empid, Employee.deptID
    FROM Employee 
    );
