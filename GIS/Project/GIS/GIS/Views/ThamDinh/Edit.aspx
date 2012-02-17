<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ThamDinhEditViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Cập nhật biên bản thẩm định
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_19 alpha">
        <div class="box grid_10 alpha">
            <h3>
                Edit hồ sơ
                <% 
                    if (Model.giayphep.LoaiGiayPhep == 1)
                    {%>
                đăng ký giấy phép<% }
                else if (Model.giayphep.LoaiGiayPhep == 2)
                {%>
                đăng ký bổ sung hoạt động<% }
                else if (Model.giayphep.LoaiGiayPhep == 3)
                {%>
                đăng ký gia hạn<% }%>
            </h3>
        </div>
        <div class="box grid_8 omega" style="text-align: right">
            <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang != 1)
               {%>
            <p>
                Số giấy phép :<%=Html.Encode(Model.giayphep.SoGiayPhep)%></p>
            <% if (Model.giayphep.NgayCapPhep != null)
               {%>
            <p>
                Cấp ngày :
                <%=Html.Encode(Model.giayphep.NgayCapPhep.Value.ToShortDateString())%>
            </p>
            <% }
               else
               {%>
            <p>
                Cấp ngày :</p>
            <%} %>
            <%  }%>
        </div>
        <div class="clear">
        </div>
        <% Html.RenderPartial("ThongTinChung", Model.thongtinchung); %>
        <div class="box">
            <h2>
                <a id="toggle-thamdinh" href="#" style="cursor: pointer;">Biên bản thẩm định</a>
            </h2>
            <div class="block" id="thamdinh">
                <% Html.EnableClientValidation(); %>
                <%= Html.ValidationSummary(true) %>
                <% using (Html.BeginForm("Edit", "ThamDinh", FormMethod.Post, new { id = "xetduyetForm" }))
                   {
                       var save = "1";
                %>
                <input id="save" type="hidden" value="<%=save%>" />
                <p>
                    <label class="grid_6">
                        Ngày thẩm định :
                    </label>
                    <%= Html.TextBox("NgayThamDinh", Model.NgayThamDinh.ToString("dd/MM/yyyy"), new { @class = "date-picker text" })%>
                     <span id="NgayCapPhepDoDac_validation" style="display:none" class="field-validation-error"><span>Ngày thẩm định không hợp lệ.</span></span>
                </p>
                <p>
                    <label class="grid_6">
                        Thành phần cơ quan thẩm định :
                    </label>
                    <%= Html.TextAreaFor(m=>m.ThamDinh.NguoiThamDinh) %>
                    <%= Html.ValidationMessageFor(m => m.ThamDinh.NguoiThamDinh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Thành phần tổ chức đề nghị cấp giấy phép :
                    </label>
                    <%= Html.TextAreaFor(m=>m.ThamDinh.NguoiPhiaToChuc) %>
                    <%= Html.ValidationMessageFor(m => m.ThamDinh.NguoiPhiaToChuc)%>
                </p>
                <p>
                    <label class="grid_6">
                        Thẩm định kê khai lực lượng kỹ thuật :
                    </label>
                    <%= Html.TextAreaFor(m=>m.ThamDinh.NangLucNhanVien) %>
                    <%= Html.ValidationMessageFor(m => m.ThamDinh.NangLucNhanVien)%>
                </p>
                <p>
                    <label class="grid_6">
                        Kết luận
                    </label>
                    <%= Html.TextAreaFor(m=>m.ThamDinh.KetLuan) %>
                    <%= Html.ValidationMessageFor(m => m.ThamDinh.KetLuan)%>
                </p>
                <p>
                    <label class="grid_6">
                        Kiến nghị :
                    </label>
                    <%= Html.TextAreaFor(m=>m.ThamDinh.KienNghi) %>
                    <%= Html.ValidationMessageFor(m => m.ThamDinh.KienNghi)%>
                </p>
                <p>
                    <label class="grid_6">
                        Số giấy phép :
                    </label>
                    <% if (Model.giayphep.SoGiayPhep == null || Model.giayphep.SoGiayPhep == "")
                       { %>
                    <%= Html.TextBoxFor(m => m.giayphep.SoGiayPhep, new { @id="sogiayphep"})%>
                    <% }
                       else
                       { %>
                    <%= Html.TextBoxFor(m => m.giayphep.SoGiayPhep, new {@disabled = "disabled"})%>
                    <%}%>
                    <%= Html.ValidationMessageFor(m => m.giayphep.SoGiayPhep)%>
                </p>
                <p>
                <label class="grid_6">
                   Ngày cấp phép :
                </label>
                 <%= Html.TextBox("NgayCapPhep", Model.NgayCapPhep.ToString("dd/MM/yyyy"), new {@class = "date-picker text" })%>
                 <span id="Span1" style="display:none" class="field-validation-error"><span>Vui lòng nhập ngày cấp phép</span></span>
            </p>
             <p>
                <label class="grid_6">
                   Ngày hết hạn :
                </label>
                <% if (Model.giayphep.LoaiGiayPhep == 3)
                   {%>
                 <%= Html.TextBox("NgayHetHan", DateTime.Now.AddYears(3).ToString("dd/MM/yyyy"), new {  @class = "date-picker text" })%>
                 <%}
                   else if (Model.giayphep.LoaiGiayPhep == 1)
                   { %>
                    <%= Html.TextBox("NgayHetHan", DateTime.Now.AddYears(5).ToString("dd/MM/yyyy"), new { @class = "date-picker text" })%>
                 <%}
                   else
                   {%>
                   <%= Html.TextBoxFor(m=>m.giayphep.NgayHetHan, new { @class = "date-picker text" })%>
                       <%} %>
                  <span id="Span2" style="display:none" class="field-validation-error"><span>Ngày gia hạn không hợp lệ </span></span>
            </p>
                <%
               }
                %>
            </div>
        </div>
        <div class="box">
            <div class="block prefix_4">
                <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                    <span class="back">Thoát</span></button>
                <button type="reset" id="lammoiButton" class="button redmond">
                    <span class="duyet">Làm mới</span></button>
                <button id="luuButton" class="button redmond">
                    <span>Lưu</span></button>
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
            $("input[type=submit]").button();
            $('#danhsachButton').button({
                icons:
                    {
                        primary: "ui-icon-document"
                    }
            });
        });
        
        $(function() {
        $(".date-picker").datepicker({ dateFormat: 'dd/mm/yy' });
        });
        
        var save;
        $(function() {
            $('#xetduyetButton').click(function() {
            //alert("aa");
            $("#Span1").hide();
                save = 1;
                if ($("#sogiayphep").val() != '') {
                    if ($("#NgayCapPhep").val() == '') {
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

            $('#luuButton').click(function() {
                // Luu lai
                save = 2;
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
                    return true;
                });
        });
    </script>

</asp:Content>
