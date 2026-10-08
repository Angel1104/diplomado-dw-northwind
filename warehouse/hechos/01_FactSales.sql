-- Tabla de hechos. Fusiona Orders + OrderDetails (OLTP): cada fila representa
-- una linea de venta (un producto dentro de una orden), que es el nivel de
-- grano mas detallado disponible en el negocio.
CREATE TABLE [FactSales] (
    [SalesKey]     BIGINT  IDENTITY(1,1) NOT NULL,

    -- llaves foraneas hacia las dimensiones
    [OrderDateKey] INT     NOT NULL,  -- FK a DimDate (fecha del pedido)
    [CustomerKey]  INT     NOT NULL,  -- FK a DimCustomer
    [EmployeeKey]  INT     NOT NULL,  -- FK a DimEmployee
    [ProductKey]   INT     NOT NULL,  -- FK a DimProduct
    [ShipperKey]   INT     NULL,      -- FK a DimShipper

    -- llaves naturales del origen, utiles para trazabilidad y carga incremental
    [OrderID]      INT     NOT NULL,
    [ProductID]    INT     NOT NULL,

    -- medidas (hechos numericos)
    [Quantity]     SMALLINT NOT NULL,
    [UnitPrice]    MONEY    NOT NULL,
    [Discount]     REAL     NOT NULL,
    [LineTotal]    MONEY    NOT NULL,  -- Quantity * UnitPrice * (1 - Discount)
    [Freight]      MONEY    NULL,

    PRIMARY KEY ([SalesKey]),
    FOREIGN KEY ([OrderDateKey]) REFERENCES [DimDate]     ([DateKey]),
    FOREIGN KEY ([CustomerKey])  REFERENCES [DimCustomer] ([CustomerKey]),
    FOREIGN KEY ([EmployeeKey])  REFERENCES [DimEmployee] ([EmployeeKey]),
    FOREIGN KEY ([ProductKey])   REFERENCES [DimProduct]  ([ProductKey]),
    FOREIGN KEY ([ShipperKey])   REFERENCES [DimShipper]  ([ShipperKey])
);
