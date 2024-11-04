--04 - surrogateKey.sql
--Key giả, Key nhân tạo, Key thay thế, Key tự tăng
--SQL cho mình 2 cơ chế phát sinh số tự tăng
--	+ Phát sinh số tự tăng, không trùng lại trên toàn table
--	+ Phát sinh chuỗi được mã hóa hệ hexa(16) không trùng lại trên toàn bộ database
---CƠ CHẾ 1---
CREATE TABLE KeyWords( --SEQUENCE: tuần tự
	SEQ int identity(5,5),
		--mỗi lần mình chèn một dòng object
		--thì cột SEQ sẽ tự có giá trị 
		--khởi đầu là 5, mỗi lần tăng 5
	InputText nvarchar(40),
	InputDate datetime, --lưu ngày và giờ
	IP char(40),
	--Constraint PK_KeyWords_SEQ Primary Key(SEQ): vẫn được nhưng không nên vì xấu òm, khó sửa
)
ALTER TABLE KeyWords
	add Constraint PK_KeyWords_SEQ Primary Key(SEQ)

INSERT INTO KeyWords
	VALUES (N'Điện thoại 1', GETDATE(), '10.1.1.1')
INSERT INTO KeyWords
	VALUES (N'Điện thoại 2', GETDATE(), '10.1.1.1')
INSERT INTO KeyWords
	VALUES (N'Phone', GETDATE(), '10.1.1.1')
--Khi chèn thiếu cột/chèn cột 3, nếu như cột thiếu là Identity thì không cần phải liệt kê
SELECT * FROM KeyWords
---CƠ CHẾ 2---
CREATE TABLE KeyWordsV2(
	SEQ uniqueIdentifier default newID() not null,
	InputText nvarchar(40),
	InputDate datetime, 
	IP char(40),
	Constraint PK_KeyWordsV2_SEQ Primary Key(SEQ)
)
--Bắt buộc liệt kê những cột chuẩn bị thêm dữ liệu
--Default giúp chèn giá trị mặc định cho SEQ nếu không chèn dữ liệu cho nó
INSERT INTO KeyWordsV2(InputText, InputDate, IP)
	VALUES (N'Điện thoại 1', GETDATE(), '10.1.1.1')
INSERT INTO KeyWordsV2(InputText, InputDate, IP)
	VALUES (N'Điện thoại 2', GETDATE(), '10.1.1.1')
INSERT INTO KeyWordsV2(InputText, InputDate, IP)
	VALUES (N'Phone', GETDATE(), '10.1.1.1')

SELECT * FROM KeyWordsV2
-----
--Surrogate Key
--Ý nghĩa:
-- 1. Nếu Table bạn không biết chọn ai làm PK thì dùng Surrogate Key
-- 2. Thay thế cho Composite Key
-- 3. Giúp tránh hiện tượng đổ Domino
--------------Natural Key-------------
CREATE TABLE MajorV1(
	ID char(2) not null Primary Key,
	Name nvarchar(30),
)
INSERT INTO MajorV1
	VALUES ('SB', N'Quản Trị Kinh Doanh')
INSERT INTO MajorV1
	VALUES ('SE', N'Kỹ Thuật Phần Mềm')
INSERT INTO MajorV1
	VALUES ('GD', N'Thiết Kế Đồ Họa')
--CN(1) - SV(N)
CREATE TABLE StudentV1(
	ID char(8) Primary Key,
	Name nvarchar(40),
	MID char(2),
	Constraint FK_StudentV1_MID_tblMajorV1_ID 
		Foreign Key (MID) References MajorV1(ID)
			ON DELETE SET null
			ON UPDATE CASCADE
)
INSERT INTO StudentV1 
	VALUES ('S1', N'An', 'GD')
INSERT INTO StudentV1 
	VALUES ('S2', N'Bình', 'GD')
INSERT INTO StudentV1 
	VALUES ('S3', N'Cường', 'SB')
INSERT INTO StudentV1 
	VALUES ('S4', N'Dũng', 'SB')
--------Surrogate Key---------
CREATE TABLE MajorV2(
	SEQ int Identity(1,1) Primary Key,
	ID char(2) not null unique,
	Name nvarchar(30),
)
INSERT INTO MajorV2
	VALUES ('SB', N'Quản Trị Kinh Doanh')
INSERT INTO MajorV2
	VALUES ('SE', N'Kỹ Thuật Phần Mềm')
INSERT INTO MajorV2
	VALUES ('GD', N'Thiết Kế Đồ Họa')

CREATE TABLE StudentV2(
	ID char(8) Primary Key,
	Name nvarchar(40),
	MID int,
	Constraint FK_StudentV2_MID_tblMajorV2_SEQ 
		Foreign Key (MID) References MajorV2(SEQ)
)
INSERT INTO StudentV2
	VALUES ('S1', N'An', '1')
INSERT INTO StudentV2 
	VALUES ('S2', N'Bình', '1')
INSERT INTO StudentV2 
	VALUES ('S3', N'Cường', '2')
INSERT INTO StudentV2 
	VALUES ('S4', N'Dũng', '2')
--Homework--
--05-SuperMaket:siêu thị
--thiết kế 1 table customer
--quản lý khách hàng gồm
--(id,name,dob,sex,numberOFInhabitants,phone,email,typeOFCustomer)

--06-PromotionGirl
	--(kỹ thuật đệ quy khóa ngoại)
	--tạo table lưu trữ thông tin các em promotion girl
	--trong đám promotion girl
	--sẽ có 1 vài em được chọn ra để quản lý các em khác chia thành nhiều team