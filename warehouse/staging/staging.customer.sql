-- Tabla de staging para la carga del ETL hacia DimCustomer.
-- Espeja la estructura de la dimension final, pero sin IDENTITY: el proceso
-- ETL resuelve y asigna la surrogate key antes de insertar en staging.
CREATE TABLE [staging].[customer]
(
	[CustomerSK]   [int]         NOT NULL,
	[CustomerID]   [nchar](5)    NOT NULL,
	[CompanyName]  [varchar](40) NOT NULL,
	[ContactName]  [varchar](30) NULL,
	[ContactTitle] [varchar](30) NULL,
	[City]         [varchar](15) NULL,
	[Region]       [varchar](15) NULL,
	[Country]      [varchar](15) NULL
);
GO
