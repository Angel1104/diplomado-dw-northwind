-- Tabla de hechos. Fusiona Orders + OrderDetails (OLTP): cada fila representa
-- una linea de venta (un producto dentro de una orden), que es el nivel de
-- grano mas detallado disponible en el negocio.
-- Estructura siguiendo el proyecto guia del docente
-- (mclaure/Data-Management-and-BI, BikeStoresDW.FactOrders): tres fechas de
-- negocio (pedido, requerida, envio), cada una con su propia FK a DimDate.
CREATE TABLE [dbo].[FactSales]
(
	[OrderID]         [int]      NOT NULL,
	[ProductID]       [int]      NOT NULL,

	[OrderDateKey]    [int]      NOT NULL,
	[RequiredDateKey] [int]      NOT NULL,
	[ShippedDateKey]  [int]      NULL,

	[CustomerSK]      [int]      NULL,
	[EmployeeSK]      [int]      NULL,
	[ProductSK]       [int]      NULL,
	[ShipperSK]       [int]      NULL,

	[OrderDate]       [date]     NOT NULL,
	[RequiredDate]    [date]     NOT NULL,
	[ShippedDate]     [date]     NULL,

	[Quantity]        [smallint] NOT NULL,
	[UnitPrice]       [money]    NOT NULL,
	[Discount]        [real]     NOT NULL,
	[LineTotal]       [money]    NOT NULL,  -- calculado por el ETL: Quantity * UnitPrice * (1 - Discount)
	[Freight]         [money]    NULL
);
GO

ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT PK_FactSales PRIMARY KEY(OrderID,ProductID);
GO

ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_DimCustomer] FOREIGN KEY([CustomerSK]) REFERENCES [dbo].[DimCustomer] ([CustomerSK]);
GO

ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_DimEmployee] FOREIGN KEY([EmployeeSK]) REFERENCES [dbo].[DimEmployee] ([EmployeeSK]);
GO

ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_DimProduct] FOREIGN KEY([ProductSK]) REFERENCES [dbo].[DimProduct] ([ProductSK]);
GO

ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_DimShipper] FOREIGN KEY([ShipperSK]) REFERENCES [dbo].[DimShipper] ([ShipperSK]);
GO

ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_DimDate_OrderDate] FOREIGN KEY([OrderDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);
GO

ALTER TABLE [dbo].[FactSales] ADD CONSTRAINT [FK_DimDate_RequiredDate] FOREIGN KEY([RequiredDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);
GO
