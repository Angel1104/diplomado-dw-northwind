CREATE TABLE [Territories] (
    [TerritoryID] nvarchar(20) NOT NULL,
    [TerritoryDescription] nchar(50) NOT NULL,
    [RegionID] int NOT NULL,
    [rowversion] timestamp NULL,
    PRIMARY KEY ([TerritoryID])
);
