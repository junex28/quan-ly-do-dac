use master
go
drop database DDBDUserManagement
go
create database DDBDUserManagement
go
use DDBDUserManagement
go
/*==============================================================*/
/* Table: ACCOUNT                                               */
/*==============================================================*/
create table ACCOUNT 
(
   ACCOUNTID            int                    identity(1,1)        not null,
   USERACCOUNT          int,
   ROLEID               int,
   PASSWORD             nvarchar(30),
   FIRSTNAME            nvarchar(20),
   LASTNAME             nvarchar(20),
   ADDRESS              nvarchar(250),
   CELLPHONE            varchar(15),
   EMAIL                nvarchar(250),
   DESCRIPTION          text,
   STATUSID             int,
   constraint PK_ACCOUNT primary key clustered (ACCOUNTID)
);

/*==============================================================*/
/* Table: ACCOUNTPERMISSION                                     */
/*==============================================================*/
create table ACCOUNTPERMISSION 
(
   ACCOUNTID            int                           not null,
   PERMISSIONID         int                            not null,
   constraint PK_ACCOUNTPERMISSION primary key clustered (ACCOUNTID, PERMISSIONID)
);

/*==============================================================*/
/* Table: PERMISSION                                            */
/*==============================================================*/
create table PERMISSION 
(
   PERMISSIONID         int                  identity(1,1)          not null,
   PERMISSIONTYPEID     int,
   PERMISSIONNAME       nvarchar,
   DESCRIPTION          text,
   constraint PK_PERMISSION primary key clustered (PERMISSIONID)
);

/*==============================================================*/
/* Table: PERMISSIONTYPE                                        */
/*==============================================================*/
create table PERMISSIONTYPE 
(
   PERMISSIONTYPEID     int                       identity(1,1)     not null,
   PERMISSIONTYPENAME   nvarchar(100),
   constraint PK_PERMISSIONTYPE primary key clustered (PERMISSIONTYPEID)
);

/*==============================================================*/
/* Table: ROLE                                                  */
/*==============================================================*/
create table ROLE 
(
   ROLEID               int                         not null,
   ROLENAME             nvarchar(50),
   constraint PK_ROLE primary key clustered (ROLEID)
);

/*==============================================================*/
/* Table: ROLEPERMISSION                                        */
/*==============================================================*/
create table ROLEPERMISSION 
(
   ROLEID               int                         not null,
   PERMISSIONID         int                            not null,
   constraint PK_ROLEPERMISSION primary key clustered (ROLEID, PERMISSIONID)
);

/*==============================================================*/
/* Table: STATUS                                                */
/*==============================================================*/
create table STATUS 
(
   STATUSID             int                 identity(1,1)           not null,
   STATUSNAME           nvarchar(50),
   constraint PK_STATUS primary key clustered (STATUSID)
);

alter table ACCOUNT
   add constraint FK_ACCOUNT_REFERENCE_STATUS foreign key (STATUSID)
      references STATUS (STATUSID)
      on update cascade
      on delete cascade;

alter table ACCOUNT
   add constraint FK_ACCOUNT_REFERENCE_ROLE foreign key (ROLEID)
      references ROLE (ROLEID)
      on update cascade
      on delete cascade;

alter table ACCOUNTPERMISSION
   add constraint FK_ACCOUNTP_REFERENCE_PERMISSI foreign key (PERMISSIONID)
      references PERMISSION (PERMISSIONID)
      on update cascade
      on delete cascade;
use DDBDUserManagement
go

alter table ACCOUNTPERMISSION
   add constraint FK_ACCOUNTP_REFERENCE_ACCOUNT foreign key (ACCOUNTID)
      references ACCOUNT (ACCOUNTID)
      on update cascade
      on delete cascade;

alter table PERMISSION
   add constraint FK_PERMISSI_REFERENCE_PERMISSI foreign key (PERMISSIONTYPEID)
      references PERMISSIONTYPE (PERMISSIONTYPEID)
      on update cascade
      on delete cascade;

alter table ROLEPERMISSION
   add constraint FK_ROLEPERM_REFERENCE_ROLE foreign key (ROLEID)
      references ROLE (ROLEID)
      on update cascade
      on delete cascade;

alter table ROLEPERMISSION
   add constraint FK_ROLEPERM_REFERENCE_PERMISSI foreign key (PERMISSIONID)
      references PERMISSION (PERMISSIONID)
      on update cascade
      on delete cascade;
      
/*-----------------view---------------------------------*/
CREATE VIEW [dbo].[ViewPermissionAndType]
AS
SELECT        dbo.Permission.PermissionID AS Expr1, dbo.PermissionType.PERMISSIONTYPENAME, dbo.PermissionType.PermissionTypeID AS Expr2, dbo.Permission.PERMISSIONNAME, 
                         dbo.Permission.Description, dbo.Permission.PermissionTypeID
FROM            dbo.Permission INNER JOIN
                         dbo.PermissionType ON dbo.Permission.PermissionTypeID = dbo.PermissionType.PermissionTypeID
go
--------------
CREATE VIEW [dbo].[RolePermissionView]
AS
SELECT     dbo.RolePermission.RoleID, dbo.Role.ROLENAME, dbo.RolePermission.PermissionID, dbo.Permission.PERMISSIONNAME, dbo.Permission.PermissionTypeID, 
                      dbo.PermissionType.PERMISSIONTYPENAME
FROM         dbo.RolePermission INNER JOIN
                      dbo.Role ON dbo.RolePermission.RoleID = dbo.Role.RoleID INNER JOIN
                      dbo.Permission ON dbo.RolePermission.PermissionID = dbo.Permission.PermissionID INNER JOIN
                      dbo.PermissionType ON dbo.Permission.PermissionTypeID = dbo.PermissionType.PermissionTypeID
GO
------------------------
create VIEW [dbo].[AccountView]
AS
SELECT     dbo.Account.AccountID, dbo.Account.USERACCOUNT, dbo.Account.RoleID, dbo.Account.Password, dbo.Account.FIRSTNAME,dbo.Account.LASTNAME, 
                      dbo.Account.Address, dbo.Account.CellPhone, dbo.Account.Email, dbo.Account.Description, 
                      dbo.Account.STATUSID, dbo.Role.ROLENAME, dbo.STATUS.STATUSNAME
FROM         dbo.Account INNER JOIN
                      dbo.Role ON dbo.Account.RoleID = dbo.Role.RoleID INNER JOIN
                      dbo.Status ON dbo.Account.STATUSID = dbo.Status.StatusID
GO
---------------------------
CREATE VIEW [dbo].[AccountPermissionView]
AS
SELECT     dbo.AccountPermission.AccountID, dbo.Account.USERACCOUNT, dbo.Account.RoleID, dbo.Role.ROLENAME, dbo.Account.Password, dbo.Account.FIRSTNAME, 
                      dbo.ACCOUNT.LASTNAME, dbo.Account.StatusID, dbo.STATUS.STATUSNAME , dbo.AccountPermission.PermissionID, dbo.Permission.PERMISSIONNAME, 
                      dbo.Permission.PermissionTypeID, dbo.PermissionType.PERMISSIONTYPENAME, dbo.Permission.Description
FROM         dbo.AccountPermission INNER JOIN
                      dbo.Account ON dbo.AccountPermission.AccountID = dbo.Account.AccountID INNER JOIN
                      dbo.Role ON dbo.Account.RoleID = dbo.Role.RoleID INNER JOIN
                      dbo.Status ON dbo.Account.StatusID = dbo.Status.StatusID INNER JOIN
                      dbo.Permission ON dbo.AccountPermission.PermissionID = dbo.Permission.PermissionID INNER JOIN
                      dbo.PermissionType ON dbo.Permission.PermissionTypeID = dbo.PermissionType.PermissionTypeID
GO
-------------------------------------------------------




