<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.RegisterViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Thông tin tài khoản
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_19 alpha">
        <h3>
            Thông tin Tài Khoản</h3>
        <div class="clear">
        </div>
        <div class="box">
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
                    <%= Html.Encode(Model.Coquan)%>
                </p>
            </div>
        </div>
        <div class="box">
            <div class="block prefix_4">
                <button id="backButton" class="button redmond" onclick="window.location.href='/TrangChu/Index'">
                    <span class="back">Thoát</span></button>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">
    </script>

</asp:Content>
