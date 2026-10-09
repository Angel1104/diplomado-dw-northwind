-- Tabla de staging para la carga del ETL hacia DimEmployee.
CREATE TABLE [staging].[employee]
(
	[EmployeeSK] [int]         NOT NULL,
	[EmployeeID] [int]         NOT NULL,
	[FirstName]  [varchar](10) NOT NULL,
	[LastName]   [varchar](20) NOT NULL,
	[Title]      [varchar](30) NULL,
	[City]       [varchar](15) NULL,
	[Country]    [varchar](15) NULL
);
GO
