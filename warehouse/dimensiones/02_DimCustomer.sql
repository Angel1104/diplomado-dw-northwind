-- Dimension de cliente. Derivada directamente de Customers (OLTP).
CREATE TABLE [dbo].[DimCustomer]
(
	[CustomerSK]   [int]         IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimCustomer PRIMARY KEY,
	[CustomerID]   [nchar](5)    NOT NULL,  -- llave natural de NorthWind.Customers
	[CompanyName]  [varchar](40) NOT NULL,
	[ContactName]  [varchar](30) NULL,
	[ContactTitle] [varchar](30) NULL,
	[City]         [varchar](15) NULL,
	[Region]       [varchar](15) NULL,
	[Country]      [varchar](15) NULL
);
GO
