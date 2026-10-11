# Reto 1 — Entender el negocio a través de los datos

**Responsable:** Daniela Zapata ([DanieZapata](https://github.com/DanieZapata))

## Objetivo

Antes de diseñar o implementar cualquier estructura, el primer paso de todo
proyecto de datos es entender el negocio que esos datos representan: quiénes
son los actores (entidades), qué eventos ocurren entre ellos (hechos), y qué
preguntas de negocio tienen sentido hacerse.

## Preguntas a responder

Completar cada punto ejecutando consultas SQL reales sobre la base NorthWind
restaurada, y documentar el resultado y la interpretación (no solo el número).

1. **¿De qué trata el negocio de NorthWind?**
   Describir en 2-3 frases el tipo de empresa que es (qué vende, a quién, cómo
   opera), basándose en las tablas disponibles (`Customers`, `Suppliers`,
   `Products`, `Orders`, `Employees`, `Shippers`).

2. **¿Quiénes son las entidades (personas y cosas) del negocio?**
   Listar las entidades principales y clasificarlas: ¿cuáles son personas
   (`Customers`, `Employees`), cuáles son cosas (`Products`, `Shippers`), y
   cuáles son conceptos abstractos (`Categories`)?

3. **¿Cuál es el evento central (hecho) del negocio?**
   ¿Qué interacción entre esas entidades genera el dato más importante para
   el negocio? (pista: es la que terminó siendo la tabla de hechos del
   warehouse, `FactSales`).

4. **Exploración de los datos — responder con una consulta SQL cada una:**
   - ¿Cuántos clientes, productos, órdenes y empleados tiene la base?
   - ¿Cuáles son los 5 países con más clientes?
   - ¿Cuál es el producto más vendido (por cantidad) y cuál genera más
     ingresos (por monto)?
   - ¿Hay órdenes sin fecha de envío (`ShippedDate` nula)? ¿Qué podría
     significar eso para el negocio?
   - ¿Qué empleado tiene más ventas registradas a su cargo?

5. **Conclusión**
   En 1 párrafo, explicar qué preguntas de negocio NO se pueden responder
   fácilmente con el esquema OLTP actual (por la cantidad de *joins*
   necesarios), y que sí se resuelven con el modelo estrella del warehouse.

## Cómo entregar

- Las consultas SQL usadas en el punto 4 van en
  [`reto1-queries.sql`](./reto1-queries.sql), en esta misma carpeta.
- Este documento se completa con las respuestas, reemplazando esta plantilla.
