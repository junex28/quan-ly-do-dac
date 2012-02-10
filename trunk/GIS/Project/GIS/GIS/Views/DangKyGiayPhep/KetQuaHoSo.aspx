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
                    <%=Html.Encode(Model.giayphep.ThongTinChung.TenToChuc)%>
                    
                </p>
                <!--Kiểm tra điều kiện không là xin giấy phép -->
                <%if (Model.giayphep.TinhTrang != 1 && Model.giayphep.TinhTrang != 2 && Model.giayphep.TinhTrang != 4)
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
                    <%=Html.Encode(Model.giayphep.NgayXinPhep.Value.ToShortDateString()) %>
                </p>
                                <p>
                    <label class="grid_6">
                       Loại hồ sơ gửi  :
                    </label>
                    <% //int i = Model.giayphep.LoaiGiayPhep; 
                        if (Model.giayphep.LoaiGiayPhep == 1)
                        {%>
                        Hồ sơ đăng ký giấy phép mới
                     <% }
                        else if (Model.giayphep.LoaiGiayPhep == 2)
                        {%>
                        Hồ sơ xin bổ sung hoạt động
                        <%}
                        else if (Model.giayphep.LoaiGiayPhep == 3)
                        {%>
                        Hồ sơ xin gia hạn giấy phép
                        <%} %>
                </p>
                <!--Biên bản thẩm định-->
                <%if (Model.ThamDinh != null )
                  {
                      if (Model.ThamDinh.TinhTrangThamDinh != null || Model.ThamDinh.TinhTrangThamDinh != false)
                      {
                      %>
                <p>
                    <label class="grid_6">
                        Ngày thẩm định :
                    </label>
                    <%if (Model.ThamDinh.NgayThamDinh != null)
                      { %>
                    <%=Html.Encode(Model.ThamDinh.NgayThamDinh.Value.ToShortDateString())%>
                    <%} %>
                </p>
                <p>
                    <label class="grid_6">
                        Thành phần cơ quan thẩm định :
                    </label>
                    <% var nguoithamdinh = Model.ThamDinh.NguoiThamDinh;
                       if (nguoithamdinh != null)
                       {
                           string[] strList = nguoithamdinh.Split(';');
                           int count = 1;
                           foreach (var k in strList)
                           {%>
                               <%=count%>. <%=Html.Encode(k)%> <br />
                            <% count++;
                           }
                       } %>
                </p>
                <p>
                    <label class="grid_6">
                        Thành phần tổ chức đề nghị cấp giấy phép :
                    </label>
                   <% var nguoiphiatochuc = Model.ThamDinh.NguoiPhiaToChuc;
                      if (nguoiphiatochuc != null)
                      {
                          string[] strList = nguoiphiatochuc.Split(';');
                          int count = 1;
                          foreach (var k in strList)
                          {%>
                               <%=count%>. <%=Html.Encode(k)%> <br />
                            <% count++;
                          }
                      } %>
                </p>
                <p>
                    <label class="grid_6">
                        Thẩm định tính hợp lệ của hồ sơ :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.TinhHopLe)%>
                </p>
                <p>
                    <label class="grid_6">
                        Thẩm định kê khai lực lượng kỹ thuật :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.NangLucNhanVien)%>
                </p>
                <p>
                    <label class="grid_6">
                        Thẩm định năng lực thiết bị :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.NangLucThietBi)%>
                </p>
                <p>
                    <label class="grid_6">
                        Kết luận :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.KetLuan)%>
                </p>
                <p>
                    <label class="grid_6">
                        Kiến nghị :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.KienNghi)%>
                </p>
                <% }
                  }
                  else
                  { %> 
                  <span style="color:Red">Hồ sơ này vẫn chưa được thẩm định. Xin vui lòng xem kết quả thẩm định sau!</span>
                <%} %>
            </div>
        </div>
        <div class="box">
            <div class="block prefix_4">
                <button id="backButton" class="button redmond" onclick="window.location.href='/trangchu/index'">
                    <span class="back">Quay về</span></button>                   
            </div>
        </div>
   </div>
 

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
