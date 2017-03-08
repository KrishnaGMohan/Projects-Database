CREATE TABLE [dbo].[tabDataGrade9]
(
	[school_id] SMALLINT NOT NULL , 
    [school_year] NCHAR(9) NOT NULL, 
    [grade] TINYINT NOT NULL DEFAULT 9, 
    [academic_students_count] INT NULL, 
    [academic_ELLs] DECIMAL(3, 2) NULL, 
    [academic_special_education] DECIMAL(3, 2) NULL, 
    [academic_no_data] DECIMAL(3, 2) NULL, 
    [academic_level_234] DECIMAL(3, 2) NULL, 
    [academic_level_34] DECIMAL(3, 2) NULL, 
    [applied_students_count] DECIMAL(3, 2) NULL, 
    [applied_ELLs] DECIMAL(3, 2) NULL, 
    [applied_special_education] DECIMAL(3, 2) NULL, 
    [applied_no_data] DECIMAL(3, 2) NULL, 
    [applied_level_234] DECIMAL(3, 2) NULL, 
    [applied_level_34] DECIMAL(3, 2) NULL, 
    CONSTRAINT [PK_Table1] PRIMARY KEY ([school_id], [school_year]), 
    CONSTRAINT [FK_tabDataGrade9_tabSchool] FOREIGN KEY ([school_id]) REFERENCES [tabSchool]([school_id]), 
    CONSTRAINT [CK_tabDataGrade9_grade] CHECK (grade = 9)
)
