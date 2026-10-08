-- Dimension de transportista. Derivada directamente de Shippers (OLTP).
CREATE TABLE [DimShipper] (
    [ShipperKey]  INT          IDENTITY(1,1) NOT NULL,
    [ShipperID]   INT          NOT NULL,  -- llave natural
    [CompanyName] NVARCHAR(40) NOT NULL,
    PRIMARY KEY ([ShipperKey])
);
