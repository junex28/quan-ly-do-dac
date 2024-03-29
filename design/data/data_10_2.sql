USE [QLDDBD]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HoatDong](
	[MaHoatDong] [int] IDENTITY(1,1) NOT NULL,
	[TenHoatDong] [nvarchar](500) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [HoatDong] ON
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (1, N'Khảo sát, lập dự án, thiết kế kỹ thuật – dự toán công trình đo đạc và bản đồ')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (2, N'Kiểm tra, thẩm định chất lượng công trình, sản phẩm đo đạc và bản đồ')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (3, N'Xây dựng lưới tọa độ, độ cao quốc gia')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (4, N'Xây dựng điểm trọng lực, thiên văn, tọa độ, độ cao')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (5, N'Chụp ảnh, quét địa hình từ máy bay')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (6, N'Đo vẽ, thành lập bản đồ địa hình các tỷ lệ')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (7, N'Đo vẽ, thành lập bản đồ địa hình đáy biển các tỷ lệ')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (8, N'Đo vẽ, thành lập bản đồ địa chính các tỷ lệ')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (9, N'Thành lập bản đồ hành chính các cấp')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (10, N'Đo vẽ, thành lập bản đồ địa giới hành chính các cấp')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (11, N'Xây dựng cơ sở dữ liệu đo đạc và bản đồ')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (12, N'Xây dựng cơ sở dữ liệu hệ thống thông tin địa lý')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (13, N'Thành lập bản đồ chuyên đề')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (14, N'Thành lập atlas địa lý')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (15, N'Khảo sát, đo đạc công trình')
INSERT [HoatDong] ([MaHoatDong], [TenHoatDong]) VALUES (16, N'Kiểm định các thiết bị đo đạc')
SET IDENTITY_INSERT [HoatDong] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TinhTrangTaiKhoan](
	[MaTinhTrang] [int] NOT NULL,
	[DienGiai] [nvarchar](50) NULL
) ON [PRIMARY]
GO
INSERT [TinhTrangTaiKhoan] ([MaTinhTrang], [DienGiai]) VALUES (1, N'Chưa kích hoạt')
INSERT [TinhTrangTaiKhoan] ([MaTinhTrang], [DienGiai]) VALUES (2, N'Đã kích hoạt')
INSERT [TinhTrangTaiKhoan] ([MaTinhTrang], [DienGiai]) VALUES (3, N'Bị khoá')
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TinhTrangGiayPhep](
	[MaTinhTrang] [int] NOT NULL,
	[DienGiai] [nvarchar](50) NULL
) ON [PRIMARY]
GO
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (1, N'Chờ thẩm định giấy phép mới')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (2, N'Xin cấp giấy phép thất bại')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (3, N'Giấy phép hết hạn')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (4, N'Chờ cấp số giấy phép')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (5, N'Đã được cấp giấy phép')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (6, N'Chờ xin bổ sung hoạt động')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (7, N'Bổ sung hoạt động thất bại')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (8, N'Bổ sung hoạt động thành công')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (9, N'Chờ xin gia hạn')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (10, N'Xin gia hạn thất bại')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (11, N'Xin gia hạn thành công')
INSERT [TinhTrangGiayPhep] ([MaTinhTrang], [DienGiai]) VALUES (12, N'Giấy phép bị hủy')
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TinhThanh](
	[MaTinhThanh] [int] IDENTITY(1,1) NOT NULL,
	[TenTinhThanh] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LoaiSanPham](
	[MaLoaiSanPham] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiSanPham] [nvarchar](500) NULL,
	[DienGiai] [nvarchar](2000) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [LoaiSanPham] ON
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (1, N'Mốc toạ độ', N'Mốc toạ độ')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (2, N'Mốc độ cao', N'Mốc độ cao')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (3, N'Mốc trọng lực', N'Mốc trọng lực')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (4, N'Bản đồ địa chính 1: 2000', N'Bản đồ địa chính 1: 2000')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (5, N'Bản đồ địa chính 1: 10000', N'Bản đồ địa chính 1: 10000')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (6, N'Bản đồ địa chính 1: 20000', N'Bản đồ địa chính 1: 20000')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (7, N'Bản độ địa hình 1: 1000', N'Bản đồ địa hình 1:1000')
SET IDENTITY_INSERT [LoaiSanPham] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LoaiQuyen](
	[MaLoaiQuyen] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiQuyen] [nvarchar](50) NULL,
	[DienGiai] [nvarchar](100) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [LoaiQuyen] ON
INSERT [LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (1, N'Quản lý người dùng', NULL)
INSERT [LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (2, N'Quản lý tổ chức', NULL)
INSERT [LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (3, N'Quản lý giấy phép ', NULL)
INSERT [LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (4, N'Quản lý bản đồ', NULL)
INSERT [LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (5, N'Quản lý hoạt động', NULL)
SET IDENTITY_INSERT [LoaiQuyen] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LoaiHinhToChuc](
	[MaLoaiHinhToChuc] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiHinhToChuc] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [LoaiHinhToChuc] ON
INSERT [LoaiHinhToChuc] ([MaLoaiHinhToChuc], [TenLoaiHinhToChuc]) VALUES (1, N'Tổ chức trong nước')
INSERT [LoaiHinhToChuc] ([MaLoaiHinhToChuc], [TenLoaiHinhToChuc]) VALUES (2, N'Tổ chức thuộc thành phần kinh tế Nhà nước')
INSERT [LoaiHinhToChuc] ([MaLoaiHinhToChuc], [TenLoaiHinhToChuc]) VALUES (3, N'Tổ chức nước ngoài')
INSERT [LoaiHinhToChuc] ([MaLoaiHinhToChuc], [TenLoaiHinhToChuc]) VALUES (4, N'Tổ chức chính trị- xã hội- nghề nghiệp')
SET IDENTITY_INSERT [LoaiHinhToChuc] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NhomNguoiDung](
	[MaNhom] [int] IDENTITY(1,1) NOT NULL,
	[TenNhom] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [NhomNguoiDung] ON
INSERT [NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (1, N'Đăng ký')
INSERT [NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (2, N'Quản lý địa phương')
INSERT [NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (3, N'Quản lý cấp phép')
INSERT [NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (4, N'SuperAdmin')
SET IDENTITY_INSERT [NhomNguoiDung] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CongTrinh](
	[MaCongTrinh] [int] IDENTITY(1,1) NOT NULL,
	[TenCongTrinh] [nvarchar](500) NULL,
	[ChuDauTu] [nvarchar](500) NULL,
	[DonViNghiemThu] [nvarchar](500) NULL,
	[NgayBatDau] [date] NULL,
	[NgayKetThuc] [date] NULL,
	[GhiChu] [nvarchar](2000) NULL,
	[TinhTrang] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CongDoanThucHien](
	[MaCongDoan] [int] IDENTITY(1,1) NOT NULL,
	[SoGiayPhep] [nvarchar](50) NULL,
	[MaCongTrinh] [int] NULL,
	[NgayBatDau] [date] NULL,
	[NgayKetThuc] [date] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ThongTinChung](
	[MaThongTinChung] [int] IDENTITY(1,1) NOT NULL,
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
	[HangDoanhNghiep] [nvarchar](50) NULL,
	[VonLuuDong] [money] NULL,
	[VonPhapDinh] [money] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [ThongTinChung] ON
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (1, 1, N'Công ty A ', N'GPKD1234', N'Nguyễn Văn Lâm', N'Đặng Văn Ngữ', N'jfdskfj', NULL, NULL, NULL, NULL, NULL, NULL, 8948595.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (2, 1, N'Công ty B', N'GPKD1235', N'Nguyễn Văn Hùng', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (3, 2, N'Công ty C', N'1234567', N'Nguyễn Sinh Hùng', N'Điện Biên Phủ', NULL, N'89754309', N'89754309', NULL, 35, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (4, 1, N'Công ty D', NULL, NULL, N'Mac Dinh Chi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (5, 2, N'Công ty E', N'4372864', NULL, N'Nguyen Thai Son', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (6, 2, N'Công ty F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (7, 1, N'Công ty A ', N'GPKD1234', N'Nguyễn Văn Lâm', N'Đặng Văn Ngữ', N'jfdskfj', NULL, NULL, NULL, NULL, NULL, NULL, 8948595.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (8, 1, N'Công ty B', N'GPKD1235', N'Nguyễn Văn Hùng', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (9, 2, N'Công ty C', N'1234567', N'Nguyễn Sinh Hùng', N'Điện Biên Phủ', NULL, N'89754309', N'89754309', NULL, 35, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (10, 2, N'Công ty C', N'1234567', N'Nguyễn Sinh Hùng', N'Điện Biên Phủ', NULL, N'89754309', N'89754309', NULL, 35, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (11, 2, N'Công ty E', N'4372864', NULL, N'Nguyen Thai Son', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (12, 1, N'Công ty K', NULL, N'Nguyễn Văn Lâm', N'Nguyễn Sơn, Tân Phú', N'K7863-G3958-H9876', N'083374652', N'083374652', N'congtyK@gmail.com', 70, NULL, 2.0000, 8948595.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (13, NULL, N'Công ty ảnh viễn thám 1', N'GP098/4498', NULL, N'Mạc Đĩnh Chi', N'K9847-Y9373', N'0835748478', N'0835748478', N'ctyanhvientham@gmail.com', 80, N'2', 5030000000.0000, 5030000000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (14, 1, N'Công ty A ', N'GPKD1234', NULL, N'Đặng Văn Ngữ', N'jfdskfj', NULL, NULL, NULL, 0, NULL, 894859500.0000, 485300000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (30, 1, N'a', N'a', NULL, N'a', N'a', N'0835748478', N'0835748478', N'0935876554@gmail.com', 0, N'2', 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (39, 1, N'qq', N'QD978/CP', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (59, 1, N'A', N'a', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'1', 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (63, 1, N'A', N'A', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'1', 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (64, 1, N'Cty TNHH Dịch vụ Địa chính Thiên Hòa', N'GPKD0001', NULL, N'204 Quốc lộ 1A, phường Ba Ngòi, thành phố Cam Ranh. ', N'K3948-D3934-D3490-D3465', NULL, NULL, N'daichinhthienhoa@gmaill.com', 50, N'2', 8948595000.0000, 4853000000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (69, 1, N'Cty TNHH Dịch vụ Địa chính Thiên Hòa', N'GPKD0001', NULL, N'204 Quốc lộ 1A, phường Ba Ngòi, thành phố Cam Ranh. ', N'K3948-D3934-D3490-D3465', N'0839754309', N'0839754309', N'daichinhthienhoa@gmaill.com', 68, N'2', 8948595000.0000, 4853000000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (72, 1, N'Cty TNHH Dịch vụ Địa chính Thiên Hòa', N'GPKD0001', NULL, N'204 Quốc lộ 1A, phường Ba Ngòi, thành phố Cam Ranh. ', N'K3948-D3934-D3490-D3465', N'0839754309', N'0839754309', N'daichinhthienhoa@gmaill.com', 68, N'2', 8948595000.0000, 4853000000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (73, 1, N'Cty TNHH Dịch vụ Địa chính Thiên Hòa', N'GPKD0001', NULL, N'204 Quốc lộ 1A, phường Ba Ngòi, thành phố Cam Ranh. ', N'K3948-D3934-D3490-D3465', N'0839754309', N'0839754309', N'daichinhthienhoa@gmaill.com', 68, N'2', 8948595000.0000, 4853000000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (74, 1, N'Cty TNHH Dịch vụ Địa chính Thiên Hòa', N'GPKD0001', NULL, N'204 Quốc lộ 1A, phường Ba Ngòi, thành phố Cam Ranh. ', N'K3948-D3934-D3490-D3465', N'0839754309', N'0839754309', N'daichinhthienhoa@gmaill.com', 68, N'2', 8948595000.0000, 4853000000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (75, 1, N'Cty TNHH Dịch vụ Địa chính Thiên Hòa', N'GPKD0001', NULL, N'204 Quốc lộ 1A, phường Ba Ngòi, thành phố Cam Ranh. ', N'K3948-D3934-D3490-D3465', N'0839754309', N'0839754309', N'daichinhthienhoa@gmaill.com', 68, N'2', 8948595000.0000, 4853000000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (76, 1, N'Cty TNHH Dịch vụ Địa chính Thanh Lâm', N'GPKD0002', NULL, N'Số 24F đường Hoàng Hoa Thám, phường Lộc Thọ, thành phố Nha Trang.', N'J3489-K3489-W2093-I9485', N'0867663548', N'0867663548', N'diachinhthanhlam@gmail.com', 95, N'2', 25000000000.0000, 1244000000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (85, 1, N'Công ty TNHH Dịch vụ Địa chính Thiên Quốc ', N'GPKD0004', NULL, N'Số 06 Nguyễn Thiện Thuật, phường Tân Lập, thành phố Nha Trang', N'J0385-K0494-L9983-K0394', NULL, NULL, N'diachinhthienquoc@gmail.com', 68, N'2', 25000000000.0000, 4853000000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (86, 2, N'Công ty TNHH Thanh Tùng', N'GPKD0005', NULL, N'Số 77-79 Quốc lộ 1A, Khóm Phú Sơn, phường Cam Phú, thành phố Cam Ranh', N'J8596-Y3583-Q4739-U8490', NULL, NULL, N'congtythanhtung@gmail.com', 92, N'2', 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (87, 2, N'Văn phòng Đăng ký QSDĐ thành phố Nha Trang', N'GPKD0006', NULL, N'Số 17B đường Hoàng Hoa Thám, phường Lộc Thọ, thành phố Nha Trang. ', N'K8496-Y8496-B3948-Q2374', NULL, NULL, N'vanphongqsdd@gmail.com', 150, N'1', 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (88, 2, N'Văn phòng Đăng ký QSDĐ thành phố Nha Trang', N'GPKD0006', NULL, N'Số 17B đường Hoàng Hoa Thám, phường Lộc Thọ, thành phố Nha Trang. ', N'K8496-Y8496-B3948-Q2374', NULL, NULL, N'vanphongqsdd@gmail.com', 150, N'1', 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (90, 1, N'Văn phòng ĐKQSDĐ tỉnh', N'GPKD0010', NULL, N'Số 35 đường Yết Kiêu, phường Vạn Thắng, thành phố Nha Trang.', N'U8475-I8484-Y4759-M9494', NULL, NULL, N'vanphongdkqsdd@gmail.com', 50, N'2', 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (92, 1, N'123123', N'123123', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 123.0000, 123.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (93, 2, N'123123', N'123123', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'////', 123.0000, 123.0000)
SET IDENTITY_INSERT [ThongTinChung] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Quyen](
	[MaQuyen] [int] IDENTITY(1,1) NOT NULL,
	[TenQuyen] [nvarchar](50) NULL,
	[MoTa] [nvarchar](100) NULL,
	[LoaiQuyen] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [QuanHuyen](
	[MaQuanHuyen] [int] IDENTITY(1,1) NOT NULL,
	[TenQuanHuyen] [nvarchar](50) NULL,
	[MaTinhThanh] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TaiKhoan](
	[MaTaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[NhomNguoiDung] [int] NULL,
	[TenTaiKhoan] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[CMND] [nvarchar](50) NULL,
	[Email] [nvarchar](250) NULL,
	[CoQuan] [nvarchar](100) NULL,
	[TinhTrang] [int] NULL,
	[MatKhau] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [TaiKhoan] ON
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (1, 4, N'dodacvn', N'dodacvn', N'34 truong dinh', N'123456756', N'admin@gmail.com', N'cuc do dac', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (2, 4, N'thuong', N'thuongthuong', N'fdjsjl', N'123456789', N'thuongthuong1990@gmail.com', N'fjdlsjflkds', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (3, 2, N'hyolthuong', N'Phan Thương Thương', N'31/16 Đỗ Đức Dục', N'311998695', N'thuongthuong1990@gmail.com.vn', N'cuc do dac', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (4, 2, N'thuongphan', N'phan thuong', N'31/16 Đỗ Đức Dục', N'311998695', N'thuongphan@gmail.com', N'cong ty AA', 3, N'619170C4D559A0786A141D489D019E22')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (5, 1, N'thuongthuong', N'Phan Thương', N'Nguyễn Sơn, Tân Phú', N'311998695', N'thuongthuong1989@gmail.com', N'Xí nghiệp ảnh viễn thám', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (8, 1, N'user1', N'Nguyễn Duy A', NULL, N'311991111', N'user1@gmail.com', N'Địa chính Thiên Hòa', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (9, 1, N'user2', N'Nguyễn Duy B', NULL, N'311991112', N'user2@gmail.com', N'Cty TNHH Dịch vụ Địa chính Thanh Lâm', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (10, 1, N'user3', N'Nguyễn Duy C', NULL, N'311991113', N'user3@gmail.com', N'Công ty Cổ phần Tư vấn Kiến trúc Đô thị Khánh Hòa', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (11, 1, N'user4', N'Nguyễn Duy D', NULL, N'311991114', N'user4@gmail.com', N'Công ty TNHH Dịch vụ Địa chính Thiên Quốc ', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (12, 1, N'user5', N'Nguyễn Duy E', NULL, N'311991115', N'user5@gmail.com', N'Công ty TNHH Thanh Tùng', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (13, 1, N'user6', N'Nguyễn Duy F', NULL, N'311991116', N'user6@gmail.com', N'Văn phòng Đăng ký QSDĐ thành phố Nha Trang', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (14, 1, N'user7', N'Nguyễn Duy G', NULL, N'311991117', N'user7@gmail.com', N'Công ty TNHH Địa chính Công Hùng', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (15, 1, N'user8', N'Nguyễn Duy K', NULL, N'311991118', N'user8@gmail.com', N'Công ty Cổ phần Tư vấn Xây dựng Thủy lợi Khánh Hòa', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (16, 1, N'user9', N'Nguyễn Duy H', NULL, N'311991119', N'user9@gmail.com', N'Trung Tâm Điều tra khảo sát thiết kế Nông nghiệp và Phát triển Nông thôn ', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (17, 1, N'user10', N'Nguyễn Duy X', NULL, N'311991120', N'user10@gmail.com', N'Văn phòng ĐKQSDĐ tỉnh', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (18, 1, N'user11', N'Nguyễn Duy Y', NULL, N'311991121', N'user11@gmail.com', N'Công ty TNHH Hợp Nhất ', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (19, 1, N'user12', N'Phan Đình A', NULL, N'311991122', N'user12@gmail.com', N'Công ty TNHH SLC', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (20, 1, N'user13', N'Phan Đình B', NULL, N'311991123', N'user13@gmail.com', N'Văn phòng ĐKQSDĐ huyện Ninh Hòa', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (25, 1, N'user14', N'Phan Đình C', NULL, N'311991124', N'user14@gmail.com', N'Công ty TNHH Dịch vụ, Thương mại và xây dựng Thành Lợi', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (26, 1, N'user15', N'Phan Đình D', NULL, N'311991125', N'user15@gmail.com', N'Công ty TNHH Xây dựng, Đo đạc Địa chính Nguyên Kim', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (28, 1, N'user16', N'Phan Đình E', NULL, N'311991126', N'user16@gmail.com', N'Công ty TNHH Đo đạc và Dịch vụ Địa chính Ninh Hòa', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (30, 1, N'user17', N'Phan Đình K', NULL, N'311991127', N'user17@gmail.com', N'Công ty TNHH Nhật Tùng', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (31, 1, N'user18', N'Phan Đình G', NULL, N'311991128', N'user18@gmail.com', N'Công ty TNHH Địa chính 7', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (32, 1, N'user19', N'Nguyễn Văn A', NULL, N'311991129', N'user19@gmail.com', N'Công ty Cổ phần Tư vấn Kiến trúc và Xây dựng Khánh Hòa', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (33, 1, N'user20', N'Nguyễn Văn B', NULL, N'311991130', N'user20@gmail.com', N'Công ty TNHH Đo đạc - Dịch vụ Địa chính Vạn Ninh', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (34, 1, N'user21', N'Nguyễn Văn C', NULL, N'311991131', N'user21@gmail.com', N'Công ty TNHH Đất Biển', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (36, 1, N'user22', N'Nguyễn Văn D', NULL, N'311991132', N'user22@gmail.com', N'Công ty TNHH Đo đạc - Dịch vụ Văn Chính', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (37, 1, N'user23', N'Nguyễn Văn E', NULL, N'311991133', N'user23@gmail.com', N'rung tâm kỹ thuật Tài nguyên và Môi trường', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (38, 1, N'user24', N'Nguyễn Văn F', NULL, N'311991134', N'user24@gmail.com', N'Công ty TNHH Tư vấn -Dịch vụ TN và MT Đại Phú', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (39, 3, N'user25', N'Nguyễn Văn K', NULL, N'311991135', N'user25@gmail.com', N'Công ty TNHH Đo đạc Bản đồ và Dịch vụ Thương mại Chiến Thắng', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (40, 1, N'test1', N'test1', NULL, NULL, N'test1@email.com', NULL, 2, N'4297F44B13955235245B2497399D7A93')
SET IDENTITY_INSERT [TaiKhoan] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ToChuc](
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
	[TepDinhKem] [nvarchar](500) NULL,
	[MaTaiKhoan] [int] NULL,
	[HangDoanhNghiep] [nvarchar](50) NULL,
	[VonLuuDong] [money] NULL,
	[VonPhapDinh] [money] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [ToChuc] ON
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (6, 1, N'Cty TNHH Dịch vụ Địa chính Thiên Hòa', NULL, N'Nguyễn Đình Trí', N'204 Quốc lộ 1A, phường Ba Ngòi, thành phố Cam Ranh. ', N'K3948-D3934-D3490-D3465', N'0839754309', N'0839754309', N'daichinhthienhoa@gmaill.com', 68, NULL, 8, N'2', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (7, 1, N'Cty TNHH Dịch vụ Địa chính Thanh Lâm', N'GPKD0002', NULL, N'Số 24F đường Hoàng Hoa Thám, phường Lộc Thọ, thành phố Nha Trang.', N'J3489-K3489-W2093-I9485', N'0867663548', N'0867663548', N'diachinhthanhlam@gmail.com', 95, NULL, 9, N'2', 25000000000.0000, 1244000000.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (8, 2, N'Công ty Cổ phần Tư vấn Kiến trúc Đô thị Khánh Hòa', N'GPKD0003', N'Nguyễn Văn C', N'Số168 đường Bạch Đằng, phường Tân Lập, thành phố Nha Trang.', N'E9483-Y9473-K9358-I9383', N'89754309', N'89754309', N'dothikhanhhoa@gmail.com', 35, NULL, 10, N'3', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (9, 1, N'Công ty TNHH Dịch vụ Địa chính Thiên Quốc ', N'GPKD0004', NULL, N'Số 06 Nguyễn Thiện Thuật, phường Tân Lập, thành phố Nha Trang', N'J0385-K0494-L9983-K0394', NULL, NULL, N'diachinhthienquoc@gmail.com', 68, NULL, 11, N'2', 25000000000.0000, 4853000000.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (10, 2, N'Công ty TNHH Thanh Tùng', N'GPKD0005', NULL, N'Số 77-79 Quốc lộ 1A, Khóm Phú Sơn, phường Cam Phú, thành phố Cam Ranh', N'J8596-Y3583-Q4739-U8490', NULL, NULL, N'congtythanhtung@gmail.com', 92, NULL, 12, N'2', 0.0000, 0.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (11, 2, N'Văn phòng Đăng ký QSDĐ thành phố Nha Trang', N'GPKD0006', NULL, N'Số 17B đường Hoàng Hoa Thám, phường Lộc Thọ, thành phố Nha Trang. ', N'K8496-Y8496-B3948-Q2374', NULL, NULL, N'vanphongqsdd@gmail.com', 150, NULL, 13, N'1', 0.0000, 0.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (12, 1, N'Công ty TNHH Địa chính Công Hùng', N'GPKD0007', N'Nguyễn Văn G', N'Số 321 Đường 22/8, phường Cam Thuận, thành phố Cam Ranh', N'K7863-G3958-H9876-I9847', N'083374652', N'083374652', N'daichinhconghung@gmail.com', 70, N'1e29dab2-7f20-4a7a-a9b6-728bb934a649.rar', 14, N'2', 8948595.0000, 48530000.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (25, 1, N'Công ty Cổ phần Tư vấn Xây dựng Thủy lợi Khánh Hòa', N'GPKD0008', N'Nguyễn Văn H', N'Số 12 đường Trần Hưng Đạo, phường Lộc Thọ, thành phố Nha Trang.', N'H9384-I9384-Q9454-H9884', NULL, NULL, N'tuvanxaydungthuyloi@gmail.com', 247, NULL, 15, N'1', 0.0000, 0.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (31, 1, N'Trung Tâm Điều tra khảo sát thiết kế Nông nghiệp và Phát triển Nông thôn ', N'GPKD0009', N'Nguyễn Văn I', N'Số 138 - Đường 2/4, phường Vĩnh Phước, TP Nha Trang.', N'Y8847-Y9494-T8484-H7432', NULL, NULL, N'ttksnongnghiep@gmail.com', 233, NULL, 16, N'1', 0.0000, 0.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (33, 1, N'Văn phòng ĐKQSDĐ tỉnh', N'GPKD0010', NULL, N'Số 35 đường Yết Kiêu, phường Vạn Thắng, thành phố Nha Trang.', N'U8475-I8484-Y4759-M9494', NULL, NULL, N'vanphongdkqsdd@gmail.com', 50, NULL, 17, N'2', 0.0000, 0.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (34, 2, N'Công ty TNHH Hợp Nhất ', N'GPKD0011', N'Nguyễn Văn X', N'Số 333 Quốc lộ 1A, khóm 3, phường Cam Phú, thành phố Cam Ranh.', N'Y9847-N9830-M3940-V8457', NULL, NULL, N'congtyhopnhat@gmail.com', 450, NULL, 18, N'1', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (35, 2, N'Công ty TNHH SLC', N'GPKD0012', N'Nguyễn Văn Y', N'Số 59A đường  Đống Đa, phường Tân Lập, thành phố Nha Trang. ', N'W9485-Q9458-Y9475-M9485', NULL, NULL, N'congtySLC@gmail.com', 70, NULL, 19, N'2', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (36, 2, N'Văn phòng ĐKQSDĐ huyện Ninh Hòa', N'GPKD0013', N'Nguyễn Văn U', N'Số 109 đường Trần Quý Cáp, phường Ninh Hiệp, thị xã Ninh Hòa. ', N'K3948-D3934-D3490-D3465', NULL, NULL, N'vanphongdkqsddNinhHoa@gmail.com', 250, NULL, 20, N'1', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (37, 2, N'Công ty TNHH Dịch vụ, Thương mại và xây dựng Thành Lợi', N'GPKD0014', N'Nguyễn Văn O', N'Số 8 đường Trần Văn Ơn, phường Lộc Thọ, thành phố Nha Trang.', N'J3489-K3489-W2093-I9485', NULL, NULL, N'thuongmaixaydungThanhLoi@gmail.com', 68, NULL, 25, N'2', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (38, 1, N'Công ty TNHH Xây dựng, Đo đạc Địa chính Nguyên Kim', N'GPKD0015', N'Nguyễn Văn T', N'Số 52 Nguyễn Trãi, phường Phước Tân, thành phố Nha Trang.', N'E9483-Y9473-K9358-I9383', NULL, NULL, N'diachinhNguyenKim@gmail.com', 340, NULL, 26, N'1', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (39, 1, N'Công ty TNHH Đo đạc và Dịch vụ Địa chính Ninh Hòa', N'GPKD0016', N'Phan Đình  A', N'Lô 236 Đường Tân Định, Khu dân cư Bắc Thị trấn Ninh Hòa, phường Ninh Hiệp, thị xã Ninh Hòa. ', N'J0385-K0494-L9983-K0394', NULL, NULL, N'diachinhNinhHoa@gmail.com', 192, NULL, 28, N'1', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (40, 1, N'Công ty TNHH Nhật Tùng', N'GPKD0017', N'Phan Đình  B', N'Số 413 đường số 2, phường Cam Thuận, thành phố Cam Ranh.', N'J8596-Y3583-Q4739-U8490', NULL, NULL, N'diachinhNhatTung@gmail.com', 70, NULL, 30, N'2', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (41, 1, N'Công ty TNHH Địa chính 7', N'GPKD0018', N'Phan Đình  C', N'93 đường Lý Tự Trọng, thị trấn Diên Khánh, huyện Diên Khánh.', N'K8496-Y8496-B3948-Q2374', NULL, NULL, N'diachinh7@gmail.com', 155, NULL, 31, N'1', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (42, 2, N'Công ty Cổ phần Tư vấn Kiến trúc và Xây dựng Khánh Hòa', N'GPKD0019', N'Phan Đình  D', N'Số 27 đường Tô Hiến Thành, phường Tân Lập, thành phố Nha Trang.', N'K7863-G3958-H9876-I9847', NULL, NULL, N'tuvanvaxaydungKhanhHoa@gmail.com', 50, NULL, 32, N'3', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (43, 2, N'Công ty TNHH Đo đạc - Dịch vụ Địa chính Vạn Ninh', N'GPKD0020', N'Phan Đình  E', N'Số 20 đường Hùng Vương, thị trấn Vạn Giã, huyện Vạn Ninh', N'H9384-I9384-Q9454-H9884', NULL, NULL, N'diachinhVanNinh@gmail.com', 98, NULL, 33, N'2', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (44, 2, N'Công ty TNHH Đất Biển', N'GPKD0021', N'Phan Đình  F', N'Số 2/6 Đại lộ Nguyễn Tất Thành, khóm Phước Trung, phường Phước Long, thành phố Nha Trang.', N'K7863-G3958-H9876-I9847', NULL, NULL, N'congtyDatBien@gmail.com', 167, NULL, 34, N'1', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (45, 2, N'Công ty TNHH Đo đạc - Dịch vụ Văn Chính', N'GPKD0022', N'Phan Đình  G', N'Số 483 Hùng Vương, tổ dân phố 9, Thị trấn Vạn Giã, huyện Vạn Ninh.', N'K7863-G3958-H9876-I9847', NULL, NULL, N'dodacdichvuVanChinh@gmail.com', 233, NULL, 36, N'1', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (46, 1, N'rung tâm kỹ thuật Tài nguyên và Môi trường', N'GPKD0023', N'Phan Đình  H', N'Số 13B đường Hoàng Hoa Thám, phường Lộc Thọ, thành phố Nha Trang. ', N'J0385-K0494-L9983-K0394', NULL, NULL, N'ttkttainguyenmoitruong@gmaill.com', 70, NULL, 37, N'2', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (47, 2, N'Công ty TNHH Tư vấn -Dịch vụ TN và MT Đại Phú', N'GPKD0024', N'Phan Đình  K', N'Số 101 đường Mai Xuân Thưởng, phường Vĩnh Hòa, thành phố Nha Trang.', N'H9384-I9384-Q9454-H9884', NULL, NULL, N'ctyTDVDaiPhu@gmail.com', 50, NULL, 38, N'3', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (48, 3, N'Công ty TNHH Đo đạc Bản đồ và Dịch vụ Thương mại Chiến Thắng', N'GPKD0025', N'Phan Đình  I', N'Số 124 đường Bạch Đằng, phường Tân Lập, thành phố Nha Trang.', N'W9485-Q9458-Y9475-M9485', NULL, NULL, N'ddbdChinhThang@gmail.com', 189, NULL, 39, N'1', NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (49, 3, NULL, N'GPKD0026', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (50, NULL, NULL, N'GPKD0027', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (51, 2, N'123123', N'123123', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 40, N'////', 123.0000, 123.0000)
SET IDENTITY_INSERT [ToChuc] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SanPham](
	[MaSanPham] [int] IDENTITY(1,1) NOT NULL,
	[SoHieu] [nvarchar](50) NULL,
	[MaLoaiSanPham] [int] NULL,
	[MaCongTrinh] [int] NULL,
	[MaQuanHuyen] [int] NULL,
	[CapHanhChinh] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [QuyenCuaNhom](
	[MaQuyenNhom] [int] IDENTITY(1,1) NOT NULL,
	[MaNhom] [int] NOT NULL,
	[Quyen] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HoSoGiayPhep](
	[MaHoSo] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[SoGiayPhep] [nvarchar](50) NULL,
	[NgayCapPhep] [date] NULL,
	[NgayHetHan] [date] NULL,
	[LyDo] [nvarchar](2000) NULL,
	[CamKet] [nvarchar](2000) NULL,
	[TinhTrang] [int] NULL,
	[NgayXinPhep] [date] NULL,
	[TepDinhKem] [nvarchar](50) NULL,
	[MaThongTinChung] [int] NULL,
	[LoaiGiayPhep] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [HoSoGiayPhep] ON
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (1, 6, N'123456', CAST(0x6B350B00 AS Date), CAST(0xB2390B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 12, CAST(0x18350B00 AS Date), N'1e29dab2-7f20-4a7a-a9b6-728bb934a649.rar', 1, 1)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (2, 7, N'4656', CAST(0x80360B00 AS Date), CAST(0x5A390B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 5, CAST(0x38320B00 AS Date), N'fdsfsfewfgdfafd', 2, 1)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (3, 9, N'12345678', CAST(0x43350B00 AS Date), CAST(0x44350B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 3, CAST(0x1C2E0B00 AS Date), N'fdgsfdsgfd', 3, 3)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (11, 6, N'123456', CAST(0x75350B00 AS Date), CAST(0x70350B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 8, CAST(0x18350B00 AS Date), N'fdsafdksajfkjdskajfkdsj', 7, 2)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (14, 8, N'123456789', CAST(0x43350B00 AS Date), CAST(0x44350B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 3, CAST(0x1C2E0B00 AS Date), N'fdgsfdsgfd', 3, 3)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (15, 6, N'123456', CAST(0x43350B00 AS Date), NULL, NULL, NULL, 8, NULL, NULL, 4, 2)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (16, 6, N'123456', CAST(0x43350B00 AS Date), NULL, N'lý do 2', N'cam kết 2', 6, NULL, NULL, 8, 2)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (17, 8, NULL, CAST(0x90320B00 AS Date), CAST(0xB2390B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 4, CAST(0x18350B00 AS Date), N'fdsafdksajfkjdskajfkdsj', 10, 1)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (18, 10, NULL, CAST(0x43350B00 AS Date), NULL, NULL, NULL, 10, NULL, NULL, 11, 3)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (19, 12, N'653754', CAST(0x43350B00 AS Date), NULL, N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 10, CAST(0x38350B00 AS Date), N'/tochuc/congtyK/tepdinhkem', 12, 3)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (24, 6, N'K123456', CAST(0x482E0B00 AS Date), CAST(0x6B350B00 AS Date), N'Xin đăng ký giấy phép mới.', N'Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.', 5, CAST(0x43350B00 AS Date), N'facd6f7b-978d-4d4b-bc92-bbeb8ca40d2a.rar', 74, 1)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (25, 6, N'GP00025', NULL, CAST(0xD1350B00 AS Date), N'Xin đăng ký bổ sung hoạt động đo đạc', N'Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.', 8, CAST(0x45350B00 AS Date), N'', 75, 2)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (26, 7, NULL, NULL, NULL, N'Xin đăng ký giấy phép mới.', N'Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.', 1, CAST(0x46350B00 AS Date), N'6137b187-0bef-47ad-924f-d32527a25d84.rar', 76, 1)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (34, 11, NULL, NULL, NULL, N'Xin đăng ký giấy phép mới.', N'Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.', 1, CAST(0x46350B00 AS Date), N'', 88, 1)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (35, 33, NULL, NULL, NULL, N'Xin đăng ký giấy phép mới.', N'Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.', 1, CAST(0x4B350B00 AS Date), N'', 90, 1)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung], [LoaiGiayPhep]) VALUES (37, 51, NULL, NULL, NULL, N'Xin đăng ký gia hạn giấy phép hoạt động', N'Tôi xin chịu trách nhiệm về toàn bộ nội dung bản đăng ký này.', 9, CAST(0x4E350B00 AS Date), N'', 93, 3)
SET IDENTITY_INSERT [HoSoGiayPhep] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [HoatDongDuocCap](
	[MaHDHienTai] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[SoGiayPhep] [varchar](50) NULL,
	[LanBoSung] [int] NULL,
	[TenHoatDong] [nvarchar](500) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [HoatDongDuocCap] ON
INSERT [HoatDongDuocCap] ([MaHDHienTai], [MaToChuc], [SoGiayPhep], [LanBoSung], [TenHoatDong]) VALUES (1, 6, N'K123456', 0, N'Khảo sát, lập dự án, thiết kế kỹ thuật – dự toán công trình đo đạc và bản đồ')
INSERT [HoatDongDuocCap] ([MaHDHienTai], [MaToChuc], [SoGiayPhep], [LanBoSung], [TenHoatDong]) VALUES (2, 6, N'K123456', 0, N'Kiểm tra, thẩm định chất lượng công trình, sản phẩm đo đạc và bản đồ')
SET IDENTITY_INSERT [HoatDongDuocCap] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NhanLuc](
	[MaNhanVien] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[HoTen] [nvarchar](50) NULL,
	[ChucVu] [nvarchar](50) NULL,
	[TrinhDoHocVan] [nvarchar](50) NULL,
	[MaThongTinChung] [int] NULL,
	[ThamNien] [nvarchar](20) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [NhanLuc] ON
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (22, 31, N'a1', N'a', N'a', NULL, N'13')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (23, NULL, N'a1', N'a', N'a', 59, N'13')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (27, NULL, N'a', N'a', N'a', 63, N'12')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (29, NULL, N'Nguyễn Văn A', N'giám đốc', N'cao học', 64, N'25')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (31, NULL, N'Trần Thanh Hùng', N'phó giám đốc', N'đại học', 64, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (33, NULL, N'Nguyễn Tấn Đạt', N'trưởng kỹ thuật', N'Kỹ sư trắc địa', 64, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (47, NULL, N'Nguyễn Văn A', N'giám đốc', NULL, 69, N'25')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (49, NULL, N'Trần Thanh Hùng', N'phó giám đốc', NULL, 69, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (51, NULL, N'Nguyễn Tấn Đạt', N'trưởng kỹ thuật', NULL, 69, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (65, NULL, N'Nguyễn Văn A', N'giám đốc', NULL, 72, N'25')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (67, NULL, N'Trần Thanh Hùng', N'phó giám đốc', NULL, 72, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (69, NULL, N'Nguyễn Tấn Đạt', N'trưởng kỹ thuật', NULL, 72, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (71, NULL, N'Nguyễn Văn A', N'giám đốc', NULL, 73, N'25')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (73, NULL, N'Trần Thanh Hùng', N'phó giám đốc', NULL, 73, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (75, NULL, N'Nguyễn Tấn Đạt', N'trưởng kỹ thuật', NULL, 73, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (77, NULL, N'Nguyễn Văn A', N'giám đốc', NULL, 74, N'25')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (79, NULL, N'Trần Thanh Hùng', N'phó giám đốc', NULL, 74, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (81, NULL, N'Nguyễn Tấn Đạt', N'trưởng kỹ thuật', NULL, 74, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (83, NULL, N'Nguyễn Văn A', N'giám đốc', NULL, 75, N'25')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (85, NULL, N'Trần Thanh Hùng', N'phó giám đốc', NULL, 75, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (87, NULL, N'Nguyễn Tấn Đạt', N'trưởng kỹ thuật', NULL, 75, N'15')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (89, NULL, N'Nguyễn Thị Thảo', N'giám đốc', N'cử nhân quản trị kinh doanh', 76, N'20 năm')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (91, NULL, N'Nguyễn Sỹ Hùng', N'phó giám đốc', N'kỹ sư công nghệ thông tin', 76, N'18 năm')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (92, 7, N'Nguyễn Thị Thảo', N'giám đốc', N'cử nhân quản trị kinh doanh', NULL, N'20 năm')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (118, 33, N'a', N'a', N'a', NULL, N'12')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (119, NULL, N'a', N'a', N'a', 90, N'12')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (125, 51, N'?', N'?', NULL, NULL, N'?')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (126, NULL, N'?', N'?', NULL, 93, N'?')
SET IDENTITY_INSERT [NhanLuc] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NangLucKeKhai](
	[MaKeKhaiNangLuc] [int] IDENTITY(1,1) NOT NULL,
	[NganhNghe] [nvarchar](250) NULL,
	[SoTrenDaiHoc] [int] NULL,
	[SoTrungCap] [int] NULL,
	[SoCongNhanKyThuat] [int] NULL,
	[LoaiKhac] [int] NULL,
	[MaThongTinChung] [int] NULL,
	[MaToChuc] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [NangLucKeKhai] ON
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (8, N'trac dia', 8, 5, 10, 2, NULL, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (36, N'a', 1, 1, 1, 1, NULL, 31)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (37, N'a', 1, 1, 1, 1, 59, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (41, N'a', 12, 12, 12, 1, 63, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (43, N'Trắc địa', 6, 5, 10, 0, 64, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (45, N'Công nghệ thông tin', 3, 2, 0, 0, 64, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (63, N'Trắc địa', 6, 5, 10, 0, 69, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (65, N'Công nghệ thông tin', 3, 2, 0, 0, 69, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (75, N'Trắc địa', 6, 5, 10, 0, 72, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (77, N'Công nghệ thông tin', 3, 2, 0, 0, 72, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (79, N'Trắc địa', 6, 5, 10, 0, 73, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (81, N'Công nghệ thông tin', 3, 2, 0, 0, 73, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (83, N'Trắc địa', 6, 5, 10, 0, 74, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (85, N'Công nghệ thông tin', 3, 2, 0, 0, 74, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (87, N'Trắc địa', 6, 5, 10, 0, 75, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (89, N'Công nghệ thông tin', 3, 2, NULL, 0, 75, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (91, N'công nghệ thông tin', 4, 2, 2, 0, 76, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (93, N'trắc địa', 6, 4, 10, NULL, 76, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (94, N'công nghệ thông tin', 4, 2, 2, 0, NULL, 7)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (96, N'trắc địa', 6, 4, 10, NULL, NULL, 7)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (121, N'a', 0, 0, 0, 0, 87, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (122, N'a', 0, 0, 0, 0, NULL, 11)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (123, N'a', 0, 0, 0, 0, 88, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (124, N'a', 12, 12, 12, 1, NULL, 33)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (125, N'a', 12, 12, 12, 1, 90, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (134, N'l', 0, 0, 0, 0, NULL, 51)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (135, N'l', 0, 0, 0, 0, 93, NULL)
SET IDENTITY_INSERT [NangLucKeKhai] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BaoCaoHoatDong](
	[MaBaoCao] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[DoanhThu] [money] NULL,
	[NopNganSach] [money] NULL,
	[TuNam] [int] NULL,
	[DenNam] [int] NULL,
	[MaThongTinChung] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [BaoCaoHoatDong] ON
INSERT [BaoCaoHoatDong] ([MaBaoCao], [MaToChuc], [DoanhThu], [NopNganSach], [TuNam], [DenNam], [MaThongTinChung]) VALUES (1, 6, 10000000000.0000, 2000000000.0000, 2010, 2012, NULL)
INSERT [BaoCaoHoatDong] ([MaBaoCao], [MaToChuc], [DoanhThu], [NopNganSach], [TuNam], [DenNam], [MaThongTinChung]) VALUES (2, NULL, 10000000000.0000, 200000000.0000, 2010, 2012, 75)
INSERT [BaoCaoHoatDong] ([MaBaoCao], [MaToChuc], [DoanhThu], [NopNganSach], [TuNam], [DenNam], [MaThongTinChung]) VALUES (7, NULL, 0.0000, 0.0000, NULL, NULL, 93)
SET IDENTITY_INSERT [BaoCaoHoatDong] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ThietBi](
	[MaThietBi] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[TenThietBi_CongNghe] [nvarchar](500) NULL,
	[SoLuong] [int] NULL,
	[GhiChu] [nvarchar](2000) NULL,
	[TinhTrang] [nvarchar](50) NULL,
	[MaThongTinChung] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [ThietBi] ON
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (33, 31, N'a', 1, N'a', N'a', NULL)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (34, NULL, N'a', 1, N'a', N'a', 59)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (38, NULL, N'a', 12, N'a', N'a', 63)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (40, NULL, N'Thiết bị định vị GPS', 10, N'không có', N'tốt', 64)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (42, NULL, N'Máy toàn đạc điện tử Nikon DTM 352', 5, N'không có', N'tốt', 64)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (44, NULL, N'Máy đo trắc địa SOUTH', 5, N'không có', N'còn sử dụng tốt', 64)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (57, NULL, N'Thiết bị định vị GPS', 10, N'không có', N'tốt', 69)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (59, NULL, N'Máy toàn đạc điện tử Nikon ', 5, N'không có', N'tốt', 69)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (69, NULL, N'Thiết bị định vị GPS', 10, N'không có', N'tốt', 72)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (71, NULL, N'Máy toàn đạc điện tử Nikon ', 5, N'không có', N'tốt', 72)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (73, NULL, N'Thiết bị định vị GPS', 10, N'không có', N'tốt', 73)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (75, NULL, N'Máy toàn đạc điện tử Nikon ', 5, N'không có', N'tốt', 73)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (77, NULL, N'Thiết bị định vị GPS', 10, N'không có', N'tốt', 74)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (79, NULL, N'Máy toàn đạc điện tử Nikon ', 5, N'không có', N'tốt', 74)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (81, NULL, N'Thiết bị định vị GPS', NULL, N'không có', N'tốt', 75)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (83, NULL, N'Máy toàn đạc điện tử Nikon ', 5, N'không có', N'tốt', 75)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (85, NULL, N'Thiết bị định vị GPS', 20, N'Máy nhập từ Mỹ', N'tốt', 76)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (87, NULL, N'Máy trắc', NULL, NULL, NULL, 76)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (88, 7, N'Thiết bị định vị GPS', 20, N'Máy nhập từ Mỹ', N'tốt', NULL)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (90, 7, N'Máy trắc', NULL, NULL, NULL, NULL)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (104, 6, N'Thiết bị định vị GPS', NULL, N'không có', N'tốt', NULL)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (106, 6, N'Máy toàn đạc điện tử Nikon ', 5, N'không có', N'tốt', NULL)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (108, 33, N'a', 12, N'a', N'a', NULL)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (109, NULL, N'a', 12, N'a', N'a', 90)
SET IDENTITY_INSERT [ThietBi] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [sp_CapNhatTinhTrangHoSo]
AS
BEGIN
	UPDATE HoSoGiayPhep 
	set TinhTrang = 3
	where NgayHetHan < GETDATE();
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ThamDinh](
	[MaThamDinh] [int] IDENTITY(1,1) NOT NULL,
	[MaHoSo] [int] NULL,
	[NguoiThamDinh] [nvarchar](500) NULL,
	[NguoiPhiaToChuc] [nvarchar](500) NULL,
	[NgayThamDinh] [date] NULL,
	[TinhHopLe] [nvarchar](2000) NULL,
	[NangLucNhanVien] [nvarchar](2000) NULL,
	[NangLucThietBi] [nvarchar](2000) NULL,
	[KetLuan] [nvarchar](2000) NULL,
	[KienNghi] [nvarchar](2000) NULL,
	[TinhTrangThamDinh] [bit] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [ThamDinh] ON
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (1, 1, N'Nguyễn Văn Lâm; Trần Văn Lạc', N'Nguyễn Thị Hồng Hạnh;Nguyễn Đình Phương', CAST(0x2B350B00 AS Date), N'hồ sơ đầy đủ', N'đủ năng lực', N'đủ điều kiện', N'đủ tiêu chuẩn cấp phép', N'cấp giấy phép hoạt động', 1)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (2, 2, N'Nguyễn Cao Kỳ', N'Lâm Chấn Phong', CAST(0x00000000 AS Date), N'hồ sơ đầy đủ', N' đủ năng lực', N'khong đủ điều kiện', N' đủ tiêu chuẩn cấp phép bổ sung hoạt động', N'cấp phép những hoạt động đăng ký bổ sung', 1)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (12, 3, N'g', N'g', NULL, N'g', N'g', N'g', N'g', N'g', 0)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (13, 11, N'k', N'd', CAST(0x31350B00 AS Date), N'f', N'f', N's', N'g', N'd', 0)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (14, 15, N'fa', N'fa', CAST(0x00000000 AS Date), NULL, N'fa', NULL, N'fa', N'fa', 0)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (20, 17, N'd', N'd', CAST(0x38360B00 AS Date), NULL, N'd', NULL, N'd', N'd', 0)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (28, 18, N'a', N'a', CAST(0x75360B00 AS Date), NULL, N'a', NULL, N'a', N'a', 0)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (31, 19, N'Nguyễn Văn Lâm;;Cao Đăng Khoa', N'Nguyễn Thu Thủy;;Lê Đăng Thái', CAST(0x37350B00 AS Date), NULL, N'đủ điều kiện về nhân lực và thiết bị', NULL, N'đủ tiêu chuẩn cấp phép', N'Cấp giấy phép hoạt động', 1)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (32, 25, N'Nguyễn Văn Sơn;Nguyễn Chánh Tín;Vũ Đăng Thái', N'Phan Đình Thiện;Nguyễn Hồng Hạnh', CAST(0x4C350B00 AS Date), NULL, N'lực lượng phân tích kỹ thuật theo ngành nghề của tổ chức có đủ chuẩn để hoạt động trong những lĩnh vực đo đạc bản đồ đã đăng ký', NULL, N'đủ chuẩn cấp phép', N'cấp phép bổ sung hoạt động', 1)
SET IDENTITY_INSERT [ThamDinh] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DangKyHoatDong](
	[MaDangKyHoatDong] [int] IDENTITY(1,1) NOT NULL,
	[MaHoSo] [int] NULL,
	[NgayBoSung] [date] NULL,
	[MaHoatDong] [int] NULL,
	[LanBoSung] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [DangKyHoatDong] ON
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (1, 24, NULL, 1, 0)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (2, 24, NULL, 2, 0)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (7, 24, NULL, 3, 0)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (8, 24, NULL, 7, 0)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (9, 25, NULL, 4, 1)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (10, 26, NULL, 1, 0)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (11, 26, NULL, 5, 0)
SET IDENTITY_INSERT [DangKyHoatDong] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BaoCaoCongTrinh](
	[MaCongTrinh] [int] IDENTITY(1,1) NOT NULL,
	[TenCongTrinh] [nvarchar](200) NULL,
	[ChuDauTu] [nvarchar](200) NULL,
	[CongDoanDaThiCong] [nvarchar](2000) NULL,
	[GiaTriDaThucHien] [nvarchar](2000) NULL,
	[ThoiGianThucHien] [nvarchar](500) NULL,
	[GhiChu] [nvarchar](2000) NULL,
	[MaBaoCao] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [BaoCaoCongTrinh] ON
INSERT [BaoCaoCongTrinh] ([MaCongTrinh], [TenCongTrinh], [ChuDauTu], [CongDoanDaThiCong], [GiaTriDaThucHien], [ThoiGianThucHien], [GhiChu], [MaBaoCao]) VALUES (2, N'Xây dựng lưới chiếu quốc gia', N'Bộ Tài nguyên và Môi trường', NULL, NULL, NULL, N'aaaaa', 2)
INSERT [BaoCaoCongTrinh] ([MaCongTrinh], [TenCongTrinh], [ChuDauTu], [CongDoanDaThiCong], [GiaTriDaThucHien], [ThoiGianThucHien], [GhiChu], [MaBaoCao]) VALUES (8, N'Xây dựng bản đồ địa chính TP.HCM', N'Bộ Tài nguyên và Môi trường', NULL, N'120000000', N'3/2010- 2/2012', NULL, 1)
SET IDENTITY_INSERT [BaoCaoCongTrinh] OFF
ALTER TABLE [TaiKhoan] ADD  CONSTRAINT [DF_TaiKhoan_TinhTrang]  DEFAULT ((1)) FOR [TinhTrang]
GO
