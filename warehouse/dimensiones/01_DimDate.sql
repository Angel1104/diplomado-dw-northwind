-- Dimension de tiempo. No existe en el OLTP: se genera para el warehouse,
-- con una fila por cada fecha del rango de operacion del negocio.
CREATE TABLE [DimDate] (
    [DateKey]     INT         NOT NULL,  -- formato AAAAMMDD, ej. 19970704
    [FullDate]    DATE        NOT NULL,
    [Day]         TINYINT     NOT NULL,
    [Month]       TINYINT     NOT NULL,
    [MonthName]   NVARCHAR(20) NOT NULL,
    [Quarter]     TINYINT     NOT NULL,
    [Year]        SMALLINT    NOT NULL,
    [DayOfWeek]   TINYINT     NOT NULL,  -- 1 = domingo ... 7 = sabado
    [DayName]     NVARCHAR(20) NOT NULL,
    [IsWeekend]   BIT         NOT NULL,
    PRIMARY KEY ([DateKey])
);
