use convenienceStoreDB
--1. in ra danh sách các khách hàng
SELECT * FROM Customer
--2. Đếm xem mỗi thành phố có bao nhiêu khách hàng
--mỗi khu vực: chia nhóm theo khu vực 
--TỪ MỖI -> GOM NHÓM 
SELECT iif(City is null, 'Nowhere', City), Count(CusID) as Np FROM Customer Group By City
--nếu bạn đếm count(city) bạn sẽ mất các khách hàng chưa xác định thành phố
--vì null nên sẽ không đếm được số lượng của null bằng cách này, vì null nó sẽ
--không đếm, dùng iif để chỉnh city Null thành 'Chưa xác định'
--5. Liệt kê danh sách các thành phố của các đơn hàng, mỗi thanh pho xuat hien
-- 1 lần thoy 
SELECT DISTINCT(iif(ShipCity is null, 'Nowhere', ShipCity)) FROM Orders
--thử dùng group by cho câu này xem sao ?
SELECT (iif(ShipCity is null, 'Nowhere', ShipCity)) as ShipCity FROM Orders Group By ShipCity 
--3. Đếm xem có bao nhiêu quốc gia đã giao dịch trong đơn hàng(cứ có là đếm)
SELECT Count(ShipCountry) as Number FROM Orders
--4. Đếm xem có bao nhiêu quốc gia đã giao dịch trong đơn hàng, mỗi
--quốc gia đếm 1 lần thoy(distinct)
SELECT Count(ShipCountry) FROM (SELECT DISTINCT ShipCountry FROM Orders) as Ld
--4.1 làm nghệ thuật, group by + count + multipleColumn
SELECT Count(ShipCountry) FROM (SELECT ShipCountry FROM Orders Group By ShipCountry) as Ld
--thử count(ShipCountry) trong group by sẽ thấy nó đếm kiểu khác
---
--5. Mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry
--6. mỗi khác hàng đã mua bao nhiêu đơn hàng
SELECT CustomerID, Count(OrdID) as Np FROM Orders Group By CustomerID
--7.khách hàng CUS004 đã mua bao nhiêu đơn hàng(làm 2 cách)
	--c1-hãy dùng group by xem sao ?
	SELECT Count(OrdID) as Np FROM Orders Group By CustomerID 
	Having CustomerID = N'CUS004'
	--c2-thử làm cách không dùng group by, chỉ dùng aggregate và where hoi xem sao ?
	SELECT Count(OrdID) as Np FROM Orders 
	WHERE CustomerID = N'CUS004'
--8. CUS004 CUS001 CUS005 có tổng cộng bao nhiêu đơn hàng
--dùng aggregate + Where hoi xem sao ?
SELECT Count(OrdID) FROM Orders 
WHERE CustomerID in (N'CUS001', N'CUS004', N'CUS005')
--dùng count + where + group by + multipleColume + Sum xem sao ?
SELECT Sum(Np) as Sum FROM (SELECT CustomerID, Count(OrdID) as Np FROM Orders Group By CustomerID) as Ld
WHERE CustomerID in (N'CUS001', N'CUS004', N'CUS005')
--9. Đếm số đơn hàng của mỗi quốc gia --21 rows
SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry
--10. Đếm số đơn hàng của nước Mĩ
--c1.Dùng Count + Where
SELECT Count(OrdID) as Np FROM Orders 
WHERE ShipCountry = N'USA'
--c2.dùng Where + Group By
SELECT Np FROM (SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry) as Ld
WHERE ShipCountry = N'USA'
--c3.dùng having, lọc sau group
SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry 
Having ShipCountry = N'USA'
--11.liệt kê id của các khách hàng nào đã mua trên 2 đơn hàng
SELECT CustomerID, Count(OrdID) FROM Orders Group By CustomerID 
Having Count(OrdID) > 2
--12. Quốc gia nào có số lượng đơn hàng nhiều nhất?????
--phân tích:
-- - đếm số đơn hàng của mỗi quốc gia, count(*), mỗi - group by
-- - đếm xong có quá trời quốc gia, kèm số lượng đơn hàng
-- - ta cần số lớn nhất
-- - ta having cột số lượng vừa đếm >= ALL (??????)
--dùng All()
SELECT ShipCountry FROM Orders Group By ShipCountry 
Having Count(OrdID) >= ALL(SELECT Count(OrdID) as Np FROM Orders Group By ShipCountry)
--thử thách dùng max() đi đại ca :
SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry
Having Count(OrdID) = (SELECT Max(Np) FROM (SELECT ShipCountry, Count(OrdID) as Np FROM Orders Group By ShipCountry) as LD)
--13. Mỗi công ty đã vận chuyển bao nhiêu đơn hàng
SELECT ShipID, Count(OrdID) as Np FROM Orders Group By ShipID
--14. Mỗi nhân viên phụ trách bao nhiêu đơn hàng
--output 1: mã nv, số đơn hàng
SELECT EmpID, Count(OrdID) as Np FROM Orders Group By EmpID
--output2:(khó) mã nv, tên nv, số đơn hàng(phải học nhiều hơn mới làm được, để từ từ làm)
