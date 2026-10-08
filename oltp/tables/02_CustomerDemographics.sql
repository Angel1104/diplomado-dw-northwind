CREATE TABLE [CustomerDemographics] (
    [CustomerTypeID] nchar(10) NOT NULL,
    [CustomerDesc] nvarchar(MAX) NULL,
    [rowversion] timestamp NULL,
    PRIMARY KEY ([CustomerTypeID])
);
