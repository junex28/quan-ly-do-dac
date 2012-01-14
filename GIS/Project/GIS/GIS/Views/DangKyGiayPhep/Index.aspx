<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Đăng ký hồ sơ giấy phép
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="grid_19 alpha">
      <div class="box grid_10 alpha">  
        <h3>
            Hồ sơ
            <% if (false)
               {%>
            đăng ký giấy phép<% }
               else if (false)
               {%>
            đăng ký bổ sung hoạt động<% }
               else if (true)
               {%>
            đăng ký gia hạn<% }%>
        </h3>
      </div>
      <div class="box grid_8 omega" style="text-align:right">
      <% if (true) {%> 
         <p> Số giấy phép :<%=Html.Encode(Model.giayphep.SoGiayPhep) %></p>
         <p> Cấp ngày : <%=Html.Encode(Model.giayphep.NgayCapPhep) %>   </p> 
       <%  } %>
      </div>
      <div class="clear"></div> 
              <div class="box">
            <h2>
                <a id="toggle-thongtinchung" href="#" style="cursor: pointer;">Thông tin chung</a>
            </h2>
            <div class="block" id="thongtinchung">
                <p>
                    <label class="grid_6">
                        Tên tổ chức/cá nhân :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.TenToChuc)%>
                </p>
                <p>
                    <label class="grid_6">
                        Quyết định thành lập/Giấy phép kinh doanh số :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.GiayPhepKinhDoanh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Hạng của doanh nghiệp :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.HangDoanhNghiep) %>
                </p>
                <p>
                    <label class="grid_6">
                        Vốn pháp định :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.VonPhapDinh) %>
                </p>
                <p>
                    <label class="grid_6">
                        Vốn lưu động :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.VonLuuDong) %>
                </p>
                <p>
                    <label class="grid_6">
                        Số tài khoản :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.SoTaiKhoan)%>
                </p>
                <p>
                    <label class="grid_6">
                        Tổng số cán bộ, công nhân viên (không kể cộng tác viên):
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.TongSoCanBo)%>
                </p>
                <p>
                    <label class="grid_6">
                        Trụ sở chính tại :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.TruSoChinh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Số điện thoại :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.DienThoai)%>
                </p>
                <p>
                    <label class="grid_6">
                        Fax :
                    </label>
                    .<%= Html.Encode(Model.giayphep.ThongTinChung.Fax)%>
                </p>
                <p>
                    <label class="grid_6">
                        Email :
                    </label>
                    <%= Html.Encode(Model.giayphep.ThongTinChung.Email)%>
                </p>
            </div>
        </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
