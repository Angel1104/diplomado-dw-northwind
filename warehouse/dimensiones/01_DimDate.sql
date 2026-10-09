-- Dimension de tiempo. No existe en el OLTP: se genera para el warehouse,
-- con una fila por cada fecha del rango de operacion del negocio.
-- Granularidad y nomenclatura siguiendo el proyecto guia del docente
-- (mclaure/Data-Management-and-BI, BikeStoresDW).
CREATE TABLE [dbo].[DimDate]
(
	[DateKey]           [int]      NOT NULL CONSTRAINT PK_DimDate PRIMARY KEY,
	[FullDate]          [date]     NOT NULL,
	[DayNumberOfWeek]   [tinyint]  NOT NULL,
	[DayNameOfWeek]     [nvarchar](10) NOT NULL,
	[DayNumberOfMonth]  [tinyint]  NOT NULL,
	[DayNumberOfYear]   [smallint] NOT NULL,
	[WeekNumberOfYear]  [tinyint]  NOT NULL,
	[MonthName]         [nvarchar](10) NOT NULL,
	[MonthNumberOfYear] [tinyint]  NOT NULL,
	[CalendarQuarter]   [tinyint]  NOT NULL,
	[CalendarYear]      [smallint] NOT NULL,
	[CalendarSemester]  [tinyint]  NOT NULL
);
GO
