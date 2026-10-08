CREATE TABLE [OrderDetails] (
    [OrderID] int NOT NULL,
    [ProductID] int NOT NULL,
    [UnitPrice] money NOT NULL,
    [Quantity] smallint NOT NULL,
    [Discount] real NOT NULL,
    [rowversion] timestamp NULL,
    PRIMARY KEY ([OrderID], [ProductID])
);
