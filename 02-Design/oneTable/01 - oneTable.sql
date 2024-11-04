CREATE DATABASE DBK17F3_OneTable
USE DBK17F3_OneTable
--Mỗi một table nên có 1 cột cấm trùng (Primary Key)
--Student(ID, Name, DOB, Email, Phone, Sổ hộ khẩu, Bằng lái xe, CMND)
--Trong một table có nhiều cột cấm trùng: ID, Email, Bằng lái xe, CMND
--Những thằng này là candidate key: Key ứng viên cho Primary Key
--Chọn khóa chính có 2 tiêu chí:
-- + Phù hợp với bài toán lưu trữ của table
-- + Không có tính khả dụng cao khi ở table khác
--Khóa chính dùng mình ràng buộc data cấm trùng, not null
--Khóa chính là một constraint (ràng buộc)

CREATE TABLE StudentV1(
	ID char(8),
	Name nvarchar(30),
	DOB date, --yyyy/mm/đd
	Sex char(1), --M, F, L, G, B, T, U --null
	Email varchar(50),
)
INSERT INTO StudentV1 
	VALUES('SE123456', N'An Nguyễn', '1999-1-1', 'F', 'an@...')
INSERT INTO StudentV1 
	VALUES('SE123457', 'Bình Nguyễn', '1999-1-1', 'F', 'an@...')
SELECT * FROM StudentV1
Update StudentV1 set Name = N'Bình Nguyễn' WHERE ID = 'SE123457'
--
CREATE TABLE StudentV2(
	ID char(8) Primary Key,
	Name nvarchar(30),
	DOB date, --yyyy/mm/đd
	Sex char(1), --M, F, L, G, B, T, U --null
	Email varchar(50),
)
INSERT INTO StudentV2 
	VALUES('SE123456', N'An Nguyễn', '1999-1-1', 'F', 'an@...')
INSERT INTO StudentV2 
	VALUES('SE123457', null, null, null, null)

CREATE TABLE StudentV3(
	ID char(8) Primary Key,
	Name nvarchar(30) not null,
	DOB date null, --yyyy/mm/đd
	Sex char(1) null, --M, F, L, G, B, T, U --null
	Email varchar(50) null,
)
INSERT INTO StudentV3 
	VALUES('SE123457', N'Bình Nguyễn', null, null, null)
INSERT INTO StudentV3(ID, Name) 
	VALUES('SE123457', N'Bình Nguyễn') --Kỹ thuật chèn cột ba/ chèn thiếu cột

--Điệp Lê
--Johnny Đen
--Phạm An

--Cần tách tên thành First Name với Last Name để đáp ứng nhu cầu sắp xếp
----
CREATE TABLE StudentV4(
	ID char(8) Primary Key,
	FirstName nvarchar(15) not null,
	LastName nvarchar(30) not null,
	DOB date null, --yyyy/mm/đd
	Sex char(1) null, --M, F, L, G, B, T, U --null
	Email varchar(50) null,
)
INSERT INTO StudentV4(ID, FirstName, LastName) 
	VALUES ('SE123456', N'Bình', N'Nguyễn')
INSERT INTO StudentV4(ID, FirstName, LastName) 
	VALUES ('SE123457', N'Đặng', N'Johnny')
INSERT INTO StudentV4(ID, FirstName, LastName) 
	VALUES ('SE123458', N'An', N'Lê')
SELECT * FROM StudentV4 Order By FirstName asc
------------------------------
--Ràng buộc là gì? Là cách ta ép người dùng nhập vào data
--phải theo một chuẩn nào đó
--VD: SEX phải là M F L G B T U
--Tên thì không được bỏ trống
--ID cấm trùng trong mọi thời điểm
--ID bên table này phải xuất hiện trong table khác
--Sinh viên không được đăng ký quá 5 môn/kỳ
--Trong table có những loại ràng buộc nào?
	--Primary Key		(khóa chính: not null, cấm trùng)
	--Unique			(Cấm trùng, cho phép null)
	--Foreign key		(Khóa ngoài: ràng buộc tham chiếu)
	--Default			(Giá trị mặc định)
	--Check				(Phải nhập giá trị theo yêu cầu nào đó)
--Trong 1 table có rất nhiều ràng buộc
--Nên đặt tên các ràng buộc này
--Mục đích: dễ quản lý và dễ xóa
-------------------------
--R101 - BlockS102
--Primary Key (Room, Block)--Composite key (Key kết hợp)

--Super Key (Siêu Key ngu ngốc| key vô dụng)
--là composite key (PK, cột khác)
CREATE TABLE StudentV5(
	ID char(8) not null,
	FirstName nvarchar(15) not null,
	LastName nvarchar(30) not null,
	DOB date null, --yyyy/mm/đd
	Sex char(1) null, --M, F, L, G, B, T, U --null
	Email varchar(50) null,
	--Primary Key(ID,..?..) -> Tạo ra Composite Key
	--Nhưng không dùng vì không đặt được tên
)
ALter TABLE StudentV5 
	add Constraint PK_StudentV5_ID Primary Key(ID)
Alter TABLE StudentV5
	add Constraint UQ_StudentV5_Email Unique(Email)




