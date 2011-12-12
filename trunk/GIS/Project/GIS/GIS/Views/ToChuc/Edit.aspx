<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thay đổi thông tin tổ chức</title>
    <link rel="stylesheet" type="text/css" media="screen" href="../../Content/redmond/jquery-ui-1.8.16.custom.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../../Content/ui.jqgrid.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../../Content/Site.css" />

    <script src="../../Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>

    <script src="../../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>

</head>
<body>
    <% using (Html.BeginForm())
       {%>
    <%= Html.ValidationSummary(true) %>
    <fieldset class="editor-form">
        <legend>Tổ chức</legend>
        <%= Html.Hidden("MaToChuc",Model.toChuc.MaToChuc) %>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TenToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("TenToChuc",Model.toChuc.TenToChuc, new { @disabled = "disabled" })%>
                <%= Html.ValidationMessageFor(model => model.toChuc.TenToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.GiayPhepKinhDoanh) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("GiayPhepKinhDoanh",Model.toChuc.GiayPhepKinhDoanh)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.GiayPhepKinhDoanh)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label" disabled='disabled'>
                <%= Html.LabelFor(model => model.toChuc.LoaiHinhToChuc.TenLoaiHinhToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.DropDownList("MaLoaiToChuc",new SelectList(Model.loaiHinh,"MaLoaiHinhToChuc","TenLoaiHinhToChuc",Model.toChuc.MaLoaiHinhToChuc)) %>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TruSoChinh) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("TruSoChinh",Model.toChuc.TruSoChinh)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.TruSoChinh)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.NguoiDaiDien) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("NguoiDaiDien",Model.toChuc.NguoiDaiDien)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.NguoiDaiDien)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.DienThoai) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("DienThoai",Model.toChuc.DienThoai)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.NguoiDaiDien)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.Email) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("Email", Model.toChuc.Email)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.Email)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.Fax) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("Fax",Model.toChuc.Fax)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.Fax)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.SoTaiKhoan) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("SoTaiKhoan",Model.toChuc.SoTaiKhoan)%>
                (* Ngân hàng VietcomBank)
                <%= Html.ValidationMessageFor(model => model.toChuc.SoTaiKhoan)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TongSoCanBo) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("TongSoCanBo",Model.toChuc.TongSoCanBo)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.TongSoCanBo)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.KichHoat) %>
            </div>
            <div class="editor-field">
                <%= Html.RadioButton("KichHoat",true, Model.toChuc.KichHoat == true)%>
                Bật
                <%= Html.RadioButton("KichHoat", false, Model.toChuc.KichHoat == false)%>
                Tắt
            </div>
        </div>
        <!--div class="editor-field">
                <--%= Html.CheckBoxFor(model => model.toChuc.KichHoat)%>
            </div-->
        <div class="editor-row">
            <input class="submit" type="submit" value="Lưu lại" />
        </div>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ActionLink("Quay về", "Index") %>
    </div>
</body>
</html>
