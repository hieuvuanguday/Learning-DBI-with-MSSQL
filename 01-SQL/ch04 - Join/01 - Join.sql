--CH04-Join
--01.Join.sql
CREATE DATABASE DBIK17_CH04_Join
USE DBIK17_CH04_Join

--tạo table Master

CREATE TABLE Master(
	MNO int,
	ViDesc nvarchar(10)
)

INSERT INTO Master VALUES (1, N'Một')
INSERT INTO Master VALUES (2, N'Hai')
INSERT INTO Master VALUES (3, N'Ba')
INSERT INTO Master VALUES (4, N'Bốn')
INSERT INTO Master VALUES (5, N'Năm')

DELETE Master

SELECT * FROM Master


CREATE TABLE Detailed(
	DNO int,
	EnDesc nvarchar(10)
)

INSERT INTO Detailed VALUES (1, N'One')
INSERT INTO Detailed VALUES (3, N'Three')
INSERT INTO Detailed VALUES (5, N'Five')
INSERT INTO Detailed VALUES (7, N'Seven')

DELETE Detailed

SELECT * FROM Detailed

SELECT * FROM Master,Detailed
WHERE MNO = DNO

--tích đề cát 
--Descartes
--Pro thì k viết tích decartes
--Dùng Join... On

SELECT * FROM Master INNER JOIN Detailed --Table Master sẽ xác nhập vào table Detailed dựa trên MNO = DMO
ON MNO = DNO--INNER JOIN là 2 thg có thg chung với nhau thì mới xác nhập

--JOIN môn đăng hộ đối, cả 2 thg đều có mới được
--JOIN dựa trên điểm tương đồng (INNER JOIN)
-------------------------------------------------

--OUTTER JOIN: join phần ngoài

--nó sẽ có 3 dạng
SELECT * FROM Master LEFT JOIN Detailed ON MNO = DNO--này nghĩa là nhận Master làm gốc
--và kéo sang Detailed tìm phần chung
--nếu không có thì null
SELECT * FROM Master RIGHT JOIN Detailed ON MNO = DNO
--Detailed làm gốc, giữ được hết data của Detailed nhưng có thể mất data của Master
--Full join
SELECT * FROM Master FULL JOIN Detailed ON MNO = DNO
--Anh giứ cả hai làm gốc
--Tìm được điểm chung thì nối
--Không thì Null
SELECT * FROM Master CROSS JOIN Detailed -- Hoang sơ

CREATE TABLE Major(
	ID char(3) Primary Key,
	Name nvarchar(30),
	Room char(4),
	Hotline char(10),
)

INSERT INTO Major VALUES ('IS','Information System','R101','091x...')
INSERT INTO Major VALUES ('JS','Japanese Software Eng','R101','091x...')
INSERT INTO Major VALUES ('ES','Embedded System','R102','091x...')
INSERT INTO Major VALUES ('JP','Japanese Language','R103','091x...')
INSERT INTO Major VALUES ('EN','English','R102',null)
INSERT INTO Major VALUES ('HT','Hotel Management','R103',null)

CREATE TABLE Student(
	ID char(8) Primary Key,
	Name nvarchar(30),
	MID char(3) null,
	Foreign Key(MID) References Major(ID) --Chỉ định khóa ngoài, để tham khảo giá trị từ cột khác từ bằng khác
)

INSERT INTO Student VALUES ('SE123456', N'An Nguyễn', 'IS')
INSERT INTO Student VALUES ('SE123457', N'Bình Lê', 'IS')
INSERT INTO Student VALUES ('SE123458', N'Cường Võ', 'IS')
INSERT INTO Student VALUES ('SE123459', N'Dũng Phạm', 'IS')

INSERT INTO Student VALUES ('SE123460', N'Em Trần', 'JS')
INSERT INTO Student VALUES ('SE123461', N'Giang Lê', 'JS')
INSERT INTO Student VALUES ('SE123462', N'Hương Võ', 'JS') 
INSERT INTO Student VALUES ('SE123463', N'Khanh Lê', 'JS') 

INSERT INTO Student VALUES ('SE123464', N'Lan Trần', 'ES')
INSERT INTO Student VALUES ('SE123465', N'Minh Lê', 'ES')
INSERT INTO Student VALUES ('SE123466', N'Ninh Phạm', 'ES') 

INSERT INTO Student VALUES ('SE123467', N'Oanh Phạm', 'JP')
INSERT INTO Student VALUES ('SE123468', N'Phương Nguyễn', 'JP')
--
--IS: 4, JS: 4, ES: 3, JP: 2
--HT: 0, EN: 0
--3 sv đang học dự bị, tức là mã CN là null
INSERT INTO Student VALUES ('SE123469', N'Quang Trần', null)
INSERT INTO Student VALUES ('SE123470', N'Rừng Lê', null)
INSERT INTO Student VALUES ('SE123471', N'Sơn Phạm', null)

--Liệt kê danh sách chuyên ngành kèm theo danh sách sinh viên theo học
SELECT * FROM Major m Left Join Student s on m.ID = s.MID 
--Đản bảo không mất chuyên ngành nào hết
--Nhưng mất 3 sinh viên chưa có chuyên ngành
--
SELECT * FROM Major m Right Join Student s on m.ID = s.MID 
--Đảm bảo không mất sinh viên nào
--Nhưng mất 2 chuyên ngành không có sinh viên
--
SELECT * FROM Major m Full Join Student s on m.ID = s.MID 
--Không mất gì hết, có 3 sinh viên chưa có chuyên ngành và 2 chuyên ngành chưa có sinh viên
--
SELECT * FROM Major m Inner Join Student s on m.ID = s.MID 
--Mất 2 chuyên ngành và cả 3 sinh viên

----------------------------------
use convenienceStoreDB
--1. Mỗi khách hàng đã mua bao nhiêu đơn hàng
--Output 1: Mã customer, số đơn hàng
SELECT CusID, Count(OrdID) as Np
FROM Customer c Left Join Orders o ON c.CusID = o.CustomerID Group By CusID
--Output 2: Mã customer, tên customer, số đơn hàng  
--**************************LƯU Ý***************************************
--nhớ rằng phải xác định table nào là góc, table nào là table bị kéo
--table góc sẽ hiển thị đầy đủ danh sách và thông tin của đối tượng
--chỉ nên lấy data của bên góc, khi cần hoặc gốc không có mới lấy data của phụ
SELECT c.CusID, c.FirstName, c.LastName, Ld.Np FROM (SELECT CusID, Count(OrdID) as Np
FROM Customer c Left Join Orders o ON c.CusID = o.CustomerID Group By CusID) as Ld Left Join Customer c
ON Ld.CusID = c.CusID
--2. khác hàng nào mua nhiều đơn hàng nhất
--Output: Mã cty, tên cty, số đơn hàng  
SELECT c.CusID, c.FirstName, c.LastName, Ld.Np FROM (SELECT CusID, Count(OrdID) as Np
FROM Customer c Left Join Orders o ON c.CusID = o.CustomerID Group By CusID) as Ld Left Join Customer c
ON Ld.CusID = c.CusID
WHERE Ld.Np >= ALL(SELECT Ld.Np FROM (SELECT CusID, Count(OrdID) as Np
FROM Customer c Left Join Orders o ON c.CusID = o.CustomerID Group By CusID) as Ld Left Join Customer c
ON Ld.CusID = c.CusID)
--nhớ rằng chơi kiểu này không thể lấy ra những thằng không mua hàng được
--phải join trước rồi mới group by thì sẽ lấy được giá trị 0 cho những thằng k mua hàng
SELECT CusID, Count(OrdID) FROM (SELECT * FROM Orders o FULL Join Customer c on o.CustomerID = c.CusID) as Ld Group By CusID
--Hỏng hỉu gì hết chơn!!!
--//
--3. Mỗi nhân viên đã chăm sóc bao nhiêu đơn hàng
--Output 1: Mã nhân viên, số đơn hàng
SELECT e.EmpID, Count(o.OrdID) as Np FROM  Employee e Left Join Orders o 
ON e.EmpID = o.EmpID Group By e.EmpID
--Output 2: Mã nhân viên, tên nhân viên, số đơn hàng  
SELECT e.EmpID, e.FirstName, e.LastName, Ld.Np FROM (SELECT e.EmpID, Count(o.OrdID) as Np FROM  Employee e Left Join Orders o 
ON e.EmpID = o.EmpID Group By e.EmpID) as Ld Left Join Employee e 
ON Ld.EmpID = e.EmpID
--4. show ra ai(những ai) là khách hàng mua nhiều đơn hàng nhất 
SELECT c.CusID, c.FirstName, c.LastName, Ld.Np FROM (SELECT CusID, Count(OrdID) as Np
FROM Customer c Left Join Orders o ON c.CusID = o.CustomerID Group By CusID) as Ld Left Join Customer c
ON Ld.CusID = c.CusID
WHERE Ld.Np >= ALL(SELECT Ld.Np FROM (SELECT CusID, Count(OrdID) as Np
FROM Customer c Left Join Orders o ON c.CusID = o.CustomerID Group By CusID) as Ld Left Join Customer c
ON Ld.CusID = c.CusID)
--5. show ra ai(những ai) là khách hàng mua ít đơn hàng nhất
SELECT c.CusID, c.FirstName, c.LastName, Ld.Np FROM (SELECT CusID, Count(OrdID) as Np
FROM Customer c Left Join Orders o ON c.CusID = o.CustomerID Group By CusID) as Ld Left Join Customer c
ON Ld.CusID = c.CusID
WHERE Ld.Np <= ALL(SELECT Ld.Np FROM (SELECT CusID, Count(OrdID) as Np
FROM Customer c Left Join Orders o ON c.CusID = o.CustomerID Group By CusID) as Ld Left Join Customer c
ON Ld.CusID = c.CusID)