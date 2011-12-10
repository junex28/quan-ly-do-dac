<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<GIS.Controllers.ToChucDetailModelView>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Edit</title>
</head>
<body>
    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
        
        <fieldset>
            <legend>Fields</legend>
                 
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.MaToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.toChuc.MaToChuc) %>
                <%= Html.ValidationMessageFor(model => model.toChuc.MaToChuc) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TenToChuc) %>
            </div>
            <div class="editor-field" >
                <%= Html.TextBoxFor(model => model.toChuc.TenToChuc, new {@disabled="disabled" })%>
                <%= Html.ValidationMessageFor(model => model.toChuc.TenToChuc) %>
            </div>
            
             <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TenToChuc) %>
            </div>
            <div class="editor-field" disabled='disabled'>
                <%= Html.TextBoxFor(model => model.toChuc.TenToChuc) %>
                <%= Html.ValidationMessageFor(model => model.toChuc.TenToChuc) %>
            </div>
            
             <div class="editor-label" disabled='disabled'>
                <%= Html.LabelFor(model => model.toChuc.LoaiHinhToChuc.TenLoaiHinhToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.toChuc.LoaiHinhToChuc.TenLoaiHinhToChuc)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.LoaiHinhToChuc.TenLoaiHinhToChuc)%>
            </div>
            
             <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.GiayPhepKinhDoanh) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.toChuc.GiayPhepKinhDoanh)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.GiayPhepKinhDoanh)%>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.NguoiDaiDien) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.toChuc.NguoiDaiDien)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.NguoiDaiDien)%>
            </div>
             
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.TruSoChinh) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.toChuc.TruSoChinh)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.TruSoChinh)%>
            </div>
             
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.DienThoai) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.toChuc.DienThoai)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.NguoiDaiDien)%>
            </div>
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.KichHoat) %>
            </div>
           <div class="editor-field">
                <%= Html.TextBoxFor(model => model.toChuc.KichHoat)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.KichHoat)%>
            </div>
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.Email) %>
            </div>
           <div class="editor-field">
                <%= Html.TextBoxFor(model => model.toChuc.Email)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.Email)%>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.toChuc.Fax) %>
            </div>
           <div class="editor-field">
                <%= Html.TextBoxFor(model => model.toChuc.Fax)%>
                <%= Html.ValidationMessageFor(model => model.toChuc.Fax)%>
            </div>
            
            <!--div class="editor-field">
                <--%= Html.CheckBoxFor(model => model.toChuc.KichHoat)%>
            </div-->
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%= Html.ActionLink("Back to List", "Index") %>
    </div>

</body>
</html>

