CREATE TABLE [Shippers] (
    [ShipperID] int IDENTITY(1,1) NOT NULL,
    [CompanyName] nvarchar(40) NOT NULL,
    [Phone] nvarchar(24) NULL,
    [rowversion] timestamp NULL,
    PRIMARY KEY ([ShipperID])
);
