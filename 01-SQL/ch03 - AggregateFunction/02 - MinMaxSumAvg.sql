--02 - MinMaxSumAvg.sql
--tạo database
CREATE DATABASE K17F3_ch03_aggregate
USE K17F3_ch03_aggregate
--tạo table lưu điểm trung bình của sinh viên
CREATE Table GPA(
	Name nvarchar(20),
	Point float,
	Major char(3),
)
INSERT INTO GPA VAlUES (N'An', 9, 'IS') --Nhúng
insert into GPA values(N'Bình', 7, 'IS')
insert into GPA values(N'Cường', 5, 'IS')

insert into GPA values(N'Dũng', 8, 'JS')
insert into GPA values(N'Em', 7, 'JS')
insert into GPA values(N'Giang', 4, 'JS')
insert into GPA values(N'Hương', 8, 'JS')

insert into GPA values(N'Khanh', 7, 'ES')
insert into GPA values(N'Minh', 6, 'ES')
insert into GPA values(N'Nam', 5, 'ES')
insert into GPA values(N'Oanh', 5, 'ES')
--
SELECT * FROM GPA
--IS 3
--JS 4
--ES 4
----------------------------
--Min() Max() Sum() Avg()
----------------------------
--tất cả những thằng này là aggregate
--các hàm gom nhóm, gom nhiều về 1 số duy nhất
--gom nhiều value trên 1 cột về thành 1 số
--***Lưu ý: Aggregate sẽ không lồng vào nhau được
--	Max(count(*)) => gãy
------------------------
--1.Có tất cả bao nhiêu sinh viên
SELECT Count(*) FROM GPA
SELECT Count(Name) FROM GPA
--2. Chuyên ngành nhúng có bao nhiêu sinh viên
SELECT Count(Name) FROM GPA 
	WHERE Major = N'IS'
--2.1 Chuyên ngành nhúng và cầu nối có tổng cộng bao nhiêu sinh
--viên('JS','IS')
SELECT Count(Name) FROM GPA 
	WHERE Major in (N'JS', N'IS')
--2.2 Con điểm bao nhiêu là cao nhất trong danh sách sinh viên
SELECT Max(Point) FROM GPA 
--nếu xài All
SELECT Point FROM GPA
	WHERE Point >= ALL (SELECT Point FROM GPA)
--2.3 ai là người cao điểm nhất trong đám sinh viên
SELECT* FROM GPA 
	WHERE Point = (SELECT Max(Point) FROM GPA)
--2.4 tính tổng điểm của tất cả sinh viên
SELECT Sum(Point) FROM GPA
--2.5 điểm trung bình của tất cả sinh viên là bao nhiêu
SELECT Avg(Point) FROM GPA 
--Khi đọc đề gặp từ "mỗi - each" thì phải nhớ dùng Group By
--Group By: là gôm nhóm các Object theo một tiêu chí nào đó
--Ví dụ: ta có danh sách sinh viên (name, yob, city, point)
--Hãy gôm nhóm sinh viên teo thành phố
--TP		Số lượng sinh viên
--HCM				30
--HN				32
--Đà Nẵng			18
---Mỗi năm sinh có bao nhiêu sinh viên
--YOB			Số lượng sinh viên
--1999					2
--2001					34
--2002					18
--***Lưu ý: Muốn xài Group By thì phải nhớ thần chú này
--'Khi xài Group By thì mệnh đề SELECT của nó phải 
--chỉ có những cột trong Group By hoặc phải là Aggregate'
--
--3. Mỗi chuyên ngành có bao nhiêu nhân viên
SELECT Major, Count(Name) as Np FROM GPA Group By Major
--4. Điểm cao nhất của mỗi chuyên ngành là bao nhiêu?
SELECT Major, Max(Point) as Np FROM GPA Group By Major
--ALL

--4.1 Điểm trung bình của mỗi chuyên ngành là bao nhiêu
SELECT Major, Avg(Point) as Np FROM GPA Group By Major
--*******************************************************
--Thêm vào 2 data nữa để tăng độ khó
INSERT INTO GPA VALUES(N'Phượng', 8 , 'JP')
--thêm Phượng 8 điểm, ngôn ngữ nhật
--->trường bổ sung thêm ngành hotel management
INSERT INTO GPA VALUES(Null, Null , 'HT')
--***Sau khi đã thêm data xem lại kết quả câu 3,  
--câu 3 làm lại:
SELECT Major, Count(Name) as Np FROM GPA Group By Major
--ES 	4
--HT 	0
--IS 	3
--JP 	1
--JS 	4
--*************************************************
--SELECT...FROM...WHERE...GROUP BY...Order By...
--Having: chính là WHERE sau khi gôm nhóm
--Dùng để lọc kết quả sau khi gôm nhóm (Group By)
--***Lưu ý: Muốn xài Group By thì phải nhớ thần chú này
--'Khi xài Group By thì mệnh đề SELECT(Having) của nó phải 
--chỉ có những cột trong Group By hoặc phải là Aggregate'
--5. Chuyên ngành có từ 4 sinh viên trở lên
SELECT Major, Count(Name) as Np FROM GPA Group By Major
Having Count(Name) >= 4
--5.1 Ngành JS, IS, ES mỗi ngành đó có bao nhiêu sinh viên
SELECT Major, Count(Name) as Np FROM GPA Group By Major
----Xài bằng WHERE
SELECT Major, Count(Name) FROM GPA WHERE Major in (N'IS', N'ES', N'JS')
Group By Major
--6. Chuyên ngành nào có ít sinh viên nhất
--ALL()
SELECT Major FROM GPA Group By Major
Having Count(Name) <= ALL(SELECT Count(Name) as Np FROM GPA Group By Major) 
--để anh demo MIN():
SELECT Major, Count(Name) as Np FROM GPA Group By Major
--MultipleColume
SELECT Min(Np) FROM (SELECT Major, Count(Name) as Np FROM GPA Group By Major) as Lđ
---
SELECT Major, count(Name) as Np FROM GPA Group by Major
Having Count(name) = (SELECT Min(np) FROM (SELECT Major, count(Name) as Np 
				FROM GPA Group by Major) as ld)

--7.Điểm lớn nhất của ngành IS là mấy điểm
--Dùng Max()
SELECT Max(Point) as Np FROM GPA 
	WHERE Major = N'IS'
--Dùng All()
SELECT Point FROM GPA WHERE Major = N'IS' 
	AND Point >= ALL (SELECT Point FROM GPA WHERE Major = N'IS')
--7.1 lấy Full thông tin của sinh viên thuộc ngành is có điểm
--lớn nhất --Dùng Max()
SELECT * FROM GPA WHERE Major = N'IS' 
	AND Point = (SELECT Max(Point) FROM GPA WHERE Major = N'IS')
--11.Điểm lớn nhất của mỗi chuyên ngành(cẩn thận HT) --Dùng Max()
--gợi ý dùng iif(<Đối tượng so sánh> is null, <giá trị thay thể>, <vị trí thay thế>)
SELECT Major, iif(Max(Point) is null, 0, Max(Point)) as Np FROM GPA Group By Major
--12.Chuyên ngành nào có thủ khoa có điểm trên 8 --Dùng Max()
SELECT Major, iif(Max(Point) is null, 0, Max(Point)) as Np FROM GPA Group By Major
Having Max(Point) > 8
--13***.Liệt kê những sinh viên đạt thủ khoa của mỗi chuyên ngành
--(chưa làm được)(đệ quy- join)
SELECT Ld.Major, Ld.Np, g.Name FROM (SELECT Major, Max(Point) as Np FROM GPA Group By Major) as Ld Left Join GPA g
ON Ld.Major = g.Major
USE convenienceStoreDB
--************Đề******************
--14.1. Trọng lượng nào là con số lớn nhất, tức là trong các đơn "hàng đã vận chuyển",
-- trọng lượng nào là lớn nhất, trọng lượng lớn nhất 
--là bao nhiêu???
--> lấy giá trị lớn nhất trong 1 tập hợp
---Dùng All:
SELECT Freight FROM Orders 
	WHERE Freight >= ALL(SELECT Freight FROM Orders)
---Dùng MAX Thử:
SELECT Max(Freight) FROM Orders
--14. Đơn hàng nào có trọng lượng lớn nhất
--Output: mã đơn, mã kh, trọng lượng
--dùng All thử:
SELECT OrdID, CustomerID, Freight FROM Orders 
	WHERE Freight >= ALL(SELECT Freight FROM Orders)
--dùng MAX thử: 
SELECT OrdID, CustomerID, Freight FROM Orders 
	WHERE Freight = (SELECT Max(Freight) FROM Orders)
--15.Đếm số đơn hàng của mỗi quốc gia 
--Output: quốc gia, số đơn hàng
--nghe chữ mỗi: chia nhóm theo .... => dùng Group By ngay 
SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry
--15.1-Hỏi rằng quốc gia nào có từ 8 đơn hàng trở lên
--việc đầu tiên là phải đếm số đơn hàng của mỗi quốc gia
--đếm xong, lọc lại coi thằng nào >= 8 đơn thì in 
--lọc lại sau khi group by, chính là HAVING
SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry
Having Count(OrdID) >= 8
--16.Quốc gia nào có nhiều đơn hàng nhất??
--Output: quốc gia, số đơn hàng
--đếm xem mỗi quốc gia có bao nhiêu đơn hàng
--sau đó lọc lại
--Dùng ALL Thử: 
SELECT ShipCountry, Np FROM (SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry) as Ld
WHERE Np >= ALL(SELECT Np FROM (SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry) as Ld)
--Dùng Max thử: 
SELECT ShipCountry, Np FROM (SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry) as Ld
WHERE Np = (SELECT Max(Np) FROM (SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry) as Ld)
--Nếu ko đc dùng >= ALL
--tim max sau khi đếm, mà ko đc dùng max(count) do SQL ko cho phép
--ta sẽ count, coi kết quả count là 1 table, tìm max của table này để
--ra đc 12
--Thử dùng Max() xem sao
--17.Mỗi cty đã vận chuyển bao nhiêu đơn hàng
--Output1: Mã cty, số lượng đơn hàng - hint: group by ShipId(ShipVia)
SELECT ShipID, count(OrdID) as Np FROM Orders Group By ShipID
--*khó*Output2: mã cty, tên cty, sl (để in ra được câu này thì phải học nhiều hơn)
SELECT Ld.ShipID, s.CompanyName, Ld.Np FROM (SELECT ShipID, count(OrdID) as Np FROM Orders Group By ShipID) as Ld Left Join Shipper s
ON Ld.ShipID = s.ShipID
--18.Cty nào vận chuyển ít đơn hàng nhất
--Output1: Mã cty, số lượng đơn
---Dùng All Thử: 
SELECT ShipID, Np FROM (SELECT ShipID, Count(OrdID) as Np FROM Orders Group By ShipID) as Ld
WHERE Np <= ALL (SELECT Np FROM (SELECT ShipID, Count(OrdID) as Np FROM Orders Group By ShipID) as Ld)
---dùng Min() thử xem: 
SELECT ShipID, Np FROM (SELECT ShipID, Count(OrdID) as Np FROM Orders Group By ShipID) as Ld
WHERE Np = (SELECT Min(Np) FROM (SELECT ShipID, Count(OrdID) as Np FROM Orders Group By ShipID) as Ld)
--*Khó*Output2: mã cty, tên cty, sl (để in ra được câu này thì phải học nhiều hơn)
SELECT Ld.ShipID, s.CompanyName, Ld.Np FROM (SELECT ShipID, Count(OrdID) as Np FROM Orders Group By ShipID
				Having Count(OrdID) <= ALL(SELECT Count(OrdID) as Np FROM Orders Group By ShipID)) as Ld Left Join Shipper s
				ON Ld.ShipID = s.ShipID
--19.in ra danh sách id các khánh hàng kèm tổng
-- cân nặng của tất cả đơn hàng họ đã mua
---->câu này hỏi khác đi: số lượng cân nặng mà khách hàng đã mua
--hint: Sum + Group by:
SELECT CustomerID, Sum(Freight) as Np FROM Orders Group By CustomerID
--20.khách hàng nào có tổng cân nặng của 
--tất cả đơn hàng họ đã mua là lớn nhất
--dùng ALL():
SELECT CustomerID FROM (SELECT CustomerID, Sum(Freight) as Np FROM Orders Group By CustomerID) as Ld
WHERE Np >= ALL (SELECT Np FROM (SELECT CustomerID, Sum(Freight) as Np FROM Orders Group By CustomerID) as Ld)
--Dùng Max thử: 
SELECT CustomerID FROM (SELECT CustomerID, Sum(Freight) as Np FROM Orders Group By CustomerID) as Ld
WHERE Np = (SELECT Max(Np) FROM (SELECT CustomerID, Sum(Freight) as Np 
			FROM Orders Group By CustomerID) as Ld)
--21.NY, London có tổng bao nhiêu đơn hàng
-- dùng count bth xem sao
SELECT Count(OrdID) FROM Orders
WHERE ShipCity in (N'NY', N'London')
--group by having, sum cho nghệ thuật: 
SELECT Sum(Np) FROM (SELECT ShipCity, Count(OrdID) as Np FROM Orders Group By ShipCity
				Having ShipCity in (N'NY', N'London')) as Ld
--22.công ty vận chuyển nào vận chuyển nhiều đơn hàng nhất
--dùng thử All(): 
SELECT ShipID FROM (SELECT ShipID, Count(OrdID) as Np FROM Orders Group By ShipID) as Ld
WHERE Np >= ALL(SELECT Np FROM (SELECT ShipID, Count(OrdID) as Np FROM Orders Group By ShipID) as Ld)
--Dùng MAX() thử xem:
SELECT ShipID FROM (SELECT ShipID, Count(OrdID) as Np FROM Orders Group By ShipID) as Ld
WHERE Np = (SELECT Max(Np) FROM (SELECT ShipID, Count(OrdID) as Np FROM Orders Group By ShipID) as Ld)