--02 - JoinAGgregate.sql
--1. Ta sẽ thiết kế Database lưu trữ thông tin sinh viên
--và chuyên ngành sinh viên đó theo học
--Mô tả
--Chuyên ngành gồm: mã chuyên ngành, tên chuyên ngành, phòng ban chuyên ngành, hotline
--VD: JP	Ngôn ngữ Nhật	R102	098x ....
--có tình trạng trường mở ra cn nhưng chưa có học sinh theo học 

--Thông tin sinh viên: mã sinh viên, tên sinh viên, mã chuyên ngành mà sinh viên đó theo học 
--
CREATE DATABASE DBK17F3_Ch04_JoinAggregate

USE DBK17F3_Ch04_JoinAggregate

CREATE TABLE Major(
	ID char(3) Primary Key,
	Name nvarchar(30) not null,
	Room char(5) null,
	Hotline char(11) null,
)

INSERT INTO Major VALUES('IS','Information System','R101','091x...')
INSERT INTO Major VALUES('JS','Japanese Software Eng','R102','091x...')
INSERT INTO Major VALUES('ES','Embedded System','R103',null)
INSERT INTO Major VALUES('JP','Japanese Language','R104','091x...')
INSERT INTO Major VALUES('EN','English','R105','091x...')
INSERT INTO Major VALUES('HT','Hotel Management','R106','091x...')
INSERT INTO Major VALUES('IA','Information Asurance','R103',null)

CREATE TABLE Student(
	ID char(9) Primary Key,
	Name nvarchar(30) not null,
	MID char(3) null,
	Foreign Key (MID) References Major (ID),
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

INSERT INTO Student VALUES ('SE123472', N'Anh Lê', 'IA')
--IS: 4, JS: 4, ES: 3, JP: 2
--HT: 0, EN: 0
--3 sv đang học dự bị, tức là mã CN là null
INSERT INTO Student VALUES ('SE123469', N'Quang Trần', null)
INSERT INTO Student VALUES ('SE123470', N'Rừng Lê', null)
INSERT INTO Student VALUES ('SE123471', N'Sơn Phạm', null)

--1. Có bao nhiêu chuyên ngành  --6rows
SELECT Count(ID) as Np FROM Major
--2. Có bao nhiêu sinh viên
SELECT Count(ID) as Np FROM Student
--3. Có bao nhiêu sv học chuyên ngành IS
SELECT MID, Count(ID) as Np FROM Student Group By MID
Having MID = N'IS'
--4. Đếm xem mỗi CN có bao nhiêu SV
SELECT m.ID, Count(s.ID) as Np FROM Major m Left Join Student s
ON m.ID = s.MID Group By m.ID
--5. Chuyên ngành nào có nhiều SV nhất
--xử lý 2 cn không có sinh viên bằng iff trước khi tìm max min
SELECT m.ID, iif(Count(s.ID) is null, 0, Count(s.ID)) as Np FROM Major m Left Join Student s
ON m.ID = s.MID Group By m.ID
Having iif(Count(s.ID) is null, 0, Count(s.ID)) >= ALL(SELECT iif(Count(s.ID) is null, 0, Count(s.ID)) as Np FROM Major m Left Join Student s
ON m.ID = s.MID Group By m.ID)
--6. Chuyên ngành nào có ít sv nhất
--<= ALL:
SELECT m.ID, Count(s.ID) as Np FROM Major m Left Join Student s
ON m.ID = s.MID Group By m.ID
Having Count(s.ID) <= ALL(SELECT Count(s.ID) as Np FROM Major m Left Join Student s
ON m.ID = s.MID Group By m.ID)
--dùng min:
SELECT m.ID, Count(s.ID) as Np FROM Major m Left Join Student s
ON m.ID = s.MID Group By m.ID
Having COUNT(s.ID) = (SELECT Min(Np) as Mincolume FROM (SELECT m.ID, Count(s.ID) as Np FROM Major m Left Join Student s
ON m.ID = s.MID Group By m.ID) as Ld)
--7. Đếm số sv của cả 2 chuyên ngành ES và JS 
--dùng Where + aggregate: 
SELECT Count(ID) as Np FROM Student
Where MID in (N'ES', N'JS')
--dùng Group by + MultipleColum + sum : 
SELECT Sum(Np) FROM (SELECT m.ID, Count(s.ID) as Np FROM Major m Left Join Student s ON m.ID = s.MID Group By m.ID 
						Having m.ID in (N'ES', N'JS')) as Ld
--8. Mỗi chuyên ngành ES và JS có bao nhiêu sv
SELECT m.ID, Count(s.ID) as Np FROM Major m Left Join Student s ON m.ID = s.MID Group By m.ID 
Having m.ID in (N'ES', N'JS')
--9. Chuyên ngành nào có từ 3 sv trở lên
SELECT m.ID, Count(s.ID) as Np FROM Major m Left Join Student s ON m.ID = s.MID Group By m.ID 
Having Count(s.ID) >= 3
--10. Chuyên ngành nào có từ 2 sv trở xuống
SELECT m.ID, Count(s.ID) as Np FROM Major m Left Join Student s ON m.ID = s.MID Group By m.ID 
Having Count(s.ID) <= 2
--11. Liệt kê danh sách sv của mỗi CN
--output: mã cn, tên cn, mã sv, tên sv
SELECT m.ID, m.Name, s.ID, s.Name FROM Major m Left Join Student s ON m.ID = s.MID
--12. Liệt kê thông tin chuyên ngành của mỗi sv
--output: mã sv, tên sv, mã cn, tên cn, room
SELECT s.ID, s.Name, s.MID, m.Name, m.Room FROM Student s Left Join Major m ON s.MID = m.ID
--thử thách làm lại câu 13 siêu khó của bài MaxMinSumAll
--Done!

Use convenienceStoreDB
--1. đếm xem mỗi nhà vận chuyển đã vận chuyển bao nhiêu đơn hàng ?
--output: mã nhà vận chuyển, tên nhà vận chuyển, số lượng đơn hàng
SELECT Ld.ShipID, s.CompanyName, Ld.Np 
	FROM (SELECT s.ShipID, Count(OrdID) as Np 
			FROM Shipper s Left Join Orders o 
			ON s.ShipID = o.ShipID 
			Group By s.ShipID) as Ld
	Left Join Shipper s --Dùng 'Right Join' ở đây được bởi vì 2 bảng đang ngang nhau về ShipID
	ON Ld.ShipID = s.ShipID	
--2. đếm xem mỗi nhà vận chuyển đã vận chuyển bao nhiêu đơn hàng đến USA?
--output: mã nhà vận chuyển, tên nhà vận chuyển, số lượng đơn hàng
SELECT Ld.ShipID, s.CompanyName, Ld.Np 
	FROM (SELECT s.ShipID, Count(OrdID) as Np 
					FROM Shipper s Left Join Orders o 
					ON s.ShipID = o.ShipID 
					WHERE o.ShipCountry = N'USA' --WHERE có thể xài chung với Group By
					Group By s.ShipID) as Ld 
	Left Join Shipper s 
	ON Ld.ShipID = s.ShipID

--3. Khách hàng CUS001 , CUS005, CUS007 dã mua bao nhiêu đơn hàng
--output: mã khách hàng, tên khách hàng, số lượng khách hàng
SELECT Ld.CusID, c.FirstName, c.LastName, Ld.Np 
	FROM (SELECT c.CusID, Count(OrdID) as Np 
			FROM Customer c Left Join Orders o 
			ON c.CusID = o.CustomerID Group By CusID 
			Having c.CusID in (N'CUS001', N'CUS005', N'CUS007')) as Ld 
	Left Join Customer c 
	ON Ld.CusID = c.CusID   
--4. Khách hàng CUS001 , CUS005, CUS007 dã mua bao nhiêu đơn hàng vận chuyển tới đúng quê của họ
--output: mã khách hàng, tên khách hàng, số lượng khách hàng
SELECT Ld1.CusID, c.FirstName, c.LastName, Ld1.Np 
	FROM (SELECT CusID, Count(OrdID) as Np 
			FROM (SELECT * 
					FROM Customer c
					Full Join Orders o 
					ON c.CusID = o.CustomerID 
			WHERE c.CusID in (N'CUS001', N'CUS005', N'CUS007')
			AND City = ShipCity) as Ld 
	Group By CusID) as Ld1 
	Left Join Customer c 
	ON Ld1.CusID = c.CusID