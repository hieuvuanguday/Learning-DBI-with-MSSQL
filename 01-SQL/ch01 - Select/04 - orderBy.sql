--04. OrderBy
--SELECT luôn trả về kết quả dưới dạng table
--ta có thể sắp xếp kết quả đó theo một cột nào đó
--việc sắp xếp chỉ ảnh hưởng đến kết quả không ảnh hưởng đến data gốc

--quy tắc so sánh: 
--				số: so sánh bth
--			ngày tháng: ngày ở tương lai lớn hơn ngày ở quá khứ VD 11-11-1990 < 22-05-2022
--			ss chuỗi: chuỗi dài hơn không có nghĩa là lớn hơn

--vd
--table student
--VD xếp Score tăng dần 
--		xếp  name giảm dần thì nó sẽ đi từ trái qua phải nghĩa là xếp name rồi mới xếp score 
--		sau đó thì nó sẽ tự đổi với nhau đối với những thg bị trùng
--ID   | Name | Score | YOB
--001  | ABC | 10    | 1999
--002  | ADC | 4     | 2003
--003  | ABCD  | 8     | 2003
--004  | ABC | 9     | 2003
--005  | ABCD | 10    | 1999

--trong này thì thg ADC lớn nhất tức là ưu tiên value hơn size, so value trước mới so độ dài theo ASI II không quan tâm hoa thường
--cùng value thg nào size to thì to hơn
--so sánh nhiều cột cùng lúc không quan tâm vị trí 
--luôn từ trái qua phải


--muốn sx dùng ORDER BY cột ASC | DESC
--ASC: ascending tăng dần
--DESC: descending giảm dần
--ORDER BY luôn nằm sau SELECT
--không dùng DISTINCT với * vì nó lấy ra PK rồi không cần DISTINCT
USE convenienceStoreDB

--1. in ra thông tin các đơn hàng
SELECT * FROM Orders

--2. liệt kê danh sách các đơn hàng đã được sắp xếp theo trọng lượng
SELECT * FROM Orders ORDER BY Freight ASC --nhớ syntax

--3. Sắp xếp theo tên nhân viên 
--tăng dần
SELECT * FROM Employee ORDER BY FirstName ASC
--giảm dần
SELECT * FROM Employee ORDER BY FirstName DESC

--4. sắp xếp đơn hàng tăng dân theo mã nhân viên chịu trách nhiệm và giảm dần
SELECT * FROM Orders ORDER BY EmpID ASC, Freight DESC