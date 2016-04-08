﻿CREATE TABLE [dpd].[QRYM_ROUTE] (
    [DRUG_CODE]                    NCHAR (8)     NOT NULL,
    [ROUTE_OF_ADMINISTRATION_CODE] NCHAR (6)     NULL,
    [ROUTE_OF_ADMINISTRATION]      NVARCHAR (40) NULL,
    CONSTRAINT [CK_QRYM_ROUTE_DRUG_CODE] CHECK (NOT [DRUG_CODE] like '%[^0-9 ]%'),
    CONSTRAINT [CK_QRYM_ROUTE_ROUTE_OF_ADMINISTRATION_CODE] CHECK (NOT [ROUTE_OF_ADMINISTRATION_CODE] like '%[^0-9 ]%'),
    CONSTRAINT [FK_QRYM_ROUTE_QRYM_DRUG_PRODUCT] FOREIGN KEY ([DRUG_CODE]) REFERENCES [dpd].[QRYM_DRUG_PRODUCT] ([DRUG_CODE])
);

