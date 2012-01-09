USE [QLDDBD]
GO
/****** Object:  Table [dbo].[LoaiQuyen]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoaiQuyen]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoaiQuyen](
	[MaLoaiQuyen] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiQuyen] [nvarchar](50) NULL,
	[DienGiai] [nvarchar](100) NULL,
 CONSTRAINT [PK_LOAIQUYEN] PRIMARY KEY CLUSTERED 
(
	[MaLoaiQuyen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[LoaiQuyen] ON
INSERT [dbo].[LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (1, N'Quản lý người dùng', NULL)
INSERT [dbo].[LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (2, N'Quản lý tổ chức', NULL)
INSERT [dbo].[LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (3, N'Quản lý giấy phép ', NULL)
INSERT [dbo].[LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (4, N'Quản lý bản đồ', NULL)
INSERT [dbo].[LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (5, N'Quản lý hoạt động', NULL)
SET IDENTITY_INSERT [dbo].[LoaiQuyen] OFF
/****** Object:  Table [dbo].[LoaiHinhToChuc]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoaiHinhToChuc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoaiHinhToChuc](
	[MaLoaiHinhToChuc] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiHinhToChuc] [nvarchar](50) NULL,
 CONSTRAINT [PK_LOAIHINHTOCHUC] PRIMARY KEY CLUSTERED 
(
	[MaLoaiHinhToChuc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[LoaiHinhToChuc] ON
INSERT [dbo].[LoaiHinhToChuc] ([MaLoaiHinhToChuc], [TenLoaiHinhToChuc]) VALUES (1, N'Tổ chức trong nước')
INSERT [dbo].[LoaiHinhToChuc] ([MaLoaiHinhToChuc], [TenLoaiHinhToChuc]) VALUES (2, N'Tổ chức đầu tư nước ngoài')
INSERT [dbo].[LoaiHinhToChuc] ([MaLoaiHinhToChuc], [TenLoaiHinhToChuc]) VALUES (3, N'Tổ chức nước ngoài')
SET IDENTITY_INSERT [dbo].[LoaiHinhToChuc] OFF
/****** Object:  Table [dbo].[KieuSanPham]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KieuSanPham]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KieuSanPham](
	[MaKieuSanPham] [int] IDENTITY(1,1) NOT NULL,
	[DienGiai] [nvarchar](50) NULL,
 CONSTRAINT [PK_KieuSanPham] PRIMARY KEY CLUSTERED 
(
	[MaKieuSanPham] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[KieuSanPham] ON
INSERT [dbo].[KieuSanPham] ([MaKieuSanPham], [DienGiai]) VALUES (1, N'Mốc')
INSERT [dbo].[KieuSanPham] ([MaKieuSanPham], [DienGiai]) VALUES (2, N'Bản đồ')
SET IDENTITY_INSERT [dbo].[KieuSanPham] OFF
/****** Object:  Table [dbo].[HoatDong]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HoatDong]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HoatDong](
	[MaHoatDong] [int] IDENTITY(1,1) NOT NULL,
	[TenHoatDong] [nvarchar](500) NULL,
 CONSTRAINT [PK_HOATDONG] PRIMARY KEY CLUSTERED 
(
	[MaHoatDong] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[HoatDong] ON
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (1, N'Khảo sát, lập dự án, thiết kế kỹ thuật – dự toán công trình đo đạc và bản đồ')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (2, N'Kiểm tra, thẩm định chất lượng công trình, sản phẩm đo đạc và bản đồ')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (3, N'Xây dựng lưới tọa độ, độ cao quốc gia')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (4, N'Xây dựng điểm trọng lực, thiên văn, tọa độ, độ cao')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (5, N'Chụp ảnh, quét địa hình từ máy bay')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (6, N'Đo vẽ, thành lập bản đồ địa hình các tỷ lệ')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (7, N'Đo vẽ, thành lập bản đồ địa hình đáy biển các tỷ lệ')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (8, N'Đo vẽ, thành lập bản đồ địa chính các tỷ lệ')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (9, N'Thành lập bản đồ hành chính các cấp')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (10, N'Đo vẽ, thành lập bản đồ địa giới hành chính các cấp')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (11, N'Xây dựng cơ sở dữ liệu đo đạc và bản đồ')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (12, N'Xây dựng cơ sở dữ liệu hệ thống thông tin địa lý')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (13, N'Thành lập bản đồ chuyên đề')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (14, N'Thành lập atlas địa lý')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (15, N'Khảo sát, đo đạc công trình')
INSERT [dbo].[HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (16, N'Kiểm định các thiết bị đo đạc')
SET IDENTITY_INSERT [dbo].[HoatDong] OFF
/****** Object:  Table [dbo].[CongTrinh]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CongTrinh]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CongTrinh](
	[MaCongTrinh] [int] IDENTITY(1,1) NOT NULL,
	[TenCongTrinh] [nvarchar](500) NULL,
	[ChuDauTu] [nvarchar](500) NULL,
	[DonViNghiemThu] [nvarchar](500) NULL,
	[NgayBatDau] [date] NULL,
	[NgayKetThuc] [date] NULL,
	[GhiChu] [nvarchar](2000) NULL,
	[TinhTrang] [int] NULL,
 CONSTRAINT [PK_CONGTRINH] PRIMARY KEY CLUSTERED 
(
	[MaCongTrinh] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[LoaiThamDinh]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoaiThamDinh]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoaiThamDinh](
	[MALOAITHAMDINH] [int] NOT NULL,
	[DIENGIAI] [nvarchar](50) NULL,
 CONSTRAINT [PK_LOAITHAMDINH] PRIMARY KEY CLUSTERED 
(
	[MALOAITHAMDINH] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[LoaiThamDinh] ([MALOAITHAMDINH], [DIENGIAI]) VALUES (1, N'Xin cấp phép mới')
INSERT [dbo].[LoaiThamDinh] ([MALOAITHAMDINH], [DIENGIAI]) VALUES (2, N'Gia hạn')
INSERT [dbo].[LoaiThamDinh] ([MALOAITHAMDINH], [DIENGIAI]) VALUES (3, N'Bổ sung hoạt động')
/****** Object:  Table [dbo].[TinhTrangXetDuyet]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TinhTrangXetDuyet]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TinhTrangXetDuyet](
	[MaTinhTrang] [int] NOT NULL,
	[DienGiai] [nvarchar](50) NULL,
 CONSTRAINT [PK_TinhTrangHoatDong] PRIMARY KEY CLUSTERED 
(
	[MaTinhTrang] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[TinhTrangXetDuyet] ([MaTinhTrang], [DienGiai]) VALUES (1, N'Chờ xét duyệt')
INSERT [dbo].[TinhTrangXetDuyet] ([MaTinhTrang], [DienGiai]) VALUES (2, N'Không được xét duyệt')
INSERT [dbo].[TinhTrangXetDuyet] ([MaTinhTrang], [DienGiai]) VALUES (3, N'Đã duyệt')
/****** Object:  Table [dbo].[TinhTrangTaiKhoan]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TinhTrangTaiKhoan]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TinhTrangTaiKhoan](
	[MaTinhTrang] [int] NOT NULL,
	[DienGiai] [nvarchar](50) NULL,
 CONSTRAINT [PK_TinhTrangTaiKhoan] PRIMARY KEY CLUSTERED 
(
	[MaTinhTrang] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[TinhTrangTaiKhoan] ([MaTinhTrang], [DienGiai]) VALUES (1, N'Chưa kích hoạt')
INSERT [dbo].[TinhTrangTaiKhoan] ([MaTinhTrang], [DienGiai]) VALUES (2, N'Đã kích hoạt')
INSERT [dbo].[TinhTrangTaiKhoan] ([MaTinhTrang], [DienGiai]) VALUES (3, N'Bị khoá')
/****** Object:  Table [dbo].[TinhTrangGiayPhep]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TinhTrangGiayPhep]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TinhTrangGiayPhep](
	[MaTinhTrang] [int] NOT NULL,
	[DienGiai] [nvarchar](50) NULL,
 CONSTRAINT [PK_TINHTRANGGIAYPHEP] PRIMARY KEY CLUSTERED 
(
	[MaTinhTrang] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (1, N'Chờ xin cấp giấy phép')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (2, N'Xin cấp giấy phép thất bại')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (3, N'Giấy phép hết hạn')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (4, N'Xin cấp phép thành công')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (5, N'Đã được cấp giấy phép')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (6, N'Chờ xin bổ sung hoạt động')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (7, N'Bổ sung hoạt động thất bại')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (8, N'Bổ sung hoạt động thành công')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (9, N'Chờ xin gia hạn')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (10, N'Xin gia hạn thất bại')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (11, N'Xin gia hạn thành công')
INSERT [dbo].[TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (12, N'Giấy phép bị hủy')
/****** Object:  Table [dbo].[TinhThanh]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TinhThanh]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TinhThanh](
	[MaTinhThanh] [int] IDENTITY(1,1) NOT NULL,
	[TenTinhThanh] [nvarchar](50) NULL,
 CONSTRAINT [PK_TINHTHANH] PRIMARY KEY CLUSTERED 
(
	[MaTinhThanh] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[NhomNguoiDung]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NhomNguoiDung]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NhomNguoiDung](
	[MaNhom] [int] IDENTITY(1,1) NOT NULL,
	[TenNhom] [nvarchar](50) NULL,
 CONSTRAINT [PK_NHOMNGUOIDUNG] PRIMARY KEY CLUSTERED 
(
	[MaNhom] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[NhomNguoiDung] ON
INSERT [dbo].[NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (1, N'Đăng ký')
INSERT [dbo].[NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (2, N'Quản lý địa phương')
INSERT [dbo].[NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (3, N'Quản lý cấp phép')
INSERT [dbo].[NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (4, N'SuperAdmin')
SET IDENTITY_INSERT [dbo].[NhomNguoiDung] OFF
/****** Object:  Table [dbo].[Quyen]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Quyen]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Quyen](
	[MaQuyen] [int] IDENTITY(1,1) NOT NULL,
	[TenQuyen] [nvarchar](50) NULL,
	[MoTa] [nvarchar](100) NULL,
	[LoaiQuyen] [int] NULL,
 CONSTRAINT [PK_QUYEN] PRIMARY KEY CLUSTERED 
(
	[MaQuyen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[QuanHuyen]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuanHuyen]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QuanHuyen](
	[MaQuanHuyen] [int] IDENTITY(1,1) NOT NULL,
	[TenQuanHuyen] [nvarchar](50) NULL,
	[MaTinhThanh] [int] NULL,
 CONSTRAINT [PK_QUANHUYEN] PRIMARY KEY CLUSTERED 
(
	[MaQuanHuyen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[LoaiSanPham]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoaiSanPham]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoaiSanPham](
	[MaLoaiSanPham] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiSanPham] [nvarchar](500) NULL,
	[KieuSanPham] [int] NULL,
	[DienGiai] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LOAISANPHAM] PRIMARY KEY CLUSTERED 
(
	[MaLoaiSanPham] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[LoaiSanPham] ON
INSERT [dbo].[LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [KieuSanPham], [DienGiai]) VALUES (1, N'Mốc toạ độ', 1, N'Mốc toạ độ')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [KieuSanPham], [DienGiai]) VALUES (2, N'Mốc độ cao', 1, N'Mốc độ cao')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [KieuSanPham], [DienGiai]) VALUES (3, N'Mốc trọng lực', 1, N'Mốc trọng lực')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [KieuSanPham], [DienGiai]) VALUES (4, N'Bản đồ địa chính 1: 2000', 2, N'Bản đồ địa chính 1: 2000')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [KieuSanPham], [DienGiai]) VALUES (5, N'Bản đồ địa chính 1: 10000', 2, N'Bản đồ địa chính 1: 10000')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [KieuSanPham], [DienGiai]) VALUES (6, N'Bản đồ địa chính 1: 20000', 2, N'Bản đồ địa chính 1: 20000')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [KieuSanPham], [DienGiai]) VALUES (7, N'Bản độ địa hình 1: 1000', 2, N'Bản đồ địa hình 1:1000')
SET IDENTITY_INSERT [dbo].[LoaiSanPham] OFF
/****** Object:  Table [dbo].[CongDoanThucHien]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CongDoanThucHien]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CongDoanThucHien](
	[MaCongDoan] [int] IDENTITY(1,1) NOT NULL,
	[SoGiayPhep] [nvarchar](50) NULL,
	[MaCongTrinh] [int] NULL,
	[NgayBatDau] [date] NULL,
	[NgayKetThuc] [date] NULL,
 CONSTRAINT [PK_CONGDOANTHUCHIEN] PRIMARY KEY CLUSTERED 
(
	[MaCongDoan] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaiKhoan]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TaiKhoan](
	[MaTaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[NhomNguoiDung] [int] NULL,
	[TenTaiKhoan] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[CMND] [nvarchar](50) NULL,
	[Email] [nvarchar](250) NULL,
	[CoQuan] [nvarchar](100) NULL,
	[TinhTrang] [int] NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TAIKHOAN] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (1, 4, N'dodacvn', N'dodacvn', N'34 truong dinh', N'123456756', N'admin@gmail.com', N'cuc do dac', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (2, 4, N'thuong', N'thuongthuong', N'fdjsjl', N'123456789', N'thuongthuong1990@gmail.com', N'fjdlsjflkds', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
/****** Object:  Table [dbo].[ToChuc]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ToChuc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ToChuc](
	[MaToChuc] [int] IDENTITY(1,1) NOT NULL,
	[MaLoaiHinhToChuc] [int] NULL,
	[TenToChuc] [nvarchar](250) NULL,
	[GiayPhepKinhDoanh] [nvarchar](15) NULL,
	[NguoiDaiDien] [nvarchar](50) NULL,
	[TruSoChinh] [nvarchar](2000) NULL,
	[SoTaiKhoan] [nvarchar](50) NULL,
	[DienThoai] [nvarchar](15) NULL,
	[Fax] [nvarchar](15) NULL,
	[Email] [nvarchar](250) NULL,
	[TongSoCanBo] [int] NULL,
	[NgayXinPhep] [date] NULL,
	[KichHoat] [bit] NULL,
	[TepDinhKem] [nvarchar](500) NULL,
	[MaTaiKhoan] [int] NULL,
	[HangDoanhNghiep] [nvarchar](50) NULL,
	[VonLuuDong] [money] NULL,
	[VonPhapDinh] [money] NULL,
 CONSTRAINT [PK_TOCHUC] PRIMARY KEY CLUSTERED 
(
	[MaToChuc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[ToChuc] ON
INSERT [dbo].[ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [NgayXinPhep], [KichHoat], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (6, 1, N'Công ty A ', N'GPKD1234', N'Nguyễn Văn Lâm', N'Đặng Văn Ngữ', N'jfdskfj', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 8948595.0000, 48530000.0000)
INSERT [dbo].[ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [NgayXinPhep], [KichHoat], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (7, 1, N'Công ty B', N'GPKD1235', N'Nguyễn Văn Hùng', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [NgayXinPhep], [KichHoat], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (8, NULL, N'Công ty C', N'1234567', N'Nguyễn Sinh Hùng', N'Điện Biên Phủ', NULL, N'89754309', N'89754309', NULL, 35, CAST(0x23350B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [NgayXinPhep], [KichHoat], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (9, 1, N'Công ty D', NULL, NULL, N'Mac Dinh Chi', NULL, NULL, NULL, NULL, NULL, CAST(0x23350B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [NgayXinPhep], [KichHoat], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (10, 2, N'Công ty E', N'4372864', NULL, N'Nguyen Thai Son', NULL, NULL, NULL, NULL, NULL, CAST(0x23350B00 AS Date), 1, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ToChuc] OFF
/****** Object:  Table [dbo].[SanPham]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SanPham]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SanPham](
	[MaSanPham] [int] IDENTITY(1,1) NOT NULL,
	[SoHieu] [nvarchar](50) NULL,
	[MaLoaiSanPham] [int] NULL,
	[MaCongTrinh] [int] NULL,
	[MaQuanHuyen] [int] NULL,
	[CapHanhChinh] [int] NULL,
 CONSTRAINT [PK_SANPHAM] PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[QuyenCuaNhom]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuyenCuaNhom]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QuyenCuaNhom](
	[MaQuyenNhom] [int] IDENTITY(1,1) NOT NULL,
	[MaNhom] [int] NOT NULL,
	[Quyen] [int] NOT NULL,
 CONSTRAINT [PK_QUYENCUANHOM] PRIMARY KEY CLUSTERED 
(
	[MaQuyenNhom] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BaoCaoHoatDong]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BaoCaoHoatDong]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BaoCaoHoatDong](
	[MaBaoCaoHoatDong] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[Nam] [int] NULL,
	[DoanhThu] [money] NULL,
	[NopNganSach] [money] NULL,
	[DanhSachCongTrinh] [nvarchar](2000) NULL,
	[TepDinhKem] [nvarchar](500) NULL,
 CONSTRAINT [PK_BAOCAOHOATDONG] PRIMARY KEY CLUSTERED 
(
	[MaBaoCaoHoatDong] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[GiayPhepHoatDong]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GiayPhepHoatDong]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GiayPhepHoatDong](
	[MaGiayPhepHoatDong] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[SoGiayPhep] [nvarchar](50) NULL,
	[NgayCapPhep] [date] NULL,
	[NgayHetHan] [date] NULL,
	[NgayGiaHan] [date] NULL,
	[LyDoXinPhep] [nvarchar](2000) NULL,
	[LyDoGiaHan] [nvarchar](2000) NULL,
	[LyDoCapPhep] [nvarchar](2000) NULL,
	[CamKetXinPhep] [nvarchar](2000) NULL,
	[CamKetGiaHan] [nvarchar](2000) NULL,
	[CamKetBoSung] [nvarchar](2000) NULL,
	[TinhTrang] [int] NULL,
	[NgayXinPhep] [date] NULL,
	[NgayXinGiaHan] [date] NULL,
	[NgayXinBoSung] [date] NULL,
	[TepDinhKem] [nvarchar](50) NULL,
 CONSTRAINT [PK_GIAYPHEPHOATDONG] PRIMARY KEY CLUSTERED 
(
	[MaGiayPhepHoatDong] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UQ__GIAYPHEP__061E427407F6335A] UNIQUE NONCLUSTERED 
(
	[SoGiayPhep] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[SoGiayPhep] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[GiayPhepHoatDong] ON
INSERT [dbo].[GiayPhepHoatDong] ([MaGiayPhepHoatDong], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [NgayGiaHan], [LyDoXinPhep], [LyDoGiaHan], [LyDoCapPhep], [CamKetXinPhep], [CamKetGiaHan], [CamKetBoSung], [TinhTrang], [NgayXinPhep], [NgayXinGiaHan], [NgayXinBoSung], [TepDinhKem]) VALUES (1, 6, N'86786868', CAST(0x90320B00 AS Date), CAST(0x45380B00 AS Date), NULL, N'muốn được hoạt động trong lĩnh vực đbd', NULL, N'đủ điều kiện theo quy định', N'thực hiện đúng quy định về ddbd', NULL, N'Hoạt động tốt và đúng quy định khi bắt đầu hoạt động đo đạc mới', 6, CAST(0x18350B00 AS Date), NULL, NULL, N'fdsafdksajfkjdskajfkdsj')
INSERT [dbo].[GiayPhepHoatDong] ([MaGiayPhepHoatDong], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [NgayGiaHan], [LyDoXinPhep], [LyDoGiaHan], [LyDoCapPhep], [CamKetXinPhep], [CamKetGiaHan], [CamKetBoSung], [TinhTrang], [NgayXinPhep], [NgayXinGiaHan], [NgayXinBoSung], [TepDinhKem]) VALUES (2, 7, N'5fdsj38', CAST(0x38320B00 AS Date), CAST(0x80360B00 AS Date), NULL, N'muốn được hoạt động trong lĩnh vực đbd', NULL, NULL, N'thực hiện đúng quy định về ddbd', NULL, N'Hoạt động tốt và đúng quy định khi bắt đầu hoạt động đo đạc mới', 4, CAST(0x38320B00 AS Date), NULL, CAST(0x16350B00 AS Date), N'fdsfsfewfgdfafd')
INSERT [dbo].[GiayPhepHoatDong] ([MaGiayPhepHoatDong], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [NgayGiaHan], [LyDoXinPhep], [LyDoGiaHan], [LyDoCapPhep], [CamKetXinPhep], [CamKetGiaHan], [CamKetBoSung], [TinhTrang], [NgayXinPhep], [NgayXinGiaHan], [NgayXinBoSung], [TepDinhKem]) VALUES (3, 9, N'12345678', CAST(0x212E0B00 AS Date), CAST(0x44350B00 AS Date), CAST(0x2F350B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'tiếp tục công tác đo đạc', N'đủ điều kiện theo quy định', N'thực hiện đúng quy định về ddbd', N'Giữ vững hoạt động, phát triển hoạt động đã đăng ký', NULL, 9, CAST(0x1C2E0B00 AS Date), CAST(0x2C350B00 AS Date), NULL, N'fdgsfdsgfd')
SET IDENTITY_INSERT [dbo].[GiayPhepHoatDong] OFF
/****** Object:  Table [dbo].[NhanLuc]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NhanLuc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NhanLuc](
	[MaNhanVien] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[HoTen] [nvarchar](50) NULL,
	[ChucVu] [nvarchar](50) NULL,
	[TrinhDoHocVan] [nvarchar](50) NULL,
	[ChuyenNganh] [nvarchar](500) NULL,
	[ThamNien] [int] NULL,
	[TepDinhKem] [nvarchar](500) NULL,
 CONSTRAINT [PK_NHANLUC] PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[NhanLuc] ON
INSERT [dbo].[NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [ChuyenNganh], [ThamNien], [TepDinhKem]) VALUES (2, 6, N'Nguyễn Văn lâm', N'giám đốc', N'cao học', N'kinh tế', 15, N'dfdsafdsaff')
INSERT [dbo].[NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [ChuyenNganh], [ThamNien], [TepDinhKem]) VALUES (3, 6, N'Trần Thanh Hùng', N'phó giám đốc', N'đại học', N'trắc địa', 13, N'fdsafksdkkj')
SET IDENTITY_INSERT [dbo].[NhanLuc] OFF
/****** Object:  Table [dbo].[NangLucKeKhai]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NangLucKeKhai]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NangLucKeKhai](
	[MaKeKhaiNangLuc] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NOT NULL,
	[NganhNghe] [nvarchar](250) NULL,
	[SoTrenDaiHoc] [int] NULL,
	[SoTrungCap] [int] NULL,
	[SoCongNhanKyThuat] [int] NULL,
	[LoaiKhac] [int] NULL,
 CONSTRAINT [PK_NangLucKeKhai] PRIMARY KEY CLUSTERED 
(
	[MaKeKhaiNangLuc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[NangLucKeKhai] ON
INSERT [dbo].[NangLucKeKhai] ([MaKeKhaiNangLuc], [MaToChuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac]) VALUES (1, 6, N'trắc địa', 5, 6, 10, 4)
INSERT [dbo].[NangLucKeKhai] ([MaKeKhaiNangLuc], [MaToChuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac]) VALUES (2, 6, N'kế toán', 4, 2, 0, 0)
SET IDENTITY_INSERT [dbo].[NangLucKeKhai] OFF
/****** Object:  Table [dbo].[ThietBi]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ThietBi]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ThietBi](
	[MaThietBi] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[TenThietBi_CongNghe] [nvarchar](500) NULL,
	[SoLuong] [int] NULL,
	[GhiChu] [nvarchar](2000) NULL,
	[TepDinhKem] [nvarchar](500) NULL,
	[TinhTrang] [nvarchar](50) NULL,
 CONSTRAINT [PK_THIETBI] PRIMARY KEY CLUSTERED 
(
	[MaThietBi] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[ThietBi] ON
INSERT [dbo].[ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TepDinhKem], [TinhTrang]) VALUES (1, 6, N'Thiết bị định vị', 5, NULL, N'thietbi/6', N'tốt')
INSERT [dbo].[ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TepDinhKem], [TinhTrang]) VALUES (2, 6, N'Thiết bị đo độ dài', 10, N'được Nhà nước cung cấp', N'thietbi/6', N'tốt')
SET IDENTITY_INSERT [dbo].[ThietBi] OFF
/****** Object:  Table [dbo].[ThamDinh]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ThamDinh]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ThamDinh](
	[MaThamDinh] [int] IDENTITY(1,1) NOT NULL,
	[MaGiayPhepHoatDong] [int] NULL,
	[NguoiThamDinh] [nvarchar](500) NULL,
	[NguoiPhiaToChuc] [nvarchar](500) NULL,
	[NgayThamDinh] [date] NULL,
	[TinhHopLe] [nvarchar](2000) NULL,
	[NangLucNhanVien] [nvarchar](2000) NULL,
	[NangLucThietBi] [nvarchar](2000) NULL,
	[KetLuan] [nvarchar](2000) NULL,
	[KienNghi] [nvarchar](2000) NULL,
	[LoaiThamDinh] [int] NULL,
 CONSTRAINT [PK_THAMDINH] PRIMARY KEY CLUSTERED 
(
	[MaThamDinh] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[ThamDinh] ON
INSERT [dbo].[ThamDinh] ([MaThamDinh], [MaGiayPhepHoatDong], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [LoaiThamDinh]) VALUES (1, 1, N'Nguyễn Văn Lâm, Trần Văn Lạc', N'Nguyễn Thị Hồng Hạnh, Nguyễn Đình Phương', CAST(0x5D1D0100 AS Date), N'hồ sơ đầy đủ', N'đủ năng lực', N'đủ điều kiện', N'đủ tiêu chuẩn cấp phép', N'cấp giấy phép hoạt động', 1)
INSERT [dbo].[ThamDinh] ([MaThamDinh], [MaGiayPhepHoatDong], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [LoaiThamDinh]) VALUES (2, 2, N'Nguyễn Cao Kỳ', N'Lâm Chấn Phong', CAST(0x00000000 AS Date), N'hồ sơ đầy đủ', N' đủ năng lực', N'khong đủ điều kiện', N' đủ tiêu chuẩn cấp phép bổ sung hoạt động', N'cấp phép những hoạt động đăng ký bổ sung', 1)
SET IDENTITY_INSERT [dbo].[ThamDinh] OFF
/****** Object:  Table [dbo].[DangKyHoatDong]    Script Date: 01/09/2012 23:06:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DangKyHoatDong]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DangKyHoatDong](
	[MaDangKyHoatDong] [int] IDENTITY(1,1) NOT NULL,
	[MaGiayPhepHoatDong] [int] NULL,
	[LaBoSung] [bit] NULL,
	[NgayBoSung] [date] NULL,
	[TinhTrang] [int] NULL,
	[MaHoatDong] [int] NULL,
 CONSTRAINT [PK_DANGKYHOATDONG] PRIMARY KEY CLUSTERED 
(
	[MaDangKyHoatDong] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[DangKyHoatDong] ON
INSERT [dbo].[DangKyHoatDong] ([MaDangKyHoatDong], [MaGiayPhepHoatDong], [LaBoSung], [NgayBoSung], [TinhTrang], [MaHoatDong]) VALUES (1, 1, 1, CAST(0xA5330B00 AS Date), 1, 2)
INSERT [dbo].[DangKyHoatDong] ([MaDangKyHoatDong], [MaGiayPhepHoatDong], [LaBoSung], [NgayBoSung], [TinhTrang], [MaHoatDong]) VALUES (2, 1, 1, CAST(0xA5330B00 AS Date), 1, 3)
INSERT [dbo].[DangKyHoatDong] ([MaDangKyHoatDong], [MaGiayPhepHoatDong], [LaBoSung], [NgayBoSung], [TinhTrang], [MaHoatDong]) VALUES (3, 1, 0, CAST(0x2D320B00 AS Date), 3, 4)
INSERT [dbo].[DangKyHoatDong] ([MaDangKyHoatDong], [MaGiayPhepHoatDong], [LaBoSung], [NgayBoSung], [TinhTrang], [MaHoatDong]) VALUES (4, 1, 0, CAST(0x2D320B00 AS Date), 3, 5)
SET IDENTITY_INSERT [dbo].[DangKyHoatDong] OFF
/****** Object:  Default [DF_TaiKhoan_TinhTrang]    Script Date: 01/09/2012 23:06:59 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_TaiKhoan_TinhTrang]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaiKhoan]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TaiKhoan_TinhTrang]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TaiKhoan] ADD  CONSTRAINT [DF_TaiKhoan_TinhTrang]  DEFAULT ((1)) FOR [TinhTrang]
END


End
GO
/****** Object:  ForeignKey [FK_QUYEN_LOAIQUYEN]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QUYEN_LOAIQUYEN]') AND parent_object_id = OBJECT_ID(N'[dbo].[Quyen]'))
ALTER TABLE [dbo].[Quyen]  WITH CHECK ADD  CONSTRAINT [FK_QUYEN_LOAIQUYEN] FOREIGN KEY([LoaiQuyen])
REFERENCES [dbo].[LoaiQuyen] ([MaLoaiQuyen])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QUYEN_LOAIQUYEN]') AND parent_object_id = OBJECT_ID(N'[dbo].[Quyen]'))
ALTER TABLE [dbo].[Quyen] CHECK CONSTRAINT [FK_QUYEN_LOAIQUYEN]
GO
/****** Object:  ForeignKey [FK_QUANHUYE_REFERENCE_TINHTHAN]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QUANHUYE_REFERENCE_TINHTHAN]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuanHuyen]'))
ALTER TABLE [dbo].[QuanHuyen]  WITH CHECK ADD  CONSTRAINT [FK_QUANHUYE_REFERENCE_TINHTHAN] FOREIGN KEY([MaTinhThanh])
REFERENCES [dbo].[TinhThanh] ([MaTinhThanh])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QUANHUYE_REFERENCE_TINHTHAN]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuanHuyen]'))
ALTER TABLE [dbo].[QuanHuyen] CHECK CONSTRAINT [FK_QUANHUYE_REFERENCE_TINHTHAN]
GO
/****** Object:  ForeignKey [FK_LoaiSanPham_KieuSanPham]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LoaiSanPham_KieuSanPham]') AND parent_object_id = OBJECT_ID(N'[dbo].[LoaiSanPham]'))
ALTER TABLE [dbo].[LoaiSanPham]  WITH CHECK ADD  CONSTRAINT [FK_LoaiSanPham_KieuSanPham] FOREIGN KEY([KieuSanPham])
REFERENCES [dbo].[KieuSanPham] ([MaKieuSanPham])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LoaiSanPham_KieuSanPham]') AND parent_object_id = OBJECT_ID(N'[dbo].[LoaiSanPham]'))
ALTER TABLE [dbo].[LoaiSanPham] CHECK CONSTRAINT [FK_LoaiSanPham_KieuSanPham]
GO
/****** Object:  ForeignKey [FK_CONGDOAN_REFERENCE_CONGTRIN]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CONGDOAN_REFERENCE_CONGTRIN]') AND parent_object_id = OBJECT_ID(N'[dbo].[CongDoanThucHien]'))
ALTER TABLE [dbo].[CongDoanThucHien]  WITH CHECK ADD  CONSTRAINT [FK_CONGDOAN_REFERENCE_CONGTRIN] FOREIGN KEY([MaCongTrinh])
REFERENCES [dbo].[CongTrinh] ([MaCongTrinh])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CONGDOAN_REFERENCE_CONGTRIN]') AND parent_object_id = OBJECT_ID(N'[dbo].[CongDoanThucHien]'))
ALTER TABLE [dbo].[CongDoanThucHien] CHECK CONSTRAINT [FK_CONGDOAN_REFERENCE_CONGTRIN]
GO
/****** Object:  ForeignKey [FK_TAIKHOAN_NHOMNGUOIDUNG]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TAIKHOAN_NHOMNGUOIDUNG]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaiKhoan]'))
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TAIKHOAN_NHOMNGUOIDUNG] FOREIGN KEY([NhomNguoiDung])
REFERENCES [dbo].[NhomNguoiDung] ([MaNhom])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TAIKHOAN_NHOMNGUOIDUNG]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaiKhoan]'))
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TAIKHOAN_NHOMNGUOIDUNG]
GO
/****** Object:  ForeignKey [FK_TaiKhoan_TinhTrangTaiKhoan]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TaiKhoan_TinhTrangTaiKhoan]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaiKhoan]'))
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_TinhTrangTaiKhoan] FOREIGN KEY([TinhTrang])
REFERENCES [dbo].[TinhTrangTaiKhoan] ([MaTinhTrang])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TaiKhoan_TinhTrangTaiKhoan]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaiKhoan]'))
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_TinhTrangTaiKhoan]
GO
/****** Object:  ForeignKey [FK_TOCHUC_REFERENCE_LOAIHINH]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TOCHUC_REFERENCE_LOAIHINH]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToChuc]'))
ALTER TABLE [dbo].[ToChuc]  WITH CHECK ADD  CONSTRAINT [FK_TOCHUC_REFERENCE_LOAIHINH] FOREIGN KEY([MaLoaiHinhToChuc])
REFERENCES [dbo].[LoaiHinhToChuc] ([MaLoaiHinhToChuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TOCHUC_REFERENCE_LOAIHINH]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToChuc]'))
ALTER TABLE [dbo].[ToChuc] CHECK CONSTRAINT [FK_TOCHUC_REFERENCE_LOAIHINH]
GO
/****** Object:  ForeignKey [FK_TOCHUC_TAIKHOAN]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TOCHUC_TAIKHOAN]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToChuc]'))
ALTER TABLE [dbo].[ToChuc]  WITH CHECK ADD  CONSTRAINT [FK_TOCHUC_TAIKHOAN] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TOCHUC_TAIKHOAN]') AND parent_object_id = OBJECT_ID(N'[dbo].[ToChuc]'))
ALTER TABLE [dbo].[ToChuc] CHECK CONSTRAINT [FK_TOCHUC_TAIKHOAN]
GO
/****** Object:  ForeignKey [FK_SANPHAM_REFERENCE_CONGTRIN]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SANPHAM_REFERENCE_CONGTRIN]') AND parent_object_id = OBJECT_ID(N'[dbo].[SanPham]'))
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SANPHAM_REFERENCE_CONGTRIN] FOREIGN KEY([MaCongTrinh])
REFERENCES [dbo].[CongTrinh] ([MaCongTrinh])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SANPHAM_REFERENCE_CONGTRIN]') AND parent_object_id = OBJECT_ID(N'[dbo].[SanPham]'))
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SANPHAM_REFERENCE_CONGTRIN]
GO
/****** Object:  ForeignKey [FK_SANPHAM_REFERENCE_LOAISANP]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SANPHAM_REFERENCE_LOAISANP]') AND parent_object_id = OBJECT_ID(N'[dbo].[SanPham]'))
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SANPHAM_REFERENCE_LOAISANP] FOREIGN KEY([MaLoaiSanPham])
REFERENCES [dbo].[LoaiSanPham] ([MaLoaiSanPham])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SANPHAM_REFERENCE_LOAISANP]') AND parent_object_id = OBJECT_ID(N'[dbo].[SanPham]'))
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SANPHAM_REFERENCE_LOAISANP]
GO
/****** Object:  ForeignKey [FK_SANPHAM_REFERENCE_QUANHUYE]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SANPHAM_REFERENCE_QUANHUYE]') AND parent_object_id = OBJECT_ID(N'[dbo].[SanPham]'))
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SANPHAM_REFERENCE_QUANHUYE] FOREIGN KEY([MaQuanHuyen])
REFERENCES [dbo].[QuanHuyen] ([MaQuanHuyen])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SANPHAM_REFERENCE_QUANHUYE]') AND parent_object_id = OBJECT_ID(N'[dbo].[SanPham]'))
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SANPHAM_REFERENCE_QUANHUYE]
GO
/****** Object:  ForeignKey [FK_QUYENCUANHOM_NHOMNGUOIDUNG]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QUYENCUANHOM_NHOMNGUOIDUNG]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuyenCuaNhom]'))
ALTER TABLE [dbo].[QuyenCuaNhom]  WITH CHECK ADD  CONSTRAINT [FK_QUYENCUANHOM_NHOMNGUOIDUNG] FOREIGN KEY([MaNhom])
REFERENCES [dbo].[NhomNguoiDung] ([MaNhom])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QUYENCUANHOM_NHOMNGUOIDUNG]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuyenCuaNhom]'))
ALTER TABLE [dbo].[QuyenCuaNhom] CHECK CONSTRAINT [FK_QUYENCUANHOM_NHOMNGUOIDUNG]
GO
/****** Object:  ForeignKey [FK_QUYENCUANHOM_QUYEN]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QUYENCUANHOM_QUYEN]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuyenCuaNhom]'))
ALTER TABLE [dbo].[QuyenCuaNhom]  WITH CHECK ADD  CONSTRAINT [FK_QUYENCUANHOM_QUYEN] FOREIGN KEY([Quyen])
REFERENCES [dbo].[Quyen] ([MaQuyen])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QUYENCUANHOM_QUYEN]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuyenCuaNhom]'))
ALTER TABLE [dbo].[QuyenCuaNhom] CHECK CONSTRAINT [FK_QUYENCUANHOM_QUYEN]
GO
/****** Object:  ForeignKey [FK_BAOCAOHO_REFERENCE_TOCHUC]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BAOCAOHO_REFERENCE_TOCHUC]') AND parent_object_id = OBJECT_ID(N'[dbo].[BaoCaoHoatDong]'))
ALTER TABLE [dbo].[BaoCaoHoatDong]  WITH CHECK ADD  CONSTRAINT [FK_BAOCAOHO_REFERENCE_TOCHUC] FOREIGN KEY([MaToChuc])
REFERENCES [dbo].[ToChuc] ([MaToChuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BAOCAOHO_REFERENCE_TOCHUC]') AND parent_object_id = OBJECT_ID(N'[dbo].[BaoCaoHoatDong]'))
ALTER TABLE [dbo].[BaoCaoHoatDong] CHECK CONSTRAINT [FK_BAOCAOHO_REFERENCE_TOCHUC]
GO
/****** Object:  ForeignKey [FK_GIAYPHEP_REFERENCE_TOCHUC]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GIAYPHEP_REFERENCE_TOCHUC]') AND parent_object_id = OBJECT_ID(N'[dbo].[GiayPhepHoatDong]'))
ALTER TABLE [dbo].[GiayPhepHoatDong]  WITH CHECK ADD  CONSTRAINT [FK_GIAYPHEP_REFERENCE_TOCHUC] FOREIGN KEY([MaToChuc])
REFERENCES [dbo].[ToChuc] ([MaToChuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GIAYPHEP_REFERENCE_TOCHUC]') AND parent_object_id = OBJECT_ID(N'[dbo].[GiayPhepHoatDong]'))
ALTER TABLE [dbo].[GiayPhepHoatDong] CHECK CONSTRAINT [FK_GIAYPHEP_REFERENCE_TOCHUC]
GO
/****** Object:  ForeignKey [FK_GiayPhepHoatDong_TinhTrangGiayPhep]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GiayPhepHoatDong_TinhTrangGiayPhep]') AND parent_object_id = OBJECT_ID(N'[dbo].[GiayPhepHoatDong]'))
ALTER TABLE [dbo].[GiayPhepHoatDong]  WITH CHECK ADD  CONSTRAINT [FK_GiayPhepHoatDong_TinhTrangGiayPhep] FOREIGN KEY([TinhTrang])
REFERENCES [dbo].[TinhTrangGiayPhep] ([MaTinhTrang])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_GiayPhepHoatDong_TinhTrangGiayPhep]') AND parent_object_id = OBJECT_ID(N'[dbo].[GiayPhepHoatDong]'))
ALTER TABLE [dbo].[GiayPhepHoatDong] CHECK CONSTRAINT [FK_GiayPhepHoatDong_TinhTrangGiayPhep]
GO
/****** Object:  ForeignKey [FK_NHANLUC_REFERENCE_TOCHUC]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NHANLUC_REFERENCE_TOCHUC]') AND parent_object_id = OBJECT_ID(N'[dbo].[NhanLuc]'))
ALTER TABLE [dbo].[NhanLuc]  WITH CHECK ADD  CONSTRAINT [FK_NHANLUC_REFERENCE_TOCHUC] FOREIGN KEY([MaToChuc])
REFERENCES [dbo].[ToChuc] ([MaToChuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NHANLUC_REFERENCE_TOCHUC]') AND parent_object_id = OBJECT_ID(N'[dbo].[NhanLuc]'))
ALTER TABLE [dbo].[NhanLuc] CHECK CONSTRAINT [FK_NHANLUC_REFERENCE_TOCHUC]
GO
/****** Object:  ForeignKey [FK_NangLucKeKhai_ToChuc]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NangLucKeKhai_ToChuc]') AND parent_object_id = OBJECT_ID(N'[dbo].[NangLucKeKhai]'))
ALTER TABLE [dbo].[NangLucKeKhai]  WITH CHECK ADD  CONSTRAINT [FK_NangLucKeKhai_ToChuc] FOREIGN KEY([MaToChuc])
REFERENCES [dbo].[ToChuc] ([MaToChuc])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NangLucKeKhai_ToChuc]') AND parent_object_id = OBJECT_ID(N'[dbo].[NangLucKeKhai]'))
ALTER TABLE [dbo].[NangLucKeKhai] CHECK CONSTRAINT [FK_NangLucKeKhai_ToChuc]
GO
/****** Object:  ForeignKey [FK_THIETBI_REFERENCE_TOCHUC]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_THIETBI_REFERENCE_TOCHUC]') AND parent_object_id = OBJECT_ID(N'[dbo].[ThietBi]'))
ALTER TABLE [dbo].[ThietBi]  WITH CHECK ADD  CONSTRAINT [FK_THIETBI_REFERENCE_TOCHUC] FOREIGN KEY([MaToChuc])
REFERENCES [dbo].[ToChuc] ([MaToChuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_THIETBI_REFERENCE_TOCHUC]') AND parent_object_id = OBJECT_ID(N'[dbo].[ThietBi]'))
ALTER TABLE [dbo].[ThietBi] CHECK CONSTRAINT [FK_THIETBI_REFERENCE_TOCHUC]
GO
/****** Object:  ForeignKey [FK_ThamDinh_LoaiThamDinh]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ThamDinh_LoaiThamDinh]') AND parent_object_id = OBJECT_ID(N'[dbo].[ThamDinh]'))
ALTER TABLE [dbo].[ThamDinh]  WITH CHECK ADD  CONSTRAINT [FK_ThamDinh_LoaiThamDinh] FOREIGN KEY([LoaiThamDinh])
REFERENCES [dbo].[LoaiThamDinh] ([MALOAITHAMDINH])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ThamDinh_LoaiThamDinh]') AND parent_object_id = OBJECT_ID(N'[dbo].[ThamDinh]'))
ALTER TABLE [dbo].[ThamDinh] CHECK CONSTRAINT [FK_ThamDinh_LoaiThamDinh]
GO
/****** Object:  ForeignKey [FK_THAMDINH_REFERENCE_GIAYPHEP]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_THAMDINH_REFERENCE_GIAYPHEP]') AND parent_object_id = OBJECT_ID(N'[dbo].[ThamDinh]'))
ALTER TABLE [dbo].[ThamDinh]  WITH CHECK ADD  CONSTRAINT [FK_THAMDINH_REFERENCE_GIAYPHEP] FOREIGN KEY([MaGiayPhepHoatDong])
REFERENCES [dbo].[GiayPhepHoatDong] ([MaGiayPhepHoatDong])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_THAMDINH_REFERENCE_GIAYPHEP]') AND parent_object_id = OBJECT_ID(N'[dbo].[ThamDinh]'))
ALTER TABLE [dbo].[ThamDinh] CHECK CONSTRAINT [FK_THAMDINH_REFERENCE_GIAYPHEP]
GO
/****** Object:  ForeignKey [FK_DANGKYHOATDONG_GIAYPHEPHOATDONG]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DANGKYHOATDONG_GIAYPHEPHOATDONG]') AND parent_object_id = OBJECT_ID(N'[dbo].[DangKyHoatDong]'))
ALTER TABLE [dbo].[DangKyHoatDong]  WITH CHECK ADD  CONSTRAINT [FK_DANGKYHOATDONG_GIAYPHEPHOATDONG] FOREIGN KEY([MaGiayPhepHoatDong])
REFERENCES [dbo].[GiayPhepHoatDong] ([MaGiayPhepHoatDong])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DANGKYHOATDONG_GIAYPHEPHOATDONG]') AND parent_object_id = OBJECT_ID(N'[dbo].[DangKyHoatDong]'))
ALTER TABLE [dbo].[DangKyHoatDong] CHECK CONSTRAINT [FK_DANGKYHOATDONG_GIAYPHEPHOATDONG]
GO
/****** Object:  ForeignKey [FK_DANGKYHOATDONG_HOATDONG]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DANGKYHOATDONG_HOATDONG]') AND parent_object_id = OBJECT_ID(N'[dbo].[DangKyHoatDong]'))
ALTER TABLE [dbo].[DangKyHoatDong]  WITH CHECK ADD  CONSTRAINT [FK_DANGKYHOATDONG_HOATDONG] FOREIGN KEY([MaHoatDong])
REFERENCES [dbo].[HoatDong] ([MaHoatDong])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DANGKYHOATDONG_HOATDONG]') AND parent_object_id = OBJECT_ID(N'[dbo].[DangKyHoatDong]'))
ALTER TABLE [dbo].[DangKyHoatDong] CHECK CONSTRAINT [FK_DANGKYHOATDONG_HOATDONG]
GO
/****** Object:  ForeignKey [FK_DangKyHoatDong_TinhTrangXetDuyet]    Script Date: 01/09/2012 23:06:59 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DangKyHoatDong_TinhTrangXetDuyet]') AND parent_object_id = OBJECT_ID(N'[dbo].[DangKyHoatDong]'))
ALTER TABLE [dbo].[DangKyHoatDong]  WITH CHECK ADD  CONSTRAINT [FK_DangKyHoatDong_TinhTrangXetDuyet] FOREIGN KEY([TinhTrang])
REFERENCES [dbo].[TinhTrangXetDuyet] ([MaTinhTrang])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DangKyHoatDong_TinhTrangXetDuyet]') AND parent_object_id = OBJECT_ID(N'[dbo].[DangKyHoatDong]'))
ALTER TABLE [dbo].[DangKyHoatDong] CHECK CONSTRAINT [FK_DangKyHoatDong_TinhTrangXetDuyet]
GO
