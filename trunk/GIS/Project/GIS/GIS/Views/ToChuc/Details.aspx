<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<GIS.Controllers.ToChucDetailModelView>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Details</title>
</head>
<body>
    <fieldset>
        <legend>Fields</legend>
        
        <div class="display-label">Mã tổ chức</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.MaToChuc) %></div>
        
        <div class="display-label">Loại hình tổ chức</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.LoaiHinhToChuc.TenLoaiHinhToChuc)%></div>
        
        <div class="display-label">Tên tổ chức</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.TenToChuc)%></div>
        
        <div class="display-label">Giấy phép kinh doanh</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.GiayPhepKinhDoanh)%></div>
        
        <div class="display-label">Người đại diện</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.NguoiDaiDien)%></div>
        
        <div class="display-label">Trụ sở chính</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.TruSoChinh)%></div>
        
        <div class="display-label">Số tài khoản</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.SoTaiKhoan)%></div>
        
        <div class="display-label">Điện thoại</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.DienThoai)%></div>
        
        <div class="display-label">Fax</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.Fax)%></div>
        
        <div class="display-label">Email</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.Email)%></div>
        
        <div class="display-label">Tổng số cán bộ</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.TongSoCanBo)%></div>
        
        <div class="display-label">Ngày xin phép</div>
        <div class="display-field><%= Html.Encode(String.Format("{0:g}", Model.toChuc.NgayXinPhep))%></div>
        
        <div class="display-label">Tình trạng</div>
        <div class="display-field><%= Html.Encode( Model.toChuc.KichHoat)%></div>
 
        <div class="display-label">Tệp đính kèm</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.TepDinhKem)%></div>
        
        <div class="display-label">Mã tài khoản</div>
        <div class="display-field"><%= Html.Encode(Model.toChuc.MaTaiKhoan)%></div>
        
        
    </fieldset>
    <p>
        <%= Html.ActionLink("Edit", "Edit", new { id=Model.toChuc.MaToChuc }) %> |
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>

</body>
</html>

