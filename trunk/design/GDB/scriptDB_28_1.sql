USE [QLDDBD]
GO
/****** Object:  Table [dbo].[HoatDong]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoatDong](
	[MaHoatDong] [int] IDENTITY(1,1) NOT NULL,
	[TenHoatDong] [nvarchar](500) NULL,
 CONSTRAINT [PK_HOATDONG] PRIMARY KEY CLUSTERED 
(
	[MaHoatDong] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TinhTrangTaiKhoan]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhTrangTaiKhoan](
	[MaTinhTrang] [int] NOT NULL,
	[DienGiai] [nvarchar](50) NULL,
 CONSTRAINT [PK_TinhTrangTaiKhoan] PRIMARY KEY CLUSTERED 
(
	[MaTinhTrang] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TinhTrangGiayPhep]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhTrangGiayPhep](
	[MaTinhTrang] [int] NOT NULL,
	[DienGiai] [nvarchar](50) NULL,
 CONSTRAINT [PK_TINHTRANGGIAYPHEP] PRIMARY KEY CLUSTERED 
(
	[MaTinhTrang] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TinhThanh]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhThanh](
	[MaTinhThanh] [int] IDENTITY(1,1) NOT NULL,
	[TenTinhThanh] [nvarchar](50) NULL,
 CONSTRAINT [PK_TINHTHANH] PRIMARY KEY CLUSTERED 
(
	[MaTinhThanh] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiSanPham]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSanPham](
	[MaLoaiSanPham] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiSanPham] [nvarchar](500) NULL,
	[DienGiai] [nvarchar](2000) NULL,
 CONSTRAINT [PK_LOAISANPHAM] PRIMARY KEY CLUSTERED 
(
	[MaLoaiSanPham] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiQuyen]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiQuyen](
	[MaLoaiQuyen] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiQuyen] [nvarchar](50) NULL,
	[DienGiai] [nvarchar](100) NULL,
 CONSTRAINT [PK_LOAIQUYEN] PRIMARY KEY CLUSTERED 
(
	[MaLoaiQuyen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiHinhToChuc]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiHinhToChuc](
	[MaLoaiHinhToChuc] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiHinhToChuc] [nvarchar](50) NULL,
 CONSTRAINT [PK_LOAIHINHTOCHUC] PRIMARY KEY CLUSTERED 
(
	[MaLoaiHinhToChuc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhomNguoiDung]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomNguoiDung](
	[MaNhom] [int] IDENTITY(1,1) NOT NULL,
	[TenNhom] [nvarchar](50) NULL,
 CONSTRAINT [PK_NHOMNGUOIDUNG] PRIMARY KEY CLUSTERED 
(
	[MaNhom] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CongTrinh]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[CongDoanThucHien]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[ThongTinChung]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinChung](
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
	[TepDinhKem] [nvarchar](500) NULL,
	[HangDoanhNghiep] [nvarchar](50) NULL,
	[VonLuuDong] [money] NULL,
	[VonPhapDinh] [money] NULL,
 CONSTRAINT [PK_ThongTinChung] PRIMARY KEY CLUSTERED 
(
	[MaThongTinChung] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quyen]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[QuanHuyen]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuanHuyen](
	[MaQuanHuyen] [int] IDENTITY(1,1) NOT NULL,
	[TenQuanHuyen] [nvarchar](50) NULL,
	[MaTinhThanh] [int] NULL,
 CONSTRAINT [PK_QUANHUYEN] PRIMARY KEY CLUSTERED 
(
	[MaQuanHuyen] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[DangKyHoatDong]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DangKyHoatDong](
	[MaDangKyHoatDong] [int] IDENTITY(1,1) NOT NULL,
	[MaHoSo] [int] NULL,
	[NgayBoSung] [date] NULL,
	[MaHoatDong] [int] NULL,
	[LanBoSung] [int] NULL,
 CONSTRAINT [PK_DANGKYHOATDONG] PRIMARY KEY CLUSTERED 
(
	[MaDangKyHoatDong] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NangLucKeKhai]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NangLucKeKhai](
	[MaKeKhaiNangLuc] [int] IDENTITY(1,1) NOT NULL,
	[NganhNghe] [nvarchar](250) NULL,
	[SoTrenDaiHoc] [int] NULL,
	[SoTrungCap] [int] NULL,
	[SoCongNhanKyThuat] [int] NULL,
	[LoaiKhac] [int] NULL,
	[MaThongTinChung] [int] NULL,
	[MaToChuc] [int] NULL,
 CONSTRAINT [PK_NangLucKeKhai] PRIMARY KEY CLUSTERED 
(
	[MaKeKhaiNangLuc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ToChuc]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[QuyenCuaNhom]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuyenCuaNhom](
	[MaQuyenNhom] [int] IDENTITY(1,1) NOT NULL,
	[MaNhom] [int] NOT NULL,
	[Quyen] [int] NOT NULL,
 CONSTRAINT [PK_QUYENCUANHOM] PRIMARY KEY CLUSTERED 
(
	[MaQuyenNhom] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanLuc]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanLuc](
	[MaNhanVien] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[HoTen] [nvarchar](50) NULL,
	[ChucVu] [nvarchar](50) NULL,
	[TrinhDoHocVan] [nvarchar](50) NULL,
	[MaThongTinChung] [int] NULL,
	[ThamNien] [nvarchar](20) NULL,
 CONSTRAINT [PK_NHANLUC] PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BaoCaoHoatDong]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaoCaoHoatDong](
	[MaBaoCao] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[Nam] [int] NULL,
	[DoanhThu] [money] NULL,
	[NopNganSach] [money] NULL,
	[DanhSachCongTrinh] [nvarchar](2000) NULL,
	[TepDinhKem] [nvarchar](500) NULL,
 CONSTRAINT [PK_BAOCAOHOATDONG] PRIMARY KEY CLUSTERED 
(
	[MaBaoCao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoSoGiayPhep]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoSoGiayPhep](
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
 CONSTRAINT [PK_GIAYPHEPHOATDONG] PRIMARY KEY CLUSTERED 
(
	[MaHoSo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoatDongDuocCap]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HoatDongDuocCap](
	[MaHDHienTai] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[SoGiayPhep] [varchar](50) NULL,
	[LanBoSung] [int] NULL,
	[TenHoatDong] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ThietBi]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThietBi](
	[MaThietBi] [int] IDENTITY(1,1) NOT NULL,
	[MaToChuc] [int] NULL,
	[TenThietBi_CongNghe] [nvarchar](500) NULL,
	[SoLuong] [int] NULL,
	[GhiChu] [nvarchar](2000) NULL,
	[TinhTrang] [nvarchar](50) NULL,
	[MaThongTinChung] [int] NULL,
 CONSTRAINT [PK_THIETBI] PRIMARY KEY CLUSTERED 
(
	[MaThietBi] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThamDinh]    Script Date: 01/28/2012 23:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThamDinh](
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
	[TinhTrangThamDinh] [bit] NULL,
 CONSTRAINT [PK_THAMDINH] PRIMARY KEY CLUSTERED 
(
	[MaThamDinh] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF_TaiKhoan_TinhTrang]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[TaiKhoan] ADD  CONSTRAINT [DF_TaiKhoan_TinhTrang]  DEFAULT ((1)) FOR [TinhTrang]
GO
/****** Object:  ForeignKey [FK_CONGDOAN_REFERENCE_CONGTRIN]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[CongDoanThucHien]  WITH CHECK ADD  CONSTRAINT [FK_CONGDOAN_REFERENCE_CONGTRIN] FOREIGN KEY([MaCongTrinh])
REFERENCES [dbo].[CongTrinh] ([MaCongTrinh])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CongDoanThucHien] CHECK CONSTRAINT [FK_CONGDOAN_REFERENCE_CONGTRIN]
GO
/****** Object:  ForeignKey [FK_ThongTinChung_LoaiHinhToChuc]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[ThongTinChung]  WITH CHECK ADD  CONSTRAINT [FK_ThongTinChung_LoaiHinhToChuc] FOREIGN KEY([MaLoaiHinhToChuc])
REFERENCES [dbo].[LoaiHinhToChuc] ([MaLoaiHinhToChuc])
GO
ALTER TABLE [dbo].[ThongTinChung] CHECK CONSTRAINT [FK_ThongTinChung_LoaiHinhToChuc]
GO
/****** Object:  ForeignKey [FK_QUYEN_LOAIQUYEN]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[Quyen]  WITH CHECK ADD  CONSTRAINT [FK_QUYEN_LOAIQUYEN] FOREIGN KEY([LoaiQuyen])
REFERENCES [dbo].[LoaiQuyen] ([MaLoaiQuyen])
GO
ALTER TABLE [dbo].[Quyen] CHECK CONSTRAINT [FK_QUYEN_LOAIQUYEN]
GO
/****** Object:  ForeignKey [FK_QUANHUYE_REFERENCE_TINHTHAN]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[QuanHuyen]  WITH CHECK ADD  CONSTRAINT [FK_QUANHUYE_REFERENCE_TINHTHAN] FOREIGN KEY([MaTinhThanh])
REFERENCES [dbo].[TinhThanh] ([MaTinhThanh])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuanHuyen] CHECK CONSTRAINT [FK_QUANHUYE_REFERENCE_TINHTHAN]
GO
/****** Object:  ForeignKey [FK_TAIKHOAN_NHOMNGUOIDUNG]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TAIKHOAN_NHOMNGUOIDUNG] FOREIGN KEY([NhomNguoiDung])
REFERENCES [dbo].[NhomNguoiDung] ([MaNhom])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TAIKHOAN_NHOMNGUOIDUNG]
GO
/****** Object:  ForeignKey [FK_TaiKhoan_TinhTrangTaiKhoan]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_TinhTrangTaiKhoan] FOREIGN KEY([TinhTrang])
REFERENCES [dbo].[TinhTrangTaiKhoan] ([MaTinhTrang])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_TinhTrangTaiKhoan]
GO
/****** Object:  ForeignKey [FK_DangKyHoatDong_DangKyHoatDong]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[DangKyHoatDong]  WITH CHECK ADD  CONSTRAINT [FK_DangKyHoatDong_DangKyHoatDong] FOREIGN KEY([MaDangKyHoatDong])
REFERENCES [dbo].[DangKyHoatDong] ([MaDangKyHoatDong])
GO
ALTER TABLE [dbo].[DangKyHoatDong] CHECK CONSTRAINT [FK_DangKyHoatDong_DangKyHoatDong]
GO
/****** Object:  ForeignKey [FK_DANGKYHOATDONG_HOATDONG]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[DangKyHoatDong]  WITH CHECK ADD  CONSTRAINT [FK_DANGKYHOATDONG_HOATDONG] FOREIGN KEY([MaHoatDong])
REFERENCES [dbo].[HoatDong] ([MaHoatDong])
GO
ALTER TABLE [dbo].[DangKyHoatDong] CHECK CONSTRAINT [FK_DANGKYHOATDONG_HOATDONG]
GO
/****** Object:  ForeignKey [FK_NangLucKeKhai_ThongTinChung]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[NangLucKeKhai]  WITH CHECK ADD  CONSTRAINT [FK_NangLucKeKhai_ThongTinChung] FOREIGN KEY([MaThongTinChung])
REFERENCES [dbo].[ThongTinChung] ([MaThongTinChung])
GO
ALTER TABLE [dbo].[NangLucKeKhai] CHECK CONSTRAINT [FK_NangLucKeKhai_ThongTinChung]
GO
/****** Object:  ForeignKey [FK_TOCHUC_REFERENCE_LOAIHINH]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[ToChuc]  WITH CHECK ADD  CONSTRAINT [FK_TOCHUC_REFERENCE_LOAIHINH] FOREIGN KEY([MaLoaiHinhToChuc])
REFERENCES [dbo].[LoaiHinhToChuc] ([MaLoaiHinhToChuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ToChuc] CHECK CONSTRAINT [FK_TOCHUC_REFERENCE_LOAIHINH]
GO
/****** Object:  ForeignKey [FK_TOCHUC_TAIKHOAN]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[ToChuc]  WITH CHECK ADD  CONSTRAINT [FK_TOCHUC_TAIKHOAN] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[ToChuc] CHECK CONSTRAINT [FK_TOCHUC_TAIKHOAN]
GO
/****** Object:  ForeignKey [FK_SANPHAM_REFERENCE_CONGTRIN]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SANPHAM_REFERENCE_CONGTRIN] FOREIGN KEY([MaCongTrinh])
REFERENCES [dbo].[CongTrinh] ([MaCongTrinh])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SANPHAM_REFERENCE_CONGTRIN]
GO
/****** Object:  ForeignKey [FK_SANPHAM_REFERENCE_LOAISANP]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SANPHAM_REFERENCE_LOAISANP] FOREIGN KEY([MaLoaiSanPham])
REFERENCES [dbo].[LoaiSanPham] ([MaLoaiSanPham])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SANPHAM_REFERENCE_LOAISANP]
GO
/****** Object:  ForeignKey [FK_SANPHAM_REFERENCE_QUANHUYE]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SANPHAM_REFERENCE_QUANHUYE] FOREIGN KEY([MaQuanHuyen])
REFERENCES [dbo].[QuanHuyen] ([MaQuanHuyen])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SANPHAM_REFERENCE_QUANHUYE]
GO
/****** Object:  ForeignKey [FK_QUYENCUANHOM_NHOMNGUOIDUNG]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[QuyenCuaNhom]  WITH CHECK ADD  CONSTRAINT [FK_QUYENCUANHOM_NHOMNGUOIDUNG] FOREIGN KEY([MaNhom])
REFERENCES [dbo].[NhomNguoiDung] ([MaNhom])
GO
ALTER TABLE [dbo].[QuyenCuaNhom] CHECK CONSTRAINT [FK_QUYENCUANHOM_NHOMNGUOIDUNG]
GO
/****** Object:  ForeignKey [FK_QUYENCUANHOM_QUYEN]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[QuyenCuaNhom]  WITH CHECK ADD  CONSTRAINT [FK_QUYENCUANHOM_QUYEN] FOREIGN KEY([Quyen])
REFERENCES [dbo].[Quyen] ([MaQuyen])
GO
ALTER TABLE [dbo].[QuyenCuaNhom] CHECK CONSTRAINT [FK_QUYENCUANHOM_QUYEN]
GO
/****** Object:  ForeignKey [FK_NHANLUC_REFERENCE_TOCHUC]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[NhanLuc]  WITH CHECK ADD  CONSTRAINT [FK_NHANLUC_REFERENCE_TOCHUC] FOREIGN KEY([MaToChuc])
REFERENCES [dbo].[ToChuc] ([MaToChuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NhanLuc] CHECK CONSTRAINT [FK_NHANLUC_REFERENCE_TOCHUC]
GO
/****** Object:  ForeignKey [FK_NhanLuc_ThongTinChung]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[NhanLuc]  WITH CHECK ADD  CONSTRAINT [FK_NhanLuc_ThongTinChung] FOREIGN KEY([MaThongTinChung])
REFERENCES [dbo].[ThongTinChung] ([MaThongTinChung])
GO
ALTER TABLE [dbo].[NhanLuc] CHECK CONSTRAINT [FK_NhanLuc_ThongTinChung]
GO
/****** Object:  ForeignKey [FK_BAOCAOHO_REFERENCE_TOCHUC]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[BaoCaoHoatDong]  WITH CHECK ADD  CONSTRAINT [FK_BAOCAOHO_REFERENCE_TOCHUC] FOREIGN KEY([MaToChuc])
REFERENCES [dbo].[ToChuc] ([MaToChuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BaoCaoHoatDong] CHECK CONSTRAINT [FK_BAOCAOHO_REFERENCE_TOCHUC]
GO
/****** Object:  ForeignKey [FK_GIAYPHEP_REFERENCE_TOCHUC]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[HoSoGiayPhep]  WITH CHECK ADD  CONSTRAINT [FK_GIAYPHEP_REFERENCE_TOCHUC] FOREIGN KEY([MaToChuc])
REFERENCES [dbo].[ToChuc] ([MaToChuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoSoGiayPhep] CHECK CONSTRAINT [FK_GIAYPHEP_REFERENCE_TOCHUC]
GO
/****** Object:  ForeignKey [FK_GiayPhepHoatDong_ThongTinChung]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[HoSoGiayPhep]  WITH CHECK ADD  CONSTRAINT [FK_GiayPhepHoatDong_ThongTinChung] FOREIGN KEY([MaThongTinChung])
REFERENCES [dbo].[ThongTinChung] ([MaThongTinChung])
GO
ALTER TABLE [dbo].[HoSoGiayPhep] CHECK CONSTRAINT [FK_GiayPhepHoatDong_ThongTinChung]
GO
/****** Object:  ForeignKey [FK_GiayPhepHoatDong_TinhTrangGiayPhep]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[HoSoGiayPhep]  WITH CHECK ADD  CONSTRAINT [FK_GiayPhepHoatDong_TinhTrangGiayPhep] FOREIGN KEY([TinhTrang])
REFERENCES [dbo].[TinhTrangGiayPhep] ([MaTinhTrang])
GO
ALTER TABLE [dbo].[HoSoGiayPhep] CHECK CONSTRAINT [FK_GiayPhepHoatDong_TinhTrangGiayPhep]
GO
/****** Object:  ForeignKey [FK_HoatDongDuocCap_ToChuc]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[HoatDongDuocCap]  WITH CHECK ADD  CONSTRAINT [FK_HoatDongDuocCap_ToChuc] FOREIGN KEY([MaToChuc])
REFERENCES [dbo].[ToChuc] ([MaToChuc])
GO
ALTER TABLE [dbo].[HoatDongDuocCap] CHECK CONSTRAINT [FK_HoatDongDuocCap_ToChuc]
GO
/****** Object:  ForeignKey [FK_THIETBI_REFERENCE_TOCHUC]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[ThietBi]  WITH CHECK ADD  CONSTRAINT [FK_THIETBI_REFERENCE_TOCHUC] FOREIGN KEY([MaToChuc])
REFERENCES [dbo].[ToChuc] ([MaToChuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ThietBi] CHECK CONSTRAINT [FK_THIETBI_REFERENCE_TOCHUC]
GO
/****** Object:  ForeignKey [FK_ThietBi_ThongTinChung]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[ThietBi]  WITH CHECK ADD  CONSTRAINT [FK_ThietBi_ThongTinChung] FOREIGN KEY([MaThongTinChung])
REFERENCES [dbo].[ThongTinChung] ([MaThongTinChung])
GO
ALTER TABLE [dbo].[ThietBi] CHECK CONSTRAINT [FK_ThietBi_ThongTinChung]
GO
/****** Object:  ForeignKey [FK_ThamDinh_HoSoGiayPhep]    Script Date: 01/28/2012 23:16:59 ******/
ALTER TABLE [dbo].[ThamDinh]  WITH CHECK ADD  CONSTRAINT [FK_ThamDinh_HoSoGiayPhep] FOREIGN KEY([MaHoSo])
REFERENCES [dbo].[HoSoGiayPhep] ([MaHoSo])
GO
ALTER TABLE [dbo].[ThamDinh] CHECK CONSTRAINT [FK_ThamDinh_HoSoGiayPhep]
GO
