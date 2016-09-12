/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
DELETE FROM [control].[LoadList]

INSERT INTO [control].[LoadList] VALUES ('[DPD].[LOADVW_QRYM_DRUG_PRODUCT]','DRUG.FMT','DRUG.TXT')
INSERT INTO [control].[LoadList] VALUES ('[DPD].[LOADVW_QRYM_ACTIVE_INGREDIENTS]','INGRED.FMT','INGRED.TXT')
INSERT INTO [control].[LoadList] VALUES ('[DPD].[QRYM_COMPANIES]','COMP.FMT','COMP.TXT')
INSERT INTO [control].[LoadList] VALUES ('[DPD].[LOADVW_QRYM_STATUS]','STATUS.FMT','STATUS.TXT')
INSERT INTO [control].[LoadList] VALUES ('[DPD].[QRYM_FORM]','FORM.FMT','FORM.TXT')
INSERT INTO [control].[LoadList] VALUES ('[DPD].[QRYM_PACKAGING]','PACKAGE.FMT','PACKAGE.TXT')
INSERT INTO [control].[LoadList] VALUES ('[DPD].[QRYM_PHARMACEUTICAL_STD]','PHARM.FMT','PHARM.TXT')
INSERT INTO [control].[LoadList] VALUES ('[DPD].[QRYM_ROUTE]','ROUTE.FMT','ROUTE.TXT')
INSERT INTO [control].[LoadList] VALUES ('[DPD].[QRYM_SCHEDULE]','SCHEDULE.FMT','SCHEDULE.TXT')
INSERT INTO [control].[LoadList] VALUES ('[DPD].[QRYM_THERAPEUTIC_CLASS]','THER.FMT','THER.TXT')
INSERT INTO [control].[LoadList] VALUES ('[DPD].[QRYM_VETERINARY_SPECIES]','VET.FMT','VET.TXT')

DELETE FROM [control].[ControlTable]

INSERT INTO [control].[ControlTable](DataDir) VALUES ('D:\Personal\OneDrive\Projects\Projects-Database\DrugProductDatabase\DrugProductDatabase\Z-NonBuild\')
