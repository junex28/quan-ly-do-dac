<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.TaiKhoanEditViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    CapNhat
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.EnableClientValidation(); %>
    <%= Html.ValidationSummary(true, "Cập nhật Tài Khoản thất bại. Xin vui lòng sửa lỗi và nhập lại.") %>
    <% using (Html.BeginForm("CapNhat", "QLTaiKhoan", FormMethod.Post, new {id ="capnhatForm"}))
       {  %>
    <div class="grid_19 alpha">
        <h3>
            Cập Nhật Tài Khoản</h3>
        <div class="clear">
        </div>
        <div class="box">
            <div class="block">
                <p>
                    <label class="grid_6">
                        Tên tài khoản
                    </label>
                    <%= Html.TextBoxFor(m => m.TenTaiKhoan, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.TenTaiKhoan) %>
                </p>
                <p>
                    <label class="grid_6">
                        Địa chỉ email
                    </label>
                    <%= Html.TextBoxFor(m => m.Email, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.Email) %>
                </p>
                <p>
                    <label class="grid_6">
                        Họ và tên
                    </label>
                    <%= Html.TextBoxFor(m => m.HoTen, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.HoTen) %>
                </p>
                <p>
                    <label class="grid_6">
                        Địa chỉ
                    </label>
                    <%= Html.TextBoxFor(m => m.DiaChi, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.DiaChi) %>
                </p>
                <p>
                    <label class="grid_6">
                        Số CMND
                    </label>
                    <%= Html.TextBoxFor(m => m.CMND, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.CMND) %>
                </p>
                <p>
                    <label class="grid_6">
                        Cơ quan
                    </label>
                    <%= Html.TextBoxFor(m => m.CoQuan, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m => m.CoQuan) %>
                </p>
                <p>
                    <label class="grid_6">
                        Nhóm người dùng
                    </label>
                    <%= Html.DropDownListFor(m => m.MaNhom, new SelectList(Model.nhomNguoiDung, "MaNhom", "TenNhom", Model.MaNhom), new { style = "padding: 0.5em; background-color: #FFFFFF;border: 1px solid #BBBBBB;" })%>
                </p>
                <p>
                    <label class="grid_6">
                        Tình trạng tài khoản
                    </label>
                    <%= Html.DropDownListFor(m => m.MaTinhTrang, new SelectList(Model.tinhtrangTaiKhoan, "MaTinhTrang", "DienGiai", Model.MaTinhTrang), new { style = "padding: 0.5em; background-color: #FFFFFF;border: 1px solid #BBBBBB;" })%>
                </p>
                <div class="box">
                    <div class="block prefix_4">
                        <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                            <span class="back">Thoát</span></button>
                        <button id="capnhatButton" class="button redmond">
                            <span class="edit">Cập nhật</span></button>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">
    $(function()  {
     $('#capnhatButton').click(function() { 
      $('#capnhatForm').submit(); });
      
            $('#capnhatForm').submit(
                function() {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", "<%=Model.MaTaiKhoan%>");
                    $(this).append(input);
                    return true;
                    });
                });
    </script>

</asp:Content>
