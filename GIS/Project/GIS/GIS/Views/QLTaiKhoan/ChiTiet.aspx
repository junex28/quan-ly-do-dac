<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.Models.TaiKhoan>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    ChiTiet
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_19 alpha">
        <h3>
            Thông tin Tài Khoản</h3>
        <div class="clear">
        </div>
        <div class="box">
            <h2>
                <a id="toggle-thongtinchung" href="#" style="cursor: pointer;">Thông tin</a>
            </h2>
            <div class="block">
                <p>
                    <label class="grid_6">
                        Tên tài khoản
                    </label>
                    <%= Html.Encode(Model.TenTaiKhoan)%>
                </p>
                <p>
                    <label class="grid_6">
                        Địa chỉ email
                    </label>
                    <%= Html.Encode(Model.Email)%>
                </p>
                <p>
                    <label class="grid_6">
                        Họ và tên
                    </label>
                    <%= Html.Encode(Model.HoTen)%>
                </p>
                <p>
                    <label class="grid_6">
                        Địa chỉ
                    </label>
                    <%= Html.Encode(Model.DiaChi)%>
                </p>
                <p>
                    <label class="grid_6">
                        Số CMND
                    </label>
                    <%= Html.Encode(Model.CMND)%>
                </p>
                <p>
                    <label class="grid_6">
                        Tên cơ quan
                    </label>
                    <%= Html.Encode(Model.CoQuan)%>
                </p>
                <p>
                    <label class="grid_6">
                        Tình trạng tài khoản
                    </label>
                    <%= Html.Encode(Model.TinhTrangTaiKhoan.DienGiai)%>
                </p>
                <p>
                    <label class="grid_6">
                        Nhóm người dùng
                    </label>
                    <%= Html.Encode(Model.NhomNguoiDung1.TenNhom)%>
                </p>
            </div>
            <div class="box">
                <div class="block prefix_4">
                    <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                        <span class="back">Thoát</span></button>
                </div>
                <div class="block prefix_4">
                    <button id="editButton" class="button redmond" onclick="">
                        <span class="back">Chỉnh sửa </span>
                    </button>
                </div>
            </div>
        </div>
         <% using (Html.BeginForm("CapNhat", "QLTaiKhoan", FormMethod.Get, new { id = "editForm" })) { } %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
    $(function() {
        $('#editButton').click(function() {
            $('#editForm').submit();
        });
        $('#editForm').submit(function() {
            var input = document.createElement("input");
            input.setAttribute("type", "hidden");
            input.setAttribute("name", "id");
            input.setAttribute("value", "<%= Model.MaTaiKhoan %>");
            $(this).append(input);
            return true;
        });

    });
</script>
</asp:Content>
