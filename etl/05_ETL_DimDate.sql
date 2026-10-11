-- ETL de DimDate: genera una fila por cada fecha que aparece en las
-- ordenes de NorthWind (OrderDate, RequiredDate, ShippedDate).
-- Responsable: Kevin
--
-- A diferencia de las demas dimensiones, DimDate no viene de una tabla
-- del OLTP: se GENERA a partir del rango de fechas que realmente se usan
-- en Orders, para no inventar fechas que nunca ocurren en el negocio.
--
-- Debe ejecutarse ANTES que el ETL de FactSales, porque FactSales
-- depende de que todas las fechas que necesita ya existan en DimDate.

USE NorthWindDW;
GO

-- Paso 1: calcular el rango de fechas real (minima y maxima) entre las
-- tres columnas de fecha de Orders.
-- TODO: usar una CTE o subconsulta que una (UNION) los valores de
--       OrderDate, RequiredDate y ShippedDate de NorthWind.dbo.Orders,
--       y calcule MIN() y MAX() sobre ese conjunto.


-- Paso 2: generar una fila por cada dia entre el minimo y el maximo,
-- calculando todas las columnas de DimDate (DateKey en formato AAAAMMDD,
-- DayNumberOfWeek, DayNameOfWeek, MonthName, CalendarQuarter, etc.)
-- TODO: usar una CTE recursiva (WITH ... AS, UNION ALL, DATEADD) para
--       generar la secuencia de fechas, y las funciones DATEPART/DATENAME
--       de SQL Server para derivar cada columna a partir de cada fecha.


-- Paso 3: insertar el resultado en DimDate (no requiere staging, porque
-- no viene de ningun sistema transaccional externo).
-- TODO: INSERT INTO dbo.DimDate (...) SELECT ...


-- Verificacion: cantidad de fechas generadas
-- TODO: SELECT COUNT(*) AS fechas_en_dimension FROM dbo.DimDate;
