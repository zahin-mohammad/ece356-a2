INSERT INTO NewPostalCode (postalCode, cityName, provName) 
    (
    SELECT DISTINCT 
    REGEXP_SUBSTR(Department.location,".{7}$"),
    REGEXP_REPLACE
    (
        REGEXP_SUBSTR(Department.location, "(\,[[:blank:]][A-z]+\,)"),
        "\,[[:blank:]]*",
        ""
    ),
    REGEXP_REPLACE
        (
        REGEXP_SUBSTR(Department.location, "([A-z]+\,)",1,3),
        "\,[[:blank:]]*",
        ""
        )
    FROM Department 
    );

INSERT INTO NewDepartment (deptID, deptName) 
    (
    SELECT DISTINCT Department.deptID, Department.deptName
    FROM Department 
    );

INSERT INTO NewDepartmentLocation (deptID, postalCode, strNumber, strName) 
    (
    SELECT DISTINCT
    Department.deptID,
    REGEXP_SUBSTR(Department.location,".{7}$"),
    REGEXP_SUBSTR(Department.location,"[0-9]+[A-z]*",1,1),
    REGEXP_SUBSTR(Department.location,"[A-z]+[[:blank:]][A-z]+",1,1)
    FROM Department 
    );

INSERT INTO NewEmployee (empID, firstName, middleName, lastName, job, salary) 
    (
    SELECT DISTINCT 
    Employee.empid, 
    REGEXP_SUBSTR(Employee.empName, "^[A-z]+"),
    REGEXP_REPLACE
    (
        REGEXP_SUBSTR(Employee.empName, "[[:blank:]][A-z]+[[:blank:]]"),
        "[[:blank:]]*",
        ""
    ),
    REGEXP_SUBSTR(Employee.empName, "[A-z]+$"),
    Employee.job, 
    Employee.salary 
    FROM Employee 
    );

INSERT INTO NewEmployeeDepartment (empID, deptID) 
    (
    SELECT DISTINCT Employee.empid, Employee.deptID
    FROM Employee 
    );
