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
            <%= Html.Encode(Model.giayphep.ToChuc.VonPhapDinh) %>
        </p>
        <p>
            <label class="grid_6">
                Vốn lưu động :
            </label>
            <%= Html.Encode(Model.giayphep.ToChuc.VonLuuDong) %>
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
<div class="box">
    <h2>
        <a id="toggle-hoso" href="#" style="cursor: pointer;">Hồ sơ đính kèm</a>
    </h2>
    <div class="block" id="hoso">
        <p>
            <label class="grid_6">
                Hồ sơ đăng ký đính kèm :
            </label>
            <%= Html.Encode(Model.giayphep.TepDinhKem) %>
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
    function doAjaxPageNangLuc(pageNo, tcid) {
        $("#nanglucresult").load("/nangluc/dsnanglucs", { page: pageNo, tcid: tcid });
    }

    function doAjaxPageNhanLuc(pageNo, tcid) {
        $("#nhanlucresult").load("/nhanluc/dsnhanlucs", { page: pageNo, tcid: tcid });
    }

    function doAjaxPageThietBi(pageNo, tcid) {
        $("#thietbiresult").load("/thietbi/dsthietbis", { page: pageNo, tcid: tcid });
    }

    $(document).ready(function() {
        var tcid = '<%=Model.giayphep.ToChuc.MaToChuc%>';
        doAjaxPageNangLuc(1, tcid);
        doAjaxPageNhanLuc(1, tcid);
        doAjaxPageThietBi(1, tcid);
    });
</script>