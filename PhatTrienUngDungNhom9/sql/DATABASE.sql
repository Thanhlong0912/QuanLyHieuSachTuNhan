create database QuanLyHieuSachTuNhan 
on primary --Tạo tập tin data
( 
  size = 100
  ,filegrowth = 10
  ,maxsize = 2GB
  ,filename = 'd:\QuanLyHieuSachTuNhan\QuanLyHieuSachTuNhan.mdf'
  ,name = QuanLyHieuSachTuNhan_dat
)
log on --Tạo tập tin log
(
  size = 200
  ,filegrowth = 20
  ,maxsize = Unlimited
  ,filename = 'd:\QuanLyHieuSachTuNhan\QuanLyHieuSachTuNhan.ldf'
  ,name = QuanLyHieuSachTuNhan_log
)

use QuanLyHieuSachTuNhan

GO 
CREATE TABLE NHANVIEN
(
	MANV nchar(10) not null primary Key,
	TENNV nvarchar(50) not null,
	CMND varchar(12) not null,
	SDT varchar(12) not null,
	DIACHI nvarchar(50) not null,
	CHUCVU nvarchar(50) not null,
);

GO
CREATE TABLE KHACHHANG
(
	MAKH nchar(10) not null primary Key,
	TENKH nvarchar(50) not null,
	SDT varchar(12) not null,
	DIACHI nvarchar(50) not null,
	GIOITINH nvarchar(12) not null
);

GO
CREATE TABLE LOAISANPHAM
(
	MALSP nchar(10) not null primary Key,
	TENLSP nvarchar(50) not null,
	LOAILSP nvarchar(50) not null,
	TRANGTHAI bit,
);

GO
CREATE TABLE CA
(
	MACA nchar(10) not null primary Key,
	CALAM nvarchar(50) not null,
);

GO
CREATE TABLE LICHLAM
(
	MACA nchar(10) not null,
	MANV nchar(10) not null,
	NGAYLAM date  not null,
	PRIMARY KEY(MACA,MANV,NGAYLAM),
	FOREIGN KEY(MANV) REFERENCES NHANVIEN,
	FOREIGN KEY(MACA) REFERENCES CA
);

GO
CREATE TABLE TAIKHOAN
(
	MANV nchar(10) not null primary Key,
	TENTK nvarchar(50) not null,
	MATKHAU nvarchar(50) not null,
	FOREIGN KEY(MANV) REFERENCES NHANVIEN
);

GO
CREATE TABLE SANPHAM
(
	MASP nchar(10) not null primary Key,
	TENSP nvarchar(50) not null,
	DONGIA int not null,
	SOLUONG int not null,
	MALSP nchar(10) not null,
	TRANGTHAI bit,
	FOREIGN KEY(MALSP) REFERENCES LOAISANPHAM
);

GO
CREATE TABLE HOADON
(
	MAHD nchar(10) not null primary Key,
	NGAYTAO date not null,
	MAKH nchar(10) not null,
	MANV nchar(10) not null,
	TONGTHANHTIEN INT not null,
	TIENMAT INT not null,
	TIENDU INT not null,
	TRANGTHAI bit,
	FOREIGN KEY(MAKH) REFERENCES KHACHHANG,
	FOREIGN KEY(MANV) REFERENCES NHANVIEN
);

GO
CREATE TABLE CTHOADON
(
	MAHD nchar(10) not null,
	MASP nchar(10) not null,
	SOLUONG int not null,
	THANHTIEN INT not null,
	PRIMARY KEY(MAHD,MASP),
	FOREIGN KEY(MAHD) REFERENCES HOADON,
	FOREIGN KEY(MASP) REFERENCES SANPHAM
);

GO
CREATE TABLE NHAXUATBAN
(
	MANXB nchar(10) not null primary Key,
	TENNXB nvarchar(50) not null,
	DIACHI nvarchar(50) not null,
	TRANGTHAI bit,
);

GO
CREATE TABLE TACGIA
(
	MATG nchar(10) not null primary Key,
	TENTG nvarchar(50) not null,
	QUOCTICH nvarchar(50) not null,
	TRANGTHAI bit,
);

GO
CREATE TABLE SACH
(
	MASP nchar(10) not null primary Key,
	MATG nchar(10) not null,
	SOTRANG int not null,
	MANXB nchar(10) not null,
	FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP),
	FOREIGN KEY(MATG) REFERENCES TACGIA,
	FOREIGN KEY(MANXB) REFERENCES NHAXUATBAN
);

GO
CREATE TABLE NHACUNGCAP
(
	MANCC nchar(10) not null primary Key,
	TENNCC nvarchar(50) not null,
	DIACHI nvarchar(50) not null,
	QUOCTICH nvarchar(50) not null,
	TRANGTHAI bit,
);

GO
CREATE TABLE DUNGCUHOCTAP
(
	MASP nchar(10) not null primary Key,
	MANCC nchar(10) not null,
	FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP),
	FOREIGN KEY(MANCC) REFERENCES NHACUNGCAP
);

  INSERT INTO CA (MACA,CALAM) values(N'Ca chiều',N'từ 4 giờ chiều đến 10 giờ tối')
  INSERT INTO CA (MACA,CALAM) values(N'Ca sáng',N'từ 9 giờ sáng đến 4 giờ chiều')

  --Loại sản phẩm
  Insert into LOAISANPHAM(MALSP,TENLSP, LOAILSP,TRANGTHAI) values('LSP1',N'Tiểu thuyết',1,1);
  Insert into LOAISANPHAM(MALSP,TENLSP, LOAILSP,TRANGTHAI) values('LSP2',N'Sách giáo khoa',1,1);
  Insert into LOAISANPHAM(MALSP,TENLSP, LOAILSP,TRANGTHAI) values('LSP3',N'Truyện tranh',1,1);
  Insert into LOAISANPHAM(MALSP,TENLSP, LOAILSP,TRANGTHAI) values('LSP4',N'Vở',0,1);
  Insert into LOAISANPHAM(MALSP,TENLSP, LOAILSP,TRANGTHAI) values('LSP5',N'Bút',0,1);
  Insert into LOAISANPHAM(MALSP,TENLSP, LOAILSP,TRANGTHAI) values('LSP6',N'Thước',0,1);

  --Nhà cung cấp
  INSERT INTO NHACUNGCAP (MANCC,TENNCC,DIACHI,QUOCTICH,TRANGTHAI) VALUES ('NCC001',N'Thiên Long',N'Thành phố Hồ Chí Minh',N'Việt Nam',1)

  --Nhà xuất bản
  INSERT INTO NHAXUATBAN (MANXB,TENNXB,DIACHI,TRANGTHAI) VALUES ('NXB001',N'Huy Hoàng Bookstore',N'Thành phố Hồ Chí Minh',1)
  INSERT INTO NHAXUATBAN (MANXB,TENNXB,DIACHI,TRANGTHAI) VALUES ('NXB002',N'Nhã Nam',N'Hà nội',1)
  INSERT INTO NHAXUATBAN (MANXB,TENNXB,DIACHI,TRANGTHAI) VALUES ('NXB003',N'Văn hoá - Thông tin',N'Hà nội',1)

  --Tác giả
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG1',N'Victor Hugo',N'Pháp',1)
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG2',N'J. K. Rowling',N'Vương Quốc Anh',1)
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG3',N'Mark Twain',N'Hoa kỳ',1)
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG4',N'Haruki Murakami',N'Nhật bản',1)
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG5',N'Dan Brown',N'Hoa kỳ',1)
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG6',N'Paulo Coelho',N'Brasil',1)
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG7',N'Jeffrey Archer',N'Vương Quốc Anh',1)
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG8',N'John Boyne',N'Cộng hòa Ireland',1)
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG9',N'Lewis Caroll',N'Anh',1)
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG10',N'Antoine De Saint-Exupéry',N'Pháp',1)
  insert into TACGIA (MATG,TENTG,QUOCTICH,TRANGTHAI) values('TG11',N'Lyman Frank Baum',N'Anh',1)

  --Sách
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach1',N'Những người khốn khổ',300000,100,'LSP1',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach2',N'Harry Potter',600000,60,'LSP1',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach3',N'Những cuộc phiêu lưu của Huckleberry Finn',70000,200,'LSP1',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach4',N'Những cuộc phiêu lưu của Tom Sawyer',79000,200,'LSP1',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach5',N'Rừng Na Uy',69000,250,'LSP1',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach6',N'Mật mã Da Vinci',190000,125,'LSP1',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach7',N'Nhà giả kim',65000,250,'LSP1',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach8',N'Sherlock Holmes',32000,250,'LSP1',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach9',N' Chú Bé Mang Pyjama Sọc',52000,150,'LSP3',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach10',N'Cuộc Phiêu Lưu Của Tom Sawyer',78000,125,'LSP3',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach11',N'Hoàng Tử Bé',51000,250,'LSP3',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('Sach12',N'Văn Học Kinh Điển Thế Giới - Phù Thủy Xứ OZ',57000,250,'LSP3',1)


  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach1',N'TG1',2084,'NXB001')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach2',N'TG2',1500,'NXB001')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach3',N'TG3',435,'NXB001')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach4',N'TG3',304,'NXB001')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach5',N'TG4',556,'NXB001')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach6',N'TG5',534,'NXB001')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach7',N'TG6',228,'NXB002')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach8',N'TG7',768,'NXB002')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach9',N'TG8',253,'NXB002')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach10',N'TG9',143,'NXB001')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach11',N'TG10',102,'NXB002')
  INSERT INTO SACH(MASP,MATG,SOTRANG,MANXB) VALUES('Sach12',N'TG11',143,'NXB001')
  --Dụng cụ học tập
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('DCHT1',N'Bộ thước kẽ 5 món',12000,300,'LSP6',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('DCHT2',N'Vở 5 ô ly',7000,1250,'LSP4',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('DCHT3',N'Vở 4 ô ly',6000,2050,'LSP4',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('DCHT4',N'Túi đựng bút',30000,1020,'LSP5',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('DCHT5',N'Bút Bi 0.5 mm Thiên Long TL-027',4000,15000,'LSP5',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('DCHT6',N'Bút Gel Thiên Long Doraemon GEL-012/DO',7000,12500,'LSP5',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('DCHT7',N'Bút Chì 2B Deli',3000,250,'LSP5',1)
  INSERT INTO SANPHAM(MASP,TENSP,DONGIA,SOLUONG,MALSP,TRANGTHAI) VALUES('DCHT8',N'Bút máy Điểm 10 TP-FTC09',57000,250,'LSP5',1)

  INSERT INTO DUNGCUHOCTAP (MASP,MANCC) VALUES('DCHT1','NCC001')
  INSERT INTO DUNGCUHOCTAP (MASP,MANCC) VALUES('DCHT2','NCC001')
  INSERT INTO DUNGCUHOCTAP (MASP,MANCC) VALUES('DCHT3','NCC001')
  INSERT INTO DUNGCUHOCTAP (MASP,MANCC) VALUES('DCHT4','NCC001')
  INSERT INTO DUNGCUHOCTAP (MASP,MANCC) VALUES('DCHT5','NCC001')
  INSERT INTO DUNGCUHOCTAP (MASP,MANCC) VALUES('DCHT6','NCC001')
  INSERT INTO DUNGCUHOCTAP (MASP,MANCC) VALUES('DCHT7','NCC001')
  INSERT INTO DUNGCUHOCTAP (MASP,MANCC) VALUES('DCHT8','NCC001')

  --Nhân viên
  insert into NHANVIEN(MANV,TENNV,CMND,SDT,DIACHI,CHUCVU) values ('QL1',N'Đinh Thành Long','241892189','0329324401',N'Đắk Lắk',N'Quản lý')
  insert into NHANVIEN(MANV,TENNV,CMND,SDT,DIACHI,CHUCVU) values ('QL2',N'Lâm Chí Khang','243455977','0329309876',N'Bình Định',N'Quản lý')
  insert into NHANVIEN(MANV,TENNV,CMND,SDT,DIACHI,CHUCVU) values ('NV1',N'Long Bi','240000000','0300000000',N'Hư Không',N'Nhân viên')

  --Tài khoản
  insert into TAIKHOAN (MANV,TENTK,MATKHAU) values ('QL1','admin1','admin1')
  insert into TAIKHOAN (MANV,TENTK,MATKHAU) values ('QL2','admin2','admin2')
  insert into TAIKHOAN (MANV,TENTK,MATKHAU) values ('NV1','employee1','employee1')
  --Khách hàng
  insert into KHACHHANG(MAKH,TENKH,SDT,DIACHI,GIOITINH) values ('KH1',N'Đinh Thành Long','0356205044',N'Đắk Lắk',N'Nam')
  insert into KHACHHANG(MAKH,TENKH,SDT,DIACHI,GIOITINH) values ('KH2',N'Lâm Chí Khang','0329309876',N'Tiền Giang',N'Nam')