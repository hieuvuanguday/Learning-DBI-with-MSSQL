--03-Distinct.sql
use ConvenienceStoreDB

--1 table thường luôn có 1 cột đặc biệt tên là PK(primary key)
--1 câu lệnh select luôn trả ra kết quả dưới dạng table
-- khi mà ta select * thì kết quả trả về luôn không không có dòng nào
--	trùng 100%
--nhưng nếu ta SELECT cột, cột giả sử không liệt kê cột PK
--		thì kết quả trả về có thể có dòng trùng 100%
-- những cặp trùng thì có tên là tuple
--để loại bỏ dòng trùng ta thêm Distinct ngay sau select
--SELECT Distinct cột, cột  ...

--table student
--ID   | Name | Score | YOB
--001  | Điệp | 10    | 1999
--002  | Tùng | 4     | 2003
--003  | Nam  | 8     | 2003
--004  | Tùng | 9     | 2003
--005  | Diệp | 10    | 1999

--1. in ra thông tin khách hàng
SELECT * FROM Customer

--2. khách hàng của bạn đã đến từ những thành phố nào,
--liệt kê danh sách các thành phố có khánh hàng của bạn
SELECT DISTINCT City FROM Customer

--3.in ra thông tin các gói hàng đã nhập vào kho
SELECT * FROM InputBill

--4. in ra các sản phẩm đã nhập vào kho
SELECT DISTINCT ProID FROM InputBill