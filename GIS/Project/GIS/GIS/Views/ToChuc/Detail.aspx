<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

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
                <%= Html.LabelFor(model => model.toChuc.TenToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.TenToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.GiayPhepKinhDoanh) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.GiayPhepKinhDoanh)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.LoaiHinhToChuc.TenLoaiHinhToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.LoaiHinhToChuc.TenLoaiHinhToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TruSoChinh) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.TruSoChinh)%></div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.NguoiDaiDien) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.NguoiDaiDien)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.DienThoai) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.DienThoai)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.Email) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.Email)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.Fax) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.Fax)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.SoTaiKhoan) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.SoTaiKhoan)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TongSoCanBo) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.TongSoCanBo)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.KichHoat) %>
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
                <%= Html.LabelFor(model => model.toChuc.NgayXinPhep) %>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.toChuc.NgayXinPhep)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TepDinhKem) %>
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
</body>
</html>
