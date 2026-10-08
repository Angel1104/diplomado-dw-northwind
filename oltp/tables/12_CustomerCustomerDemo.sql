CREATE TABLE [CustomerCustomerDemo] (
    [CustomerID] nchar(5) NOT NULL,
    [CustomerTypeID] nchar(10) NOT NULL,
    [rowversion] timestamp NULL,
    PRIMARY KEY ([CustomerID], [CustomerTypeID])
);
