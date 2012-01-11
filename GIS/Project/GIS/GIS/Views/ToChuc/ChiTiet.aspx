<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thay đổi thông tin tổ chức
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <fieldset>
        <legend>Tổ chức</legend>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TenToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.TenToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.GiayPhepKinhDoanh)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.GiayPhepKinhDoanh)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.LoaiHinhToChuc.TenLoaiHinhToChuc)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.LoaiHinhToChuc.TenLoaiHinhToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TruSoChinh)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.TruSoChinh)%></div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.NguoiDaiDien)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.NguoiDaiDien)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.DienThoai)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.DienThoai)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.Email)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.Email)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.Fax)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.Fax)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.SoTaiKhoan)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.SoTaiKhoan)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TongSoCanBo)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.TongSoCanBo)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.KichHoat)%>
            </div>
            <div class="editor-field">
                <% if (Model.toChuc.KichHoat == true)
                   {%>
                Kích hoạt
                <% }
                   else %>
                Không kich hoạt
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.NgayXinPhep)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.NgayXinPhep)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TepDinhKem)%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.TepDinhKem)%>
            </div>
        </div>
        
    </fieldset>
    <p>
        <%= Html.ActionLink("Edit", "Edit", new { id=Model.toChuc.MaToChuc }) %>
        |
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>
</asp:Content>