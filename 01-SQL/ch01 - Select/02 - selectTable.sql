--02 - selectTable


--Thực tế có rất nhiều dạng database trên thế giới
--RDBMS: relationship database management system
---đại diện là (Oracle, MySQL, MS Sever, PostgreSQL)

--CSDL dạng khóa - key - value (Hashmap, Redis, Memcached)  (Blockchain)
--Document Store -(MongoDB, couchbase) 



--ưu điểm chúng ta học RDBMS: vì nó đáp ứng ACID
--		Atomicity: tính nguyên tố: trong 1 chu trình có nhiều tác vụ nếu 1 tác vụ false -> cả chu trình false
--		Consistency: tính nhất quán: sao kê vd như khi chuyển 3tr từ A điệp thì B phải tăng 3tr nếu không thì tiền sẽ quay lại bên tk A điệp đảm bảo rõ ràng
--					1 tác vụ nào đó sẽ tạo ra trạng thái mới hợp lệ cho data
--					nếu trong qt thực hiện tác vụ mà có lỗi thì quay ngược lại trạng thái hợp lệ ban đầu
--		Isolation: tính độc lập
--		Durability: tính bền vững: dữ liệu đã xác nhận sẽ được hệ thống lưu lại, trong trường hợp hỏng hóc thì dữ liệu sẽ được đảm bảo không bị mất do lỗi hệ thống ko phải do mất table
--		ví dụ: anh điệp cần chuyển tiền cho tài khoản B: cái này gọi là 1 chu trình
--		1 chu trình có nhiều tác vụ
--		đầu tiên là kiểm tra số tiền còn của A điệp 
--		check tính khả dụng tk của a Điệp nghĩa là tk có bị đóng băng không
--		rút tiền ra chuẩn bị Chuyển
--		check tk B 
--		sau khi check hết mới chuyển
--		Atomicity sẽ check hết các tác vụ trên nếu true hết thì chu trình mới hoàn thành
--		nếu trong quá trình check có 1 false thì nó sẽ không thực hiện
--		tiền đang được chuyển sẽ chuyển ngược lại cho Điệp nhờ Consistency
--		A điệp có 10tr chuyển cho A 7tr: chưa xác nhận
--		A phải chuyển cho B: giờ chỉ còn chuyển được 3tr vì 7tr đã bị cô lập khỏi những tác vụ khác
--		1 tác vụ đang được thực thi thì phải tách biệt với các tác vụ khác


--truy xuất thông qua SQL đa dụng, dễ dàng phát triển, mở rộng
--cung cấp phân quyền (admin, guest, user, ...)

--nhược điểm: xử lý dữ liệu phi cấu trúc kém, do đáp ứng ACID nên data phải rõ ràng đi kèm tốc độ xử lý chậm
--lưu trữ khó thì bảo mật cao ngược lại, lưu trữ linh hoạt thì bảo mật kém

--vậy nên dùng khi nào:
--Các trường hợp khi muốn giữ vững tính toàn vẹn dữ liệu
--Không thể bị chỉnh sửa dễ dàng
--vd dùng trong ứng dụng tài chính (Misa), Ứng dụng trong quốc phòng các trang chính phủ
--		lĩnh vực thông tin cá nhân sức khỏe
--		lĩnh vực tự động hóa
--		thông tin nội bộ

--Trong database có nhiều table

--table là gì ? là danh của 1 dạng đối tượng nào đó
--trong table có gì, có cột
--1 dòng là full thông tin của object
--> 1 dòng là 1 object
--trong 1 table thường có nhiều cột
--cột | column | field | property | attribute

--trong 1 table thường luôn có 1 cột đặc biệt
--là data trong cột không bao giờ trùng 
--> ý nghĩa: giúp nhận dạng object
-->          giúp không dòng nào trùng 100%

--table student
--ID   | Name | Score | YOB
--001  | Điệp | 10    | 1999
--002  | Tùng | 4     | 2003
--003  | Nam  | 8     | 2003
--004  | Tùng | 9     | 2003
--005  | Diệp | 10    | 1999

--2. Database là gì?
--là 1 tập hợp của nhiều table có cùng chủ đề, cùng giải quyết 1 bài toán lưu trữ
--vd Muốn tạo db quản lý bán hàng
--Nhân viên, khách hàng, sản phẩm, nhà cung cấp, shipper,...
--3. Để xem, thêm, xóa, sửa thì cần dùng
--nhóm câu lệnh thuộc SQL(bộ DML hay data manipulation language) ngoài ra 2 cái còn lại là DDL data definition language, DCL data control language
--SQL: SELECT, insert, update, delete

--I--Thực hành
--chọn database
USE convenienceStoreDB --lệnh chọn database
--1. Liệt kê danh sách nhân viên có đầy đủ thông tin
--Quy tắc select chuyên nghiệp:
--Nhớ table nào? -> table Employee
--Cột nào? -> tất cả cột --> dùng dấu * để lấy toàn bộ
SELECT * FROM Employee --lấy toàn bộ cột tại Employee

--2. Liệt kê danh sách nhân viên, ta chỉ xem một vài cột thôi
--lấy ra ID, name, birthday
--thường là dùng SELECT tên cột
--nên dùng SELECT * FROM Employee trước xong rồi xóa * và nhập tên cột
SELECT EmpID, FirstName, LastName, Birthday 
FROM Employee

--3. In ra danh sách nhân viên lấy các cột
--id, fullname, năm sinh
SELECT EmpID, FirstName + ' ' + LastName AS Fullname, Birthday --cộng thêm ' ' dấu cách để tách tên họ ra
FROM Employee

--4.In ra danh sách tuổi của nhân viên
SELECT FirstName + ' ' + LastName AS Fullname, year(GETDATE()) - year(Birthday) AS AGE --dùng lệnh AS để đổi tên cột đó đổi ảo thôi chứ gốc nó không đổi
FROM Employee --thêm vào First tới Fullname để có đủ thông tin tránh đi tù

--5.in ra thông tin các nhà cung cấp
SELECT * FROM Supplier
--cột ID: primary key - khóa chính

--6.in ra thông tin các nhà vận chuyển
SELECT * FROM Shipper --Delivery là sự vận chuyển k phải nhà vận chuyển
--ShipID: primary key - khóa chính

--7.in ra thông tin những chủng loại sản phẩm
SELECT * FROM Category
--CategoryID: primary key - khóa chính

--8.in ra xem công ty bán những loại sản phẩm nào
SELECT * FROM Product
--ProID: khóa chính

--9.kiểm tra xem trong kho có những gì
SELECT * FROM Barn

--10.in ra thông tin các đơn hàng đã bán
SELECT * FROM Orders
--OrdlID: khóa chính

--11. in ra thông tin của đơn hàng đã bán như sau
--mã đơn hàng, mã khách hàng đã mua, mã nhân viên đã bán, cân nặng
SELECT OrdID, CustomerID, EmpID, Freight --dùng weight cho những vật di chuyển đc còn Freight dùng trong hàng hóa những vật bất động
FROM Orders

--12.in ra thông tin đơn hàng chi tiết
SELECT * FROM OrdersDetail --chỗ này cả 2 thg ordlID và proID 2 key kết hợp mới đủ để định danh