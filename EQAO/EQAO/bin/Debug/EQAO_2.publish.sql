﻿/*
Deployment script for EQAO

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "EQAO"
:setvar DefaultFilePrefix "EQAO"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
PRINT N'Rename refactoring operation with key aafcd3f8-3396-49a5-82eb-ff0776785963, 6cce2b09-5e95-4082-80a6-b02e951f0809 is skipped, element [dbo].[tabDataGrade3].[Id] (SqlSimpleColumn) will not be renamed to school_id';


GO
PRINT N'Rename refactoring operation with key c8730d44-da7b-45c0-995b-f467ad5aa2b8 is skipped, element [dbo].[tabDataGrade3].[perc_ELLs] (SqlSimpleColumn) will not be renamed to ELLs';


GO
PRINT N'Rename refactoring operation with key d713f1f4-ed31-4f1a-8cad-04936457c6d9 is skipped, element [dbo].[tabDataGrade3].[Year] (SqlSimpleColumn) will not be renamed to year';


GO
PRINT N'Rename refactoring operation with key ac7aa0bd-2ea0-4b83-b112-236ddc62df9d is skipped, element [dbo].[tabDataGrade3].[specialEducation] (SqlSimpleColumn) will not be renamed to special_education';


GO
PRINT N'Creating [dbo].[tabDataGrade3]...';


GO
CREATE TABLE [dbo].[tabDataGrade3] (
    [school_id]         INT            NOT NULL,
    [year]              NCHAR (9)      NOT NULL,
    [grade]             TINYINT        NOT NULL,
    [student_count]     INT            NULL,
    [ELLs]              DECIMAL (3, 2) NULL,
    [special_education] DECIMAL (3, 2) NULL,
    [exempt]            DECIMAL (3, 2) NULL,
    [reading_exempt]    DECIMAL (3, 2) NULL,
    [reading_level_34]  DECIMAL (3, 2) NULL,
    [writing_exempt]    DECIMAL (3, 2) NULL,
    [writing_level_34]  DECIMAL (3, 2) NULL,
    [math_exempt]       DECIMAL (3, 2) NULL,
    [math_level_34]     DECIMAL (3, 2) NULL,
    CONSTRAINT [PK_tabDataGrade3] PRIMARY KEY CLUSTERED ([year] ASC, [school_id] ASC)
);


GO
PRINT N'Update complete.';


GO