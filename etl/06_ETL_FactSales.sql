-- ETL: NorthWind.Orders + OrderDetails -> dbo.FactSales
-- Responsable: Kevin
--
-- Es el ETL mas complejo del warehouse, porque FactSales depende de
-- TODAS las demas dimensiones (deben estar cargadas antes de correr esto:
-- DimDate, DimCustomer, DimEmployee, DimProduct, DimShipper).
--
-- Por cada linea de detalle de una orden (OrderDetails), hay que resolver:
--   - OrderDateKey, RequiredDateKey: buscando la fecha en DimDate y
--     tomando su DateKey (join por FullDate)
--   - CustomerSK, EmployeeSK, ProductSK, ShipperSK: buscando la llave
--     natural (CustomerID, EmployeeID, ProductID, ShipVia) en cada
--     dimension y tomando su surrogate key
--
-- No se usa staging aqui: FactSales se carga directo desde el OLTP
-- haciendo los JOIN necesarios contra las dimensiones ya cargadas.

USE NorthWindDW;
GO

-- Paso 1: vaciar la tabla de hechos antes de cada carga completa
-- TODO: TRUNCATE TABLE dbo.FactSales;


-- Paso 2: insertar resolviendo cada llave foranea con un JOIN
-- TODO: completar el INSERT INTO dbo.FactSales (...)
--       SELECT
--           o.OrderID, od.ProductID,
--           dOrder.DateKey    AS OrderDateKey,
--           dRequired.DateKey AS RequiredDateKey,
--           dShipped.DateKey  AS ShippedDateKey,
--           dc.CustomerSK, de.EmployeeSK, dp.ProductSK, ds.ShipperSK,
--           o.OrderDate, o.RequiredDate, o.ShippedDate,
--           od.Quantity, od.UnitPrice, od.Discount,
--           od.Quantity * od.UnitPrice * (1 - od.Discount) AS LineTotal,
--           o.Freight
--       FROM NorthWind.dbo.Orders o
--       INNER JOIN NorthWind.dbo.[Order Details... o el nombre real de
--           detalle que uses] od ON o.OrderID = od.OrderID
--       INNER JOIN dbo.DimDate dOrder    ON CAST(o.OrderDate AS date) = dOrder.FullDate
--       INNER JOIN dbo.DimDate dRequired ON CAST(o.RequiredDate AS date) = dRequired.FullDate
--       LEFT  JOIN dbo.DimDate dShipped  ON CAST(o.ShippedDate AS date) = dShipped.FullDate
--           -- LEFT JOIN porque ShippedDate puede ser NULL (orden aun no enviada)
--       LEFT JOIN dbo.DimCustomer dc ON o.CustomerID = dc.CustomerID
--       LEFT JOIN dbo.DimEmployee de ON o.EmployeeID = de.EmployeeID
--       LEFT JOIN dbo.DimProduct  dp ON od.ProductID = dp.ProductID
--       LEFT JOIN dbo.DimShipper  ds ON o.ShipVia = ds.ShipperID;
--
-- Nota: revisa el nombre real de la tabla de detalle de orden en tu copia
-- de NorthWind (puede ser "Order Details" con espacio, u "OrderDetails").


-- Verificacion: cantidad de lineas de venta cargadas, y que coincida
-- aproximadamente con la cantidad de filas de OrderDetails en el OLTP.
-- TODO: SELECT COUNT(*) AS lineas_en_fact FROM dbo.FactSales;
-- TODO: SELECT COUNT(*) AS lineas_en_oltp FROM NorthWind.dbo.[OrderDetails];
