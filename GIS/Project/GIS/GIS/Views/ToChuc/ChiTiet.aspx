<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chi tiết tổ chức</title>
    <link rel="stylesheet" type="text/css" media="screen" href="../../Content/redmond/jquery-ui-1.8.16.custom.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../../Content/ui.jqgrid.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../../Content/Site.css" />

    <script src="../../Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>

    <script src="../../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>

</head>
<body>
    <fieldset>
        <legend>Tổ chức</legend>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.TenToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.TenToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.GiayPhepKinhDoanh) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.GiayPhepKinhDoanh)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.LoaiHinhToChuc.TenLoaiHinhToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.LoaiHinhToChuc.TenLoaiHinhToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.TruSoChinh) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.TruSoChinh)%></div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.NguoiDaiDien) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.NguoiDaiDien)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.DienThoai) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.DienThoai)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Email) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.Email)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Fax) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.Fax)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.SoTaiKhoan) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.SoTaiKhoan)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.TongSoCanBo) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.TongSoCanBo)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.KichHoat) %>
            </div>
            <div class="editor-field">
                <% if (Model.toChuc.KichHoat == true)
                   {%>
                Bật
                <% }
                   else %>
                Tắt
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.NgayXinPhep) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.NgayXinPhep)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.TepDinhKem) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.TepDinhKem)%>
            </div>
        </div>
    </fieldset>
    <p>
        <%= Html.ActionLink("Edit", "Edit", new { id=Model.MaToChuc }) %>
        |
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>
</body>
</html>
