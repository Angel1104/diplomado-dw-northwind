-- Dimension de empleado. Derivada de Employees (OLTP), simplificada
-- (se omite la autorreferencia ReportsTo, propia de un modelo jerarquico OLTP).
CREATE TABLE [dbo].[DimEmployee]
(
	[EmployeeSK]  [int]          IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimEmployee PRIMARY KEY,
	[EmployeeID]  [int]          NOT NULL,  -- llave natural de NorthWind.Employees
	[FirstName]   [varchar](10)  NOT NULL,
	[LastName]    [varchar](20)  NOT NULL,
	[Title]       [varchar](30)  NULL,
	[City]        [varchar](15)  NULL,
	[Country]     [varchar](15)  NULL
);
GO
