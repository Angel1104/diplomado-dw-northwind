-- Vista de ejemplo (ya resuelta y validada): ventas totales por categoria
-- de producto y pais del proveedor, por anio.
--
-- Responde la misma pregunta de negocio usada en analisis/comparacion-joins.sql,
-- pero como una vista reutilizable: en vez de escribir el JOIN cada vez,
-- cualquiera puede hacer SELECT * FROM dbo.vw_VentasPorCategoria.
--
-- Sirve de guia para las demas vistas de reporte.

USE NorthWindDW;
GO

CREATE VIEW dbo.vw_VentasPorCategoria AS
SELECT
    dp.CategoryName,
    dp.SupplierCountry,
    YEAR(f.OrderDate)      AS Anio,
    SUM(f.Quantity)        AS UnidadesVendidas,
    SUM(f.LineTotal)       AS TotalVentas
FROM dbo.FactSales f
INNER JOIN dbo.DimProduct dp ON f.ProductSK = dp.ProductSK
GROUP BY
    dp.CategoryName,
    dp.SupplierCountry,
    YEAR(f.OrderDate);
GO

-- Verificacion: consultar la vista
SELECT TOP 10 * FROM dbo.vw_VentasPorCategoria ORDER BY TotalVentas DESC;
GO
