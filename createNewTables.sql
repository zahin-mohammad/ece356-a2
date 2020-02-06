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
    deptName VARCHAR (100)(100),
    PRIMARY KEY (deptID)
);

CREATE TABLE NewDepartmentLocation(
    deptID INT,
    postalCode VARCHAR (100),
    strNumber VARCHAR (100),
    strName VARCHAR (100),
    PRIMARY KEY (deptID, postalCode),
    FOFOREIGN KEY (`postalCode`) REFERENCES NewPostalCode(`postalCode`)
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





