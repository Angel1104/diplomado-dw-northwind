-- Dimension de transportista. Derivada directamente de Shippers (OLTP).
CREATE TABLE [dbo].[DimShipper]
(
	[ShipperSK]   [int]         IDENTITY(1,1) NOT NULL CONSTRAINT PK_DimShipper PRIMARY KEY,
	[ShipperID]   [int]         NOT NULL,  -- llave natural de NorthWind.Shippers
	[CompanyName] [varchar](40) NOT NULL
);
GO
