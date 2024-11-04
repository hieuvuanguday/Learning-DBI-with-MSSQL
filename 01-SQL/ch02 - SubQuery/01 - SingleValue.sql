--02 - SubQuery
--	01-SingleVlue
--SELECT.....FROM.....WHERE.....ORDER BY.....
--SELECT * | Cột, Cột
--FROM Table, Table (Join)
--WHERE điều kiện lọc data (lọc hàng, lọc dữ liệu)
--Order by cột asc| desc (sắp xếp kết quả)
USE convenienceStoreDB
--Liệt kê các nhân viên đến từ cùng thành phố với nhân viên có mã số là emp004
SELECT City FROM Employee 
	WHERE EmpID = N'EMP004'
--SIngleValue: câu SELECT trả ra kết quả chỉ có 1 hàng 1 cột
--trả ra cell| 1 data
SELECT * FROM Employee
	WHERE (City = (SELECT City FROM Employee 
					WHERE EmpID = N'EMP004'))
	AND (not EmpID = N'EMP004')

-----------------------------------------------------------------------------
--1. In ra những nhân viên ở London 
SELECT * FROM Employee 
	WHERE City = N'London'
--2. In ra những nhân viên cùng quê với Angelina
SELECT * FROM Employee
	WHERE (Country = (SELECT Country FROM Employee
					WHERE FirstName = N'Angelina'))
	AND (not EmpID = (SELECT EmpID FROM Employee
					WHERE FirstName = N'Angelina'))
--3. Liệt kê các đơn hàng có ngày yêu cầu giao
SELECT * FROM Orders 
	WHERE RequiredDate is not null
--4. Liệt kê các đơn hàng có trọng lượng lớn hơn trọng lượng của
--đơn hàng có mã số ORD021
SELECT * FROM Orders
	WHERE Freight > (SELECT Freight FROM Orders 
						WHERE OrdID = N'ORD021')
--5. Liệt kê các đơn hàng trọng lượng lớn hơn đơn hàng ORD021
--và vận chuyển đến cùng tp với đơn hàng mã ORD012, tính cả đơn ORD012
SELECT * FROM Orders
	WHERE (Freight > (SELECT Freight FROM Orders 
						WHERE OrdID = N'ORD021'))
	AND (ShipCity = (SELECT ShipCity FROM Orders
						WHERE OrdID = N'ORD012'))
--6. Liệt kê các đơn hàng đc ship cùng tp với đơn hàng ORD014
--và có trọng lượng > 50 pound
SELECT * FROM Orders
	WHERE (Freight > 50)
	AND (ShipCity = (SELECT ShipCity FROM Orders
						WHERE OrdID = N'ORD014'))
	AND (not OrdID = N'ORD014')
--Nhưng nên:
SELECT * FROM Orders
	WHERE (Freight > 50)
	AND (ShipCity = (SELECT ShipCity FROM Orders
						WHERE OrdID = N'ORD014'))
--7. Những đơn hàng nào đc vận chuyển bởi cty vận chuyển mã số 
--là SHIP003  và được ship đến cùng thành phố với đơn hàng ORD012(ShipVia)
SELECT * FROM Orders
	WHERE (ShipID = N'SHIP003')
	AND (ShipCity = (SELECT ShipCity FROM Orders
						WHERE OrdID = N'ORD012'))
--8. Hãng Giaohangtietkiem vận chuyển những đơn hàng nào
SELECT * FROM Orders 
	WHERE ShipID = (SELECT ShipID FROM Shipper
					WHERE CompanyName = N'Giaohangtietkiem')
--9. Liệt kê danh sách các mặt hàng/món hàng/products gồm mã sp
--tên sp, chủng loại (category)
SELECT ProID, ProName, CategoryID FROM Product
--10. pork shank thuộc nhóm hàng nào 
--output: mã nhóm, tên nhóm (xuất hiện ở table Category)
SELECT CategoryID, CategoryName FROM Category
	WHERE CategoryID = (SELECT CategoryID FROM Product
							WHERE ProName = N'pork shank')
--11. Liệt kê danh sách các món hàng có cùng chủng loại với mặt hàng pork shank
--có tính pork shank
SELECT * FROM Product
	WHERE CategoryID = (SELECT CategoryID FROM Product
							WHERE ProName = N'pork shank')
--12. liệt kê các sản phầm có chủng loại là thịt
SELECT * FROM Product
	WHERE CategoryID = (SELECT CategoryID FROM Category
							WHERE CategoryName = N'meat')
--13. liệt kê ID các nhà cung cấp , cung cấp sản phẩm có tên là pork shank
SELECT * FROM InputBill
	WHERE ProID = (SELECT ProID FROM Product
						WHERE ProName = N'pork shank')
--Extra: Liệt kê full thông tin của nhà cung cấp
SELECT * FROM Supplier
	WHERE SupID in (SELECT SupID FROM InputBill
						WHERE ProID = (SELECT ProID FROM Product
											WHERE ProName = N'pork shank'))
--Xài "in" không xài "=" vì sau trả ra là một tập hợp giá trị
--Hoặc xài "in" hết cho đỡ đi tù

--Multiple Value: Câu select
--trả ra kết quả dưới dạng 1 tập giá trị
--				1 cột nhiều hàng| hay 1 cột 1 hàng (singleValue)


