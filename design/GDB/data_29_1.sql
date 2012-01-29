USE [QLDDBD]
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
INSERT [TinhTrangTaiKhoan] ([MaTinhTrang], [DienGiai]) VALUES (1, N'Chưa kích hoạt')
INSERT [TinhTrangTaiKhoan] ([MaTinhTrang], [DienGiai]) VALUES (2, N'Đã kích hoạt')
INSERT [TinhTrangTaiKhoan] ([MaTinhTrang], [DienGiai]) VALUES (3, N'Bị khoá')
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
SET IDENTITY_INSERT [LoaiSanPham] ON
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (1, N'Mốc toạ độ', N'Mốc toạ độ')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (2, N'Mốc độ cao', N'Mốc độ cao')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (3, N'Mốc trọng lực', N'Mốc trọng lực')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (4, N'Bản đồ địa chính 1: 2000', N'Bản đồ địa chính 1: 2000')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (5, N'Bản đồ địa chính 1: 10000', N'Bản đồ địa chính 1: 10000')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (6, N'Bản đồ địa chính 1: 20000', N'Bản đồ địa chính 1: 20000')
INSERT [LoaiSanPham] ([MaLoaiSanPham], [TenLoaiSanPham], [DienGiai]) VALUES (7, N'Bản độ địa hình 1: 1000', N'Bản đồ địa hình 1:1000')
SET IDENTITY_INSERT [LoaiSanPham] OFF
SET IDENTITY_INSERT [LoaiQuyen] ON
INSERT [LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (1, N'Quản lý người dùng', NULL)
INSERT [LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (2, N'Quản lý tổ chức', NULL)
INSERT [LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (3, N'Quản lý giấy phép ', NULL)
INSERT [LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (4, N'Quản lý bản đồ', NULL)
INSERT [LoaiQuyen] ([MaLoaiQuyen], [TenLoaiQuyen], [DienGiai]) VALUES (5, N'Quản lý hoạt động', NULL)
SET IDENTITY_INSERT [LoaiQuyen] OFF
SET IDENTITY_INSERT [LoaiHinhToChuc] ON
INSERT [LoaiHinhToChuc] ([MaLoaiHinhToChuc], [TenLoaiHinhToChuc]) VALUES (1, N'Tổ chức trong nước')
INSERT [LoaiHinhToChuc] ([MaLoaiHinhToChuc], [TenLoaiHinhToChuc]) VALUES (2, N'Tổ chức đầu tư nước ngoài')
INSERT [LoaiHinhToChuc] ([MaLoaiHinhToChuc], [TenLoaiHinhToChuc]) VALUES (3, N'Tổ chức nước ngoài')
SET IDENTITY_INSERT [LoaiHinhToChuc] OFF
SET IDENTITY_INSERT [NhomNguoiDung] ON
INSERT [NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (1, N'Đăng ký')
INSERT [NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (2, N'Quản lý địa phương')
INSERT [NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (3, N'Quản lý cấp phép')
INSERT [NhomNguoiDung] ([MaNhom], [TenNhom]) VALUES (4, N'SuperAdmin')
SET IDENTITY_INSERT [NhomNguoiDung] OFF
SET IDENTITY_INSERT [ThongTinChung] ON
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (1, 1, N'Công ty A ', N'GPKD1234', N'Nguyễn Văn Lâm', N'Đặng Văn Ngữ', N'jfdskfj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8948595.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (2, 1, N'Công ty B', N'GPKD1235', N'Nguyễn Văn Hùng', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (3, 2, N'Công ty C', N'1234567', N'Nguyễn Sinh Hùng', N'Điện Biên Phủ', NULL, N'89754309', N'89754309', NULL, 35, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (4, 1, N'Công ty D', NULL, NULL, N'Mac Dinh Chi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (5, 2, N'Công ty E', N'4372864', NULL, N'Nguyen Thai Son', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (6, 2, N'Công ty F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (7, 1, N'Công ty A ', N'GPKD1234', N'Nguyễn Văn Lâm', N'Đặng Văn Ngữ', N'jfdskfj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8948595.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (8, 1, N'Công ty B', N'GPKD1235', N'Nguyễn Văn Hùng', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (9, 2, N'Công ty C', N'1234567', N'Nguyễn Sinh Hùng', N'Điện Biên Phủ', NULL, N'89754309', N'89754309', NULL, 35, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (10, 2, N'Công ty C', N'1234567', N'Nguyễn Sinh Hùng', N'Điện Biên Phủ', NULL, N'89754309', N'89754309', NULL, 35, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (11, 2, N'Công ty E', N'4372864', NULL, N'Nguyen Thai Son', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (12, 1, N'Công ty K', NULL, N'Nguyễn Văn Lâm', N'Nguyễn Sơn, Tân Phú', N'K7863-G3958-H9876', N'083374652', N'083374652', N'congtyK@gmail.com', 70, N'/TOCHUC/congtyK', NULL, 2.0000, 8948595.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (13, NULL, N'Công ty ảnh viễn thám 1', N'GP098/4498', NULL, N'Mạc Đĩnh Chi', N'K9847-Y9373', N'0835748478', N'0835748478', N'ctyanhvientham@gmail.com', 80, NULL, N'2', 5030000000.0000, 5030000000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (14, 1, N'Công ty A ', N'GPKD1234', NULL, N'Đặng Văn Ngữ', N'jfdskfj', NULL, NULL, NULL, 0, NULL, NULL, 894859500.0000, 485300000.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (30, 1, N'a', N'a', NULL, N'a', N'a', N'0835748478', N'0835748478', N'0935876554@gmail.com', 0, NULL, N'2', 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (39, 1, N'qq', N'QD978/CP', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (59, 1, N'A', N'a', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, N'1', 0.0000, 0.0000)
INSERT [ThongTinChung] ([MaThongTinChung], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (63, 1, N'A', N'A', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, N'1', 0.0000, 0.0000)
SET IDENTITY_INSERT [ThongTinChung] OFF
SET IDENTITY_INSERT [TaiKhoan] ON
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (1, 4, N'dodacvn', N'dodacvn', N'34 truong dinh', N'123456756', N'admin@gmail.com', N'cuc do dac', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (2, 4, N'thuong', N'thuongthuong', N'fdjsjl', N'123456789', N'thuongthuong1990@gmail.com', N'fjdlsjflkds', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (3, 1, N'hyolthuong', N'Phan Thương Thương', N'31/16 Đỗ Đức Dục', N'311998695', N'thuongthuong1990@gmail.com.vn', N'cuc do dac', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (4, 1, N'thuongphan', N'phqn thuong', N'fhffh', N'311998695', N'thuongphan@gmail.com', N'cong ty AA', 2, N'619170C4D559A0786A141D489D019E22')
INSERT [TaiKhoan] ([MaTaiKhoan], [NhomNguoiDung], [TenTaiKhoan], [HoTen], [DiaChi], [CMND], [Email], [CoQuan], [TinhTrang], [MatKhau]) VALUES (5, 1, N'thuongthuong', N'Phan Thương', N'Nguyễn Sơn, Tân Phú', N'311998695', N'thuongthuong1989@gmail.com', N'Xí nghiệp ảnh viễn thám', 2, N'E10ADC3949BA59ABBE56E057F20F883E')
SET IDENTITY_INSERT [TaiKhoan] OFF
SET IDENTITY_INSERT [DangKyHoatDong] ON
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (1, 1, CAST(0xA5330B00 AS Date), 2, 0)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (2, 1, CAST(0xA5330B00 AS Date), 3, 0)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (3, 8, CAST(0x2D320B00 AS Date), 4, 1)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (4, 8, CAST(0x2D320B00 AS Date), 5, 1)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (5, 16, NULL, 6, 2)
INSERT [DangKyHoatDong] ([MaDangKyHoatDong], [MaHoSo], [NgayBoSung], [MaHoatDong], [LanBoSung]) VALUES (6, 16, NULL, 7, 2)
SET IDENTITY_INSERT [DangKyHoatDong] OFF
SET IDENTITY_INSERT [NangLucKeKhai] ON
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (8, N'trac dia', 8, 5, 10, 2, NULL, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (36, N'a', 1, 1, 1, 1, NULL, 31)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (37, N'a', 1, 1, 1, 1, 59, NULL)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (40, N'a', 12, 12, 12, 1, NULL, 33)
INSERT [NangLucKeKhai] ([MaKeKhaiNangLuc], [NganhNghe], [SoTrenDaiHoc], [SoTrungCap], [SoCongNhanKyThuat], [LoaiKhac], [MaThongTinChung], [MaToChuc]) VALUES (41, N'a', 12, 12, 12, 1, 63, NULL)
SET IDENTITY_INSERT [NangLucKeKhai] OFF
SET IDENTITY_INSERT [ToChuc] ON
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (6, 1, N'Công ty A ', N'GPKD1234', N'Nguyễn Văn Lâm', N'Đặng Văn Ngữ', N'jfdskfj', NULL, NULL, NULL, NULL, NULL, 3, NULL, 8948595.0000, 48530000.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (7, 1, N'Công ty B', N'GPKD1235', N'Nguyễn Văn Hùng', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (8, 2, N'Công ty C', N'1234567', N'Nguyễn Sinh Hùng', N'Điện Biên Phủ', NULL, N'89754309', N'89754309', NULL, 35, NULL, NULL, NULL, NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (9, 1, N'Công ty D', NULL, NULL, N'Mac Dinh Chi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (10, 2, N'Công ty E', N'4372864', NULL, N'Nguyen Thai Son', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (11, 2, N'Công ty F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (12, 1, N'Công ty K', NULL, N'Nguyễn Văn Lâm', N'Nguyễn Sơn, Tân Phú', N'K7863-G3958-H9876', N'083374652', N'083374652', N'congtyK@gmail.com', 70, N'1e29dab2-7f20-4a7a-a9b6-728bb934a649.rar', NULL, N'2', 8948595.0000, 48530000.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (25, 1, N'qq', N'QD978/CP', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 4, NULL, 0.0000, 0.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (31, 1, N'A', N'a', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 5, N'1', 0.0000, 0.0000)
INSERT [ToChuc] ([MaToChuc], [MaLoaiHinhToChuc], [TenToChuc], [GiayPhepKinhDoanh], [NguoiDaiDien], [TruSoChinh], [SoTaiKhoan], [DienThoai], [Fax], [Email], [TongSoCanBo], [TepDinhKem], [MaTaiKhoan], [HangDoanhNghiep], [VonLuuDong], [VonPhapDinh]) VALUES (33, 1, N'A', N'A', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2, N'1', 0.0000, 0.0000)
SET IDENTITY_INSERT [ToChuc] OFF
SET IDENTITY_INSERT [NhanLuc] ON
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (8, 6, N'Nguyễn Văn lâm', N'giám đốc', N'cao học', NULL, NULL)
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (9, 6, N'Trần Thanh Hùng', N'phó giám đốc', N'đại học', NULL, NULL)
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (22, 31, N'a1', N'a', N'a', NULL, N'13')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (23, NULL, N'a1', N'a', N'a', 59, N'13')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (26, 33, N'a', N'a', N'a', NULL, N'12')
INSERT [NhanLuc] ([MaNhanVien], [MaToChuc], [HoTen], [ChucVu], [TrinhDoHocVan], [MaThongTinChung], [ThamNien]) VALUES (27, NULL, N'a', N'a', N'a', 63, N'12')
SET IDENTITY_INSERT [NhanLuc] OFF
SET IDENTITY_INSERT [HoSoGiayPhep] ON
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (1, 6, N'123456', CAST(0x6B350B00 AS Date), CAST(0xB2390B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 5, CAST(0x18350B00 AS Date), N'1e29dab2-7f20-4a7a-a9b6-728bb934a649.rar', 1)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (2, 7, N'4656', CAST(0x80360B00 AS Date), CAST(0x5A390B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 5, CAST(0x38320B00 AS Date), N'fdsfsfewfgdfafd', 2)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (3, 9, N'12345678', CAST(0x43350B00 AS Date), CAST(0x44350B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 10, CAST(0x1C2E0B00 AS Date), N'fdgsfdsgfd', 3)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (11, 6, N'123456', CAST(0x75350B00 AS Date), CAST(0x70350B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 8, CAST(0x18350B00 AS Date), N'fdsafdksajfkjdskajfkdsj', 7)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (14, 8, N'123456789', CAST(0x43350B00 AS Date), CAST(0x44350B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 11, CAST(0x1C2E0B00 AS Date), N'fdgsfdsgfd', 3)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (15, 6, N'123456', CAST(0x43350B00 AS Date), NULL, NULL, NULL, 8, NULL, NULL, 4)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (16, 6, N'123456', CAST(0x43350B00 AS Date), NULL, N'lý do 2', N'cam kết 2', 6, NULL, NULL, 8)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (17, 8, N'4656', CAST(0x90320B00 AS Date), CAST(0xB2390B00 AS Date), N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 1, CAST(0x18350B00 AS Date), N'fdsafdksajfkjdskajfkdsj', 10)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (18, 10, NULL, CAST(0x43350B00 AS Date), NULL, NULL, NULL, 10, NULL, NULL, 11)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (19, 12, N'653754', CAST(0x43350B00 AS Date), NULL, N'muốn được hoạt động trong lĩnh vực đbd', N'thực hiện đúng quy định về ddbd', 10, CAST(0x38350B00 AS Date), N'/tochuc/congtyK/tepdinhkem', 12)
INSERT [HoSoGiayPhep] ([MaHoSo], [MaToChuc], [SoGiayPhep], [NgayCapPhep], [NgayHetHan], [LyDo], [CamKet], [TinhTrang], [NgayXinPhep], [TepDinhKem], [MaThongTinChung]) VALUES (20, NULL, NULL, CAST(0x43350B00 AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [HoSoGiayPhep] OFF
SET IDENTITY_INSERT [HoatDongDuocCap] ON
INSERT [HoatDongDuocCap] ([MaHDHienTai], [MaToChuc], [SoGiayPhep], [LanBoSung], [TenHoatDong]) VALUES (1, 6, N'123456', 0, N'hoạt động 1 ')
INSERT [HoatDongDuocCap] ([MaHDHienTai], [MaToChuc], [SoGiayPhep], [LanBoSung], [TenHoatDong]) VALUES (2, 6, N'123456', 0, N'hoạt động 2')
INSERT [HoatDongDuocCap] ([MaHDHienTai], [MaToChuc], [SoGiayPhep], [LanBoSung], [TenHoatDong]) VALUES (3, 6, N'123456', 1, N'hoạt động 3')
INSERT [HoatDongDuocCap] ([MaHDHienTai], [MaToChuc], [SoGiayPhep], [LanBoSung], [TenHoatDong]) VALUES (4, 6, N'123456', 1, N'hoạt động 4')
SET IDENTITY_INSERT [HoatDongDuocCap] OFF
SET IDENTITY_INSERT [ThietBi] ON
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (3, 6, N'Thiết bị định vị', 5, N'mua tu Nga', N'tốt', NULL)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (4, 6, N'Thiết bị đo độ dài', 10, N'được Nhà nước cung cấp', N'tốt', NULL)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (33, 31, N'a', 1, N'a', N'a', NULL)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (34, NULL, N'a', 1, N'a', N'a', 59)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (37, 33, N'a', 12, N'a', N'a', NULL)
INSERT [ThietBi] ([MaThietBi], [MaToChuc], [TenThietBi_CongNghe], [SoLuong], [GhiChu], [TinhTrang], [MaThongTinChung]) VALUES (38, NULL, N'a', 12, N'a', N'a', 63)
SET IDENTITY_INSERT [ThietBi] OFF
SET IDENTITY_INSERT [ThamDinh] ON
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (1, 1, N'Nguyễn Văn Lâm; Trần Văn Lạc', N'Nguyễn Thị Hồng Hạnh;Nguyễn Đình Phương', CAST(0x2B350B00 AS Date), N'hồ sơ đầy đủ', N'đủ năng lực', N'đủ điều kiện', N'đủ tiêu chuẩn cấp phép', N'cấp giấy phép hoạt động', NULL)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (2, 2, N'Nguyễn Cao Kỳ', N'Lâm Chấn Phong', CAST(0x00000000 AS Date), N'hồ sơ đầy đủ', N' đủ năng lực', N'khong đủ điều kiện', N' đủ tiêu chuẩn cấp phép bổ sung hoạt động', N'cấp phép những hoạt động đăng ký bổ sung', NULL)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (12, 3, N'g', N'g', NULL, N'g', N'g', N'g', N'g', N'g', NULL)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (13, 11, N'k', N'd', CAST(0x31350B00 AS Date), N'f', N'f', N's', N'g', N'd', NULL)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (14, 15, N'fa', N'fa', CAST(0x00000000 AS Date), NULL, N'fa', NULL, N'fa', N'fa', NULL)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (20, 17, N'd', N'd', CAST(0x38360B00 AS Date), NULL, N'd', NULL, N'd', N'd', NULL)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (28, 18, N'a', N'a', CAST(0x75360B00 AS Date), NULL, N'a', NULL, N'a', N'a', NULL)
INSERT [ThamDinh] ([MaThamDinh], [MaHoSo], [NguoiThamDinh], [NguoiPhiaToChuc], [NgayThamDinh], [TinhHopLe], [NangLucNhanVien], [NangLucThietBi], [KetLuan], [KienNghi], [TinhTrangThamDinh]) VALUES (31, 19, N'Nguyễn Văn Lâm;
Cao Đăng Khoa', N'Nguyễn Thu Thủy;
Lê Đăng Thái', CAST(0x38350B00 AS Date), NULL, N'đủ điều kiện về nhân lực và thiết bị', NULL, N'đủ tiêu chuẩn cấp phép', N'Cấp giấy phép hoạt động', NULL)
SET IDENTITY_INSERT [ThamDinh] OFF
