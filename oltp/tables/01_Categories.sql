CREATE TABLE [Categories] (
    [CategoryID] int IDENTITY(1,1) NOT NULL,
    [CategoryName] nvarchar(15) NOT NULL,
    [Description] nvarchar(MAX) NULL,
    [Picture] image NULL,
    [rowversion] timestamp NULL,
    PRIMARY KEY ([CategoryID])
);
