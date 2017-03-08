CREATE TABLE [dbo].[tabDataGrade3]
(
	[school_id] SMALLINT NOT NULL , 
    [school_year] NCHAR(9) NOT NULL, 
	[grade] TINYINT NOT NULL DEFAULT 3, 
    [student_count] INT NULL, 
    [ELLs] DECIMAL(3, 2) NULL, 
    [special_education] DECIMAL(3, 2) NULL, 
    [exempt] DECIMAL(3, 2) NULL, 
    [reading_exempt] DECIMAL(3, 2) NULL, 
	[reading_level_234] DECIMAL(3, 2) NULL, 
    [reading_level_34] DECIMAL(3, 2) NULL, 
    [writing_exempt] DECIMAL(3, 2) NULL, 
	[writing_level_234] DECIMAL(3, 2) NULL, 
    [writing_level_34] DECIMAL(3, 2) NULL, 
    [math_exempt] DECIMAL(3, 2) NULL, 
	[math_level_234] DECIMAL(3, 2) NULL, 
    [math_level_34] DECIMAL(3, 2) NULL, 
    CONSTRAINT [FK_tabDataGrade3_tabSchool] FOREIGN KEY ([school_id]) REFERENCES tabSchool([school_id]), 
    CONSTRAINT [PK_tabDataGrade3] PRIMARY KEY ([school_id], [school_year]), 
    CONSTRAINT [CK_tabDataGrade3_grade] CHECK (grade = 3) 
)
