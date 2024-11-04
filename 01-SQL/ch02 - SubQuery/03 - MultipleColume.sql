--03-MultipleColumn.sql
--Câu select luôn trả ra kết quả dưới dạng table
--Mệnh đề SELECT đầu đủ
--SELECT...FROM...WHERE...GROUP BY...HAVING...ORDER BY....
--SELECT * | Cột, cột
--FROM Table, Table, subQuery

--SELECT mà dùng ở mệnh đề FROM
--cần đáp ứng 2 yêu cầu sau
--1. table kết quả không có 'no column name'
--2. table kết quả phải có tên
----> phải đặt tên hết bằng Alias (as)
USE convenienceStoreDB
--1. Lấy ra các khách hàng đến từ London
SELECT * FROM Customer
	WHERE Country = N'London'
--2. Lấy ra khách hàng đến từ London và đã xác định số điện thoại
SELECT * FROM Customer
	WHERE City = N'London' 
	AND PhoneNumber is not null
--Biểu diễn--
--tỏ ra mình ngầu, thượng đẳng
SELECT * FROM (SELECT * FROM Customer
					WHERE City = N'London' ) as ld
		WHERE PhoneNumber is not null
--Thượng đẳng hơn--
SELECT * FROM (SELECT * FROM Customer
					WHERE PhoneNumber is not null) as ld
		WHERE City = N'London' 
--Thượng đẳng hơn--
SELECT * FROM (SELECT * FROM Customer
					WHERE PhoneNumber is not null AND City = N'London') as ld
--
USE convenienceStoreDB
--3.Liệt kê các đơn hàng gữi đến London, California, Hàng Mã và 
--được nhân viên EMP001 chịu trách nhiệm --8 -- 3 cách
--c1:
SELECT * FROM Orders
	WHERE (ShipCity in (N'London', N'California', N'Hàng Mã'))
	AND EmpID = N'EMP001'
--c2:
SELECT * FROM (SELECT * FROM Orders 
				WHERE ShipCity in (N'London', N'California', N'Hàng Mã')) as TH
	WHERE EmpID = N'EMP001'
--c3:
SELECT * FROM (SELECT * FROM Orders 
				WHERE EmpID = N'EMP001') as TH
	WHERE ShipCity in (N'London', N'California', N'Hàng Mã')
--4.Liệt kê các đơn hàng gữi đến London, California, Hàng Mã và 
--được mua bởi các khách hàng có tên Roney , Hồng--6-- 3 cách
--c1:
SELECT * FROM Orders
	WHERE (ShipCity in (N'London', N'California', N'Hàng Mã'))
	AND CustomerID in (SELECT CusID FROM Customer
							WHERE FirstName in (N'Roney', N'Hồng'))
--c2:
SELECT * FROM (SELECT * FROM Orders WHERE ShipCity in (N'London', N'California', N'Hàng Mã')) as TH
	WHERE CustomerID in (SELECT CusID FROM Customer
							WHERE FirstName in (N'Roney', N'Hồng'))
--c3:
SELECT * FROM (SELECT * FROM Orders WHERE CustomerID in (SELECT CusID FROM Customer
							WHERE FirstName in (N'Roney', N'Hồng'))) as TH
	WHERE ShipCity in (N'London', N'California', N'Hàng Mã')
----5. liệt kê các đơn nhập của nhà cung cấp bởi SUP006 và
-- có số lượng dưới 1000 -- 3 cách
--c1:
SELECT * FROM InputBill
	WHERE SupID = N'SUP006'
	AND Amount < 1000
--c2: 
SELECT * FROM (SELECT * FROM InputBill WHERE Amount < 1000) as TH
	WHERE SupID = N'SUP006'
--c3:
SELECT * FROM (SELECT * FROM InputBill WHERE SupID = N'SUP006') as TH
	WHERE Amount < 1000
---6.(hỏi trực tiếp) liệt kê các đơn nhập của nhà cung cấp bởi Vingroup và
-- có số lượng dưới 1000 -- 3 cách
--c1:
SELECT * FROM InputBill
	WHERE SupID in (SELECT SupID FROM Supplier WHERE SupName = N'Vingroup')
	AND Amount < 1000
--c2: 
SELECT * FROM (SELECT * FROM InputBill WHERE Amount < 1000) as TH
	WHERE SupID in (SELECT SupID FROM Supplier WHERE SupName = N'Vingroup')
--c3:
SELECT * FROM (SELECT * FROM InputBill WHERE SupID in (SELECT SupID FROM Supplier WHERE SupName = N'Vingroup')) as TH
	WHERE Amount < 1000