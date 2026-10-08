-- Dimension de producto. Fusiona (desnormaliza) Products + Categories + Suppliers,
-- que en el OLTP son tres tablas separadas unidas por FK. Aqui se absorben como
-- columnas del mismo registro para evitar joins en las consultas de reporte.
CREATE TABLE [DimProduct] (
    [ProductKey]     INT          IDENTITY(1,1) NOT NULL,
    [ProductID]      INT          NOT NULL,  -- llave natural
    [ProductName]    NVARCHAR(40) NOT NULL,
    [CategoryName]   NVARCHAR(15) NULL,      -- absorbido de Categories
    [SupplierName]   NVARCHAR(40) NULL,      -- absorbido de Suppliers
    [SupplierCountry] NVARCHAR(15) NULL,     -- absorbido de Suppliers
    [UnitPrice]      MONEY        NULL,
    [Discontinued]   BIT          NOT NULL,
    PRIMARY KEY ([ProductKey])
);
