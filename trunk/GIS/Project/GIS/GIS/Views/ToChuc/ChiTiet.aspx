<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Chi tiết tổ chức
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_19 alpha">
        <div class="box">
            <h2>
                <a id="toggle-thamdinh" href="#" style="cursor: pointer;">Chi tiết tổ chức</a>
            </h2>
            <div class="block" id="thamdinh">
                <% using (Html.BeginForm())
                   {%>
                <p>
                    <label class="grid_6">
                        Tên tổ chức :
                    </label>
                    <%=Html.Encode(Model.toChuc.TenToChuc)%>
                </p>
                <p>
                    <label class="grid_6">
                        Giấy phép kinh doanh :
                    </label>
                    <%= Html.Encode(Model.toChuc.GiayPhepKinhDoanh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Hạng doanh nghiệp:
                    </label>
                    <%= Html.Encode(Model.toChuc.HangDoanhNghiep)%>
                </p>
                <p>
                    <label class="grid_6">
                        Người đại diện :
                    </label>
                    <%= Html.Encode(Model.toChuc.NguoiDaiDien)%>
                </p>
                <p>
                    <label class="grid_6">
                        Trụ sở chính :
                    </label>
                    <%= Html.Encode(Model.toChuc.TruSoChinh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Số tài khoản:
                    </label>
                    <%= Html.Encode(Model.toChuc.SoTaiKhoan)%>
                </p>
                <p>
                    <label class="grid_6">
                        Số điện thoại :
                    </label>
                    <%= Html.Encode(Model.toChuc.DienThoai)%>
                </p>
                <p>
                    <label class="grid_6">
                        Fax :
                    </label>
                    <%= Html.Encode(Model.toChuc.Fax)%>
                </p>
                 <p>
                    <label class="grid_6">
                        Email :
                    </label>
                    <%= Html.Encode(Model.toChuc.Email)%>
                </p>
                 <p>
                    <label class="grid_6">
                        Tổng số cán bộ :
                    </label>
                    <%= Html.Encode(Model.toChuc.TongSoCanBo)%>
                </p>
                <p>
                    <label class="grid_6">
                        Vốn pháp định:
                    </label>
                    <%= Html.Encode(Model.toChuc.VonPhapDinh)%>
                </p>
                <p>
                    <label class="grid_6">
                       Vốn lưu động :
                    </label>
                    <%= Html.Encode(Model.toChuc.VonLuuDong)%>
                </p>
                
                <%} %>
            </div>
        </div>
        <div class="box">
            <div class="block prefix_4">
                <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                    <span class="back">Thoát</span></button>
            </div>
        </div>
    </div>
</asp:Content>
<%--
        <%= Html.ActionLink("Edit", "Edit", new { id=Model.toChuc.MaToChuc }) %>
        |
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>
</asp:Content>--%>