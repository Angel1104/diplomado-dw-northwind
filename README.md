# Proyecto Data Warehouse — Base de Datos NorthWind

Diplomado en Ciencia de Datos — UMSS FCyT
Módulo II — Almacenamiento y Preparación de Datos
Docente: M.Sc. Juan Marcelo Claure Salinas

## Integrantes del grupo

- Angel Christian Flores Lazarte
- Daniela Zapata
- [pendiente de confirmar]

## Descripción

Este repositorio contiene dos proyectos de base de datos SQL Server construidos
a partir de la base de datos NorthWind provista para el proyecto final:

- **`oltp/`**: el esquema transaccional (OLTP) original de NorthWind, con las
  13 tablas normalizadas y sus llaves foráneas, extraído directamente de la
  base de datos restaurada a partir del archivo `NorthWind.bak` entregado.
- **`warehouse/`**: el modelo dimensional (modelo estrella) derivado del OLTP,
  compuesto por una tabla de hechos (`FactSales`) y cinco tablas de dimensión,
  diseñado para facilitar el análisis y reporte de ventas sin necesidad de
  múltiples joins.

## Diseño del modelo estrella

El punto de partida del diseño es la pregunta de negocio central de NorthWind:
**¿cuánto se vendió, de qué producto, a qué cliente, por qué empleado y en qué
fecha?** Esa pregunta define el grano de la tabla de hechos: una fila por cada
línea de detalle de una orden (un producto dentro de un pedido).

| Tabla OLTP de origen | Tabla del warehouse | Tipo | Transformación |
|---|---|---|---|
| `Orders` + `OrderDetails` | `FactSales` | Hechos | Se fusionan ambas tablas transaccionales en una sola fila de hecho (una línea de venta), con las medidas numéricas (cantidad, precio, descuento, total) y las llaves hacia cada dimensión. |
| `Customers` | `DimCustomer` | Dimensión | Se usa prácticamente tal cual, como catálogo de clientes. |
| `Employees` | `DimEmployee` | Dimensión | Se simplifica: se desnormaliza `FirstName`+`LastName` en `FullName` y se omite la jerarquía `ReportsTo`, que no aporta al análisis de ventas. |
| `Products` + `Categories` + `Suppliers` | `DimProduct` | Dimensión | Se fusionan las tres tablas en una sola: la categoría y el proveedor dejan de requerir un join y pasan a ser columnas del propio producto. |
| `Shippers` | `DimShipper` | Dimensión | Se usa tal cual. |
| *(no existe en el OLTP)* | `DimDate` | Dimensión | Se genera una dimensión de tiempo nueva, con una fila por cada fecha, para poder analizar las ventas por día, mes, trimestre, año y día de la semana sin depender de funciones de fecha en cada consulta. |

Esta transformación reduce drásticamente la cantidad de *joins* necesarios para
un reporte típico: en el OLTP, un reporte de "ventas por categoría y país del
proveedor" requiere unir `OrderDetails`, `Orders`, `Products`, `Categories` y
`Suppliers` (5 tablas); en el warehouse, la misma pregunta se responde uniendo
únicamente `FactSales` y `DimProduct` (2 tablas).

## Estructura del repositorio

```
oltp/
└── tables/
    ├── 01_Categories.sql ... 13_EmployeeTerritories.sql   (una tabla por archivo)
    └── 14_Constraints.sql                                  (las 13 llaves foráneas)

warehouse/
├── 00_create_database.sql
├── dimensiones/
│   ├── 01_DimDate.sql
│   ├── 02_DimCustomer.sql
│   ├── 03_DimEmployee.sql
│   ├── 04_DimProduct.sql
│   └── 05_DimShipper.sql
└── hechos/
    └── 01_FactSales.sql
```

## Cómo usar los scripts

Cada archivo `.sql` contiene la sentencia `CREATE TABLE` de una tabla. Se
ejecutan en el orden numerado dentro de cada carpeta para respetar las
dependencias de llaves foráneas (en `oltp/tables`, las tablas sin dependencias
van primero; en `warehouse`, las dimensiones se crean antes que la tabla de
hechos, que depende de todas ellas).

Todos los scripts fueron generados y validados ejecutándolos contra una
instancia real de SQL Server 2022 (en contenedor Docker), confirmando que las
13 tablas del OLTP y las 6 tablas del warehouse se crean sin errores con sus
llaves primarias y foráneas correspondientes.
