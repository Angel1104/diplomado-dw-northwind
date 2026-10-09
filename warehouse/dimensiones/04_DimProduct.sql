-- Dimension de producto. Fusiona (desnormaliza) Products + Categories + Suppliers,
-- que en el OLTP son tres tablas separadas unidas por FK. Aqui se absorben como
-- columnas del mismo registro para evitar joins en las consultas de reporte.
CREATE TABLE [dbo].[DimProduct]
(
	[ProductSK]       [int]         IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimProduct PRIMARY KEY,
	[ProductID]       [int]         NOT NULL,  -- llave natural de NorthWind.Products
	[ProductName]     [varchar](40) NOT NULL,
	[CategoryName]    [varchar](15) NULL,      -- absorbido de Categories
	[SupplierName]    [varchar](40) NULL,      -- absorbido de Suppliers
	[SupplierCountry] [varchar](15) NULL,      -- absorbido de Suppliers
	[ListPrice]       [money]       NULL,
	[Discontinued]    [bit]         NOT NULL
);
GO
