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
--       LEFT JOIN dbo.DimCustomer dc ON o.CustomerID COLLATE DATABASE_DEFAULT = dc.CustomerID COLLATE DATABASE_DEFAULT
--       LEFT JOIN dbo.DimEmployee de ON o.EmployeeID = de.EmployeeID
--       LEFT JOIN dbo.DimProduct  dp ON od.ProductID = dp.ProductID
--       LEFT JOIN dbo.DimShipper  ds ON o.ShipVia = ds.ShipperID;
--
-- Nota 1: la tabla de detalle de orden se llama "OrderDetails" (sin espacio)
-- en esta copia restaurada de NorthWind.
--
-- Nota 2 (importante): NorthWind y NorthWindDW pueden quedar con distinto
-- collation (confirmado: NorthWind usa Modern_Spanish_CI_AS, NorthWindDW
-- usa SQL_Latin1_General_CP1_CI_AS). Comparar columnas de texto entre
-- ambas bases (como CustomerID, que es nchar) sin COLLATE produce el
-- error "Cannot resolve the collation conflict". Por eso el JOIN con
-- DimCustomer usa COLLATE DATABASE_DEFAULT en ambos lados, como se ve
-- arriba. Si te aparece ese mismo error en otro JOIN de texto, aplica el
-- mismo arreglo ahi.


-- Verificacion: cantidad de lineas de venta cargadas, y que coincida
-- aproximadamente con la cantidad de filas de OrderDetails en el OLTP.
-- TODO: SELECT COUNT(*) AS lineas_en_fact FROM dbo.FactSales;
-- TODO: SELECT COUNT(*) AS lineas_en_oltp FROM NorthWind.dbo.[OrderDetails];
