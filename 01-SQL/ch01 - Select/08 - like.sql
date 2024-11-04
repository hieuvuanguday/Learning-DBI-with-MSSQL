--08 - like.sql
--so sánh bằng nhau '=' là so sánh chính xác
--cell phải chuẩn 100%
--nhưng đôi khi trong thức tế ta cần filter chỉ gần giống mà thoi
--VD: lấy tỉnh thành có chữ Hà
-->Hà Nội, Hà Giang, Hà Tĩnh...
--DBEngine: cung cấp cho mình toán tử like
--giúp cho mình tìm gần đúng, giống như Google

--like đi kèm hai toán từ đặc biệt % và _
--%: sẽ đại diện cho một nhóm ký tự (0 hoặc nhiều)
--_: sẽ đại diện cho một kí tự bất kỳ (có tính cả space)

--VD1: Tìm ra sinh viên có tên là Điệp
---> WHERE name = N'Điệp'
--VD2: Tìm ra sinh viên có chữ Điệp trong tên
--->Điệp Lê, Lê Điệp, Điệp đẹp chai, aaĐiệp,...
---> WHERE name like N'%Điệp%'
--VD3: Tìm ra người có tên là chữ Điệp ở đầu
---> WHERE name like N'Điệp%'
--VD4: Tìm ra người có 3 ký tự trong tên
---> WHERE name like N'___'

-----------------------------
--1. Dùng convenienceStoreDB
USE convenienceStoreDB
--2. In ra danh sách nhân viên
SELECT * FROM Employee
--3. In ra nhân viên có tên là Scarlett (tìm chính xác)  
-- 1 row
SELECT * FROM Employee 
	WHERE FirstName = N'Scarlett'
--4. In ra những nhân viên có tên là Hanna (0 row) 
--vì tìm chính xác 
SELECT * FROM Employee 
	WHERE FirstName = N'Hana'
--5. In ra những nhân viên mà tên có chữ A đứng đầu 
--(2 người, Andrew, Anne)
SELECT * FROM Employee 
	WHERE FirstName like N'A%'
--6. In ra những nhân viên mà họ có chữ A đứng cuối cùng
SELECT * FROM Employee 
	WHERE LastName like N'%A'
--7. In ra những nhân viên mà tên có chữ A 
--(ko quan tâm chữ A đứng ở đâu trong tên)
SELECT * FROM Employee 
	WHERE FirstName like N'%A%'
--8. Những nhân viên nào có tên gồm đúng 3 kí tự 
SELECT * FROM Employee 
	WHERE FirstName like N'___'
--8. Những nhân viên nào có tên gồm đúng 2 kí tự 
----0ROW, VÌ TOÀN LÀ 3 KÍ TỰ TRỞ LÊN 
SELECT * FROM Employee 
	WHERE FirstName like N'__'
--9. Những nhân viên nào mà tên có kí tự cuối cùng là e
SELECT * FROM Employee 
	WHERE FirstName like N'%e'
--9. Những nhân viên nào mà tên có 4 kí tự, 
--kí tự cuối cùng là e
SELECT * FROM Employee 
	WHERE FirstName like N'___e'
--10. Những nhân viên nào mà tên có 6 kí tự,
-- và có chứa chữ A (A ở đâu cũng đc) --3rows
SELECT * FROM Employee 
	WHERE FirstName like N'______' 
		and FirstName like N'%A%'
--11. Tìm các khách hàng mà địa chỉ có I đứng thứ 
--2 kể từ bên trái sang
SELECT * FROM Customer 
	WHERE Address like N'_I%'
--12. Tìm các sản phẩm mà tên sản phẩm có 5 kí tự  -2row
SELECT * FROM Product 
	WHERE ProName like N'_____'
--13.*** Tìm các sản phẩm mà từ cuối cùng trong 
--tên sản phẩm có 5 kí tự
SELECT * FROM Product 
	WHERE ProName like N'% _____' or ProName like N'_____'

--Nâng cao
--1. In ra sản phẩm mà tên của nó có chứa '.'
SELECT  * FROM Product 
	WHERE ProName like N'%.%'
--2. In ra nhân viên mà địa chỉ của nó có chứa '_'
SELECT * FROM Employee
	WHERE Address like N'%[_]%' --Biến nó thành ký tự cần tìm
SELECT * FROM Employee
	WHERE Address like N'%#_%' ESCAPE '#' --Dấu hiệu thoát, thường dùng ~ # $ ^
--3. Tìm kiếm những nhân viên có ' trong tên
SELECT * FROM Employee 
	WHERE FIrstName like N'%''%' --Double dấu nháy đơn lên
-------------DEMO HACK BKAV-------------
SELECT * FROM Employee
	WHERE EmpID = '' AND FirstName = ''Or 1 = '1' --Hack được do cho phép nhập dấu ' trong ô nhập data
SQL Injection