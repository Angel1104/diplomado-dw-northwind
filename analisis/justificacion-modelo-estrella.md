# Justificación del modelo estrella

**Responsable:** Kevin ([kevdev21](https://github.com/kevdev21))

## Objetivo

El esquema en `warehouse/` ya está diseñado e implementado. Este documento no
pide rediseñarlo, sino **justificar con criterio propio** por qué cada tabla
quedó clasificada como tabla de hechos o como dimensión, y cuantificar la
ganancia real de hacerlo así frente al esquema OLTP original.

## Preguntas a responder

1. **¿Por qué `FactSales` es la tabla de hechos y no, por ejemplo, `DimProduct`?**
   Explicar con tus propias palabras qué distingue a una tabla de hechos de
   una de dimensión (pista: una registra eventos/medidas numéricas que
   ocurren en el tiempo, la otra describe atributos descriptivos que casi no
   cambian).

2. **Para cada dimensión, justificar la fusión realizada:**
   - `DimProduct` fusiona `Products` + `Categories` + `Suppliers`. ¿Qué joins
     del OLTP se evitan al consultar el warehouse en vez del OLTP?
   - `DimCustomer`, `DimEmployee`, `DimShipper`: ¿por qué estas sí pudieron
     quedar casi tal cual, sin fusionar varias tablas?
   - `DimDate`: no existe en el OLTP. ¿Qué tipo de preguntas de negocio se
     vuelven más fáciles de responder gracias a esta dimensión nueva?

3. **Medir la ganancia real (ejercicio práctico):**
   Escribir dos versiones de la misma consulta de negocio —por ejemplo,
   "ventas totales por categoría de producto y país del proveedor, en el
   año 1997"— una contra el esquema OLTP y otra contra el warehouse.
   Comparar cuántas tablas se necesitan unir (`JOIN`) en cada caso.
   Las dos consultas van en [`comparacion-joins.sql`](./comparacion-joins.sql),
   en esta misma carpeta.

4. **Conclusión**
   En 1 párrafo, explicar en qué escenario SÍ seguiría conviniendo consultar
   directamente el OLTP en vez del warehouse (pista: piensa en lectura vs.
   escritura, y en qué tan actualizados necesitan estar los datos).

## Cómo entregar

- Las dos consultas comparativas del punto 3 van en
  [`comparacion-joins.sql`](./comparacion-joins.sql).
- Este documento se completa con las respuestas, reemplazando esta plantilla.
