<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<GIS.ViewModels.GiayPhepDetailModel>" %>
<div class="box">
    <h2>
        <a id="toggle-thongtinchung" href="#" style="cursor: pointer;">Thông tin chung</a>
    </h2>
    <div class="block" id="thongtinchung">
        <p>
            <label class="grid_6">
                Tên tổ chức/cá nhân :
            </label>
            <%= Html.Encode(Model.giayphep.ToChuc.TenToChuc)%>
        </p>
        <p>
            <label class="grid_6">
                Quyết định thành lập/Giấy phép kinh doanh số :
            </label>
            <%= Html.Encode(Model.giayphep.ToChuc.GiayPhepKinhDoanh)%>
        </p>
        <p>
            <label class="grid_6">
                Hạng của doanh nghiệp :
            </label>
            <%= Html.Encode(Model.giayphep.ToChuc.HangDoanhNghiep) %>
        </p>
        <p>
            <label class="grid_6">
                Vốn pháp định :
            </label>
            <%= Html.Encode(string.Format("{0:0,0}", Model.giayphep.ToChuc.VonPhapDinh)) %>
        </p>
        <p>
            <label class="grid_6">
                Vốn lưu động :
            </label>
            <%= Html.Encode(string.Format("{0:0,0}", Model.giayphep.ToChuc.VonLuuDong)) %>
        </p>
        <p>
            <label class="grid_6">
                Số tài khoản :
            </label>
            <%= Html.Encode(Model.giayphep.ToChuc.SoTaiKhoan)%>
        </p>
        <p>
            <label class="grid_6">
                Tổng số cán bộ, công nhân viên (không kể cộng tác viên):
            </label>
            <%= Html.Encode(Model.giayphep.ToChuc.TongSoCanBo)%>
        </p>
        <p>
            <label class="grid_6">
                Trụ sở chính tại :
            </label>
            <%= Html.Encode(Model.giayphep.ToChuc.TruSoChinh)%>
        </p>
        <p>
            <label class="grid_6">
                Số điện thoại :
            </label>
            <%= Html.Encode(Model.giayphep.ToChuc.DienThoai)%>
        </p>
        <p>
            <label class="grid_6">
                Fax :
            </label>
            <%= Html.Encode(Model.giayphep.ToChuc.Fax)%>
        </p>
        <p>
            <label class="grid_6">
                Email :
            </label>
            <%= Html.Encode(Model.giayphep.ToChuc.Email)%>
        </p>
    </div>
</div>
<div class="box">
    <h2>
        <a id="toggle-nangluc" href="#" style="cursor: pointer;">Kê khai năng lực</a>
    </h2>
    <div class="block" id="nangluc">
        <h4>
            1. Lực lượng kỹ thuật</h4>
        <h5>
            a. Lực lượng kỹ thuật phân tích theo ngành nghề</h5>
        <div class="box">
            <div id="nanglucresult">
            </div>
        </div>
        <h5>
            b. Danh sách người chịu trách nhiệm trước pháp luật và người phụ trách kỹ thuật
            chính</h5>
        <div class="box">
            <div id="nhanlucresult">
            </div>
        </div>
        <h5>
            c. Danh sách thiết bị công nghệ</h5>
        <div class="box">
            <div id="thietbiresult">
            </div>
        </div>
    </div>
</div>
<!-- Kiểm tra loại giấy phép -->
 <%     
     if (Model.giayphep.LoaiGiayPhep == 2 || Model.giayphep.LoaiGiayPhep == 3)
     {
          var bchd = Model.giayphep.ThongTinChung.BaoCaoHoatDongs.SingleOrDefault(m => m.MaThongTinChung == Model.giayphep.MaThongTinChung);
           %>
        <div class="box">
            <h2>
                <a id="toggle-baocaothhd" href="#" style="cursor: pointer;">Báo cáo tình hình hoạt động</a>
            </h2>
            <div class="block" id="baocaothhd">
                 <p>
                    <label class="grid_2 prefix_4">
                        Từ năm:<%= bchd == null || bchd.TuNam == null ? "" : bchd.TuNam.Value.ToString() %>
                    </label>
                    
                    <label class="grid_3">
                        Đến năm:<%= bchd == null || bchd.DenNam == null ? "" : bchd.DenNam.Value.ToString() %>
                    </label>
                </p>
                <p>
                    <label class="grid_6">Doanh thu năm:</label>
                    <%= bchd == null || bchd.DoanhThu == null ? "" : string.Format("{0:0,0}", bchd.DoanhThu.Value) %>
                </p>
                <p>
                    <label class="grid_6">Nộp ngân sách:</label>
                    <%= bchd == null || bchd.NopNganSach == null ? "" : string.Format("{0:0,0}", bchd.NopNganSach.Value)%>
               </p>
                 <h5>Danh sách công trình đã thực hiện</h5>
        <div class="box">
            <div id="congtrinhresult">
            </div>
        </div>
            </div>
        </div>
        <%} %>
<div class="box">
    <h2>
        <a id="toggle-hoso" href="#" style="cursor: pointer;">Hồ sơ đính kèm</a>
    </h2>
    <div class="block" id="hoso">
        <p>
            <label class="grid_6">
                Hồ sơ đăng ký đính kèm :
            </label>
            <% if (Model.giayphep.TepDinhKem == null || Model.giayphep.TepDinhKem == "")
               { %>
                  Không có tệp đính kèm
            <%}
               else
               {%>
                     <%= Html.ActionLink("Download", "Download","QLGiayPhep", new { fn = Model.giayphep.TepDinhKem },null)%>
            <%} %>
        </p>
    </div>
</div>
<!-- Đăng ký hoạt động mới-->
<% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang == 1)
   {%>
<div class="box clearfix">
    <h2>
        <a id="toggle-hoatdongdk" href="#" style="cursor: pointer;">Danh sách hoạt động đăng
            ký mới </a>
    </h2>
    <div class="block clearfix" id="hoatdongdk">
        <p class="grid_7">
            <label class="grid_6 alpha">
                Danh sách đăng ký hoạt động:
            </label>
            <ul class="grid_6">
            <%foreach (var item in Model.DangKy)
              {
                   %>
                <li><%=item.HoatDong.TenHoatDong %></li>
                <%} %>
            </ul>
        </p>
    </div>
    <div class="block">
        <p>
            <label class="grid_6">
                Cam kết:
            </label>
            <%= Html.Encode(Model.giayphep.CamKet)%>
        </p>
    </div>
</div>
<!-- Đăng ký bổ sung hoạt động-->
<% }
   else if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang == 6)
   {%>
<div class="box clearfix">
    <h2>
        <a id="toggle-danhsachhd" href="#" style="cursor: pointer;">Danh sách hoạt động hiện
            tại </a>
    </h2>
    <div class="block clearfix" id="danhsachhd">
        <p class="grid_7">
            <label class="grid_6 alpha">
                Danh sách hoạt động :
            </label>
            <ul class="grid_6">
                <% foreach (var item in Model.DangKyDaCap)
                   {%>
                <li><%=item.TenHoatDong%></li>
                <%} %>
            </ul>
        </p>
    </div>
</div>
<div class="box clearfix">
    <h2>
        <a id="toggle-hoatdongdk" href="#" style="cursor: pointer;">Danh sách hoạt động đăng
            ký bổ sung </a>
    </h2>
    <div class="block clearfix" id="hoatdongdk">
        <p class="grid_7">
            <label class="grid_6 alpha">
                Danh sách hoạt động bổ sung:
            </label>
            <ul class="grid_6">
               <%foreach (var item in Model.DangKy)
                 { %>
                <li><%= item.HoatDong.TenHoatDong %></li>
                <%}
                 foreach (var item in Model.DangKyBoSung)
                 {%>
                <li><%=item.TenHoatDong%></li>
                <%} %>
            </ul>
        </p>
    </div>
    <div class="block">
        <p>
            <label class="grid_6">
                Cam kết:
            </label>
            <%= Html.Encode(Model.giayphep.CamKet)%>
        </p>
    </div>
</div>
<!-- Đăng ký gia hạn giấy phép-->
<% }
   else if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang == 9 )
   {%>
<div class="box clearfix">
    <h2>
        <a id="toggle-danhsachhd" href="#" style="cursor: pointer;">Danh sách hoạt động hiện
            tại </a>
    </h2>
    <div class="block clearfix" id="danhsachhd">
        <p class="grid_7">
            <label class="grid_6 alpha">
                Danh sách hoạt động :
            </label>
            <ul class="grid_6">
            <%foreach (var item in Model.DangKy)
                 { %>
                <li><%= item.HoatDong.TenHoatDong %></li>
                <%}
                 foreach (var item in Model.DangKyBoSung)
                 {%>
                <li><%=item.TenHoatDong%></li>
                <%} %>
            </ul>
        </p>
    </div>
</div>
<div class="box clearfix">
    <h2>
        <a id="toggle-hoatdongdk" href="#" style="cursor: pointer;">Thông tin gia hạn </a>
    </h2>
    <div class="block clearfix" id="hoatdongdk">
        <p>
            <label class="grid_6">
                Lý do xin gia hạn:
            </label>
            <%= Html.Encode(Model.giayphep.LyDo)%>
        </p>
        <p>
            <label class="grid_6">
                Cam kết xin gia hạn:
            </label>
            <%= Html.Encode(Model.giayphep.CamKet)%>
        </p>
    </div>
</div>

<% }%>
<script type="text/javascript">
    function doAjaxPageNangLuc(pageNo, ttcid) {
        $("#nanglucresult").load("/nangluc/dsnanglucs", { page: pageNo, ttcid: ttcid });
    }

    function doAjaxPageNhanLuc(pageNo, ttcid) {
        $("#nhanlucresult").load("/nhanluc/dsnhanlucs", { page: pageNo, ttcid: ttcid });
    }

    function doAjaxPageThietBi(pageNo, ttcid) {
        $("#thietbiresult").load("/thietbi/dsthietbis", { page: pageNo, ttcid: ttcid });
    }

    function doAjaxPageCongTrinh(pageNo, bcid) {
        $("#congtrinhresult").load("/bccongtrinh/dscongtrinh", { page: pageNo, bcid: bcid });
    }

    $(document).ready(function() {
        var ttcid = '<%=Model.giayphep.ThongTinChung.MaThongTinChung%>';
        var bcid = '<%= Model.MaBaoCao %>';
        doAjaxPageNangLuc(1, ttcid);
        doAjaxPageNhanLuc(1, ttcid);
        doAjaxPageThietBi(1, ttcid);
        doAjaxPageCongTrinh(1, bcid);
    });
</script>