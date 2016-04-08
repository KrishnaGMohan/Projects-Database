﻿CREATE TABLE [dpd].[QRYM_ACTIVE_INGREDIENTS] (
    [DRUG_CODE]               NCHAR (8)       NOT NULL,
    [ACTIVE_INGREDIENT_CODE]  NCHAR (6)       NULL,
    [INGREDIENT]              NVARCHAR (240)  NULL,
    [INGREDIENT_SUPPLIED_IND] NVARCHAR (1)    NULL,
    [STRENGTH_CHAR]           NVARCHAR (20)   NULL,
	[STRENGTH]				  AS	CAST([STRENGTH_CHAR] AS NUMERIC(38,15)),
    [STRENGTH_UNIT]           NVARCHAR (40)   NULL,
    [STRENGTH_TYPE]           NVARCHAR (40)   NULL,
    [DOSAGE_VALUE]            NVARCHAR (20)   NULL,
    [BASE]                    NVARCHAR (1)    NULL,
    [DOSAGE_UNIT]             NVARCHAR (40)   NULL,
    [NOTES]                   NVARCHAR (2000) NULL,
    CONSTRAINT [CK_QRYM_ACTIVE_INGREDIENTS_ACTIVE_INGREDIENT_CODE] CHECK (NOT [ACTIVE_INGREDIENT_CODE] like '%[^0-9 ]%'),
    CONSTRAINT [CK_QRYM_ACTIVE_INGREDIENTS_DRUG_CODE] CHECK (NOT [DRUG_CODE] like '%[^0-9 ]%'),
    CONSTRAINT [FK_QRYM_ACTIVE_INGREDIENTS_QRYM_DRUG_PRODUCT] FOREIGN KEY ([DRUG_CODE]) REFERENCES [dpd].[QRYM_DRUG_PRODUCT] ([DRUG_CODE])
);

