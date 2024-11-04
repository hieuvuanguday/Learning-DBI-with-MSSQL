--04 - All.sql
--muốn tạo một ngôi nhà (database):
--Create database databaseName
CREATE DATABASE DBK17F3_SubQuery_ALL
USE DBK17F3_SubQuery_ALL
----
--Tạo table lưu một vài số lẻ
--CREATE TABLE tableName
CREATE TABLE Odds(
	Number int  --tạo ra cột tên number, kiểu integer
)
SELECT * FROM Odds
----INSERT :  DML : Data manipulation language
INSERT INTO Odds VALUES (1)
INSERT INTO Odds VALUES (3)
INSERT INTO Odds VALUES (5)
INSERT INTO Odds VALUES (7)
INSERT INTO Odds VALUES (9)

SELECT * FROM Odds

--DROP: vứt cả cái table | DELETE: xóa Data
--DELETE Odds
--DROP (table| database): vứt cả cái table| DELETE: xóa data
----------------
--tạo table lưu một vài số chẵn
CREATE TABLE Evens(
	Number int 
)
INSERT INTO Evens VALUES (0)
INSERT INTO Evens VALUES (2)
INSERT INTO Evens VALUES (4)
INSERT INTO Evens VALUES (6)
INSERT INTO Evens VALUES (8)
--------------------
--tạo bảng chứa các số nguyên
CREATE TABLE Integers(
	Number Int
)
INSERT INTO Integers VALUES (0)
INSERT INTO Integers VALUES (2)
INSERT INTO Integers VALUES (4)
INSERT INTO Integers VALUES (6)
INSERT INTO Integers VALUES (8)
INSERT INTO Integers VALUES (1)
INSERT INTO Integers VALUES (3)
INSERT INTO Integers VALUES (5)
INSERT INTO Integers VALUES (7)
INSERT INTO Integers VALUES (9)
-----
SELECT * FROM Odds
SELECT * FROM Evens
SELECT * FROM Integers
---------------
--ALL
--1.SQL Cung cấp thêm một toán tử ALL dùng để kết hợp với 
--mệnh đề so sánh (> < >= <= = !=)
--Cú pháp:
-- toán tử so sánh ALL (Sub-MultipleValue | SIngleValue)
--ví dụ
--WHERE Cột so sánh với ALL (tập hợp)
--> so sánh các value có trong cột xem thử chúng nó thế nào 
--với tất cả những thằng bên trong tập hợp

---
-- WHERE Cột A > ALL (Cột B)
---> trong cột A có ai có giá trị lớn hơn tất cả các value trong cột B không?

------------Học sinh lớp A có ai coa điểm hơn tất cả học sinh bên lớp B không?
--1 - Trong Evens những số nào lớn hơn tất cả những số bên Odds?
SELECT * FROM Evens
	WHERE Number > ALL (SELECT Number FROM Odds)
--2 - Trong Odds những số nào lớn hơn tất cả những số bên Evens?
SELECT * FROM Odds
	WHERE Number > ALL (SELECT Number FROM Evens)
--3 - Trong Odds những số nào lớn hơn tất cả những số bên Odds?
SELECT * FROM Odds
	WHERE Number > ALL (SELECT Number FROM Odds)
--4 - Trong Odds những số nào lớn hơn hoặc bằng tất cả những số bên Odds?
SELECT * FROM Odds
	WHERE Number >= ALL (SELECT Number FROM Odds)
--5. Tìm số bé nhất trong Integer
-- Tìm bé nhất là tự so với chính mình
SELECT * FROM Integers
	WHERE Number <= ALL (SELECT Number FROM Integers)
---
USE convenienceStoreDB
--1 - In ra thông tin nhân viên kèm tuổi của họ
SELECT *, YEAR(GETDATE()) - YEAR(Birthday) as AGE FROM Employee
--2 - Tìm ra người có tuổi lớn nhất trong danh sách nhân viên
SELECT *, YEAR(GETDATE()) - YEAR(Birthday) as AGE FROM Employee
WHERE YEAR(GETDATE()) - YEAR(Birthday) >=
	 ALL (SELECT YEAR(GETDATE()) - YEAR(Birthday) as AGE FROM Employee)
--3 - Trong các nhân viên ở USA, nhân viên nào có tuổi lớn nhất

insert into Employee values ('Emp014',N'Tuấn',N'Nguyễn',N'Telesale','HCM','49 Võ Văn Tần', 'VietNam',N'1960-01-01')

SELECT *, YEAR(GETDATE()) - YEAR(Birthday) as AGE FROM (SELECT * FROM Employee
													WHERE Country = N'USA') as TH
WHERE YEAR(GETDATE()) - YEAR(Birthday) >=
	 ALL (SELECT YEAR(GETDATE()) - YEAR(Birthday) as AGE FROM (SELECT * FROM Employee
													WHERE Country = N'USA') as TH)

--4. in ra thông tin của những sản phẩm thuộc chủng loại, quần áo, túi,moto
SELECT * FROM Product
	WHERE CategoryID in (SELECT CategoryID FROM Category
							WHERE CategoryName in (N'clothes', N'bag', N'moto'))
--5. Đơn hàng nào có trọng lượng lớn nhất???
--PHÂN TÍCH: lấy ra đc tập hợp các trọng lượng đang có 
--sau đó sàng lại trong đám trọng lượng, ai lớn hơn hay bằng tất cả
SELECT * FROM Orders
	WHERE Freight >= ALL (SELECT Freight FROM Orders)
--5.1. Trong tất cả các đơn hàng, trọng lượng lớn nhất là bao nhiêu
SELECT Freight FROM Orders
	WHERE Freight >= ALL (SELECT Freight FROM Orders)
--6. Trong các đơn hàng gửi tới Hàng Mã, Tokyo đơn hàng nào trọng lượng
--lớn nhất (vi diệu)
SELECT * FROM (SELECT * FROM Orders WHERE ShipCity in (N'Hàng Mã', N'Tokyo')) as TH
	WHERE Freight >= ALL (SELECT * FROM (SELECT Freight FROM Orders WHERE ShipCity in (N'Hàng Mã', N'Tokyo')) as TH)
--7. Trong các đơn hàng gửi tới Hàng Mã, Tokyo đơn hàng nào trọng lượng
--nhỏ nhất (vi diệu)
SELECT * FROM (SELECT * FROM Orders WHERE ShipCity in (N'Hàng Mã', N'Tokyo')) as TH
	WHERE Freight <= ALL (SELECT * FROM (SELECT Freight FROM Orders WHERE ShipCity in (N'Hàng Mã', N'Tokyo')) as TH)
--8. Sản phẩm nào giá bán cao nhất
SELECT * FROM Product 
	WHERE Price >= ALL (SELECT Price FROM Product)
--9. Sản phẩm có giá bán cao nhất thuộc chủng loại gì
SELECT * FROM Category
	WHERE CategoryID in (SELECT CategoryID FROM Product 
							WHERE Price >= ALL (SELECT Price FROM Product))