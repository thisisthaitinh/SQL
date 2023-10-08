-- Tao CSDL
CREATE DATABASE QLBH
ON PRIMARY(
NAME = QLBH_data,
FILENAME = 'E:\QLBH\QLBH_data.mdf',
SIZE = 10MB,
MAXSIZE = 50MB,
FILEGROWTH = 1MB)

LOG ON(
NAME = QLBH_log,
FILENAME = 'E:\QLBH\QLBH_log.ldf',
SIZE = 5MB,
MAXSIZE = 15MB,
FILEGROWTH = 1%)

-- Tao cac bang --

-- Nhom san pham
CREATE TABLE NhomSanPham(
MaNhom int primary key not null,
TenNhom Nvarchar(15))


-- Nha cung cap
CREATE TABLE NhaCungCap(
MaNCC int primary key not null,
TenNCC nvarchar(40) not null,
Diachi nvarchar(60),
Phone nvarchar(24),
SoFax nvarchar(24),
DCMail nvarchar(50))


-- San pham
CREATE TABLE SanPham(
MaSP int primary key not null,

-- tao rang buoc khoa ngoai
MaNhom int references NhomSanPham(MaNhom),
MaNCC int references NhaCungCap(MaNCC),
TenSP nvarchar(50) not null,
MoTa nvarchar(50),
DonViTinh nvarchar(20),

-- kiem tra dieu kien
GiaGoc money check(GiaGoc > 0),
SLTon int check(SLTon >= 0))


-- Khach hang
CREATE TABLE KhachHang(

-- rang buoc khoa chinh
MaKH char(5) primary key not null,

TenKH nvarchar(40) not null,
LoaiKH nvarchar(3) check (LoaiKH in ('VIP', 'VL', 'TV')),
DiaChi Nvarchar(60),
Phone nvarchar(24),
DCMail nvarchar(50),

-- kiem tra dieu kien
DiemTL int check (DiemTL >= 0)
)


-- Hoa don
CREATE TABLE HoaDon(
-- rang buoc khoa chinh
MaHD int primary key not null,

-- kiem tra dieu kien
NgayLapHD datetime check (NgayLapHD <= GetDate()),
NgayGiao datetime,
NoiChuyen nvarchar(50) not null,

-- rang buoc khoa ngoai
MaKH char(5) references KhachHang(MaKH))

-- CT_HoaDon
CREATE TABLE CT_HoaDon(
MaHD int references HoaDon(MaHD) not null,
MaSP int references SanPham(MaSP) not null,
SoLuong smallint check (SoLuong > 0),
DonGia money,
ChietKhau money check (ChietKhau >= 0)

-- set 2 columns lam khoa chinh
primary key(MaHD, MaSP)
)

--
SELECT domain_name, data_type, character_maximum_length
FROM information_schema.domains
ORDER BY domain_name 
--

-- cap nhat du lieu --
INSERT INTO NhomSanPham values(1, N'Điện tử')