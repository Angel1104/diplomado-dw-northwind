-- ETL: NorthWind.Shippers -> staging.shipper -> dbo.DimShipper
-- Responsable: Kevin
--
-- Es el ETL mas simple del warehouse: igual de directo que DimCustomer
-- (ver 01_ETL_DimCustomer.sql como guia), solo con menos columnas.
--
-- Columnas de destino: ShipperSK, ShipperID, CompanyName

USE NorthWindDW;
GO

-- Paso 1: limpiar staging antes de cada carga
TRUNCATE TABLE staging.shipper;
GO

-- Paso 2: cargar staging asignando la surrogate key de forma secuencial
-- TODO: completar el INSERT INTO staging.shipper (...) SELECT ... FROM NorthWind.dbo.Shippers
--       usando ROW_NUMBER() OVER (ORDER BY ShipperID) para ShipperSK.


-- Paso 3: fusionar (MERGE) desde staging hacia la dimension final en dbo
-- TODO: completar el MERGE dbo.DimShipper AS target USING staging.shipper AS source
--       ON target.ShipperID = source.ShipperID


-- Verificacion: cantidad de filas cargadas
-- TODO: SELECT COUNT(*) AS transportistas_en_dimension FROM dbo.DimShipper;
