
/*Create function id_Se()
Returns char(6)
AS
Begin
	Return(Right(10000001+isnull(Right(MAX(P_ID),6),0),6)
	From account)
End
GO*/
/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 11                       */
/* Created on:     2018/12/17 10:01:06                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_ACCOUNT_CONTACT1_ROLE') then
    alter table Account
       delete foreign key FK_ACCOUNT_CONTACT1_ROLE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BAG_RELATIONS_MATERIAL') then
    alter table Bag
       delete foreign key FK_BAG_RELATIONS_MATERIAL
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BAG_CONTACT3_EQUIPMEN') then
    alter table Bag
       delete foreign key FK_BAG_CONTACT3_EQUIPMEN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_BAG_CONTACT6_ROLE') then
    alter table Bag
       delete foreign key FK_BAG_CONTACT6_ROLE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ROLE_CONTACT2_BAG') then
    alter table Role
       delete foreign key FK_ROLE_CONTACT2_BAG
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ROLE_CONTACT4_ACCOUNT') then
    alter table Role
       delete foreign key FK_ROLE_CONTACT4_ACCOUNT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CONTACT5_CONTACT5_MONSTER') then
    alter table contact5
       delete foreign key FK_CONTACT5_CONTACT5_MONSTER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CONTACT5_CONTACT7_EQUIPMEN') then
    alter table contact5
       delete foreign key FK_CONTACT5_CONTACT7_EQUIPMEN
end if;

if exists(
   select 1 from sys.systable 
   where table_name='Account'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table Account
end if;

if exists(
   select 1 from sys.systable 
   where table_name='Bag'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table Bag
end if;

if exists(
   select 1 from sys.systable 
   where table_name='Equipment'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table Equipment
end if;

if exists(
   select 1 from sys.systable 
   where table_name='Material'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table Material
end if;

if exists(
   select 1 from sys.systable 
   where table_name='Monster'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table Monster
end if;

if exists(
   select 1 from sys.systable 
   where table_name='Role'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table Role
end if;

if exists(
   select 1 from sys.systable 
   where table_name='contact5'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table contact5
end if;

/*==============================================================*/
/* Table: Account                                               */
/*==============================================================*/
create table Account 
(
   P_ID                 char(6)                        not null,
   R_id                 integer                        null,
   account              char(10)                       null,
   pass_word            varchar(12)                    null,
   constraint PK_ACCOUNT primary key (P_ID)
);

/*==============================================================*/
/* Table: Bag                                                   */
/*==============================================================*/
create table Bag 
(
   B_gold               integer                        null,
   B_id                 integer                        not null,
   R_id                 integer                        null,
   E_id                 integer                        null,
   M_id                 integer                        null,
   constraint PK_BAG primary key (B_id)
);

/*==============================================================*/
/* Table: Equipment                                             */
/*==============================================================*/
create table Equipment 
(
   E_id                 integer                        not null,
   E_name               varchar(10)                    null,
   E_st2                smallint                       null,
   E_damage2            integer                        null,
   E_gold               integer                        null,
   constraint PK_EQUIPMENT primary key (E_id)
);

/*==============================================================*/
/* Table: Material                                              */
/*==============================================================*/
create table Material 
(
   M_id                 integer                        not null,
   M_name               char(10)                       null,
   M_gold               integer                        null,
   constraint PK_MATERIAL primary key (M_id)
);

/*==============================================================*/
/* Table: Monster                                               */
/*==============================================================*/
create table Monster 
(
   G_id                 integer                        not null,
   G_HP                 integer                        null,
   G_damage             integer                        null,
   G_pro                real                           null,
   constraint PK_MONSTER primary key (G_id)
);

/*==============================================================*/
/* Table: Role                                                  */
/*==============================================================*/
create table Role 
(
   R_id                 integer                        not null,
   P_ID                 char(6)                        null,
   B_id                 integer                        null,
   R_name               varchar(10)                    null,
   R_le                 integer                        null,
   R_exp                integer                        null,
   R_damage             integer                        null,
   R_HP                 integer                        null,
   constraint PK_ROLE primary key (R_id)
);

/*==============================================================*/
/* Table: contact5                                              */
/*==============================================================*/
create table contact5 
(
   G_id                 integer                        not null,
   E_id                 integer                        not null,
   constraint PK_CONTACT5 primary key (G_id, E_id)
);

alter table Account
   add constraint FK_ACCOUNT_CONTACT1_ROLE foreign key (R_id)
      references Role (R_id)
      on update restrict
      on delete restrict;

alter table Bag
   add constraint FK_BAG_RELATIONS_MATERIAL foreign key (M_id)
      references Material (M_id)
      on update restrict
      on delete restrict;

alter table Bag
   add constraint FK_BAG_CONTACT3_EQUIPMEN foreign key (E_id)
      references Equipment (E_id)
      on update restrict
      on delete restrict;

alter table Bag
   add constraint FK_BAG_CONTACT6_ROLE foreign key (R_id)
      references Role (R_id)
      on update restrict
      on delete restrict;

alter table Role
   add constraint FK_ROLE_CONTACT2_BAG foreign key (B_id)
      references Bag (B_id)
      on update restrict
      on delete restrict;

alter table Role
   add constraint FK_ROLE_CONTACT4_ACCOUNT foreign key (P_ID)
      references Account (P_ID)
      on update restrict
      on delete restrict;

alter table contact5
   add constraint FK_CONTACT5_CONTACT5_MONSTER foreign key (G_id)
      references Monster (G_id)
      on update restrict
      on delete restrict;

alter table contact5
   add constraint FK_CONTACT5_CONTACT7_EQUIPMEN foreign key (E_id)
      references Equipment (E_id)
      on update restrict
      on delete restrict;
