--01 - Count.sql
--Aggregate: gom tụ
--AggregateFunction: hàm gom các hàng trong table về một kết quả dưới dạng cell (1 ô)
--
--đếm xem có bao nhiêu sinh viên trong lớp
-----
--count(*): đếm hàng cứ có hàng (row) là sẽ đếm
--count(cột): đếm ô trong cột, ô nào có value thì đếm, null thì không đếm
--
--câu select mà có aggregate luôn trả ra kết quả là một ô

USE convenienceStoreDB
--1 - Liệt kê danh sách các nhân viên
SELECT * FROM Employee
--2 - Có bao nhiêu nhân viên
SELECT count(*) FROM Employee -- không rõ nghĩa
SELECT count(EmpID) FROM Employee -- có thể bị mất giá trị do có null
--nên đếm cột PK
------
--5.đếm xem có bao nhiêu khác hàng có số điện thoại (5)
SELECT count(CusID) FROM Customer
	WHERE PhoneNumber is not null
--6.đếm xem có bao nhiêu thành phố đã được xuất hiện trong table khách hàng, cứ có là đếm
SELECT count(City) FROM Customer
	WHERE City is not null
--6.1 Đếm xem có bao nhiêu thành phố, mỗi thành phố đếm 1 lần (customer) 
SELECT count(DISTINCT City) FROM Customer
	WHERE City is not null
--7. Đếm xem có bao nhiêu tp trong table NV, mỗi tp đếm 1 lần
SELECT count(DISTINCT City) FROM Employee
	WHERE City is not null
--8. Có bao nhiêu khách hàng chưa xd đc số điện thoại (5)
SELECT count(CusID) FROM Customer
	WHERE PhoneNumber is null