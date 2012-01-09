<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.GiayPhepDetailModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Chi tiết giấy phép
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_19 alpha">
        <h3>
            Thông tin giấy phép</h3>
        <div class="box">
            <h2>
                <a id="toggle-thongtinchung" href="#" style="cursor: pointer;">Thông tin chung</a>
            </h2>
            <div class="block" id="thongtinchung">
                <p>
                    <label>
                        Tên tổ chức/cá nhân :
                    </label>
                    {tochuc.TenToChuc}
                </p>
                <p>
                    <label>
                        Quyết định thành lập/Giấy phép kinh doanh số :
                    </label>
                    {tochuc.GiayPhepKinhDoanh}
                </p>
                <p>
                    <label>
                        Hạng của doanh nghiệp :
                    </label>
                    {tochuc.HangDoanhNghiep}(thiếu)
                </p>
                <p>
                    <label>
                        Vốn pháp định :
                    </label>
                    {tochuc.VonPhapDinh}(thiếu)
                </p>
                <p>
                    <label>
                        Vốn lưu động :
                    </label>
                    {tochuc.VonLuuDong}(thiếu)
                </p>
                <p>
                    <label>
                        Số tài khoản :
                    </label>
                    {tochuc.SoTaiKhoan}
                </p>
                <p>
                    <label>
                        Tổng số cán bộ, công nhân viên (không kể cộng tác viên:
                    </label>
                    {tochuc.TongSoCanBo}
                </p>
                <p>
                    <label>
                        Trụ sở chính tại :
                    </label>
                    {tochuc.TruSoChinh}
                </p>
                <p>
                    <label>
                        Số điện thoại :
                    </label>
                    {tochuc.SoDienThoai}
                </p>
                <p>
                    <label>
                        Fax :
                    </label>
                    {tochuc.Fax}
                </p>
                <p>
                    <label>
                        Email :
                    </label>
                    {tochuc.Email}
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
                    c. Danh sách người chịu trách nhiệm trước pháp luật và người phụ trách kỹ thuật
                    chính</h5>
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
                    <label>
                        Hồ sơ đăng ký hoạt động đính kèm :
                    </label>
                    {tochuc.TenToChuc}
                </p>
            </div>
        </div>
        <div class="box">
            <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                <span class="back">Trở về</span></button>
            <button id="thamdinhButton" class="button redmond" onclick="">
                <span class="validation">Thẩm định</span></button>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">

        function doAjaxPageNangLuc(pageNo,tcid) {
            $("#nanglucresult").load("/nangluc/dsnanglucs", { page: pageNo, tcid: tcid });
        }

        function doAjaxPageNhanLuc(pageNo) {
            $("#nhanlucresult").load("/nhanluc/dsnhanlucs?tcid=1", { page: pageNo });
        }

        function doAjaxPageThietBi(pageNo) {
            $("#thietbiresult").load("/thietbi/dsthietbis?tcid=1", { page: pageNo });
        }

        $(document).ready(function() {
			var tcid = '<%=Model.giayphep.ToChuc.MaToChuc%>';
            doAjaxPageNangLuc(1, tcid);
            doAjaxPageNhanLuc(1);
            doAjaxPageThietBi(1);
        });
        
    </script>

</asp:Content>
<%--   <h2>
        Detail</h2>
    <fieldset>
        <legend>Thông Tin xin phép</legend>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.ToChuc.TenToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.ToChuc.TenToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.SoGiayPhep) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.SoGiayPhep)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.NgayXinPhep) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.NgayXinPhep.Value.ToShortDateString())%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.LyDoXinPhep) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.LyDoXinPhep)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.CamKetXinPhep) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.CamKetXinPhep)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.TepDinhKem) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.TepDinhKem)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
               Lịch sử thẩm định:
            </div>
            <div class="editor-field">
              <%= Html.ActionLink("Danh sách biên bản thẩm định của tổ chức", "Index", "ThamDinh", new { id = Model.giayphep.MaGiayPhepHoatDong },null)%>
            </div>
        </div>
        <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang > 3)
           { %>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.NgayCapPhep)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.NgayCapPhep.Value.ToShortDateString())%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.LyDoCapPhep)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.LyDoCapPhep)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.NgayHetHan)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.NgayHetHan.Value.ToShortDateString())%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.Encode("Tình trạng hiện tại")%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.TinhTrangGiayPhep.DienGiai)%>
            </div>
        </div>
        <% } %>
    </fieldset>
    <% if (Model.giayphep.NgayGiaHan != null || Model.giayphep.LyDoGiaHan != null || Model.giayphep.CamKetGiaHan != null)
       {%>
    <fieldset>
        <legend>Thông Tin gia hạn</legend>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.NgayXinGiaHan)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.NgayXinGiaHan.Value.ToShortDateString())%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.LyDoGiaHan)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.LyDoGiaHan)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.giayphep.CamKetGiaHan)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.CamKetGiaHan)%>
            </div>
        </div>
    </fieldset>
    <%} %>
    <fieldset>
        <legend>Thông Tin đăng ký hoạt động</legend>
        <table frame="border">
            <tr>
                <td> Mã đăng ký </td>
                <td> Tên hoạt động </td>
                <td> Loại hoạt động</td>
                <td> Ngày bổ sung </td>
                <td> Tình trạng </td>
            </tr>
            <% foreach (var item in Model.DangKy)
               {%>
            <tr>
                <% String str="";
               if (item.LaBoSung != null)
               {
                   if (item.LaBoSung == true)
                       str = "Bổ sung";
                   else str="Không phải bổ sung";
               }%>
                <td> <%=Html.Encode(item.MaDangKyHoatDong)%> </td>
                <td> <%=Html.Encode(item.HoatDong.TenHoatDong)%> </td>
                <td> <%=Html.Encode(str)%> </td>
                <td> <%=Html.Encode(item.NgayBoSung.Value.ToShortDateString())%> </td>
                <td> <%=Html.Encode(item.TinhTrangXetDuyet.DienGiai)%> </td>
            </tr>
            <%} %>
        </table>
    </fieldset>
    <p>
        <%= Html.ActionLink("Edit", "Edit", new { /* id=Model.PrimaryKey */ }) %>
      
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>--%>
<%--
<table border="0">
                        <tr>
	                        <td>TT</td>
	                        <td>Ngành, nghề</td>
	                        <td>Đại học trở lên</td>
	                        <td>Trung cấp</td>
	                        <td>Công nhân kỹ thuật</td>
	                        <td>Loại khác</td>
	                     </tr>
	                     
	                     </table>--%>