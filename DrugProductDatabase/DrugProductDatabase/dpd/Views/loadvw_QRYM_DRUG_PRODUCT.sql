﻿CREATE VIEW [dpd].[loadvw_QRYM_DRUG_PRODUCT]
	AS 
SELECT [DRUG_CODE]
    ,[PRODUCT_CATEGORIZATION]   
    ,[CLASS]                     
    ,[DRUG_IDENTIFICATION_NUMBER] 
    ,[BRAND_NAME]                 
    ,[DESCRIPTOR]                 
    ,[PEDIATRIC_FLAG]             
    ,[ACCESSION_NUMBER]           
    ,[NUMBER_OF_AIS]              
    ,[LAST_UPDATE_DATE_CHAR]
    ,[AI_GROUP_NO]              
FROM [dpd].[QRYM_DRUG_PRODUCT]