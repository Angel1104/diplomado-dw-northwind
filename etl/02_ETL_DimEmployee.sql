-- ETL: NorthWind.Employees -> staging.employee -> dbo.DimEmployee
-- Responsable: Daniela Zapata
--
-- Seguir el mismo patron de 01_ETL_DimCustomer.sql (que ya esta resuelto
-- y probado), adaptando las columnas a DimEmployee:
--   EmployeeSK, EmployeeID, FirstName, LastName, Title, City, Country
--
-- Pasos a completar (reemplazar cada TODO):

USE NorthWindDW;
GO

-- Paso 1: limpiar staging antes de cada carga
TRUNCATE TABLE staging.employee;
GO

-- Paso 2: cargar staging asignando la surrogate key de forma secuencial
-- TODO: completar el INSERT INTO staging.employee (...) SELECT ... FROM NorthWind.dbo.Employees
--       usando ROW_NUMBER() OVER (ORDER BY EmployeeID) para EmployeeSK,
--       igual que se hizo con CustomerSK en el ejemplo de DimCustomer.


-- Paso 3: fusionar (MERGE) desde staging hacia la dimension final en dbo
-- TODO: completar el MERGE dbo.DimEmployee AS target USING staging.employee AS source
--       ON target.EmployeeID = source.EmployeeID
--       (mismo patron que DimCustomer: WHEN MATCHED -> UPDATE, WHEN NOT MATCHED -> INSERT)


-- Verificacion: cantidad de filas cargadas
-- TODO: SELECT COUNT(*) AS empleados_en_dimension FROM dbo.DimEmployee;
