-- Tabla de staging para la carga del ETL hacia DimShipper.
CREATE TABLE [staging].[shipper]
(
	[ShipperSK]   [int]         NOT NULL,
	[ShipperID]   [int]         NOT NULL,
	[CompanyName] [varchar](40) NOT NULL
);
GO
