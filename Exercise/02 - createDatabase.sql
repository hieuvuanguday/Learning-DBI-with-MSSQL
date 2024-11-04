--Homework--
--05-SuperMaket:siêu thị
CREATE DATABASE DBK17HW_CreateDB
USE DBK17HW_CreateDB
--thiết kế 1 table customer
--quản lý khách hàng gồm
--(id,name,dob,sex,numberOFInhabitants,phone,email,typeOFCustomer)
-------------------------------------------------------------------
--Tạo bảng Giới Tính
CREATE TABLE Sex(
	CharacterID char(1) not null,
	Meanings nvarchar(20) not null,
)
ALTER TABLE Sex
	Add Constraint PK_Sex_CharacterID Primary Key(CharacterID)
ALTER TABLE Sex
	Add Constraint UQ_Sex_Meanings Unique(Meanings)

INSERT INTO Sex VALUES ('M', N'Male')
INSERT INTO Sex VALUES ('F', N'Female')
INSERT INTO Sex VALUES ('L', N'Lesbian')
INSERT INTO Sex VALUES ('G', N'Gay')
INSERT INTO Sex VALUES ('B', N'Bi-Sexual')
INSERT INTO Sex VALUES ('T', N'Transition')
INSERT INTO Sex VALUES ('U', N'Unknown')

SELECT * FROM Sex Order By CharacterID ASC
-------------------------------------------------------------------
--Tạo bảng Loại Khách Hàng
CREATE TABLE TypeOfCustomer(
	TypeID char(3) not null,
	Meanings nvarchar(20) not null,
)
ALTER TABLE TypeOfCustomer
	Add Constraint PK_TypeOfCustomer_TypeID Primary Key(TypeID)
ALTER TABLE TypeOfCustomer
	Add Constraint UQ_TypeOfCustomer_Meanings Unique(Meanings)

INSERT INTO TypeOfCustomer VALUES ('NOR', N'Normal Person')
INSERT INTO TypeOfCustomer VALUES ('BLK', N'Person In Black List')
INSERT INTO TypeOfCustomer VALUES ('SPC', N'Special Person')

SELECT * FROM TypeOfCustomer
-------------------------------------------------------------------
--Tạo bảng Khách Hàng
CREATE TABLE Customer(
	SEQ int Identity(1,1),
	ID char(6) not null,
	FirstName nvarchar(15) not null,
	LastName nvarchar(15) not null,
	DOB date null,
	Sex char(1) not null,
	NumberOfInhabitants char(12) not null,
	PhoneNumber char(10) null,
	Email varchar(40) null,
	TypeOfCustomer char(3) not null,
)
ALTER TABLE Customer 
	Add Constraint PK_Customer_SEQ Primary Key(SEQ)
ALTER TABLE Customer
	Add Constraint UQ_Customer_ID Unique(ID)
ALTER TABLE Customer
	Add Constraint FK_Customer_Sex_tblSex
		Foreign Key(Sex) References Sex(CharacterID)
ALTER TABLE Customer
	Add Constraint UQ_Customer_NumberOfInhabitants Unique(NumberOfInhabitants)
ALTER TABLE Customer
	Add COnstraint FK_Customer_TypeOfCustomer_tblTypeOfCustomer
		Foreign Key(TypeOfCustomer) References TypeOfCustomer(TypeID)

INSERT INTO Customer 
	VALUES ('CUS001', N'Trần', N'Anh', '2003-12-23', 'M', '068123456789', '0973563802', N'sqdasd@gmail.com', 'NOR')
INSERT INTO Customer 
	VALUES ('CUS002', N'Đặng', N'Bình', '2003-11-23', 'F', '064123456987', '0877711859', N'asFsgsgd@gmail.com', 'NOR')
INSERT INTO Customer 
	VALUES ('CUS003', N'Nguyễn', N'Đạt', '2004-04-03', 'M', '063456789123', '0966548257', N'safgrehgjhj@gmail.com', 'BLK')
INSERT INTO Customer 
	VALUES ('CUS004', N'Hoàng', N'Dung', '2006-07-30', 'F', '062153246789', '0902549723', N'kyutjhfgdbfv@gmail.com', 'SPC')
INSERT INTO Customer 
	VALUES ('CUS005', N'Lê', N'Dung', '2003-08-08', 'F', '063452136987', '0869634434', N'tyjhgfb@gmail.com', 'NOR')
INSERT INTO Customer 
	VALUES ('CUS006', N'Lâm', N'Dũng', '2003-05-25', 'M', '068254163879', '0903053505', N'jtrgfghrtefg@gmail.com', 'NOR')
INSERT INTO Customer 
	VALUES ('CUS007', N'Trần', N'Dũng', '2002-06-19', 'M', '065124569873', '0985311867', N'zxfhdjhs@gmail.com', 'NOR')
INSERT INTO Customer 
	VALUES ('CUS008', N'Lê', N'Dương', '2003-06-04', 'M', '062153289647', '0971898257', N'sefhdstg@gmail.com', 'NOR')
INSERT INTO Customer 
	VALUES ('CUS009', N'Cao', N'Duy', '2004-11-18', 'G', '067859623147', '0947605199', N'afsjuyrawegdf@gmail.com', 'BLK')
INSERT INTO Customer 
	VALUES ('CUS010', N'Đỗ', N'Hiếu', '2003-11-30', 'M', '068203001000', '0967475325', N'sdrysete@gmail.com', 'SPC')
INSERT INTO Customer 
	VALUES ('CUS011', N'Lê', N'Hoàng', '2002-10-20', 'M', '068562341789', '0966987413', N'yutrgfeds@gmail.com', 'NOR')
INSERT INTO Customer 
	VALUES ('CUS012', N'Trương', N'Hoàng', '2005-04-26', 'M', '063258943167', '0908524766', N'rtyegfbg@gmail.com', 'NOR')
INSERT INTO Customer 
	VALUES ('CUS013', N'Bùi', N'Hùng', '2006-12-07', 'M', '062752146389', '0399533724', N'hrtyegfgngh@gmail.com', 'SPC')
INSERT INTO Customer 
	VALUES ('CUS014', N'Tạ', N'Khoa', '2003-01-07', 'M', '063215436879', '0838326876', N'fdhgr@gmail.com', 'BLK')
INSERT INTO Customer 
	VALUES ('CUS015', N'Phạm', N'Khôi', '2005-02-28', 'U', '069759863214', '0363866708', N'frgefdsbf@gmail.com', 'NOR')

SELECT * FROM Customer
-------------------------------------------------------------------
--06-PromotionGirl
	--(kỹ thuật đệ quy khóa ngoại)
	--tạo table lưu trữ thông tin các em promotion girl
	--trong đám promotion girl
	--sẽ có 1 vài em được chọn ra để quản lý các em khác chia thành nhiều team
-------------------------------------------------------------------
--Tạo bảng Nhóm
CREATE TABLE GroupGirl(
	ID char(1) not null,
	GroupName nvarchar(30) not null,
)
ALTER TABLE GroupGirl 
	Add Constraint PK_GroupGirl_ID Primary Key(ID)
ALTER TABLE GroupGirl
	Add Constraint UQ_GroupGirl_GroupName Unique(GroupName)

INSERT INTO GroupGirl
	VALUES ('1', N'SNSD')
INSERT INTO GroupGirl
	VALUES ('2', N'T-ARA')
INSERT INTO GroupGirl
	VALUES ('3', N'TWICE')
INSERT INTO GroupGirl
	VALUES ('4', N'2NE1')

SELECT * FROM GroupGirl Order By ID ASC
-------------------------------------------------------------------
--Tạo bảng danh sách IDOL
CREATE TABLE PromotionGirl(
	SEQ int Identity(1,1),
	ID Char(5) not null,
	FirstName nvarchar(15) not null,
	LastName nvarchar(15) not null,
	DOB date null,
	NumberOfInhabitants char(12) not null,
	PhoneNumber char(10) null,
	Email varchar(40) null,
	GroupGirl char(1) not null,
	Position nvarchar(10) not null,
	--Cho LID được trích xuất từ ID, LID = ID thì là Leader, còn cùng LID thì chung một team 
)
ALTER TABLE PromotionGirl
	Add Constraint PK_PromotionGirl_SEQ Primary Key(SEQ)
ALTER TABLE PromotionGirl
	Add Constraint UQ_PromotionGirl_ID Unique(ID)
ALTER TABLE PromotionGirl
	Add Constraint UQ_PromotionGirl_NumberOfInhabitants Unique(NumberOfInhabitants)
ALTER TABLE PromotionGirl
	Add Constraint FK_PromotionGirl_GroupGirl 
		Foreign Key(GroupGirl) References GroupGirl(ID)

INSERT INTO PromotionGirl
	VALUES ('PG001', N'Trần', N'Anh', '2003-12-23', '068123456789', '0973563802', N'sqdasd@gmail.com', '1', N'Member')
INSERT INTO PromotionGirl 
	VALUES ('PG002', N'Đặng', N'Bình', '2003-11-23', '064123456987', '0877711859', N'asFsgsgd@gmail.com', '1', N'Member')
INSERT INTO PromotionGirl
	VALUES ('PG003', N'Nguyễn', N'Đạt', '2004-04-03', '063456789123', '0966548257', N'safgrehgjhj@gmail.com', '3', N'Leader')
INSERT INTO PromotionGirl
	VALUES ('PG004', N'Hoàng', N'Dung', '2006-07-30', '062153246789', '0902549723', N'kyutjhfgdbfv@gmail.com', '4', N'Member')
INSERT INTO PromotionGirl 
	VALUES ('PG005', N'Lê', N'Dung', '2003-08-08', '063452136987', '0869634434', N'tyjhgfb@gmail.com', '2', N'Member')
INSERT INTO PromotionGirl 
	VALUES ('PG006', N'Lâm', N'Dũng', '2003-05-25', '068254163879', '0903053505', N'jtrgfghrtefg@gmail.com', '3', N'Member')
INSERT INTO PromotionGirl 
	VALUES ('PG007', N'Trần', N'Dũng', '2002-06-19', '065124569873', '0985311867', N'zxfhdjhs@gmail.com', '4', N'Leader')
INSERT INTO PromotionGirl
	VALUES ('PG008', N'Lê', N'Dương', '2003-06-04', '062153289647', '0971898257', N'sefhdstg@gmail.com', '1', N'Member')
INSERT INTO PromotionGirl 
	VALUES ('PG009', N'Cao', N'Duy', '2004-11-18', '067859623147', '0947605199', N'afsjuyrawegdf@gmail.com', '2', N'Member')
INSERT INTO PromotionGirl 
	VALUES ('PG010', N'Đỗ', N'Hiếu', '2003-11-30', '068203001000', '0967475325', N'sdrysete@gmail.com', '2', N'Member')
INSERT INTO PromotionGirl
	VALUES ('PG011', N'Lê', N'Hoàng', '2002-10-20', '068562341789', '0966987413', N'yutrgfeds@gmail.com', '4', N'Member')
INSERT INTO PromotionGirl
	VALUES ('PG012', N'Trương', N'Hoàng', '2005-04-26', '063258943167', '0908524766', N'rtyegfbg@gmail.com', '3', N'Member')
INSERT INTO PromotionGirl 
	VALUES ('PG013', N'Bùi', N'Hùng', '2006-12-07', '062752146389', '0399533724', N'hrtyegfgngh@gmail.com', '1', N'Leader')
INSERT INTO PromotionGirl 
	VALUES ('PG014', N'Tạ', N'Khoa', '2003-01-07', '063215436879', '0838326876', N'fdhgr@gmail.com', '1', N'Member')
INSERT INTO PromotionGirl
	VALUES ('PG015', N'Phạm', N'Khôi', '2005-02-28', '069759863214', '0363866708', N'frgefdsbf@gmail.com', '2', N'Leader')
INSERT INTO PromotionGirl
	VALUES ('PG016', N'Đào', N'Phương', '2004-05-28', '069546287913', '0522952422', N'fdhsdgfhg@gmail.com', '3', N'Member')
INSERT INTO PromotionGirl
	VALUES ('PG017', N'Hà', N'Quỳnh', '2005-04-18', '068756921348', '0779885668', N'uyhjhbg@gmail.com', '4', N'Member')
INSERT INTO PromotionGirl
	VALUES ('PG018', N'Nguyễn', N'Tiên', '2004-11-25', '062256314789', '0865538442', N'jhghgb@gmail.com', '4', N'Member')
INSERT INTO PromotionGirl
	VALUES ('PG019', N'Trần', N'Trâm', '2005-12-28', '061122334455', '0337713572', N'sxjmjh@gmail.com', '3', N'Member')
INSERT INTO PromotionGirl
	VALUES ('PG020', N'Lê', N'Linh', '2006-09-04', '064565678721', '0961977302', N'ytcv@gmail.com', '2', N'Member')

SELECT * FROM PromotionGirl
