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
  tablas normalizadas tal como fueron entregadas.
- **`warehouse/`**: el modelo dimensional (modelo estrella) derivado del OLTP,
  compuesto por una tabla de hechos y sus tablas de dimensión, diseñado para
  facilitar el análisis y reporte de ventas.

## Estructura del repositorio

```
oltp/
└── tables/          Scripts CREATE TABLE del esquema OLTP de NorthWind

warehouse/
├── dimensiones/      Tablas de dimensión (Dim*)
└── hechos/           Tabla de hechos (Fact*)
```

## Cómo usar los scripts

Cada archivo `.sql` contiene la sentencia `CREATE TABLE` de una tabla. Se
ejecutan en el orden numerado dentro de cada carpeta para respetar las
dependencias de llaves foráneas.
