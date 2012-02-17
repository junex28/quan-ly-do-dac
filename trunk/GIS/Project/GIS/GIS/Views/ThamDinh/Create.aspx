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
                    <%= Html.TextBox("NgayThamDinh", DateTime.Now.ToString("dd/MM/yyyy"), new { @class = "date-picker text" })%>
                     <span id="NgayCapPhepDoDac_validation" style="display:none" class="field-validation-error"><span>Ngày thẩm định không hợp lệ.</span></span>
                </p>
                <p>
                    <label class="grid_6">
                        Thành phần cơ quan thẩm định :
                    </label>
                    <%= Html.TextAreaFor(m => m.NguoiThamDinh) %>
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
                        Thẩm định tính hợp lệ :
                    </label>
                    <%= Html.TextAreaFor(m=>m.TinhHopLe) %>
                    <%= Html.ValidationMessageFor(m => m.TinhHopLe)%>
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
                        Thẩm định năng lực thiết bị :
                    </label>
                    <%= Html.TextAreaFor(m=>m.NangLucThietBi) %>
                    <%= Html.ValidationMessageFor(m => m.NangLucThietBi)%>
                </p>
                <p>
                    <label class="grid_6">
                        Kết luận
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

            <p>
                <label class="grid_6">
                   Số giấy phép :
                </label>
                <%= Html.TextBoxFor(m => m.giayphep.SoGiayPhep, new {@id="sogiayphep", @class="text"})%>
            </p>
             <p>
                <label class="grid_6">
                   Ngày cấp phép :
                </label>
                 <%= Html.TextBox("NgayCapPhep", DateTime.Now.ToString("dd/MM/yyyy"), new { id="ngaycapphep",@class = "date-picker text" })%>
                 <span id="Span1" style="display:none" class="field-validation-error"><span>Vui lòng điền ngày cấp phép</span></span>
            </p>
             <p>
                <label class="grid_6">
                   Ngày hết hạn :
                </label>
                <% if (Model.giayphep.LoaiGiayPhep == 3)
                   {%>
                 <%= Html.TextBox("NgayHetHan", DateTime.Now.AddYears(3).ToString("dd/MM/yyyy"), new {  @class = "date-picker text" })%>
                 <%}
                   else if(Model.giayphep.LoaiGiayPhep == 1)
                   { %>
                    <%= Html.TextBox("NgayHetHan", DateTime.Now.AddYears(5).ToString("dd/MM/yyyy"), new {  @class = "date-picker text" })%>
                 <%} %>
                  <span id="Span2" style="display:none" class="field-validation-error"><span>Ngày gia hạn không hợp lệ </span></span>
            </p>
            
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
    
    </div>
   
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">

        $(function() {
        $("#NgayThamDinh").datepicker({ dateFormat: 'dd/mm/yy' });
        $("#NgayCapPhep").datepicker({ dateFormat: 'dd/mm/yy' });
        $("#NgayHetHan").datepicker({ dateFormat: 'dd/mm/yy' });
        });

        $(function() {
            var save = 0;
            $('#xetduyetButton').click(function() {
                save = 2;
                $("#Span1").hide();
                if ($("#sogiayphep").val() != '') {
                    if ($("#ngaycapphep").val() == '') {
                        $("#Span1").show();
                    }
                    else {
                        $('#xetduyetForm').submit();
                    }
                }
               
            });

            $('#khongduyetButton').click(function() {
                save = 0;
                $('#xetduyetForm').submit();
            });

            $('#saveButton').click(function() {
                // Luu lai
                save = 1;
                $('#xetduyetForm').submit();
            });


            $('#xetduyetForm').submit(
                function() {
                    $("#NgayCapPhepDoDac_validation").hide();
                    var value = $(".date-picker").val();
                    re = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
                    var dateValid = true;
                    if (value != '') {
                        if (regs = value.match(re)) { // day value between 1 and 31
                            if (regs[1] < 1 || regs[1] > 31) {
                                dateValid = false;
                            }
                            // month value between 1 and 12
                            if (regs[2] < 1 || regs[2] > 12) {
                                dateValid = false;
                            }
                            // year value between 1902 and 2012
                            if (regs[3] < 1902 || regs[3] > (new Date()).getFullYear()) {
                                dateValid = false;
                            }
                        }
                        else {
                            dateValid = false;
                        }
                    }
                    if (!dateValid) {
                        $("#NgayCapPhepDoDac_validation").show();
                        return false;
                    }
                
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "gpid");
                    input.setAttribute("value", "<%=Model.giayphep.MaHoSo%>");
                    $(this).append(input);
                    var input1 = document.createElement("input");
                    input1.setAttribute("type", "hidden");
                    input1.setAttribute("name", "save");
                    input1.setAttribute("value", save);
                    $(this).append(input1);
                    var input2 = document.createElement("input");
                    input2.setAttribute("type", "hidden");
                    input2.setAttribute("name", "sogiayphep");
                    input2.setAttribute("value", $("#sogiayphep").val());
                    $(this).append(input2);
                    return true;
                });
        });
    </script>
</asp:Content>