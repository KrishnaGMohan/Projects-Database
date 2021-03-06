﻿CREATE TABLE [dpd].[QRYM_THERAPEUTIC_CLASS] (
    [DRUG_CODE]      NCHAR (8)      NOT NULL,
    [TC_ATC_NUMBER]  NVARCHAR (8)   NULL,
    [TC_ATC]         NVARCHAR (120) NULL,
    [TC_AHFS_NUMBER] NVARCHAR (20)  NULL,
    [TC_AHFS]        NVARCHAR (80)  NULL,
    CONSTRAINT [CK_QRYM_THERAPEUTIC_CLASS_DRUG_CODE] CHECK (NOT [DRUG_CODE] like '%[^0-9 ]%'),
    CONSTRAINT [FK_QRYM_THERAPEUTIC_CLASS_QRYM_DRUG_PRODUCT] FOREIGN KEY ([DRUG_CODE]) REFERENCES [dpd].[QRYM_DRUG_PRODUCT] ([DRUG_CODE])
);

