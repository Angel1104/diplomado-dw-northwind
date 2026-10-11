# Reportes — vistas SQL sobre el warehouse

Vistas (`CREATE VIEW`) que responden preguntas de negocio directamente sobre
`NorthWindDW`, demostrando la ganancia real de tener el modelo estrella: cada
vista es un `SELECT` simple, de pocas líneas, sin necesidad de repetir joins
contra el esquema OLTP original.

Requieren que el ETL (carpeta `etl/`) ya se haya ejecutado, para que
`FactSales` y las dimensiones tengan datos.

## Vistas

1. `01_vw_VentasPorCategoria.sql` — **ya resuelta y validada**, sirve de guía.
2. `02_vw_TopClientes.sql` — Daniela
3. `03_vw_VentasPorEmpleado.sql` — Kevin
