<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ThamDinhEditViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Xem kết quả hồ sơ 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <div class="grid_19 alpha">
        <h3>Xem kết quả hồ sơ</h3>
        <div class="box">            
            <div class="block">
                <!--Thông Tin Hồ Sơ-->
              <p>
                    <label class="grid_6">
                        Tên tổ chức  :
                    </label>                      
                    <%--<%=Html.Encode(Model.giayphep.ThongTinChung.TenToChuc)%>--%>
                    
                </p>
                <!--Kiểm tra điều kiện không là xin giấy phép -->
                <%if (false)
                  { %>
                 <p>
                    <label class="grid_6">
                       Số giấy phép đo đạc  :
                    </label>
                    <%=Html.Encode(Model.giayphep.SoGiayPhep) %>
                </p>
                 <%}%>
                                <p>
                    <label class="grid_6">
                        Ngày gửi  :
                    </label>
                   <%-- <%=Html.Encode(Model.giayphep.NgayXinPhep.Value.ToShortDateString()) %>--%>
                </p>
                                <p>
                    <label class="grid_6">
                       Loại hồ sơ gửi  :
                    </label>
                    <%-- <%=Html.Encode(Model.ThamDinh.NgayThamDinh.Value.ToShortDateString()) %>--%>
                </p>
                <!--Biên bản thẩm định-->
                <p>
                    <label class="grid_6">
                        Ngày thẩm định :
                    </label>
                    <%--<%=Html.Encode(Model.ThamDinh.NgayThamDinh.Value.ToShortDateString()) %>--%>
                </p>
                <p>
                    <label class="grid_6">
                        Thành phần cơ quan thẩm định :
                    </label>
                   <%-- <%= Html.Encode(Model.ThamDinh.NguoiThamDinh) %>--%>
                </p>
                <p>
                    <label class="grid_6">
                        Thành phần tổ chức đề nghị cấp giấy phép :
                    </label>
                   <%-- <%= Html.Encode(Model.ThamDinh.NguoiPhiaToChuc) %>--%>
                </p>
                <p>
                    <label class="grid_6">
                        Thẩm định kê khai lực lượng kỹ thuật :
                    </label>
                    <%--<%= Html.Encode(Model.ThamDinh.NangLucNhanVien) %>--%>
                </p>
                <p>
                    <label class="grid_6">
                        Kết luận :
                    </label>
                    <%--<%= Html.Encode(Model.ThamDinh.KetLuan) %>--%>
                </p>
                <p>
                    <label class="grid_6">
                        Kiến nghị :
                    </label>
                   <%-- <%= Html.Encode(Model.ThamDinh.KienNghi) %>--%>
                </p>
                
                <!-- Kiểm tra hồ sơ có phải thuộc loại thẩm định không-->
                <% if (true)
                   { %>
                <p>
                    <label class="grid_6">
                        Số giấy phép :
                    </label>
                    <%--<%= Html.Encode(Model.ThamDinh.HoSoGiayPhep.SoGiayPhep)%>--%>
                </p>
                                <% } %>
            </div>
        </div>
        <div class="box">
            <div class="block prefix_4">
                <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                    <span class="back">Quay về</span></button>                   
            </div>
        </div>
   </div>
 

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
