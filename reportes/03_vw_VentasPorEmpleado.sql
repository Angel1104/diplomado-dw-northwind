-- Vista de reporte: desempeño de ventas por empleado.
-- Responsable: Kevin
--
-- Seguir el patron de 01_vw_VentasPorCategoria.sql (ya resuelta y validada).
--
-- Pregunta de negocio: ¿que empleado genera mas ventas, y cual es su
-- ticket promedio por orden?

USE NorthWindDW;
GO

-- TODO: completar
-- CREATE VIEW dbo.vw_VentasPorEmpleado AS
-- SELECT
--     de.FirstName,
--     de.LastName,
--     de.Title,
--     COUNT(DISTINCT f.OrderID) AS CantidadOrdenes,
--     SUM(f.LineTotal)          AS TotalVentas,
--     AVG(f.LineTotal)          AS TicketPromedio
-- FROM dbo.FactSales f
-- INNER JOIN dbo.DimEmployee de ON f.EmployeeSK = de.EmployeeSK
-- GROUP BY de.FirstName, de.LastName, de.Title;
-- GO

-- Verificacion: ranking de empleados por total vendido
-- TODO: SELECT * FROM dbo.vw_VentasPorEmpleado ORDER BY TotalVentas DESC;
