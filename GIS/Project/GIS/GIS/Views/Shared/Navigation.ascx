<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace= "GIS.Models" %>
<ul class="nav main">                
                    <li><a href="/trangchu/index"><span class="">Trang chủ</span></a> </li>
                    <li><a href="#WebGis">Web GIS</a>
                        <ul>
                            <li><a href="#WebGis/">Hướng dẫn</a> </li>
                            <li><a href="">Bản đồ</a> </li>                            
                        </ul>
                    </li>
                    <li><a href="/dangkygiayphep/Index">Đăng ký giấy phép</a>
                        <ul>
                            <li><a href="/dangkygiayphep/taomoi">Hướng dẫn đăng ký</a> </li>
                            <li><a href="/dangkygiayphep/taomoi">Đăng ký hoạt động</a> </li>
                            <li><a href="/dangkygiayphep/bosunggiayphep">Bổ sung hoạt động</a></li>                        
                            <li><a href="/dangkygiayphep/giahangiayphep">Xin gia hạn </a></li>
                            <li><a href="/dangkygiayphep/KetQuaHoSo">Xem kết quả</a></li>
                        </ul>
                    </li> 
                    <% if (Request.IsAuthenticated)
                       {%>
                    <li><a href="#">Tài khoản</a>
                        <ul>
                            <li><a href="/taikhoan/chitiet">Thông tin tài khoản</a> </li>
                            <li><a href="/taikhoan/capnhattaikhoan">Đổi mật khẩu</a></li>
                            <li><a href="/taikhoan/chitiettochuc">Thông tin tổ chức</a></li>                            
                        </ul>
                    </li>
                    <%}
                       else                           
                       {%>
                    <li><a href="/taikhoan/dangky">Đăng ký</a></li>  
                       <%} %>                     
                    <% if (Request.IsAuthenticated && ((EnhancedPrincipal)Page.User).Data.NhomNguoiDung==4) { %>
                    <li><a href="/qlgiayphep/index">Quản lý</a>
                        <ul>
                            <li><a href="/qlgiayphep/index">Quản lý giấy phép</a> </li>
                            <li><a href="/taikhoan/index">Quản lý tài khoản</a> </li>
							<li><a href="/tochuc/index">Quản lý tổ chức</a> </li>
							<li><a href="/thongke/index">Thống kê</a> </li>
                        </ul>
                    </li>
                     <%} %>  
                     <li><a href="/Lienhe/index">Liên hệ</a></li>       
</ul>