-- Reto 1: Entender el negocio a traves de los datos
-- Responsable: Daniela Zapata
--
-- Completar cada consulta y pegar su resultado (o un resumen) en
-- reto1-entender-negocio.md, punto 4.

-- Cuantos clientes, productos, ordenes y empleados tiene la base
SELECT
    (SELECT COUNT(*) FROM Customers)  AS total_customers,
    (SELECT COUNT(*) FROM Products)   AS total_products,
    (SELECT COUNT(*) FROM Orders)     AS total_orders,
    (SELECT COUNT(*) FROM Employees)  AS total_employees;

-- 5 paises con mas clientes
SELECT TOP 5 Country, COUNT(*) AS total_clientes
FROM Customers
GROUP BY Country
ORDER BY total_clientes DESC;

-- Producto mas vendido por cantidad, y el que genera mas ingresos
-- (completar: unir OrderDetails + Products, agrupar por producto,
-- ordenar primero por SUM(Quantity) y luego por SUM(UnitPrice*Quantity*(1-Discount)))


-- Ordenes sin fecha de envio
SELECT COUNT(*) AS ordenes_sin_enviar
FROM Orders
WHERE ShippedDate IS NULL;

-- Empleado con mas ventas registradas a su cargo
-- (completar: unir Orders + Employees, agrupar por empleado, contar ordenes)
