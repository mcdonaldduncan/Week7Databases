USE [PROG260FA22]
GO
ALTER TABLE [dbo].[Characters] DROP CONSTRAINT [FK_Characters_Types]
GO
ALTER TABLE [dbo].[Characters] DROP CONSTRAINT [FK_Characters_Map_Locations]
GO
ALTER TABLE [dbo].[Character_Info] DROP CONSTRAINT [FK_Character_Info_Characters]
GO
/****** Object:  Table [dbo].[Types]    Script Date: 10/26/2022 9:44:48 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Types]') AND type in (N'U'))
DROP TABLE [dbo].[Types]
GO
/****** Object:  Table [dbo].[Map_Locations]    Script Date: 10/26/2022 9:44:48 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Map_Locations]') AND type in (N'U'))
DROP TABLE [dbo].[Map_Locations]
GO
/****** Object:  Table [dbo].[Characters]    Script Date: 10/26/2022 9:44:48 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Characters]') AND type in (N'U'))
DROP TABLE [dbo].[Characters]
GO
/****** Object:  Table [dbo].[Character_Info]    Script Date: 10/26/2022 9:44:48 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Character_Info]') AND type in (N'U'))
DROP TABLE [dbo].[Character_Info]
GO
/****** Object:  Table [dbo].[Character_Info]    Script Date: 10/26/2022 9:44:48 PM ******/
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
/****** Object:  Table [dbo].[Characters]    Script Date: 10/26/2022 9:44:48 PM ******/
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
/****** Object:  Table [dbo].[Map_Locations]    Script Date: 10/26/2022 9:44:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Map_Locations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Map_Location] [nvarchar](50) NULL,
 CONSTRAINT [PK_Map_Locations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Types]    Script Date: 10/26/2022 9:44:48 PM ******/
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
SET IDENTITY_INSERT [dbo].[Character_Info] ON 

INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2179, 2191, N'TRUE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2180, 2192, N'FALSE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2181, 2193, N'FALSE', N'FALSE', N'')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2182, 2194, N'TRUE', N'FALSE', N'TRUE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2183, 2195, N'TRUE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2184, 2196, N'TRUE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2185, 2197, N'FALSE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2186, 2198, N'FALSE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2187, 2199, N'FALSE', N'', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2188, 2200, N'TRUE', N'FALSE', N'')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2189, 2201, N'TRUE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2190, 2202, N'TRUE', N'TRUE', N'TRUE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2191, 2203, N'FALSE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2192, 2204, N'FALSE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2193, 2205, N'TRUE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2194, 2206, N'FALSE', N'FALSE', N'TRUE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2195, 2207, N'TRUE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2196, 2208, N'FALSE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2197, 2209, N'FALSE', N'FALSE', N'')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2198, 2210, N'TRUE', N'FALSE', N'TRUE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2199, 2211, N'TRUE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2200, 2212, N'TRUE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2201, 2213, N'FALSE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2202, 2214, N'FALSE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2203, 2215, N'FALSE', N'', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2204, 2216, N'TRUE', N'FALSE', N'')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2205, 2217, N'TRUE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2206, 2218, N'TRUE', N'TRUE', N'TRUE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2207, 2219, N'FALSE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2208, 2220, N'FALSE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2209, 2221, N'TRUE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2210, 2222, N'FALSE', N'FALSE', N'TRUE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2211, 2223, N'TRUE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2212, 2224, N'FALSE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2213, 2225, N'FALSE', N'FALSE', N'')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2214, 2226, N'TRUE', N'FALSE', N'TRUE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2215, 2227, N'TRUE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2216, 2228, N'TRUE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2217, 2229, N'FALSE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2218, 2230, N'FALSE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2219, 2231, N'FALSE', N'', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2220, 2232, N'TRUE', N'FALSE', N'')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2221, 2233, N'TRUE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2222, 2234, N'TRUE', N'TRUE', N'TRUE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2223, 2235, N'FALSE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2224, 2236, N'FALSE', N'TRUE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2225, 2237, N'TRUE', N'FALSE', N'FALSE')
INSERT [dbo].[Character_Info] ([ID], [CharacterID], [Original_Character], [Sword_Fighter], [Magic_User]) VALUES (2226, 2238, N'FALSE', N'FALSE', N'TRUE')
SET IDENTITY_INSERT [dbo].[Character_Info] OFF
GO
SET IDENTITY_INSERT [dbo].[Characters] ON 

INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2191, N'Murray', 354, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2192, N'Locke Smith', 355, 151)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2193, N'Herman Toothrot', NULL, 152)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2194, N'Voodoo Lady', 356, 151)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2195, N'Otis', 357, 151)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2196, N'Carla', 358, 151)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2197, N'Captain Madison', 358, 151)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2198, N'Judge Planke', 359, 153)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2199, N'Boybrush Threepwood', 355, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2200, N'Guybrush Threepwood', 360, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2201, N'Elain Marley', 361, 154)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2202, N'Captain LeChuck', 362, 155)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2203, N'Putra', 363, 155)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2204, N'Iron Rose', 362, 155)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2205, N'Ned', 355, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2206, N'Flambe', 364, 155)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2207, N'Murray', 365, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2208, N'Locke Smith', 366, 156)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2209, N'Herman Toothrot', NULL, 157)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2210, N'Voodoo Lady', 367, 156)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2211, N'Otis', 368, 156)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2212, N'Carla', 369, 156)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2213, N'Captain Madison', 369, 156)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2214, N'Judge Planke', 370, 158)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2215, N'Boybrush Threepwood', 366, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2216, N'Guybrush Threepwood', 371, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2217, N'Elain Marley', 372, 159)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2218, N'Captain LeChuck', 373, 160)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2219, N'Putra', 374, 160)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2220, N'Iron Rose', 373, 160)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2221, N'Ned', 366, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2222, N'Flambe', 375, 160)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2223, N'Murray', 376, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2224, N'Locke Smith', 377, 161)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2225, N'Herman Toothrot', NULL, 162)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2226, N'Voodoo Lady', 378, 161)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2227, N'Otis', 379, 161)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2228, N'Carla', 380, 161)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2229, N'Captain Madison', 380, 161)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2230, N'Judge Planke', 381, 163)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2231, N'Boybrush Threepwood', 377, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2232, N'Guybrush Threepwood', 382, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2233, N'Elain Marley', 383, 164)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2234, N'Captain LeChuck', 384, 165)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2235, N'Putra', 385, 165)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2236, N'Iron Rose', 384, 165)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2237, N'Ned', 377, NULL)
INSERT [dbo].[Characters] ([ID], [Character], [TypeID], [MapLocationID]) VALUES (2238, N'Flambe', 386, 165)
SET IDENTITY_INSERT [dbo].[Characters] OFF
GO
SET IDENTITY_INSERT [dbo].[Map_Locations] ON 

INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (151, N'Melee Island')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (152, N'Terror Island')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (153, N'Brrrmuda')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (154, N'Scurvy Island')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (155, N'LeChuck''s ship')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (156, N'Melee Island')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (157, N'Terror Island')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (158, N'Brrrmuda')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (159, N'Scurvy Island')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (160, N'LeChuck''s ship')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (161, N'Melee Island')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (162, N'Terror Island')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (163, N'Brrrmuda')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (164, N'Scurvy Island')
INSERT [dbo].[Map_Locations] ([ID], [Map_Location]) VALUES (165, N'LeChuck''s ship')
SET IDENTITY_INSERT [dbo].[Map_Locations] OFF
GO
SET IDENTITY_INSERT [dbo].[Types] ON 

INSERT [dbo].[Types] ([ID], [Type]) VALUES (354, N'Ghost')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (355, N'Human')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (356, N'Melee Island')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (357, N'Inmate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (358, N'Pirate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (359, N'NPC')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (360, N'Mighty Pirate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (361, N'Politician')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (362, N'Ghost Pirate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (363, N'Ghost Cook')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (364, N'Fire Ghost')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (365, N'Ghost')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (366, N'Human')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (367, N'Melee Island')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (368, N'Inmate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (369, N'Pirate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (370, N'NPC')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (371, N'Mighty Pirate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (372, N'Politician')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (373, N'Ghost Pirate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (374, N'Ghost Cook')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (375, N'Fire Ghost')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (376, N'Ghost')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (377, N'Human')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (378, N'Melee Island')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (379, N'Inmate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (380, N'Pirate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (381, N'NPC')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (382, N'Mighty Pirate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (383, N'Politician')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (384, N'Ghost Pirate')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (385, N'Ghost Cook')
INSERT [dbo].[Types] ([ID], [Type]) VALUES (386, N'Fire Ghost')
SET IDENTITY_INSERT [dbo].[Types] OFF
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
