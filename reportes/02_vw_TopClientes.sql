-- Vista de reporte: top clientes por monto total comprado.
-- Responsable: Daniela Zapata
--
-- Seguir el patron de 01_vw_VentasPorCategoria.sql (ya resuelta y validada):
-- una vista es simplemente un SELECT guardado con nombre, que encapsula
-- un JOIN + GROUP BY para no repetirlo cada vez.
--
-- Pregunta de negocio: ¿quienes son los clientes que mas han comprado,
-- en monto total y en cantidad de ordenes distintas?

USE NorthWindDW;
GO

-- TODO: completar
-- CREATE VIEW dbo.vw_TopClientes AS
-- SELECT
--     dc.CompanyName,
--     dc.Country,
--     COUNT(DISTINCT f.OrderID) AS CantidadOrdenes,
--     SUM(f.LineTotal)          AS TotalComprado
-- FROM dbo.FactSales f
-- INNER JOIN dbo.DimCustomer dc ON f.CustomerSK = dc.CustomerSK
-- GROUP BY dc.CompanyName, dc.Country;
-- GO

-- Verificacion: los 10 clientes que mas compraron
-- TODO: SELECT TOP 10 * FROM dbo.vw_TopClientes ORDER BY TotalComprado DESC;
