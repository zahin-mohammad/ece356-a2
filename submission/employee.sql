DROP DATABASE normalization;

-- source ./createTables.sql;
CREATE DATABASE IF NOT EXISTS normalization;
USE normalization;

DROP TABLE IF EXISTS Department;           
CREATE TABLE Department(deptID INT,deptName VARCHAR(100),location VARCHAR(100));                    
          
DROP TABLE IF EXISTS Employee;  
CREATE TABLE Employee(empID INT,empName VARCHAR(100),job VARCHAR(100),deptID INT,salary INT);
                  
DROP TABLE IF EXISTS Assigned;             
CREATE TABLE Assigned(empID INT,projID INT,role VARCHAR(100));                 
        
DROP TABLE IF EXISTS Project;           
CREATE TABLE Project(projID INT,title VARCHAR(100),budget INT,funds INT);

INSERT INTO Department(deptID, deptName, location) VALUES(3, 'marketing', '123 Fake Street, Waterloo, Ontario, N2N 2N2');             
INSERT INTO Department(deptID, deptName, location) VALUES(7, 'research', '124 Unreal Way, Guelph, Ontario, N3N 3N3');            
INSERT INTO Department(deptID, deptName, location) VALUES(12, 'software', '1 Bay Street, Toronto, Ontario, M5W 1E6'); 
INSERT INTO Department(deptID, deptName, location) VALUES(13, 'computing', '1 Bay Street, Toronto, Ontario, M5W 1E6'); 

INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(23, 'Mary Jane Smith', 'programmer', 12, 35000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(45, 'Kelly Kelly', 'engineer', 7, 37000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(56, 'Adam Andrew Herr', 'janitor', 7, 26000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(89, 'William William Williams', 'analyst', 12, 36000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(77, 'Bryan Hergot', 'secretary', 7, 28000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(66, 'Brian Hess', 'technician', 7, 32000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(92, 'Mary Mays', 'engineer', 7, 45000); 
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(68, 'Joe Morris', 'secretary', 3, 23000);  
INSERT INTO Employee(empID, empName, job, deptID, salary) VALUES(69, 'Maria Jones', 'engineer', 3, 32000); 

INSERT INTO Project(projID, title, budget, funds) VALUES(345, 'compiler', 500000, 250000); 
INSERT INTO Project(projID, title, budget, funds) VALUES(123, 'display', 650000, 370000); 

INSERT INTO Assigned(empID, projID, role) VALUES(23, 345, 'programmer');            
INSERT INTO Assigned(empID, projID, role) VALUES(66, 123, 'programmer');        
INSERT INTO Assigned(empID, projID, role) VALUES(77, 123, 'secretary');           
INSERT INTO Assigned(empID, projID, role) VALUES(45, 123, 'manager'); 
INSERT INTO Assigned(empID, projID, role) VALUES(89, 345, 'manager');     
INSERT INTO Assigned(empID, projID, role) VALUES(92, 123, 'engineer'); 

-- source ./createNewTables.sql;
CREATE DATABASE IF NOT EXISTS normalization;
USE normalization;

CREATE TABLE NewPostalCode(
    postalCode VARCHAR (100),
    cityName VARCHAR (100),
    provName VARCHAR (100),
    PRIMARY KEY(postalCode)
);

CREATE TABLE NewDepartment(
    deptID INT,
    deptName VARCHAR (100),
    PRIMARY KEY (deptID)
);

CREATE TABLE NewDepartmentLocation(
    deptID INT,
    postalCode VARCHAR (100),
    strNumber VARCHAR (100),
    strName VARCHAR (100),
    PRIMARY KEY (deptID, postalCode),
    FOREIGN KEY (`postalCode`) REFERENCES NewPostalCode(`postalCode`)
);

-- Assigned stayed the same
-- Project satyed the same

CREATE TABLE NewEmployee(
    empID INT,
    firstName VARCHAR (100),
    middleName VARCHAR (100),
    lastName VARCHAR (100),
    job VARCHAR (100),
    salary INT,
    PRIMARY KEY (empID)
);

CREATE TABLE NewEmployeeDepartment(
    empID INT,
    deptID INT,
    PRIMARY KEY (empID),
    FOREIGN KEY (`empID`) REFERENCES NewEmployee(`empID`),
    FOREIGN KEY (`deptID`) REFERENCES NewDepartment(`deptID`)
);

-- source ./migrateTables.sql;
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

-- source ./deleteOldTables.sql;
USE normalization;
DROP TABLE Employee;
DROP TABLE Department;

-- source ./createViews.sql;
USE normalization;

CREATE VIEW Department 
AS SELECT 
    NewDepartment.deptID AS deptID, 
    NewDepartment.deptName AS deptName,
    CONCAT(
        NewDepartmentLocation.strNumber,
        " ",
        NewDepartmentLocation.strName,
        ", ",
        NewPostalCode.cityName,
        ", ",
        NewPostalCode.provName,
        ", ",
        NewPostalCode.postalCode)  AS location 
FROM 
NewDepartment 
INNER JOIN 
NewDepartmentLocation 
ON 
NewDepartment.deptID = NewDepartmentLocation.deptID
INNER JOIN
NewPostalCode
ON NewPostalCode.postalCode = NewDepartmentLocation.postalCode;

CREATE VIEW Employee 
AS SELECT 
    NewEmployee.empID AS empID, 
    CONCAT_WS(
        " ",
        NewEmployee.firstName,
        NewEmployee.middleName,
        NewEmployee.lastName)  AS empName,
        NewEmployee.job as job, 
        NewEmployeeDepartment.deptID as deptID
FROM 
NewEmployee 
INNER JOIN 
NewEmployeeDepartment 
ON 
NewEmployee.empID = NewEmployeeDepartment.empID
