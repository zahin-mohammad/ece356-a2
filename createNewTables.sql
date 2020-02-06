CREATE DATABASE IF NOT EXISTS normalization;

CREATE TABLE NewPostalCode(
    postalCode VARCHAR,
    cityName VARCHAR,
    provName VARCHAR
    PRIMARY KEY(postalCode)
);

CREATE TABLE NewDepartment(
    deptID INT,
    deptName VARCHAR(100),
    PRIMARY KEY (deptID)
);

CREATE TABLE NewDepartmentLocation(
    deptID INT,
    postalCode VARCHAR,
    strNumber VARCHAR,
    strName VARCHAR,
    PRIMARY KEY (deptID, postalCode),
    FOFOREIGN KEY (`postalCode`) REFERENCES NewPostalCode(`postalCode`)
);

-- Assigned stayed the same
-- Project satyed the same

CREATE TABLE NewEmployee(
    empID INT,
    firstName VARCHAR,
    middleName VARCHAR,
    lastName VARCHAR,
    job VARCHAR,
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





