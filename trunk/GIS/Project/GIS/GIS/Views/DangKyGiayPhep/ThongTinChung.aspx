<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Thông tin chung 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <div class="grid_19 alpha">
            <!--Load data từ profile-->
        <h3>
            Thông tin chung</h3>
        <div class="box">
            <h2>
                <a id="toggle-thongtinchung" href="#" style="cursor: pointer;">Thông tin chung</a>
            </h2>
            <div class="block" id="thongtinchung">
                <p>                    
                    <label>
                        Tên tổ chức/cá nhân :
                    </label>
                    <input type="text" />                        
                </p>
                 <p>
                    <label>
                        Quyết định thành lập/Giấy phép kinh doanh số :
                    </label>
                    <input type="text" />                        
                </p>
                <p>
                    <label>
                        Hạng của doanh nghiệp :
                    </label>
                   <input type="text" />                        
                </p>
                <p>
                    <label>
                        Vốn pháp định :
                    </label>
                    <%= Html.Encode(Model.giayphep.ToChuc.VonPhapDinh) %>
                </p>
                <p>
                    <label>
                        Vốn lưu động :
                    </label>
                    <%= Html.Encode(Model.giayphep.ToChuc.VonLuuDong) %>
                </p>
                <p>
                    <label>
                        Số tài khoản :
                    </label>
                    <%= Html.Encode(Model.giayphep.ToChuc.SoTaiKhoan)%>
                </p>
                <p>
                    <label>
                        Tổng số cán bộ, công nhân viên (không kể cộng tác viên:
                    </label>
                    <%= Html.Encode(Model.giayphep.ToChuc.TongSoCanBo)%>
                </p>
                <p>
                    <label>
                        Trụ sở chính tại :
                    </label>
                    <%= Html.Encode(Model.giayphep.ToChuc.TruSoChinh)%>
                </p>
                <p>
                    <label>
                        Số điện thoại :
                    </label>
                    <%= Html.Encode(Model.giayphep.ToChuc.DienThoai)%>
                </p>
                <p>
                    <label>
                        Fax :
                    </label>
                    <%= Html.Encode(Model.giayphep.ToChuc.Fax)%>
                </p>
                <p>
                    <label>
                        Email :
                    </label>
                    <%= Html.Encode(Model.giayphep.ToChuc.Email)%>
                </p>                                
             </div>
        </div>
        </div>
       </asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
