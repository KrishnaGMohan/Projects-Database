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

INSERT INTO [control].[LoadList] VALUES ('[ARD].[DRUG_PRODUCT]','DRUG_PRODUCTS.FMT','DRUG_PRODUCTS.TXT')
INSERT INTO [control].[LoadList] VALUES ('[ARD].[DRUG_PRODUCT_INGREDIENTS]','DRUG_PRODUCT_INGREDIENTS.FMT','DRUG_PRODUCT_INGREDIENTS.TXT')
INSERT INTO [control].[LoadList] VALUES ('[ARD].[loadvw_REACTIONS]','REACTIONS.FMT','REACTIONS.TXT')


DELETE FROM [control].[ControlTable]

INSERT INTO [control].[ControlTable](DataDir) VALUES ('E:\Personal\OneDrive\Projects\SQL Server Database\AdverseReactionDatabase\AdverseReactionDatabase\Z-NonBuild\')

