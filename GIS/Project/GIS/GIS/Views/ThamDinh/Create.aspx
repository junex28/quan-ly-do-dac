<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ThamDinhEditViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thêm biên bản thẩm định
</asp:Content>


<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_19 alpha">
      <div class="box grid_10 alpha">  
        <h3>
            Thẩm định hồ sơ
            <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang ==1)
               {%>
            đăng ký giấy phép<% }
               else if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang == 9)
               {%>
            đăng ký bổ sung hoạt động<% }
               else if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang == 6)
               {%>
            đăng ký gia hạn<% }%>
        </h3>
      </div>
      <div class="box grid_8 omega" style="text-align:right">
      <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang != 1)
         {%> 
         <p> Số giấy phép :<%=Html.Encode(Model.giayphep.SoGiayPhep)%></p>
         <% if (Model.giayphep.NgayCapPhep != null)
            {%>
         <p> Cấp ngày : <%=Html.Encode(Model.giayphep.NgayCapPhep.Value.ToShortDateString())%>   </p> 
        <% }
            else
            {%>
       <p> Cấp ngày :</p> 
       <%} %>
       <%  }%>
      </div>
      <div class="clear"></div> 
     <% Html.RenderPartial("ThongTinChung", Model.thongtinchung); %>
    <div class="box">
        <h2>
            <a id="toggle-thamdinh" href="#" style="cursor: pointer;">Biên bản thẩm định</a>
        </h2>
        <div class="block" id="thamdinh">
            <% Html.EnableClientValidation(); %>
            <%= Html.ValidationSummary(true) %>
            <% using (Html.BeginForm("Create", "ThamDinh", FormMethod.Post, new { id = "xetduyetForm"}))  
               {%>
            <p>
                <label class="grid_6">
                    Ngày thẩm định :
                </label>
                <%=Html.TextBoxFor(m=>m.NgayThamDinh) %>
            </p>
            <p>
                <label class="grid_6">
                    Thành phần cơ quan thẩm định :
                </label>
                <%= Html.TextAreaFor(m=>m.NguoiThamDinh) %>
                <%= Html.ValidationMessageFor(m => m.NguoiThamDinh)%>
            </p>
            <p>
                <label class="grid_6">
                    Thành phần tổ chức đề nghị cấp giấy phép :
                </label>
                <%= Html.TextAreaFor(m=>m.NguoiPhiaToChuc) %>
                <%= Html.ValidationMessageFor(m => m.NguoiPhiaToChuc)%>
            </p>
            <p>
                <label class="grid_6">
                    Thẩm định kê khai lực lượng kỹ thuật :
                </label>
                <%= Html.TextAreaFor(m=>m.NangLucNhanVien) %>
                <%= Html.ValidationMessageFor(m => m.NangLucNhanVien)%>
            </p>
            <p>
                <label class="grid_6">
                    Kết luận :
                </label>
                <%= Html.TextAreaFor(m=>m.KetLuan) %>
                <%= Html.ValidationMessageFor(m => m.KetLuan)%>
            </p>
            <p>
                <label class="grid_6">
                    Kiến nghị :
                </label>
                <%= Html.TextAreaFor(m=>m.KienNghi) %>
                <%= Html.ValidationMessageFor(m => m.KienNghi)%>
            </p>
            <% if (true)
               { %>
            <p>
                <label class="grid_6">
                   Số giấy phép :
                </label>
                <%= Html.TextBoxFor(m => m.SoGiayPhep, new {@class="text"})%>
                <%= Html.ValidationMessageFor(m => m.SoGiayPhep)%>
            </p>
             <p>
                <label class="grid_6">
                   Ngày cấp phép :
                </label>
                <%=Html.TextBoxFor(m=>m.NgayCapPhep) %>
            </p>
            
            <% } %>
            <input type="hidden" id="Save" value="0" /> 
            <input type="hidden" id="KhongDuyet" value="0" /> 
                   
            <%}
                %>
        </div>
    </div>
    <div class="box">
        <div class="block prefix_4">
            <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                <span class="back">Thoát</span></button>
                   <button id="saveButton" class="button redmond">
                <span class="save">Lưu lại</span></button>
            <button id="khongduyetButton" class="button redmond">
                <span class="khongduyet">Không Duyệt</span></button>
            <button id="xetduyetButton" class="button redmond">
                <span class="duyet">Duyệt</span></button>           
        </div>
    </div>
    
    
    
    
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">

        $(function() {
        $("#NgayThamDinh").datepicker({ dateFormat: 'dd/mm/yy' });
        $("#NgayCapPhep").datepicker({ dateFormat: 'dd/mm/yy' });
        });
        
        $(function() {

            $('#xetduyetButton').click(function() {
                $('#xetduyetForm').submit();
            });

            $('#khongduyetButton').click(function() {
                $('#khongduyet').val() = 1;
                $('#xetduyetForm').submit();
            });

            $('#saveButton').click(function() {
                // Luu lai
                $('#Save').val() = 1;
            });


            $('#xetduyetForm').submit(
                function() {

                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "gpid");
                    input.setAttribute("value", "<%=Model.giayphep.MaHoSo%>");
                    $(this).append(input);
                    return true;
                });
        });
    </script>
</asp:Content>