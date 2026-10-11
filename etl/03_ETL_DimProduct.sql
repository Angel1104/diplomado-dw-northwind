-- ETL: NorthWind.Products + Categories + Suppliers -> staging.product -> dbo.DimProduct
-- Responsable: Daniela Zapata
--
-- Este es un poco mas complejo que DimCustomer: hay que UNIR (JOIN) tres
-- tablas del OLTP para armar cada fila de staging, porque DimProduct
-- desnormaliza (fusiona) Products + Categories + Suppliers.
--
-- Columnas de destino: ProductSK, ProductID, ProductName, CategoryName,
-- SupplierName, SupplierCountry, ListPrice, Discontinued

USE NorthWindDW;
GO

-- Paso 1: limpiar staging antes de cada carga
TRUNCATE TABLE staging.product;
GO

-- Paso 2: cargar staging
-- TODO: completar el INSERT INTO staging.product (...) SELECT ...
--       FROM NorthWind.dbo.Products p
--       INNER JOIN NorthWind.dbo.Categories c ON p.CategoryID = c.CategoryID
--       INNER JOIN NorthWind.dbo.Suppliers  s ON p.SupplierID = s.SupplierID
--       usando ROW_NUMBER() OVER (ORDER BY p.ProductID) para ProductSK.
--       CategoryName viene de c.CategoryName, SupplierName y SupplierCountry
--       vienen de s.CompanyName y s.Country.


-- Paso 3: fusionar (MERGE) desde staging hacia la dimension final en dbo
-- TODO: completar el MERGE dbo.DimProduct AS target USING staging.product AS source
--       ON target.ProductID = source.ProductID


-- Verificacion: cantidad de filas cargadas
-- TODO: SELECT COUNT(*) AS productos_en_dimension FROM dbo.DimProduct;
