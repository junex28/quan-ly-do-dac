<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thay đổi thông tin tổ chức
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
    $(function()  {
     $('#capnhatButton').click(function() { 
      $('#capnhatForm').submit(); });
      
            $('#capnhatForm').submit(
                function() {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", "<%=Model.toChuc.MaToChuc%>");
                    $(this).append(input);
                    return true;
                    });
                });
       </script>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.EnableClientValidation(); %>
    <%= Html.ValidationSummary(true, "Cập nhật Tài Khoản thất bại. Xin vui lòng sửa lỗi và nhập lại.") %>
    <% using (Html.BeginForm("CapNhat", "ToChuc", FormMethod.Post, new { id = "capnhatForm" }))
       { %>
    <div class="grid_19 alpha">
        <h3>
            Cập Nhật Tổ chức</h3>
        <div class="clear">
        </div>
        <div class="box">
            <div class="block">
                <p>
                    <label class="grid_6">
                        Tên tổ chức
                    </label>
                    <%= Html.TextBoxFor(m => m.toChuc.TenToChuc, new { @disabled = "disabled" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.TenToChuc)%>
                </p>
                <p>
                    <label class="grid_6">
                        Loại hình tổ chức
                    </label>
                    <%= Html.DropDownListFor(m => m.MaLoaiHinhToChuc, new SelectList(Model.loaiHinh, "MaLoaiHinhToChuc", "TenLoaiHinhToChuc", Model.MaLoaiHinhToChuc), new { style = "padding: 0.5em; background-color: #FFFFFF;border: 1px solid #BBBBBB;" })%>
                </p>
                <p>
                    <label class="grid_6">
                        Người đại diện
                    </label>
                    <%= Html.TextBoxFor(m => m.toChuc.NguoiDaiDien, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.NguoiDaiDien)%>
                </p>
                <p>
                    <label class="grid_6">
                        Trụ sở chính
                    </label>
                    <%= Html.TextBoxFor(m => m.toChuc.TruSoChinh, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.TruSoChinh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Hạng doanh nghiệp
                    </label>
                    <%= Html.TextBoxFor(m => m.toChuc.HangDoanhNghiep, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.HangDoanhNghiep)%>
                </p>
                <p>
                    <label class="grid_6">
                        Vốn pháp định
                    </label>
                    <%= Html.TextBox("VonPhapDinh", string.Format("{0:0}", Model.toChuc.VonPhapDinh), new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.VonPhapDinh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Vốn lưu động
                    </label>
                    <%= Html.TextBox("VonLuuDong", string.Format("{0:0}", Model.toChuc.VonLuuDong), new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.VonLuuDong)%>
                </p>
                <p>
                    <label class="grid_6">
                        Điện thoại
                    </label>
                    <%= Html.TextBoxFor(m => m.toChuc.DienThoai, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.DienThoai)%>
                </p>
                <p>
                    <label class="grid_6">
                        Fax
                    </label>
                    <%= Html.TextBoxFor(m => m.toChuc.Fax, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.Fax)%>
                </p>
                <p>
                    <label class="grid_6">
                        Email
                    </label>
                    <%= Html.TextBoxFor(m => m.toChuc.Email, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.Email)%>
                </p>
                <p>
                    <label class="grid_6">
                        Số tài khoản
                    </label>
                    <%= Html.TextBoxFor(m => m.toChuc.SoTaiKhoan, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.SoTaiKhoan)%>
                </p>
                <p>
                    <label class="grid_6">
                        Tổng số cán bộ
                    </label>
                    <%= Html.TextBoxFor(m => m.toChuc.TongSoCanBo, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.toChuc.TongSoCanBo)%>
                </p>
                <% } %>
            </div>
        </div>
        <div class="box">
            <div class="block prefix_4">
                <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                    <span class="back">Thoát</span></button>
                <button id="capnhatButton" class="button redmond">
                    <span class="edit">Cập nhật</span></button>
            </div>
        </div>
        </div>
</asp:Content>
