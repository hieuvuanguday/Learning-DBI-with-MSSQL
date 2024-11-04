--06-where
------------------------
--I-Lý Thuyết
------------------------
--một câu select đầy đủ sẽ là
--select .. from... where...group by ..having...order by 

--vế select sẽ giúp ta filter các cột mà mình muốn
--1.select * from table_x 
--			sẽ lấy ra hết tất cả các cột
--			và các dòng của table x
--2. select id, name from table_X 
--			lấy ra cột id và cột name được
--			liệt kê và tất cả các dòng của tableX

--From giúp ta biết phải lấy từ table nào
--Where giúp ta filter data theo dòng dựa vào điều kiện cột

--4.select * from tableX where <condition clause>:lấy hết
-- tất cả các cột ,nhưng chỉ lấy các dòng thỏa điều kiện
--5. toán tử: <= >= = != <>
--logic: and or not
--nên dùng () để bọc mệnh để cho dễ phân biệt

--------------------------
--Thực Hành
--------------------------

 use convenienceStoreDB
 --1. Liệt kê các nhân viên
SELECT * FROM Employee
 --2. Liệt kê các nhân viên đang ở thành phố California
SELECT * FROM Employee WHERE City = 'California'
 --3. Liệt kê các nhân viên ở London.
 --output: ID, Name (ghép fullname), Title, Address
 SELECT EmpID, FirstName + ' ' + LastName AS FullName, Title, Address FROM Employee WHERE City = 'London'

 --4. Liệt kê tất cả các nhân viên ở thành phố London và California 
 SELECT * FROM Employee WHERE City = 'London' or City = 'California' --chứ and dùng khi mệnh đề trái và phải đều đúng chỗ này phải dùng or

 --5. Liệt kê tất cả các nhân viên ở thành phố London hoặc NY 
 SELECT * FROM Employee WHERE City = 'London' or City = 'NY'

 --6. liệt kê các đơn hàng
 SELECT * FROM Orders
 --7. liệt kê các đơn hàng không giao tới 'Hàng Mã'
 SELECT * FROM Orders WHERE ShipCity != N'Hàng Mã' -- cẩn thận chữ có dấu 
 
--8. liệt kê các đơn hàng không giao tới 'Hàng Mã' và London
 SELECT * FROM Orders WHERE ShipCity != N'Hàng Mã' and ShipCity != 'London'
 --hoặc cách này
 SELECT * FROM Orders WHERE not (ShipCity = N'Hàng Mã' or ShipCity = 'London') -- cách phủ định này hiệu quả hơn

--9. liệt kê các đơn hàng không giao tới 'Hàng Mã' hoặc London
 SELECT * FROM Orders WHERE ShipCity != N'Hàng Mã' or ShipCity != 'London'

--10. Liệt kê các nhân viên có chức danh là Promotion
SELECT * FROM Employee WHERE Title = 'Promotion'

--11. Liệt kê các nhân viên có chức danh không là Promotion
--làm bằng 3 cách	!= 
SELECT * FROM Employee WHERE Title != 'Promotion'
--					<>
SELECT * FROM Employee WHERE Title <> 'Promotion' -- dấu này cũng như !=
--					not
SELECT * FROM Employee WHERE not Title = 'Promotion' 


--12. Liệt kê các nhân viên có chức danh là Promotion hoặc TeleSale
SELECT * FROM Employee WHERE Title = 'Promotion' or Title = 'Telesale'

--13. Liệt kê các nhân viên có chức danh là Promotion và Mentor
SELECT * FROM Employee WHERE Title = 'Promotion' or Title = 'Mentor' -- dùng or chứ k dùng and vì 1 người không thể có 2 title đc

--14. Liệt kê các nhân viên có chức danh không là Promotion và Telesale
SELECT * FROM Employee WHERE Title != 'Promotion' and Title <> 'Telesale'

--16. Những nhân viên nào có năm sinh trước 1972
SELECT * FROM Employee WHERE year(Birthday) < 1972 

--17. Những nhân viên nào tuổi lớn hơn 40, in ra thêm cột tuổi, và sắp xếp 
SELECT *, year(getdate()) - year(Birthday) AS AGE FROM Employee WHERE year(getdate()) - year(Birthday) > 40 ORDER BY AGE ASC 
--ở sau WHERE khôgn dùng age để so sánh được vì WHERE so sánh dữ liệu đang thực hiện chứ k phải kết quả nghĩa là khi đó chưa có cột age
--Sau ORDER BY dùng được vì nó so sánh kết quả

--18. Đơn hàng nào nặng hơn 100 và được gữi đến thành phố london
SELECT * FROM Orders WHERE Freight > 100 and ShipCity = 'London'

--19.khác hàng nào có tuổi trong khoản 29 - 21 và đang ở london không ? hãy in ra
SELECT *, year(getdate()) - year(Birthday) AS AGE FROM Customer WHERE (year(getdate()) - year(Birthday) > 21 and year(getdate()) - year(Birthday) < 29) and City = N'London'
SELECT *, year(getdate()) - year(Birthday) AS AGE FROM Customer -- check thôi
--nên () mệnh đề tuổi vì nó so sánh thứ khác so với city
--nên để N trước london để tránh trường hợp dấu (cẩn thận)

--20. Liệt kê các khách hàng đến từ Anh Quốc hoặc Vietnam
	--custom
SELECT * FROM Customer WHERE Country = 'UK' or Country = 'Vietnam'

--21. Liệt kê các các đơn hàng đc gửi tới Vietnam hoặc Nhật bản
SELECT * FROM Orders WHERE ShipCountry = 'Vietnam' or ShipCountry = 'Japan'


--22. Liệt kê các đơn hàng nặng từ 500.0 đến 100.0 pound (nằm trong đoạn, khoảng)
SELECT * FROM Orders WHERE Freight <= 500 and Freight >= 100 --đoạn
SELECT * FROM Orders WHERE Freight < 500 and Freight > 100 --khoảng


--23. ktra lại cho chắc, sắp giảm dần kết quả theo cân nặng đơn hàng 
SELECT * FROM Orders ORDER BY Freight DESC

--24. Liệt các đơn hàng gửi tới Anh, 
--Mĩ, Việt sắp xếp tăng dần theo trọng lượng
SELECT * FROM Orders WHERE ShipCountry = 'UK' 
or ShipCountry = 'Vietnam' 
or ShipCountry = 'USA' ORDER BY Freight ASC


--25. Liệt các đơn hàng KHÔNG gửi tới Anh, Pháp Mĩ, và có cân nặng trong khoản 50-100
-- sắp xếp tăng dần theo trọng lượng 
SELECT * FROM Orders WHERE not (ShipCountry = 'UK' 
or ShipCountry = 'France' 
or ShipCountry = 'USA') 
and (Freight > 50 and Freight < 100) ORDER BY Freight ASC

--26. Liệt kê các nhân viên sinh ra trong khoảng năm 1970-1999
SELECT * FROM Employee WHERE year(Birthday) > 1970 and year(Birthday) < 1999