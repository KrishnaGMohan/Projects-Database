﻿CREATE VIEW [ard].[loadvw_REACTIONS]
	AS 
	SELECT
		[REACTION_ID],
		[REPORT_ID], 
		[DURATION_CHAR], 
		[DURATION_UNIT_ENG], 
		[DURATION_UNIT_FR]L, 
		[PT_NAME_ENG], 
		[PT_NAME_FR], 
		[SOC_NAME_ENG], 
		[SOC_NAME_FR], 
		[MEDDRA_VERSION]
	FROM [ard].[REACTIONS]