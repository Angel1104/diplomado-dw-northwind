-- Dimension de empleado. Derivada de Employees (OLTP), simplificada
-- (se omite la autorreferencia ReportsTo, propia de un modelo jerarquico OLTP).
CREATE TABLE [DimEmployee] (
    [EmployeeKey]  INT          IDENTITY(1,1) NOT NULL,
    [EmployeeID]   INT          NOT NULL,  -- llave natural
    [FullName]     NVARCHAR(40) NOT NULL,  -- FirstName + LastName, desnormalizado
    [Title]        NVARCHAR(30) NULL,
    [City]         NVARCHAR(15) NULL,
    [Country]      NVARCHAR(15) NULL,
    PRIMARY KEY ([EmployeeKey])
);
