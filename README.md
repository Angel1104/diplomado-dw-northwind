# Proyecto Data Warehouse — Base de Datos NorthWind

Diplomado en Ciencia de Datos — UMSS FCyT
Módulo II — Almacenamiento y Preparación de Datos
Docente: M.Sc. Juan Marcelo Claure Salinas

## Integrantes del grupo

- **Angel Christian Flores Lazarte** ([Angel1104](https://github.com/Angel1104)) — diseño del esquema OLTP y del modelo estrella, scripts SQL base, ETL de `DimCustomer` (guía), validación contra SQL Server.
- **[Nombre completo pendiente]** ([DanieZapata](https://github.com/DanieZapata)) — Reto 1 (entender el negocio a través de los datos), ETL de `DimEmployee` y `DimProduct`, proyecto SQL Server (`.sqlproj`) del esquema OLTP.
- **[Nombre completo pendiente]** ([kevdev21](https://github.com/kevdev21)) — justificación del diseño del modelo estrella, ETL de `DimShipper`, `DimDate` y `FactSales`, proyecto SQL Server (`.sqlproj`) del warehouse.

## Flujo de trabajo del grupo

Cada integrante trabaja en su propia rama y entrega su parte mediante un
Pull Request hacia `main`:

- `feature/reto1-dani` (Daniela): responde el análisis de negocio en
  [`analisis/reto1-entender-negocio.md`](./analisis/reto1-entender-negocio.md),
  completa los ETL de [`etl/02_ETL_DimEmployee.sql`](./etl/02_ETL_DimEmployee.sql)
  y [`etl/03_ETL_DimProduct.sql`](./etl/03_ETL_DimProduct.sql) siguiendo el
  ejemplo ya resuelto en `etl/01_ETL_DimCustomer.sql`, completa la vista
  [`reportes/02_vw_TopClientes.sql`](./reportes/02_vw_TopClientes.sql), y
  luego crea un SQL Server Database Project en Visual Studio importando el
  esquema OLTP ya validado en `oltp/tables/`.
- `feature/justificacion-kevin` (Kevin): responde la justificación del modelo
  en [`analisis/justificacion-modelo-estrella.md`](./analisis/justificacion-modelo-estrella.md),
  completa los ETL de [`etl/04_ETL_DimShipper.sql`](./etl/04_ETL_DimShipper.sql),
  [`etl/05_ETL_DimDate.sql`](./etl/05_ETL_DimDate.sql) y
  [`etl/06_ETL_FactSales.sql`](./etl/06_ETL_FactSales.sql) (el más complejo,
  ver [`etl/README.md`](./etl/README.md) para el orden correcto), completa
  la vista [`reportes/03_vw_VentasPorEmpleado.sql`](./reportes/03_vw_VentasPorEmpleado.sql),
  y luego crea un SQL Server Database Project en Visual Studio con las
  tablas ya validadas en `warehouse/` (staging, dimensiones y hechos).

## Descripción

Este repositorio contiene dos proyectos de base de datos SQL Server construidos
a partir de la base de datos NorthWind provista para el proyecto final:

- **`oltp/`**: el esquema transaccional (OLTP) original de NorthWind, con las
  13 tablas normalizadas y sus llaves foráneas, extraído directamente de la
  base de datos restaurada a partir del archivo `NorthWind.bak` entregado.
- **`warehouse/`**: el modelo dimensional (modelo estrella) derivado del OLTP,
  compuesto por una tabla de hechos (`FactSales`), cinco tablas de dimensión y
  un esquema `staging` de transición para el ETL, diseñado para facilitar el
  análisis y reporte de ventas sin necesidad de múltiples *joins*.

El diseño y la nomenclatura del warehouse siguen el proyecto guía provisto por
el docente ([mclaure/Data-Management-and-BI](https://github.com/mclaure/Data-Management-and-BI),
solución `BikeStoresBI`), adaptado de la base de datos BikeStores a NorthWind.

## Diseño del modelo estrella

El punto de partida del diseño es la pregunta de negocio central de NorthWind:
**¿cuánto se vendió, de qué producto, a qué cliente, por qué empleado, a través
de qué transportista y en qué fecha?** Esa pregunta define el grano de la tabla
de hechos: una fila por cada línea de detalle de una orden (un producto dentro
de un pedido).

| Tabla OLTP de origen | Tabla del warehouse | Tipo | Transformación |
|---|---|---|---|
| `Orders` + `OrderDetails` | `FactSales` | Hechos | Se fusionan ambas tablas transaccionales en una sola fila de hecho (una línea de venta), con las medidas numéricas (cantidad, precio, descuento, total) y las llaves hacia cada dimensión. Siguiendo el patrón del proyecto guía (`FactOrders`), se conservan las tres fechas de negocio de la orden (`OrderDate`, `RequiredDate`, `ShippedDate`), cada una con su propia llave hacia `DimDate`. |
| `Customers` | `DimCustomer` | Dimensión | Se usa prácticamente tal cual, como catálogo de clientes. |
| `Employees` | `DimEmployee` | Dimensión | Se simplifica: se omite la jerarquía `ReportsTo`, propia de un modelo OLTP, que no aporta al análisis de ventas. |
| `Products` + `Categories` + `Suppliers` | `DimProduct` | Dimensión | Se fusionan las tres tablas en una sola: la categoría y el proveedor dejan de requerir un *join* y pasan a ser columnas del propio producto. |
| `Shippers` | `DimShipper` | Dimensión | Se usa tal cual. |
| *(no existe en el OLTP)* | `DimDate` | Dimensión | Se genera una dimensión de tiempo nueva, con una fila por cada fecha, para poder analizar las ventas por día, mes, trimestre, semestre y año sin depender de funciones de fecha en cada consulta. |

Esta transformación reduce drásticamente la cantidad de *joins* necesarios para
un reporte típico: en el OLTP, un reporte de "ventas por categoría y país del
proveedor" requiere unir `OrderDetails`, `Orders`, `Products`, `Categories` y
`Suppliers` (5 tablas); en el warehouse, la misma pregunta se responde uniendo
únicamente `FactSales` y `DimProduct` (2 tablas).

### Esquema `staging`

Siguiendo también el proyecto guía, cada dimensión tiene una tabla espejo en el
esquema `staging` (`staging.customer`, `staging.employee`, `staging.product`,
`staging.shipper`), sin `IDENTITY`: es la zona intermedia donde el proceso ETL
deposita los datos ya transformados y con su *surrogate key* resuelta, antes de
fusionarlos (`MERGE`) con la dimensión final en `dbo`.

### Convención de nombres

Siguiendo el estilo del proyecto guía, dentro del warehouse las tablas y
columnas usan `PascalCase` (ej. `CustomerSK`, `FirstName`), a diferencia del
esquema OLTP de NorthWind, que usa `PascalCase` para tablas pero mantiene los
nombres originales de sus columnas. La *surrogate key* de cada dimensión usa
el sufijo `SK` (`CustomerSK`, `ProductSK`, etc.), mientras que la llave natural
del sistema de origen conserva su nombre original (`CustomerID`, `ProductID`).

## Estructura del repositorio

```
oltp/
└── tables/
    ├── 01_Categories.sql ... 13_EmployeeTerritories.sql   (una tabla por archivo)
    └── 14_Constraints.sql                                  (las 13 llaves foráneas)

warehouse/
├── 00_create_database.sql       (crea la base NorthWindDW y el esquema staging)
├── staging/
│   ├── staging.customer.sql
│   ├── staging.employee.sql
│   ├── staging.product.sql
│   └── staging.shipper.sql
├── dimensiones/
│   ├── 01_DimDate.sql
│   ├── 02_DimCustomer.sql
│   ├── 03_DimEmployee.sql
│   ├── 04_DimProduct.sql
│   └── 05_DimShipper.sql
└── hechos/
    └── 01_FactSales.sql

etl/
├── README.md                     (orden de ejecución y responsables)
├── 01_ETL_DimCustomer.sql        (resuelto: sirve de guía)
├── 02_ETL_DimEmployee.sql
├── 03_ETL_DimProduct.sql
├── 04_ETL_DimShipper.sql
├── 05_ETL_DimDate.sql
└── 06_ETL_FactSales.sql

analisis/
├── reto1-entender-negocio.md + reto1-queries.sql
└── justificacion-modelo-estrella.md + comparacion-joins.sql

reportes/
├── README.md
├── 01_vw_VentasPorCategoria.sql  (resuelta: sirve de guía)
├── 02_vw_TopClientes.sql
└── 03_vw_VentasPorEmpleado.sql
```

## Cómo usar los scripts

Cada archivo `.sql` contiene la sentencia `CREATE TABLE` de una tabla. Se
ejecutan en el orden numerado dentro de cada carpeta para respetar las
dependencias de llaves foráneas: primero `oltp/tables` (las tablas sin
dependencias van primero, y `14_Constraints.sql` al final); luego, en
`warehouse`, `00_create_database.sql`, después `staging/`, después
`dimensiones/` y finalmente `hechos/`, que depende de todas las dimensiones.

Todos los scripts fueron generados y validados ejecutándolos contra una
instancia real de SQL Server 2022 (en contenedor Docker), confirmando que las
13 tablas del OLTP y las 10 tablas del warehouse (6 en `dbo` + 4 en `staging`)
se crean sin errores con sus llaves primarias y foráneas correspondientes.
