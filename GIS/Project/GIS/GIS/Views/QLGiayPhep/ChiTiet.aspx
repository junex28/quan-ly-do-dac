<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.GiayPhepDetailModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Chi tiết giấy phép
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_19 alpha">
        <h3>
            Thông tin hồ sơ</h3>
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
            <div class="box">
                <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                    <span class="back">Trở về</span></button>
                <button id="thamdinhButton" class="button redmond" onclick="">
                    <span class="validation">Thẩm định</span></button>
            </div>
          </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

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

</asp:Content>