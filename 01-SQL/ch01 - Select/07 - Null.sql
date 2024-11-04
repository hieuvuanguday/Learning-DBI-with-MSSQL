--07-Null.sql
--dữ liệu trong thực tế đôi khi trong thời điểm nhập liệu
--ta biết nó kiểu gì những không biết cụ thể giá trị
--ở trạng thái đó người ta gọi là undefine (bất định, vô định)
--Nêu các học sinh chưa có điểm
--WHERE point is null?|Not point is null | Point is not null
--Cấm "Point = null" (đi tù)
---1. Xài db convenienceStoreDB
USE convenienceStoreDB
--2. Liệt kê danh sách khách hàng
SELECT * FROM Customer
--3. liệt kê danh sách các khách hàng chưa có số điện thoại
SELECT * FROM Customer
	 WHERE PhoneNumber is null
SELECT * FROM Customer 
	WHERE not PhoneNumber is null
--4. liệt kê danh sách các khách hàng đã cập nhật số điện thoại
SELECT * FROM Customer 
	WHERE PhoneNumber is not null
--5. Liệt kê danh sách các đơn hàng chưa có ngày yêu cầu (requiredDate) và đến từ London và California
SELECT * FROM Orders 
	WHERE RequiredDate is null 
	and (ShipCity = N'London' or ShipCity = N'California')
SELECT * FROM Orders 
	WHERE RequiredDate is null 
	and ShipCity in ( N'London', N'California')
--6. Liệt kê danh sách các đơn hàng đã có có ngày yêu cầu (requiredDate)
SELECT * FROM Orders 
	WHERE RequiredDate is not null 
--7. liệt kê danh sách các đơn hàng đã có ngày yêu câu , được ship bởi 2 công ty vận chuyển SHIP001
--và SHIP004
SELECT * FROM Orders 
	WHERE RequiredDate is not null 
	and ShipID in (N'SHIP001', N'SHIP004')
--10. Đơn hàng nào ở London có ngày yêu cầu khác null
SELECT * FROM Orders	
	WHERE RequiredDate is not null 
	and (ShipCity = N'London')

