--Mối quan hệ 1-1
CREATE DATABASE DBK17F3_oneOneRelationship
USE DBK17F3_oneOneRelationship

CREATE TABLE Citizen(
	ID char(9) not null,
	LastName nvarchar(30) not null,
	FirstName nvarchar(15) not null,
)
Alter TABLE Citizen
	add Constraint PK_Citizen_ID Primary Key(ID)
INSERT INTO Citizen
	VALUES ('C1', N'Nguyễn', N'An')
INSERT INTO Citizen
	VALUES ('C2', N'Lê', N'Bình')
INSERT INTO Citizen
	VALUES ('C3', N'Võ', N'Cường')
INSERT INTO Citizen
	VALUES ('C4', N'Phạm', N'Dũng')
---------
--Table Passport
--Mỗi 1 CMND thì được làm 1 cái Passport
--Mỗi 1 cái Passport được làm ra từ một CMND
---> CMND và Passport có mối quan hệ 1-1
CREATE TABLE Passport(
	PNO char(8) not null,
	IssuedDate date, --Ngày thực thi
	ExpiredDate date,
	CMND char(9) not null,
)
ALter TABLE Passport
	add Constraint PK_Passport_PNO Primary Key(PNO)
ALter TABLE Passport
	add Constraint PK_Passport_CMND_CitizenID
		Foreign Key (CMND) References Citizen(ID)
Alter TABLE Passport
	add Constraint PK_Passport_CMND Unique(CMND)

INSERT INTO Passport
	VALUES ('B1', '2022-6-22', '2032-6-22', 'Ahihi')
INSERT INTO Passport
	VALUES ('B2', '2022-6-22', '2032-6-22', 'Ahihi')
--Muốn tạo mối quan hệ 1-1, ta cần 2 ràng buộc chính (FK và UQ)
--Nếu thiếu UQ nó sẽ tạo ra mối quan hệ 1-nhiều
