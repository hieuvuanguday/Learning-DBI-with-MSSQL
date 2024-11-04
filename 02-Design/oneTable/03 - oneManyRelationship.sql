--03 - oneManyRelationship.sql
--Mối quan hệ 1-nhiều
CREATE DATABASE DBK17F3_OneManyRelationship
USE DBK17F3_OneManyRelationship
--Cần luu thông tin của các ứng viên đi thi
--Tạo table City trước
CREATE TABLE City(
	ID int not null,
	Name nvarchar(40),
)
ALTER TABLE City
	add Constraint PK_City_ID Primary Key(ID)
ALTER TABLE City
	add Constraint UQ_City_Name Unique(Name) 

INSERT INTO City VALUES (1, N'TP.HCM')
INSERT INTO City VALUES (2, N'TP.Hà Nội')
INSERT INTO City VALUES (3, N'Bình Dương')
INSERT INTO City VALUES (4, N'TP.Đắk LắK')
INSERT INTO City VALUES (5, N'Bắc Kạn')

SELECT * FROM City
-------------------------------------
CREATE TABLE Candidate(
	ID char(5) not null,
	LastName nvarchar(30) not null,
	FirstName nvarchar (15) not null,
	CityID int,
)

ALTER TABLE Candidate
	add Constraint PK_Candidate_ID Primary Key(ID)
ALTER TABLE Candidate
	add Constraint FK_Candidate_CityID_tblCity 
					Foreign Key(CityID) References City(ID)
--1 City thì có nhiều sinh viên
--CIty(1) - Sinh viên(nhiều)
INSERT INTO Candidate 
	VALUES ('C1', N'Nguyễn', N'An', 1)
INSERT INTO Candidate 
	VALUES ('C2', N'Lê', N'Bình', 1)
INSERT INTO Candidate 
	VALUES ('C3', N'Võ', N'Cường', 2)
INSERT INTO Candidate 
	VALUES ('C4', N'Phạm', N'Dũng', 3)
INSERT INTO Candidate 
	VALUES ('C5', N'Trần', N'Em', 4)
----------------
--1.Liệt Kê Danh Sách Sinh Viên
SELECT * FROM Candidate
--2.liệt kê danh sách sinh viên kèm theo thông tin thành phố
SELECT o.*, t.Name FROM Candidate o Left Join City t ON o.CityID = t.ID  
--2.1.Liệt kê danh sách các tĩnh kèm thông tin sinh viên
SELECT  t.*, o.ID, o.FirstName, o.LastName FROM Candidate o Right Join City t ON o.CityID = t.ID  
--3. in ra các sinh viên ở thành phố hồ chí minh
SELECT o.*, t.Name FROM Candidate o Left Join City t ON o.CityID = t.ID
WHERE t.Name = N'TP.HCM'
--4.đếm xem có bao nhiêu sinh viên
SELECT Count(ID) as Number FROM Candidate
--đếm xem mỗi tỉnh(thành phố) có bao nhiêu sinh viên
SELECT c.*, Ld.Np FROM (SELECT o.ID, Count(t.ID) as Np FROM City o Left Join Candidate t ON o.ID = t.CityID Group By o.ID) as Ld
				Left Join City c ON Ld.ID = c.ID
--đếm xem thành phố hồ chí minh có bao nhiêu sinh viên
SELECT t.ID, Count(o.ID) as Np FROM Candidate o Left Join City t ON o.CityID = t.ID
WHERE t.Name = N'TP.HCM' 
Group By t.ID
--tĩnh nào nhiều sinh viên nhất
SELECT c.* FROM (SELECT o.ID FROM City o Left Join Candidate t ON o.ID = t.CityID Group By o.ID
				Having Count(t.ID) = (SELECT Max(Np) as Maximum FROM (SELECT o.ID, Count(t.ID) as Np 
										FROM City o Left Join Candidate t ON o.ID = t.CityID Group By o.ID) as Ld)) as Th 
				Left Join City c ON Th.ID = c.ID
------
SELECT c.* FROM (SELECT o.ID, Count(t.ID) as Np FROM City o Left Join Candidate t ON o.ID = t.CityID Group By o.ID
					Having Count(t.ID) >= ALL (SELECT Count(t.ID) as Np FROM City o Left Join Candidate t ON o.ID = t.CityID Group By o.ID)) as Th 
			Left Join City c ON Th.ID = c.ID
------ Hiện tượng đổ Domino----------
--Điều gì sẽ xảy ra nếu anh xóa một tỉnh trong table City
--City(1): Gốc - SV(n): Nhánh
--Nếu bến 1 xóa| update thì bên N sẽ thế nào?
--Nếu bên N xóa| update thì bên 1 sẽ thế nào?
-------
--Nếu xóa thành phố có mã là 1 thì sao
DELETE City WHERE ID = '1'
--Bên 1 xóa thì phải đảm bảo rằng không còn nhánh bên N
--Trước tiên thì phải xóa Nhánh trước khi xóa gốc
-------
--Đổi mã của Binh Dương 3 -> 333
UPDATE City SET ID = '333' WHERE ID = '3'
--Nếu UPDATE thì phải xóa nhánh trước rồi mới UPDATE được
--Nếu xóa Bên N thì Bên 1 chả bị làm sao
------------------------V2-DOMINO-------------------------
--Domino: để khi xóa hay cập nhật thì dữ liệu sẽ ăn theo

CREATE TABLE CityV2(
	ID int not null,
	Name nvarchar(40),
)
ALTER TABLE CityV2
	add Constraint PK_CityV2_ID Primary Key(ID)
ALTER TABLE CityV2
	add Constraint UQ_CityV2_Name Unique(Name) 

INSERT INTO CityV2 VALUES (1, N'TP.HCM')
INSERT INTO CityV2 VALUES (2, N'TP.Hà Nội')
INSERT INTO CityV2 VALUES (3, N'Bình Dương')
INSERT INTO CityV2 VALUES (4, N'TP.Đắk LắK')
INSERT INTO CityV2 VALUES (5, N'Bắc Kạn')
-------------------------------------
CREATE TABLE CandidateV2(
	ID char(5) not null,
	LastName nvarchar(30) not null,
	FirstName nvarchar (15) not null,
	CityID int,
)

ALTER TABLE CandidateV2
	add Constraint PK_CandidateV2_ID Primary Key(ID)
ALTER TABLE CandidateV2
	add Constraint FK_CandidateV2_CityID_tblCityV2
					Foreign Key(CityID) References CityV2(ID)
					ON DELETE SET null --Nếu 1 xóa thì N bị NULL
					ON UPDATE CASCADE  --Nếu 1 cập nhật thì N ăn theo
--1 City thì có nhiều sinh viên
--CIty(1) - Sinh viên(nhiều)
INSERT INTO CandidateV2
	VALUES ('C1', N'Nguyễn', N'An', 1)
INSERT INTO CandidateV2 
	VALUES ('C2', N'Lê', N'Bình', 1)
INSERT INTO CandidateV2 
	VALUES ('C3', N'Võ', N'Cường', 2)
INSERT INTO CandidateV2 
	VALUES ('C4', N'Phạm', N'Dũng', 3)
INSERT INTO CandidateV2 
	VALUES ('C5', N'Trần', N'Em', 4)
-------------
DELETE CityV2 WHERE ID = '1'
SELECT * FROM CityV2
SELECT * FROM CandidateV2
DELETE CityV2 WHERE ID = '3'

UPDATE CityV2 SET ID = '222' WHERE ID = '2'
