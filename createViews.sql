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
        ", "
        NewPostalCode.provName,
        ", "
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
