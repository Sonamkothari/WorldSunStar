USE [Employee]
GO
/****** Object:  StoredProcedure [dbo].[MTDUserRolesInsert]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[MTDUserRolesInsert]
@RolesName	nvarchar(50)	
as 

begin
insert into MTDroles
(
RolesName
)

values 
(
@RolesName

)


end
GO
/****** Object:  StoredProcedure [dbo].[usp_updateuserRole]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_updateuserRole]  
@RoleID bigint,  
@UserID bigint  
as  
  
begin
  
  
  IF exists (SELECT
	m.UserID
FROM MTDUsers m
WHERE m.RoleID = @RoleID
AND m.UserID = @UserID)
  begin
SELECT
	'Already assign'
  

  end
  else
  begin
UPDATE MTDUsers
SET MTDUsers.RoleID = @RoleID
WHERE UserID = @UserID
SELECT
	'Updated Successfully'
  

end

end
GO
/****** Object:  StoredProcedure [dbo].[Usp_UpdateMTDSubMenu]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_UpdateMTDSubMenu]    
    
@SubMenuID bigint ,    
@SubMenuName nvarchar(100) ,    
@SubMRead int ,    
@SubMWrite int ,    
@SubMBoth int ,    
@SubUID int ,    
@SubRID int ,    
@MainMenuID int    
      
AS    
BEGIN    
update MTDSubMenuSave set    
SubMRead =@SubMRead ,    
SubMWrite =@SubMWrite ,    
SubMBoth  =@SubMBoth    
 where MTDSubMenuSave.SubRID =@SubRID  
 and MTDSubMenuSave.SubUID =@SubRID
 and MTDSubMenuSave.MainMenuID =@MainMenuID
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_UpdateMTDMenu]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_UpdateMTDMenu]  
  
@MenuID bigint ,  
@MenuName nvarchar(100) ,  
@MRead int ,  
@MWrite int ,  
@MBoth int ,  
@UID int ,  
@RID int   
    
AS  
BEGIN  
 update MTDMenuSave
 set    
MRead =@MRead,  
MWrite=@MWrite,  
MBoth=@MBoth 
 where MenuID = @MenuID
select 'recordupdated'
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_Submenu]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Usp_Submenu]      
---exec Usp_Submenu  1,1     
@userID bigint ,      
@MenuID bigint      
as      
begin      
      
      
select MD.SubmenuName,MD.SubMenuURL,cast(MD.MenuID AS Nvarchar(10))+'S' as subMenuIDx ,MD.MenuID from dbo.MTDSubMenu MD       
where MD.MenuID =@MenuID    
      
      
end
GO
/****** Object:  StoredProcedure [dbo].[Usp_MTDMTDMTDSubMenuInsert]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Usp_MTDMTDMTDSubMenuInsert]

@SubmenuName	nvarchar(200)	,
@SubMenuURL	nvarchar(MAX)	,
@MenuID	int	,
@RoleID	int	

as 



begin

insert into MTDSubMenu

(

SubmenuName,
SubMenuURL		,
MenuID		,
RoleID		

)



values 

(
@SubmenuName,
@SubMenuURL		,
@MenuID		,
@RoleID		


)





end
GO
/****** Object:  StoredProcedure [dbo].[Usp_MTDMTDMenuInsert]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[Usp_MTDMTDMenuInsert]
@MenuName Nvarchar(200),
@MenuURL Nvarchar(2000),
@RoleID int
as 

begin
insert into MTDMenu
(
MenuName,
MenuURL,
RoleID
)

values 
(
@MenuName,
@MenuURL,
@RoleID
)


end
GO
/****** Object:  StoredProcedure [dbo].[Usp_MTDgetSubMenuBymenu]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Usp_MTDgetSubMenuBymenu]

@MenuID int ,
@role int
as 

begin

select 
SubmenuID,
Rtrim(lTrim(SubmenuName)) as SubmenuName,
Rtrim(lTrim(SubMenuURL)) as  SubMenuURL
from MTDSubMenu where MTDSubMenu.MenuID = @MenuID
and MTDSubMenu.RoleID =@role
end
GO
/****** Object:  StoredProcedure [dbo].[Usp_MTDgetSubMenu]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_MTDgetSubMenu]
AS
BEGIN
	SELECT MS.SubmenuName
		,MS.SubMenuURL AS SubMenuURL
		,MS.SubmenuID
		,MR.RolesName AS RolesName
		,MM.MenuName AS MenuName
	FROM MTDSubMenu MS
	INNER JOIN MTDMenu MM ON MS.RoleID = MM.RoleID and MS.MenuID = MM.MenuID
	INNER JOIN MTDroles MR ON MS.RoleID = MR.RolesID
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_MTDgetroles]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc  [dbo].[Usp_MTDgetroles]

as

begin

select * from MTDroles
end
GO
/****** Object:  StoredProcedure [dbo].[Usp_MTDGetMenuByRoles]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  proc [dbo].[Usp_MTDGetMenuByRoles]
@roleID int
as

begin

Select * from MTDMenu where MTDMenu.RoleID = @roleID
End
GO
/****** Object:  StoredProcedure [dbo].[Usp_MTDgetMenu]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[Usp_MTDgetMenu]

as



begin

select * , MR.RolesName as RolesName from MTDMenu MD  inner join MTDroles MR on MD.RoleID = MR.RolesID

Select * from MTDroles

end
GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertMTDSubMenu]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_InsertMTDSubMenu]  
  
@SubMenuID bigint ,  
@SubMenuName nvarchar(100) ,  
@SubMRead int ,  
@SubMWrite int ,  
@SubMBoth int ,  
@SubUID int ,  
@SubRID int ,  
@MainMenuID int  
    
AS  
BEGIN  



 INSERT INTO MTDSubMenuSave (  
SubMenuID  ,  
SubMenuName ,  
SubMRead  ,  
SubMWrite  ,  
SubMBoth  ,  
SubUID  ,  
SubRID  ,  
MainMenuID   
  )  
 VALUES (  
    
@SubMenuID  ,  
@SubMenuName ,  
@SubMRead  ,  
@SubMWrite  ,  
@SubMBoth  ,  
@SubUID  ,  
@SubRID  ,  
@MainMenuID   
  
  )  
  
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertMTDMenu]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_InsertMTDMenu]  
  
@MenuID bigint ,  
@MenuName nvarchar(100) ,  
@MRead int ,  
@MWrite int ,  
@MBoth int ,  
@UID int ,  
@RID int   
    
AS  
BEGIN  

 INSERT INTO MTDMenuSave (  
MenuID,  
MenuName,  
MRead,  
MWrite,  
MBoth,  
UID,  
RID  
  )  
 VALUES (  
    
@MenuID,  
@MenuName,  
@MRead,  
@MWrite,  
@MBoth,  
@UID,  
@RID  
  
  )  
  end
GO
/****** Object:  StoredProcedure [dbo].[Usp_getuserbyUserID]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Usp_getuserbyUserID]
@userid bigint

as

begin

select * from dbo.MTDMenuSave m where m.UID=@userid
end
GO
/****** Object:  StoredProcedure [dbo].[Usp_getSubuserbyUserID]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Usp_getSubuserbyUserID]      
      
@Menuid int ,
@role int      
   
as       
      
begin    
    
SELECT    
 *,MS.SubmenuName,MS.SubMenuURL    
FROM MTDSubMenuSave    
inner JOIN MTDSubMenu MS ON MTDSubMenuSave.SubMenuID =MS.SubmenuID    
WHERE MTDSubMenuSave.MainMenuID =@Menuid  
and MTDSubMenuSave.SubRID =@role

end
GO
/****** Object:  StoredProcedure [dbo].[usp_getPageRoles]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getPageRoles]
@rolesID int
as

begin

select * from MTDMenuSave ms where ms.RID  =@rolesID
end
GO
/****** Object:  StoredProcedure [dbo].[usp_getallusers]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_getallusers]
@UserID bigint
as
begin

SELECT
	MU.UserName,
	MU.UserID,
	MT.RolesName
FROM MTDUsers MU
INNER JOIN MTDroles MT
	ON MU.RoleID = MT.RolesID
	WHERE MU.UserID =@UserID
end
GO
/****** Object:  StoredProcedure [dbo].[Usp_GetAllRoles]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Usp_GetAllRoles]        
@Menutype char(1) ,      
@ID bigint ,
@RID bigint ,
@UID bigint     
as      
begin      
      
      
IF(@Menutype = 'M')
begin
select MRead,
MWrite,
MBoth from dbo.MTDMenuSave MD where MD.MenuID =@ID and  MD.RID =@RID and MD.UID =@UID  
end

else if(@Menutype = 'S') 
begin

select MS.SubMRead ,MS.SubMWrite,MS.SubMBoth from  MTDSubMenuSave MS

where MS.SubMenuID =@ID and  MS.SubRID =@RID and MS.SubUID =@UID  
end
      
end
GO
/****** Object:  StoredProcedure [dbo].[Usp_GetAllMenuofRole]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Usp_GetAllMenuofRole]          
--exec Usp_GetAllMenuofRole 1           
@UserID1 bigint   
as           
          
begin
          
SELECT
	MT.MenuName,
	MT.MenuURL,
	CAST(MD.MenuID AS nvarchar(10)) + 'M' AS MenuIDx,
	MD.MenuID,
	MD.UID
FROM dbo.MTDMenuSave MD
INNER JOIN MTDMenu MT
	ON MD.MenuID = MT.MenuID
WHERE MD.UID = @UserID1
          
          
end
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteRoles]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_DeleteRoles] 
@RolesID int   
as  
begin  
Declare @msg varchar(100)  
IF exists(SELECT mM.RoleID FROM MTDMenu mM where mM.RoleID = @RolesID)  
BEGIN  
 set @msg = 'The role id Cannot be delete because it is in use' 
 select @msg
RETURN   
END  
else if exists(SELECT mM.RoleID FROM MTDMenu mM where mM.RoleID = @RolesID)  
BEGIN  
set @msg = 'The role id Cannot be delete because it is in use'  
select @msg
end  
  
else if exists(SELECT mM.RID FROM MTDMenuSave mM where mM.RID = @RolesID)  
BEGIN  
set @msg = 'The role id Cannot be delete because it is in use'  
select @msg
end  
  
else if exists(SELECT mM.RoleID FROM MTDSubMenu mM where mM.RoleID = @RolesID)  
BEGIN  
set @msg = 'The role id Cannot be delete because it is in use'  
select @msg
end  
  
else if exists(SELECT mM.RoleID FROM MTDSubMenu mM where mM.RoleID = @RolesID)  
BEGIN  
set @msg = 'The role id Cannot be delete because it is in use'  
select @msg
end  
  
else if exists(SELECT mM.SubRID FROM MTDSubMenuSave mM where mM.SubRID = @RolesID)  
BEGIN  
set @msg = 'The role id Cannot be delete because it is in use'  
select @msg
end    
else  
begin  
delete FROM MTDroles where RolesID = @RolesID  
set @msg = 'Delete successfully!'  
select @msg
end  

end
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteMTDSubMenu]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_DeleteMTDSubMenu]
@SubmenuID int 
as
begin
Declare @msg varchar(100)

 if exists(SELECT mM.SubMenuID FROM MTDSubMenu mM where mM.SubmenuID = @SubmenuID)
BEGIN
set @msg = 'The role id Cannot be delete because it is in use'
 select @msg
end

else if exists(SELECT mM.SubMenuID FROM MTDSubMenuSave mM where mM.SubmenuID = @SubmenuID)
BEGIN
set @msg = 'The role id Cannot be delete because it is in use'
 select @msg
end

else
begin
delete FROM MTDSubMenu where SubmenuID = @SubmenuID
end
end
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteMTDMenu]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_DeleteMTDMenu]  
@MenuID int   
as  
begin  
Declare @msg varchar(100)  
IF exists(SELECT mM.MenuID FROM MTDMenu mM where mM.RoleID = @MenuID)  
BEGIN  
 set @msg = 'The role id Cannot be delete because it is in use'  
 select @msg  
END  
else if exists(SELECT mM.MenuID FROM MTDMenuSave mM where mM.MenuID = @MenuID)  
BEGIN  
set @msg = 'The role id Cannot be delete because it is in use'  
 select @msg  
end  
  
else if exists(SELECT mM.MenuID FROM MTDSubMenu mM where mM.MenuID = @MenuID)  
BEGIN  
set @msg = 'The role id Cannot be delete because it is in use'  
 select @msg  
end  
  
else if exists(SELECT mM.MainMenuID FROM MTDSubMenuSave mM where mM.MainMenuID = @MenuID)  
BEGIN  
set @msg = 'The role id Cannot be delete because it is in use'  
  
 select @msg  
end  
  
else  
begin  
delete FROM MTDMenu where MenuID = @MenuID  
set @msg = 'Delete successfully!'  
select @msg
end  
end
GO
/****** Object:  StoredProcedure [dbo].[Usp_checklogin]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Usp_checklogin]  
--exec Usp_checklogin 'sai',123  
@username nvarchar(100),  
@password nvarchar(100)  
as  
  
begin  
declare @UID bigint 
declare @RID bigint 
 
select @UID= MU.UserID ,@RID= MU.RoleID from MTDUsers MU where MU.UserName=@username and MU.Password =@password  
  
  
IF(@@rowcount > 0)  
begin  
select @UID as UserID , @RID as RoleID
end  
else  
begin  
select 0 as UserID  
end  
  
  
end
GO
/****** Object:  StoredProcedure [dbo].[UserInsert]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UserInsert]  
@UserName nvarchar(50) ,  
@UserDetails nvarchar(50),   
@Password nvarchar(max)  
as   
  
begin
 

if exists (SELECT
	UserID
FROM MTDUsers
WHERE UserName = @UserName)
 BEGIN
SELECT
	'Already User exits'
 END
 else
 
 begin
INSERT INTO MTDUsers (UserName,
UserDetails,
Password)

	VALUES (@UserName, @UserDetails, @Password)
  
  select 'Created Successfully'
  end
end
GO
/****** Object:  StoredProcedure [dbo].[MTDGetdata]    Script Date: 05/26/2014 21:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[MTDGetdata]


as

begin

select * from MTDUsers
end
GO
