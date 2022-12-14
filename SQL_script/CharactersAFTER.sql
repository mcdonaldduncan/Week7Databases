USE [PROG260FA22]
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_FullReport'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_FullReport'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_BinaryConversion'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_BinaryConversion'
GO
/****** Object:  StoredProcedure [dbo].[sp_FindSwordNonHuman]    Script Date: 10/30/2022 9:11:18 PM ******/
DROP PROCEDURE [dbo].[sp_FindSwordNonHuman]
GO
/****** Object:  StoredProcedure [dbo].[sp_FindMaplessCharacters]    Script Date: 10/30/2022 9:11:18 PM ******/
DROP PROCEDURE [dbo].[sp_FindMaplessCharacters]
GO
ALTER TABLE [dbo].[Characters] DROP CONSTRAINT [FK_Characters_Types]
GO
ALTER TABLE [dbo].[Characters] DROP CONSTRAINT [FK_Characters_Map_Locations]
GO
ALTER TABLE [dbo].[Character_Info] DROP CONSTRAINT [FK_Character_Info_Characters]
GO
/****** Object:  View [dbo].[vw_BinaryConversion]    Script Date: 10/30/2022 9:11:18 PM ******/
DROP VIEW [dbo].[vw_BinaryConversion]
GO
/****** Object:  View [dbo].[vw_FullReport]    Script Date: 10/30/2022 9:11:18 PM ******/
DROP VIEW [dbo].[vw_FullReport]
GO
/****** Object:  Table [dbo].[Types]    Script Date: 10/30/2022 9:11:18 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Types]') AND type in (N'U'))
DROP TABLE [dbo].[Types]
GO
/****** Object:  Table [dbo].[Map_Locations]    Script Date: 10/30/2022 9:11:18 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Map_Locations]') AND type in (N'U'))
DROP TABLE [dbo].[Map_Locations]
GO
/****** Object:  Table [dbo].[Character_Info]    Script Date: 10/30/2022 9:11:18 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Character_Info]') AND type in (N'U'))
DROP TABLE [dbo].[Character_Info]
GO
/****** Object:  Table [dbo].[Characters]    Script Date: 10/30/2022 9:11:18 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Characters]') AND type in (N'U'))
DROP TABLE [dbo].[Characters]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ConvertBoolToBinary]    Script Date: 10/30/2022 9:11:18 PM ******/
DROP FUNCTION [dbo].[fn_ConvertBoolToBinary]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ConcatenatedBinary]    Script Date: 10/30/2022 9:11:18 PM ******/
DROP FUNCTION [dbo].[fn_ConcatenatedBinary]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ConcatenatedBinary]    Script Date: 10/30/2022 9:11:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_ConcatenatedBinary] 
(
	-- Add the parameters for the function here
	@OriginalChar nvarchar(50),
	@SwordFighter nvarchar(50),
	@MagicUser nvarchar(50)
)
RETURNS nvarchar(3)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ConcatenatedResult nvarchar(3)

	-- Add the T-SQL statements to compute the return value here
	SELECT @ConcatenatedResult = dbo.fn_ConvertBoolToBinary(@OriginalChar) + dbo.fn_ConvertBoolToBinary(@SwordFighter) + dbo.fn_ConvertBoolToBinary(@MagicUser)

	-- Return the result of the function
	RETURN @ConcatenatedResult

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ConvertBoolToBinary]    Script Date: 10/30/2022 9:11:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_ConvertBoolToBinary] 
(
	-- Add the parameters for the function here
	@String nvarchar(50)
	
)
RETURNS nvarchar(1)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @BinaryConversion nvarchar(3)

	-- Add the T-SQL statements to compute the return value here
	SELECT @BinaryConversion = CASE WHEN @String = 'TRUE' THEN 1 ELSE 0 END

	-- Return the result of the function
	RETURN @BinaryConversion

END
GO
/****** Object:  Table [dbo].[Characters]    Script Date: 10/30/2022 9:11:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Characters](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Character] [nvarchar](50) NOT NULL,
	[TypeID] [int] NULL,
	[MapLocationID] [int] NULL,
 CONSTRAINT [PK_Characters] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Character_Info]    Script Date: 10/30/2022 9:11:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Character_Info](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CharacterID] [int] NOT NULL,
	[Original_Character] [nvarchar](50) NULL,
	[Sword_Fighter] [nvarchar](50) NULL,
	[Magic_User] [nvarchar](50) NULL,
 CONSTRAINT [PK_Character_Info] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Map_Locations]    Script Date: 10/30/2022 9:11:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Map_Locations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Map_Location] [nvarchar](50) NULL,
	[Heading] [char](2) NULL,
 CONSTRAINT [PK_Map_Locations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Types]    Script Date: 10/30/2022 9:11:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Types](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_Types] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_FullReport]    Script Date: 10/30/2022 9:11:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_FullReport]
AS
SELECT        dbo.Characters.ID, dbo.Characters.Character, dbo.Types.Type, dbo.Map_Locations.Map_Location, dbo.Character_Info.Original_Character, dbo.Character_Info.Sword_Fighter, dbo.Character_Info.Magic_User
FROM            dbo.Character_Info INNER JOIN
                         dbo.Characters ON dbo.Character_Info.CharacterID = dbo.Characters.ID LEFT OUTER JOIN
                         dbo.Map_Locations ON dbo.Characters.MapLocationID = dbo.Map_Locations.ID LEFT OUTER JOIN
                         dbo.Types ON dbo.Characters.TypeID = dbo.Types.ID
GO
/****** Object:  View [dbo].[vw_BinaryConversion]    Script Date: 10/30/2022 9:11:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_BinaryConversion]
AS
SELECT        dbo.Characters.ID, dbo.Characters.Character, dbo.Character_Info.Original_Character, dbo.Character_Info.Sword_Fighter, dbo.Character_Info.Magic_User, dbo.fn_ConcatenatedBinary(dbo.Character_Info.Original_Character, dbo.Character_Info.Sword_Fighter, dbo.Character_Info.Magic_User) AS Binary
FROM            dbo.Character_Info INNER JOIN
                         dbo.Characters ON dbo.Character_Info.CharacterID = dbo.Characters.ID
GO
ALTER TABLE [dbo].[Character_Info]  WITH CHECK ADD  CONSTRAINT [FK_Character_Info_Characters] FOREIGN KEY([CharacterID])
REFERENCES [dbo].[Characters] ([ID])
GO
ALTER TABLE [dbo].[Character_Info] CHECK CONSTRAINT [FK_Character_Info_Characters]
GO
ALTER TABLE [dbo].[Characters]  WITH CHECK ADD  CONSTRAINT [FK_Characters_Map_Locations] FOREIGN KEY([MapLocationID])
REFERENCES [dbo].[Map_Locations] ([ID])
GO
ALTER TABLE [dbo].[Characters] CHECK CONSTRAINT [FK_Characters_Map_Locations]
GO
ALTER TABLE [dbo].[Characters]  WITH CHECK ADD  CONSTRAINT [FK_Characters_Types] FOREIGN KEY([TypeID])
REFERENCES [dbo].[Types] ([ID])
GO
ALTER TABLE [dbo].[Characters] CHECK CONSTRAINT [FK_Characters_Types]
GO
/****** Object:  StoredProcedure [dbo].[sp_FindMaplessCharacters]    Script Date: 10/30/2022 9:11:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_FindMaplessCharacters] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Characters.Character
    FROM Characters
    LEFT JOIN Map_Locations 
    ON Characters.MapLocationID = Map_Locations.ID
    WHERE Map_Locations.Map_Location is NULL
END
GO
/****** Object:  StoredProcedure [dbo].[sp_FindSwordNonHuman]    Script Date: 10/30/2022 9:11:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_FindSwordNonHuman] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Characters.ID, Characters.Character
    FROM Characters 
    LEFT JOIN Types 
    ON Characters.TypeID = Types.ID
    LEFT JOIN Character_Info
    ON Character_Info.CharacterID = Characters.ID
    WHERE Character_Info.Sword_Fighter = 'TRUE' and Types.Type != 'Human'
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Character_Info"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Characters"
            Begin Extent = 
               Top = 6
               Left = 263
               Bottom = 136
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_BinaryConversion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_BinaryConversion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Character_Info"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Characters"
            Begin Extent = 
               Top = 6
               Left = 263
               Bottom = 136
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Types"
            Begin Extent = 
               Top = 6
               Left = 679
               Bottom = 102
               Right = 849
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Map_Locations"
            Begin Extent = 
               Top = 6
               Left = 471
               Bottom = 102
               Right = 641
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_FullReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_FullReport'
GO
