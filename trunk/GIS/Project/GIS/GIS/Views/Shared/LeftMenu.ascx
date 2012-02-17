<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="GIS.Models" %>
<div class="box menu">
    <div class="block" id="section-menu">
        <ul class="section menu">
        <li><a class="menuitem">WebGIS</a>
        </li>
            <li><a class="menuitem">Giấy phép</a>
                <ul class="submenu">
                    <li><a href="/dangkygiayphep/taomoi">Đăng ký hoạt động</a> </li>
                    <li><a href="/dangkygiayphep/giahangiayphep">Xin gia hạn</a> </li>
                    <li><a href="/dangkygiayphep/bosunggiayphep">Bổ sung hoạt động</a> </li>
                    <li><a href="/dangkygiayphep/ketquahoso">Xem kết quả hồ sơ</a> </li>
                </ul>
            </li>
            <% if (Request.IsAuthenticated)
               {%>
            <li><a class="menuitem">Tài khoản</a>
                <ul class="submenu">
                    <li><a href="/TaiKhoan/ChiTiet">Thông tin tài khoản</a> </li>
                    <li><a href="/TaiKhoan/capnhattaikhoan">Cập nhật tài khoản</a> </li>
                    <li><a href="/TaiKhoan/ThongTinToChuc">Thông tin tổ chức</a> </li>
                </ul>
            </li>
            <%} %>
            <% if (Request.IsAuthenticated && ((EnhancedPrincipal)Page.User).Data.NhomNguoiDung == 4)
               { %>
            <li><a class="menuitem">Quản lý</a>
                <ul class="submenu">
                    <li><a href="/QLGiayPhep/Index">Quản lý giấy phép</a> </li>
                    <li><a href="/QLTaiKhoan/Index">Quản lý tài khoản</a> </li>
                    <li><a href="/ToChuc/Index">Quản lý tổ chức</a> </li>
                    <li><a href="/QLMoc/Index">Quản lý mốc</a> </li>
                    <li><a href="/ThongKe/Index">Thống kê</a> </li>
                </ul>
            </li>
            <%} %>
            <li><a class="menuitem" href="/LienHe/Index">Liên hệ</a>
            
            </li>
        </ul>
    </div>
</div>
