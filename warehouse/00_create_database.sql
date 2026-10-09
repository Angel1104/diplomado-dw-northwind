-- Crea la base de datos del data warehouse.
-- Ejecutar primero, antes de los scripts de staging/, dimensiones/ y hechos/.
CREATE DATABASE NorthWindDW;
GO

USE NorthWindDW;
GO

CREATE SCHEMA staging;
GO
