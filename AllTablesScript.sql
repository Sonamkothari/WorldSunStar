USE [Employee]
GO
/****** Object:  Table [dbo].[MTDUsers]    Script Date: 05/26/2014 21:42:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MTDUsers](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[UserDetails] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[Password] [varchar](max) NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_MTDUsers] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MTDSubMenuSave]    Script Date: 05/26/2014 21:42:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MTDSubMenuSave](
	[SUBTID] [int] IDENTITY(1,1) NOT NULL,
	[SubMenuID] [bigint] NULL,
	[SubMenuName] [nvarchar](100) NULL,
	[SubMRead] [int] NULL,
	[SubMWrite] [int] NULL,
	[SubMBoth] [int] NULL,
	[SubUID] [int] NULL,
	[SubRID] [int] NULL,
	[MainMenuID] [int] NULL,
 CONSTRAINT [PK_MTDSubMenuSave] PRIMARY KEY CLUSTERED 
(
	[SUBTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MTDSubMenu]    Script Date: 05/26/2014 21:42:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MTDSubMenu](
	[SubmenuID] [bigint] IDENTITY(1,1) NOT NULL,
	[SubmenuName] [nvarchar](200) NULL,
	[SubMenuURL] [nvarchar](max) NULL,
	[MenuID] [int] NULL,
	[RoleID] [int] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_MTDSubMenu] PRIMARY KEY CLUSTERED 
(
	[SubmenuID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MTDroles]    Script Date: 05/26/2014 21:42:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MTDroles](
	[RolesID] [int] IDENTITY(1,1) NOT NULL,
	[RolesName] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_MTDroles] PRIMARY KEY CLUSTERED 
(
	[RolesID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MTDMenuSave]    Script Date: 05/26/2014 21:42:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MTDMenuSave](
	[TID] [int] IDENTITY(1,1) NOT NULL,
	[MenuID] [bigint] NULL,
	[MenuName] [nvarchar](100) NULL,
	[MRead] [int] NULL,
	[MWrite] [int] NULL,
	[MBoth] [int] NULL,
	[UID] [int] NULL,
	[RID] [int] NULL,
 CONSTRAINT [PK_MTDMenuSave] PRIMARY KEY CLUSTERED 
(
	[TID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MTDMenu]    Script Date: 05/26/2014 21:42:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MTDMenu](
	[MenuID] [bigint] IDENTITY(1,1) NOT NULL,
	[MenuName] [nvarchar](100) NULL,
	[MenuURL] [nvarchar](1000) NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_MTDMenu] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF_MTDroles_CreateDate]    Script Date: 05/26/2014 21:42:06 ******/
ALTER TABLE [dbo].[MTDroles] ADD  CONSTRAINT [DF_MTDroles_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
/****** Object:  Default [DF_MTDSubMenu_CreateDate]    Script Date: 05/26/2014 21:42:06 ******/
ALTER TABLE [dbo].[MTDSubMenu] ADD  CONSTRAINT [DF_MTDSubMenu_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
/****** Object:  Default [DF_MTDUsers_CreateDate]    Script Date: 05/26/2014 21:42:06 ******/
ALTER TABLE [dbo].[MTDUsers] ADD  CONSTRAINT [DF_MTDUsers_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
