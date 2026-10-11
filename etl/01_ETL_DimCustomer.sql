-- ETL de ejemplo (ya resuelto): NorthWind.Customers -> staging.customer -> dbo.DimCustomer
--
-- Sirve de guia para los demas ETL de dimensiones (DimEmployee, DimProduct,
-- DimShipper): el patron es siempre el mismo, solo cambian las columnas.
--
-- Requiere que la base NorthWind (OLTP) y NorthWindDW (warehouse) existan
-- en el mismo servidor, para poder referenciarlas con el nombre de base
-- calificado (NorthWind.dbo.Customers).

USE NorthWindDW;
GO

-- Paso 1: limpiar staging antes de cada carga
TRUNCATE TABLE staging.customer;
GO

-- Paso 2: cargar staging asignando la surrogate key de forma secuencial
-- (ROW_NUMBER simula el IDENTITY que tendria la tabla final en dbo)
INSERT INTO staging.customer (CustomerSK, CustomerID, CompanyName, ContactName, ContactTitle, City, Region, Country)
SELECT
    ROW_NUMBER() OVER (ORDER BY CustomerID) AS CustomerSK,
    CustomerID,
    CompanyName,
    ContactName,
    ContactTitle,
    City,
    Region,
    Country
FROM NorthWind.dbo.Customers;
GO

-- Paso 3: fusionar (MERGE) desde staging hacia la dimension final en dbo
-- Esto permite que corridas futuras del ETL actualicen clientes existentes
-- e inserten los nuevos, sin duplicar.
MERGE dbo.DimCustomer AS target
USING staging.customer AS source
ON target.CustomerID = source.CustomerID
WHEN MATCHED THEN
    UPDATE SET
        target.CompanyName  = source.CompanyName,
        target.ContactName  = source.ContactName,
        target.ContactTitle = source.ContactTitle,
        target.City         = source.City,
        target.Region       = source.Region,
        target.Country      = source.Country
WHEN NOT MATCHED BY TARGET THEN
    INSERT (CustomerID, CompanyName, ContactName, ContactTitle, City, Region, Country)
    VALUES (source.CustomerID, source.CompanyName, source.ContactName, source.ContactTitle, source.City, source.Region, source.Country);
GO

-- Verificacion: cantidad de filas cargadas
SELECT COUNT(*) AS clientes_en_dimension FROM dbo.DimCustomer;
GO
