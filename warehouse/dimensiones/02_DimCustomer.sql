-- Dimension de cliente. Derivada directamente de Customers (OLTP).
CREATE TABLE [DimCustomer] (
    [CustomerKey]  INT          IDENTITY(1,1) NOT NULL,
    [CustomerID]   NCHAR(5)     NOT NULL,  -- llave natural, para rastrear el origen
    [CompanyName]  NVARCHAR(40) NOT NULL,
    [ContactName]  NVARCHAR(30) NULL,
    [ContactTitle] NVARCHAR(30) NULL,
    [City]         NVARCHAR(15) NULL,
    [Region]       NVARCHAR(15) NULL,
    [Country]      NVARCHAR(15) NULL,
    PRIMARY KEY ([CustomerKey])
);
