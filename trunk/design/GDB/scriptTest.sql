
--Table dbo.BAOCAOHOATDONG

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[BAOCAOHOATDONG] (
	[MABAOCAOHOATDONG] [int] NOT NULL IDENTITY (1, 1),
	[MATOCHUC] [int] NULL,
	[NAM] [int] NULL,
	[DOANHTHU] [money] NULL,
	[NOPNGANSACH] [money] NULL,
	[DANHSACHCONGTRINH] [nvarchar](2000) NULL,
	[TEPDINHKEM] [nvarchar](500) NULL);
GO

--Table dbo.CONGDOANTHUCHIEN

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[CONGDOANTHUCHIEN] (
	[MACONGDOAN] [int] NOT NULL IDENTITY (1, 1),
	[SOGIAYPHEP] [nvarchar](50) NOT NULL,
	[MACONGTRINH] [int] NULL,
	[NGAYBATDAU] [date] NULL,
	[NGAYKETTHUC] [date] NULL);
GO

--Table dbo.CONGTRINH

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[CONGTRINH] (
	[MACONGTRINH] [int] NOT NULL IDENTITY (1, 1),
	[TENCONGTRINH] [nvarchar](500) NULL,
	[CHUDAUTU] [nvarchar](500) NULL,
	[DONVINGHIEMTHU] [nvarchar](500) NULL,
	[THOIGIANBATDAU] [date] NULL,
	[THOIGIANKETTHUC] [date] NULL,
	[GHICHU] [nvarchar](2000) NULL,
	[DADUYET] [bit] NULL);
GO

--Table dbo.DANGKYHOATDONG

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[DANGKYHOATDONG] (
	[MADANGKYHOATDONG] [int] NOT NULL IDENTITY (1, 1),
	[MAGIAYPHEPHOATDONG] [int] NULL,
	[LABOSUNG] [bit] NULL,
	[NGAYBOSUNG] [date] NULL,
	[DAXETDUYET] [bit] NULL,
	[MAHOATDONG] [int] NULL);
GO

--Table dbo.GIAYPHEPHOATDONG

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[GIAYPHEPHOATDONG] (
	[MAGIAYPHEPHOATDONG] [int] NOT NULL IDENTITY (1, 1),
	[MATOCHUC] [int] NULL,
	[SOGIAYPHEP] [nvarchar](50) NULL,
	[NGAYCAPPHEP] [date] NULL,
	[NGAYHETHAN] [date] NULL,
	[NGAYGIAHAN] [date] NULL,
	[LYDOXINPHEP] [nvarchar](2000) NULL,
	[LYDOGIAHAN] [nvarchar](2000) NULL,
	[LYDOCAPPHEP] [nvarchar](2000) NULL,
	[CAMKETXINPHEP] [nvarchar](2000) NULL,
	[CAMKETGIAHAN] [nvarchar](2000) NULL,
	[CAMKETBOSUNG] [nvarchar](2000) NULL,
	[TINHTRANG] [int] NULL,
	[MATHAMDINH] [int] NULL);
GO

--Table dbo.HOATDONG

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[HOATDONG] (
	[MAHOATDONG] [int] NOT NULL IDENTITY (1, 1),
	[TENHOATDONG] [nvarchar](500) NULL);
GO

SET IDENTITY_INSERT [dbo].[HOATDONG] ON
GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (1, N'Khảo sát, lập dự án, thiết kế kỹ thuật – dự toán công trình đo đạc và bản đồ')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (2, N'Kiểm tra, thẩm định chất lượng công trình, sản phẩm đo đạc và bản đồ')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (3, N'Xây dựng lưới tọa độ, độ cao quốc gia')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (4, N'Xây dựng điểm trọng lực, thiên văn, tọa độ, độ cao')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (5, N'Chụp ảnh, quét địa hình từ máy bay')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (6, N'Đo vẽ, thành lập bản đồ địa hình các tỷ lệ')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (7, N'Đo vẽ, thành lập bản đồ địa hình đáy biển các tỷ lệ')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (8, N'Đo vẽ, thành lập bản đồ địa chính các tỷ lệ')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (9, N'Thành lập bản đồ hành chính các cấp')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (10, N'Đo vẽ, thành lập bản đồ địa giới hành chính các cấp')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (11, N'Xây dựng cơ sở dữ liệu đo đạc và bản đồ')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (12, N'Xây dựng cơ sở dữ liệu hệ thống thông tin địa lý')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (13, N'Thành lập bản đồ chuyên đề')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (14, N'Thành lập atlas địa lý')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (15, N'Khảo sát, đo đạc công trình')

GO
INSERT INTO [dbo].[HOATDONG] ([MAHOATDONG], [TENHOATDONG])
	VALUES (16, N'Kiểm định các thiết bị đo đạc')

GO
SET IDENTITY_INSERT [dbo].[HOATDONG] OFF
GO

--Table dbo.KIEUSANPHAM

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[KIEUSANPHAM] (
	[MAKIEUSANPHAM] [int] NULL,
	[DIENGIAI] [nvarchar](50) NULL);
GO

INSERT INTO [dbo].[KIEUSANPHAM] ([MAKIEUSANPHAM], [DIENGIAI])
	VALUES (1, N'Mốc')

GO
INSERT INTO [dbo].[KIEUSANPHAM] ([MAKIEUSANPHAM], [DIENGIAI])
	VALUES (2, N'Bản đồ')

GO

--Table dbo.LOAIHINHTOCHUC

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[LOAIHINHTOCHUC] (
	[MALOAIHINHTOCHUC] [int] NOT NULL IDENTITY (1, 1),
	[TENLOAIHINHTOCHUC] [nvarchar](50) NULL);
GO

SET IDENTITY_INSERT [dbo].[LOAIHINHTOCHUC] ON
GO
INSERT INTO [dbo].[LOAIHINHTOCHUC] ([MALOAIHINHTOCHUC], [TENLOAIHINHTOCHUC])
	VALUES (1, N'Tổ chức trong nước')

GO
INSERT INTO [dbo].[LOAIHINHTOCHUC] ([MALOAIHINHTOCHUC], [TENLOAIHINHTOCHUC])
	VALUES (2, N'Tổ chức đầu tư nước ngoài')

GO
INSERT INTO [dbo].[LOAIHINHTOCHUC] ([MALOAIHINHTOCHUC], [TENLOAIHINHTOCHUC])
	VALUES (3, N'Tổ chức nước ngoài')

GO
SET IDENTITY_INSERT [dbo].[LOAIHINHTOCHUC] OFF
GO

--Table dbo.LOAISANPHAM

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[LOAISANPHAM] (
	[MALOAISANPHAM] [int] NOT NULL IDENTITY (1, 1),
	[TENLOAISANPHAM] [nvarchar](500) NULL,
	[KIEUSANPHAM] [int] NULL,
	[DIENGIAI] [nvarchar](2000) NULL);
GO

SET IDENTITY_INSERT [dbo].[LOAISANPHAM] ON
GO
INSERT INTO [dbo].[LOAISANPHAM] ([MALOAISANPHAM], [TENLOAISANPHAM], [KIEUSANPHAM], [DIENGIAI])
	VALUES (1, N'Mốc toạ độ', 1, N'Mốc toạ độ')

GO
INSERT INTO [dbo].[LOAISANPHAM] ([MALOAISANPHAM], [TENLOAISANPHAM], [KIEUSANPHAM], [DIENGIAI])
	VALUES (2, N'Mốc độ cao', 1, N'Mốc độ cao')

GO
INSERT INTO [dbo].[LOAISANPHAM] ([MALOAISANPHAM], [TENLOAISANPHAM], [KIEUSANPHAM], [DIENGIAI])
	VALUES (3, N'Mốc trọng lực', 1, N'Mốc trọng lực')

GO
INSERT INTO [dbo].[LOAISANPHAM] ([MALOAISANPHAM], [TENLOAISANPHAM], [KIEUSANPHAM], [DIENGIAI])
	VALUES (4, N'Bản đồ địa chính 1: 2000', 2, N'Bản đồ địa chính 1: 2000')

GO
INSERT INTO [dbo].[LOAISANPHAM] ([MALOAISANPHAM], [TENLOAISANPHAM], [KIEUSANPHAM], [DIENGIAI])
	VALUES (5, N'Bản đồ địa chính 1: 10000', 2, N'Bản đồ địa chính 1: 10000')

GO
INSERT INTO [dbo].[LOAISANPHAM] ([MALOAISANPHAM], [TENLOAISANPHAM], [KIEUSANPHAM], [DIENGIAI])
	VALUES (6, N'Bản đồ địa chính 1: 20000', 2, N'Bản đồ địa chính 1: 20000')

GO
INSERT INTO [dbo].[LOAISANPHAM] ([MALOAISANPHAM], [TENLOAISANPHAM], [KIEUSANPHAM], [DIENGIAI])
	VALUES (7, N'Bản độ địa hình 1: 1000', 2, N'Bản đồ địa hình 1:1000')

GO
SET IDENTITY_INSERT [dbo].[LOAISANPHAM] OFF
GO

--Table dbo.NHANLUC

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[NHANLUC] (
	[MANHANVIEN] [int] NOT NULL IDENTITY (1, 1),
	[MATOCHUC] [int] NULL,
	[HOTEN] [nvarchar](50) NULL,
	[CMND] [nvarchar](15) NULL,
	[CHUCVU] [nvarchar](50) NULL,
	[DIACHI] [nvarchar](2000) NULL,
	[TRINHDOHV] [nvarchar](50) NULL,
	[CHUYENNGANH] [nvarchar](500) NULL,
	[THAMNIEN] [int] NULL,
	[NGAYSINH] [date] NULL,
	[QUATRINHHOCTAP] [nvarchar](2000) NULL,
	[QUATRINHCONGTAC] [nvarchar](2000) NULL,
	[CHIUTRACHNHIEM] [bit] NULL,
	[TEPDINHKEM] [nvarchar](500) NULL);
GO

--Table dbo.QUANHUYEN

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[QUANHUYEN] (
	[MAQUANHUYEN] [int] NOT NULL IDENTITY (1, 1),
	[TENQUANHUYEN] [nvarchar](50) NULL,
	[MATINHTHANH] [int] NULL);
GO

--Table dbo.SANPHAM

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[SANPHAM] (
	[MASANPHAM] [int] NOT NULL IDENTITY (1, 1),
	[SOHIEU] [nvarchar](50) NULL,
	[MALOAISANPHAM] [int] NULL,
	[MACONGTRINH] [int] NULL,
	[MAQUANHUYEN] [int] NULL,
	[CAPHANHCHINH] [int] NULL);
GO

--Table dbo.THAMDINH

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[THAMDINH] (
	[MATHAMDINH] [int] NOT NULL IDENTITY (1, 1),
	[MAGIAYPHEPHOATDONG] [int] NULL,
	[NGUOITHAMDINH] [nvarchar](500) NULL,
	[NGUOIPHIATOCHUC] [nvarchar](500) NULL,
	[NGAYTHAMDINH] [date] NULL,
	[TINHHOPLE] [nvarchar](2000) NULL,
	[NANGLUCNHANVIEN] [nvarchar](2000) NULL,
	[NANGLUCTHIETBI] [nvarchar](2000) NULL,
	[KETLUAN] [nvarchar](2000) NULL,
	[KIENNGHI] [nvarchar](2000) NULL,
	[LOAITHAMDINH] [int] NULL);
GO

--Table dbo.THIETBI

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[THIETBI] (
	[MATHIETBI] [int] NOT NULL IDENTITY (1, 1),
	[MATOCHUC] [int] NULL,
	[TENTHIETBI] [nvarchar](500) NULL,
	[SOLUONG] [int] NULL,
	[HANGSANXUAT] [nvarchar](500) NULL,
	[CONGNGHE] [nvarchar](500) NULL,
	[TINHTRANG] [bit] NULL,
	[GHICHU] [nvarchar](2000) NULL,
	[TEPDINHKEM] [nvarchar](500) NULL);
GO

--Table dbo.TINHTHANH

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[TINHTHANH] (
	[MATINHTHANH] [int] NOT NULL IDENTITY (1, 1),
	[TENTINHTHANH] [nvarchar](50) NULL);
GO

--Table dbo.TINHTRANGGIAYPHEP

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[TINHTRANGGIAYPHEP] (
	[MATINHTRANG] [int] NOT NULL,
	[DIENGIAI] [nvarchar](50) NULL);
GO

INSERT INTO [dbo].[TINHTRANGGIAYPHEP] ([MATINHTRANG], [DIENGIAI])
	VALUES (1, N'Chờ xin cấp giấy phép')

GO
INSERT INTO [dbo].[TINHTRANGGIAYPHEP] ([MATINHTRANG], [DIENGIAI])
	VALUES (2, N'Xin cấp giấy phép thất bại')

GO
INSERT INTO [dbo].[TINHTRANGGIAYPHEP] ([MATINHTRANG], [DIENGIAI])
	VALUES (3, N'Đã được cấp giấy phép')

GO
INSERT INTO [dbo].[TINHTRANGGIAYPHEP] ([MATINHTRANG], [DIENGIAI])
	VALUES (4, N'Chờ xin bổ sung hoạt động')

GO
INSERT INTO [dbo].[TINHTRANGGIAYPHEP] ([MATINHTRANG], [DIENGIAI])
	VALUES (5, N'Bổ sung hoạt động thất bại')

GO
INSERT INTO [dbo].[TINHTRANGGIAYPHEP] ([MATINHTRANG], [DIENGIAI])
	VALUES (6, N'Bổ sung hoạt động thành công')

GO
INSERT INTO [dbo].[TINHTRANGGIAYPHEP] ([MATINHTRANG], [DIENGIAI])
	VALUES (7, N'Chờ xin gia hạn')

GO
INSERT INTO [dbo].[TINHTRANGGIAYPHEP] ([MATINHTRANG], [DIENGIAI])
	VALUES (8, N'Xin gia hạn thất bại')

GO
INSERT INTO [dbo].[TINHTRANGGIAYPHEP] ([MATINHTRANG], [DIENGIAI])
	VALUES (9, N'Xin gia hạn thành công')

GO

--Table dbo.TOCHUC

USE [QLDDBD]
GO

--Create table and its columns
CREATE TABLE [dbo].[TOCHUC] (
	[MATOCHUC] [int] NOT NULL IDENTITY (1, 1),
	[MALOAIHINHTOCHUC] [int] NULL,
	[TENTOCHUC] [nvarchar](250) NULL,
	[GIAYPHEPKINHDOANH] [nvarchar](15) NULL,
	[NGUOIDAIDIEN] [nvarchar](50) NULL,
	[TRUSOCHINH] [nvarchar](2000) NULL,
	[SOTAIKHOAN] [nvarchar](15) NULL,
	[DIENTHOAI] [nvarchar](15) NULL,
	[FAX] [nvarchar](15) NULL,
	[EMAIL] [nvarchar](250) NULL,
	[TONGSOCANBO] [int] NULL,
	[NGAYXINPHEP] [date] NULL,
	[KICHHOAT] [bit] NULL,
	[TEPDINHKEM] [nvarchar](500) NULL);
GO

--Indexes of table dbo.BAOCAOHOATDONG
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[BAOCAOHOATDONG] ADD CONSTRAINT [PK_BAOCAOHOATDONG] PRIMARY KEY CLUSTERED ([MABAOCAOHOATDONG]) 
GO

--Indexes of table dbo.CONGDOANTHUCHIEN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[CONGDOANTHUCHIEN] ADD CONSTRAINT [PK_CONGDOANTHUCHIEN] PRIMARY KEY CLUSTERED ([MACONGDOAN]) 
GO

--Indexes of table dbo.CONGTRINH
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[CONGTRINH] ADD CONSTRAINT [PK_CONGTRINH] PRIMARY KEY CLUSTERED ([MACONGTRINH]) 
GO

--Indexes of table dbo.DANGKYHOATDONG
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[DANGKYHOATDONG] ADD CONSTRAINT [PK_DANGKYHOATDONG] PRIMARY KEY CLUSTERED ([MADANGKYHOATDONG]) 
GO

--Indexes of table dbo.GIAYPHEPHOATDONG
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[GIAYPHEPHOATDONG] ADD CONSTRAINT [PK_GIAYPHEPHOATDONG] PRIMARY KEY CLUSTERED ([MAGIAYPHEPHOATDONG]) 
GO

ALTER TABLE [dbo].[GIAYPHEPHOATDONG] ADD CONSTRAINT [UQ__GIAYPHEP__061E427407F6335A] UNIQUE NONCLUSTERED ([SOGIAYPHEP]) 
GO

--Indexes of table dbo.HOATDONG
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[HOATDONG] ADD CONSTRAINT [PK_HOATDONG] PRIMARY KEY CLUSTERED ([MAHOATDONG]) 
GO

--Indexes of table dbo.LOAIHINHTOCHUC
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[LOAIHINHTOCHUC] ADD CONSTRAINT [PK_LOAIHINHTOCHUC] PRIMARY KEY CLUSTERED ([MALOAIHINHTOCHUC]) 
GO

--Indexes of table dbo.LOAISANPHAM
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[LOAISANPHAM] ADD CONSTRAINT [PK_LOAISANPHAM] PRIMARY KEY CLUSTERED ([MALOAISANPHAM]) 
GO

--Indexes of table dbo.NHANLUC
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[NHANLUC] ADD CONSTRAINT [PK_NHANLUC] PRIMARY KEY CLUSTERED ([MANHANVIEN]) 
GO

--Indexes of table dbo.QUANHUYEN
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[QUANHUYEN] ADD CONSTRAINT [PK_QUANHUYEN] PRIMARY KEY CLUSTERED ([MAQUANHUYEN]) 
GO

--Indexes of table dbo.SANPHAM
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[SANPHAM] ADD CONSTRAINT [PK_SANPHAM] PRIMARY KEY CLUSTERED ([MASANPHAM]) 
GO

--Indexes of table dbo.THAMDINH
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[THAMDINH] ADD CONSTRAINT [PK_THAMDINH] PRIMARY KEY CLUSTERED ([MATHAMDINH]) 
GO

--Indexes of table dbo.THIETBI
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[THIETBI] ADD CONSTRAINT [PK_THIETBI] PRIMARY KEY CLUSTERED ([MATHIETBI]) 
GO

--Indexes of table dbo.TINHTHANH
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[TINHTHANH] ADD CONSTRAINT [PK_TINHTHANH] PRIMARY KEY CLUSTERED ([MATINHTHANH]) 
GO

--Indexes of table dbo.TINHTRANGGIAYPHEP
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[TINHTRANGGIAYPHEP] ADD CONSTRAINT [PK_TINHTRANGGIAYPHEP] PRIMARY KEY CLUSTERED ([MATINHTRANG]) 
GO

--Indexes of table dbo.TOCHUC
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[TOCHUC] ADD CONSTRAINT [PK_TOCHUC] PRIMARY KEY CLUSTERED ([MATOCHUC]) 
GO