-- đây là dấu ghi chú " -- "
-- 01-select
-- *lưu ý: trong DB không quan tâm hoa thường
-- Chữ nào màu xanh dương thì viết full hoa (quy tắc ngầm)

-- select có 2 chức năng
---1. dùng để in ra màn hình giống printf, sout, console.log
--phải tô đen xong chọn excute mới chạy và thông tin được đặt trong nháy đơn ' '
--select luôn trả kết quả dưới dạng 1 table như excel
SELECT 'hehe' 
---2. dùng để trích xuất dữ liệu từ table (bài sau học)

--Datatype: kiểu dữ liệu
-----> Số: Integer, decimal (hệ 10), float, double, money(theo đơn vị tiền tệ)
-----> Chuỗi: char(?), nchar(?), varchar(?), nvarchar(?)
	--?: dấu ? chỉ kích thước của chuỗi
	--vd: hello ---> char(6) vì hello 5 kí tự cộng thêm \0
	--n: chữ n có nghĩa là dùng unicode(viết dấu) những thằng có n sẽ lưu được dấu
--char() | nchar(): sẽ lưu trong RAM (tắt máy mất, truy xuất nhanh hơn, bị giới hạn kích thước vì sợ tràn RAM)
	--xin nhiều xài ít bù 32 (space)
--vd xin char(10) ---> 'hello\0' là dư 4 slot thì nó sẽ tự thêm vào 4 dấu space thành 'hello\0    ' như này nhanh hơn là canh đúng kích thước để cắt
--varchar() | nvarchar(): var là variable = biến, lưu ở ổ cứng, không giới hạn kích thước, có co giãn
--vd varchar(30) ---> 'hello\0' xin 30 dư 24 slot nó tự rút lại
--> dùng char thì tốc độ nhanh nhưng không co giãn được còn varchar thì tốc độ chậm nhưng co giãn được

--biểu diễn chuỗi thì phải bỏ trong nháy đơn ' ' 
--nếu biểu diễn chuỗi có dấu thì thêm N' '
SELECT N'XIN CHAO BẠN'  --còn không có N thì chữ bạn thành b?n
-- Ngày tháng năm: kiểu date, datetime theo chuẩn YYYY - MM - DD tức là năm - tháng - ngày
-- biểu diễn như chuỗi
SELECT '2022-01-13' --in theo chuẩn là năm - tháng - ngày
---
-- Build in function: hàm có sẵn
-- round(number, regit) làm tròn
SELECT round(2.6667, 1) ----> 2.7

--year() trích xuất năm từ ngày tháng năm từ chuỗi bỏ vào
SELECT year('2022 - 12 - 12')
--month() lấy tháng như year
--day() lấy ngày như year
--getdate() lấy ngày tháng năm và thời gian hiện hành
SELECT getdate()	


-----------------------------

 --1. in ra màn hình: 'Anh điệp đẹp trai quá, em nói thật lòng'
 SELECT N'Anh điệp đẹp trai quá, em nói thật lòng'

 --2. in 3 chuỗi: 'Tên của em', '❤', 'Anh Điệp'
 --Nối 3 chuỗi lại thành 1
 SELECT N'Quân'
 SELECT N'❤'
 SELECT N'Anh Điệp'
 SELECT N'Quân' + ' ' + '❤' + ' ' + N'Anh Điệp'
 --cộng thêm ' ' là chuẩn nhất vì không ai lưu tên người với dấu ' '

 --3. in ra ngày tháng năm hôm nay
 SELECT getdate()
 --hardcode: chỉ đúng 1 thời điểm hiện tại
 --4. Năm nay là năm bao nhiêu
 SELECT year(getdate())
 --5. Tháng này là tháng mấy
 SELECT month(getdate())
 --6. In ra kết quả của 10 + 12
 SELECT 12 + 10 --không bỏ trong ' ' vì nó không phải chuỗi
 -- SELECT '12' + '10' thì ra 1210
 -- SELECT '10' + 12 thì ra 22
 -- nhưng trong JS nó sẽ ra 1012
 -- SELECT '12' - '10' cái này ra lỗi còn trong JS thì ra 2
 
 --cái hàm sum là để cộng hết giá trị của 1 cột trong 1 table