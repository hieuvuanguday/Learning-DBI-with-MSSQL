/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     6/28/2022 8:58:11 PM                         */
/*==============================================================*/
CREATE DATABASE DBK17F2_StudentClub
USE DBK17F2_StudentClub

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('REGISTRATION') and o.name = 'FK_REGISTRA_FK_REGIST_CLUB')
alter table REGISTRATION
   drop constraint FK_REGISTRA_FK_REGIST_CLUB
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('REGISTRATION') and o.name = 'FK_REGISTRA_FK_REGIST_STUDENT')
alter table REGISTRATION
   drop constraint FK_REGISTRA_FK_REGIST_STUDENT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLUB')
            and   type = 'U')
   drop table CLUB
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('REGISTRATION')
            and   name  = 'FK_REGISTRATION_CID_CLUBCID_FK'
            and   indid > 0
            and   indid < 255)
   drop index REGISTRATION.FK_REGISTRATION_CID_CLUBCID_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('REGISTRATION')
            and   name  = 'FK_REGISTRATION_SID_STUDENTSID_FK'
            and   indid > 0
            and   indid < 255)
   drop index REGISTRATION.FK_REGISTRATION_SID_STUDENTSID_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('REGISTRATION')
            and   type = 'U')
   drop table REGISTRATION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('STUDENT')
            and   type = 'U')
   drop table STUDENT
go

/*==============================================================*/
/* Table: CLUB                                                  */
/*==============================================================*/
create table CLUB (
   CID                  char(5)              not null,
   NAME                 varchar(40)          not null,
   constraint PK_CLUB primary key (CID)
)
go

/*==============================================================*/
/* Table: REGISTRATION                                          */
/*==============================================================*/
create table REGISTRATION (
   SEQ                  int                  not null,
   CID                  char(5)              null,
   SID                  char(8)              null,
   REGDATE              datetime             not null,
   LEVDATE              datetime             null,
   constraint PK_REGISTRATION primary key (SEQ)
)
go

/*==============================================================*/
/* Index: FK_REGISTRATION_SID_STUDENTSID_FK                     */
/*==============================================================*/




create nonclustered index FK_REGISTRATION_SID_STUDENTSID_FK on REGISTRATION (SID ASC)
go

/*==============================================================*/
/* Index: FK_REGISTRATION_CID_CLUBCID_FK                        */
/*==============================================================*/




create nonclustered index FK_REGISTRATION_CID_CLUBCID_FK on REGISTRATION (CID ASC)
go

/*==============================================================*/
/* Table: STUDENT                                               */
/*==============================================================*/
create table STUDENT (
   SID                  char(8)              not null,
   NAME                 varchar(40)          not null,
   constraint PK_STUDENT primary key (SID)
)
go

alter table REGISTRATION
   add constraint FK_REGISTRA_FK_REGIST_CLUB foreign key (CID)
      references CLUB (CID)
go

alter table REGISTRATION
   add constraint FK_REGISTRA_FK_REGIST_STUDENT foreign key (SID)
      references STUDENT (SID)
go

