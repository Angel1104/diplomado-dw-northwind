CREATE TABLE [EmployeeTerritories] (
    [EmployeeID] int NOT NULL,
    [TerritoryID] nvarchar(20) NOT NULL,
    [rowversion] timestamp NULL,
    PRIMARY KEY ([EmployeeID], [TerritoryID])
);
