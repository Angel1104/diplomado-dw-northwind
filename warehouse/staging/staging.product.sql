-- Tabla de staging para la carga del ETL hacia DimProduct.
CREATE TABLE [staging].[product]
(
	[ProductSK]       [int]         NOT NULL,
	[ProductID]       [int]         NOT NULL,
	[ProductName]     [varchar](40) NOT NULL,
	[CategoryName]    [varchar](15) NULL,
	[SupplierName]    [varchar](40) NULL,
	[SupplierCountry] [varchar](15) NULL,
	[ListPrice]       [money]       NULL,
	[Discontinued]    [bit]         NOT NULL
);
GO
