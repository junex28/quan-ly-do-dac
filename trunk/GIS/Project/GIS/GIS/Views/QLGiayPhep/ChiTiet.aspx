<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.GiayPhepDetailModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Chi tiết giấy phép
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_19 alpha">
        <h3>
            Thông tin hồ sơ
            <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang < 3 || (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang > 3 && Model.giayphep.TinhTrangGiayPhep.MaTinhTrang < 6))
               {%>
            đăng ký giấy phép<% }
               else if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang >= 6 && Model.giayphep.TinhTrangGiayPhep.MaTinhTrang <= 8)
               {%>
            đăng ký bổ sung hoạt động<% }
               else if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang >= 9 && Model.giayphep.TinhTrangGiayPhep.MaTinhTrang <= 11)
               {%>
            đăng ký gia hạn<% }%>
        </h3>
        <div class="box">
            <h2>
                <a id="toggle-thongtinchung" href="#" style="cursor: pointer;">Thông tin chung</a>
            </h2>
            <div class="block" id="thongtinchung">
                <p>
                    <label class="grid_6">
                        Tên tổ chức/cá nhân :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.TenToChuc)%>
                </p>
                <p>
                    <label class="grid_6">
                        Quyết định thành lập/Giấy phép kinh doanh số :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.GiayPhepKinhDoanh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Hạng của doanh nghiệp :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.HangDoanhNghiep) %>
                </p>
                <p>
                    <label class="grid_6">
                        Vốn pháp định :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.VonPhapDinh) %>
                </p>
                <p>
                    <label class="grid_6">
                        Vốn lưu động :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.VonLuuDong) %>
                </p>
                <p>
                    <label class="grid_6">
                        Số tài khoản :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.SoTaiKhoan)%>
                </p>
                <p>
                    <label class="grid_6">
                        Tổng số cán bộ, công nhân viên (không kể cộng tác viên):
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.TongSoCanBo)%>
                </p>
                <p>
                    <label class="grid_6">
                        Trụ sở chính tại :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.TruSoChinh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Số điện thoại :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.DienThoai)%>
                </p>
                <p>
                    <label class="grid_6">
                        Fax :
                    </label>
                    .<%= Html.Encode(Model.giayphep.ThongTinChung.Fax)%>
                </p>
                <p>
                    <label class="grid_6">
                        Email :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.Email)%>
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
        <div class="box clearfix">
            <h2>
                <a id="A2" href="#" style="cursor: pointer;">Danh sách hoạt động đăng ký </a>
            </h2>
            <!-- Đăng ký hoạt động mới-->
            <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang < 3 || Model.giayphep.TinhTrangGiayPhep.MaTinhTrang == 4)
               {%>
            <div class="block clearfix" id="hoatdongdk">
                <p class="grid_7">
                    <label class="grid_6 alpha">
                        Danh sách đăng ký hoạt động mới:
                    </label>
                    <ul class="grid_6">
                        <% foreach (var item in Model.DangKy)
                           {%>
                        <li>
                            <%= item.HoatDong.TenHoatDong%></li>
                        <%} %>
                    </ul>
                </p>
            </div>
            <div class="block">
                <p>
                    <label class="grid_6">
                        Cam kết khi xin phép:
                    </label>
                    <%= Html.Encode(Model.giayphep.CamKet)%>
                </p>
            </div>
            <% }
               // Đăng ký hoạt động mới được cấp phép
               else if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang == 3 || Model.giayphep.TinhTrangGiayPhep.MaTinhTrang > 4)
               {%>
            <div class="block clearfix" id="Div1">
                <p class="grid_7">
                    <label class="grid_6 alpha">
                        Danh sách đã được cấp:
                    </label>
                    <ul class="grid_6">
                        <% foreach (var item in Model.DangKyDaCap)
                           {%>
                        <li>
                            <%= item.TenHoatDong%></li>
                        <%} %>
                    </ul>
                </p>
            </div>
            <%
                if (Model.DangKyBoSung != null)
                { %>
            <div class="block clearfix" id="Div1">
                <p class="grid_7">
                    <label class="grid_6 alpha">
                        Danh sách bổ sung:
                    </label>
                    <ul class="grid_6">
                        <% foreach (var item in Model.DangKyBoSung)
                           {
                        %>
                        <li>
                            <%= item.TenHoatDong%></li>
                        <%} %>
                    </ul>
                </p>
            </div>
            <%} %>
            <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang >= 9 && Model.giayphep.TinhTrangGiayPhep.MaTinhTrang <= 11)
               { %>
            <div class="block">
                <p>
                    <label class="grid_6">
                        Lý do xin phép gia hạn:
                    </label>
                    <%= Html.Encode(Model.giayphep.LyDo)%>
                </p>
            </div>
            <%}
               if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang >= 6 && Model.giayphep.TinhTrangGiayPhep.MaTinhTrang >= 8)
               { %>
            <div class="block clearfix" id="Div2">
                <p class="grid_7">
                    <label class="grid_6 alpha">
                        Danh sách hoạt động xin bổ sung đang xét:
                    </label>
                    <ul class="grid_6">
                        <% foreach (var item in Model.DangKy)
                           {
                        %>
                        <li>
                            <%= item.HoatDong.TenHoatDong%></li>
                        <%} %>
                    </ul>
                </p>
            </div>
            <div class="block">
                <p>
                    <label class="grid_6">
                        Lý do xin bổ sung hoạt động:
                    </label>
                    <%= Html.Encode(Model.giayphep.LyDo)%>
                </p>
            </div>
            <%} %>
            <div class="block">
                <p>
                    <label class="grid_6">
                        Cam kết:
                    </label>
                    <%= Html.Encode(Model.giayphep.CamKet)%>
                </p>
            </div>
        </div>
        <% }%>
        <div class="box">
            <div class="block prefix_4">
                <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                    <span class="back">Trở về</span></button>
                <button id="thamdinhButton" class="button redmond">
                    <span class="validation">Thẩm định</span></button>
            </div>
        </div>
    </div>
          <% using (Html.BeginForm("ThamDinh", "ThamDinh", FormMethod.Post, new { id = "thamdinhForm" })) { } %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">
        $(function() {
            $('#thamdinhButton').click(function() {
                $('#thamdinhForm').submit();
            });

            $('#thamdinhForm').submit(
            function() {

                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("name", "id");
                input.setAttribute("value", "<%=Model.giayphep.MaHoSo%>");
                $(this).append(input);
                return true;
            });
        });
        
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

</asp:Content>
