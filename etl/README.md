# ETL — Carga de datos del OLTP al warehouse

Esta carpeta contiene los scripts que migran los datos reales desde
`NorthWind` (OLTP) hacia `NorthWindDW` (warehouse), a través de las tablas
`staging` y usando `MERGE` para evitar duplicados en cargas repetidas.

## Orden de ejecución

1. `01_ETL_DimCustomer.sql` — **ya resuelto y probado**, sirve de guía para los demás.
2. `02_ETL_DimEmployee.sql` — Daniela
3. `03_ETL_DimProduct.sql` — Daniela
4. `04_ETL_DimShipper.sql` — Kevin
5. `05_ETL_DimDate.sql` — Kevin (debe ejecutarse antes del punto 6)
6. `06_ETL_FactSales.sql` — Kevin (depende de que las 5 dimensiones ya estén cargadas)

## Validación

Cada script termina con una consulta de verificación que cuenta cuántas
filas quedaron cargadas en la tabla destino. Al completar un ETL, ejecutarlo
contra el servidor y confirmar que el conteo tiene sentido (por ejemplo,
`DimEmployee` debería tener la misma cantidad de filas que `Employees` en
el OLTP).
