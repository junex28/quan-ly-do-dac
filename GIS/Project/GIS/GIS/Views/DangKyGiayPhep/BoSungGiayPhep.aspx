<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucBoSungViewModel>" %>

<%@ Import Namespace="GIS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Đăng ký hồ sơ bổ sung giấy phép
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.EnableClientValidation(); %>
    <% using (Html.BeginForm("BoSungGiayPhep", "DangKyGiayPhep", FormMethod.Post, new { enctype = "multipart/form-data", id = "bosungForm" }))
       {
           // Cac loai tinh trang
           //int loaigiayphep = 0; // xin cap giay phep moi 
           int loaigiayphep = 1;  // xin cap giay phep bosung 
           // loaigiayphep = 2; // xin cap giay phep gia han 
           var save = "1";
           string i = ViewData["sogiayphep"].ToString(); ;
           bool giaypheptontai = true;
           if (i.Equals("1") == false)
           {
               giaypheptontai = false;
           }
           
           
    %>
    <input id="save" type="hidden" value="<%=save%>" />
    <div class="grid_19 alpha">
        <div class="box grid_10 alpha">
            <h3>
                Hồ sơ
                <% if (loaigiayphep == 0)
                   {%>
                đăng ký giấy phép<% }
                   else if (loaigiayphep == 1)
                   {%>
                đăng ký bổ sung hoạt động<% }
                   else if (loaigiayphep == 2)
                   {%>
                đăng ký gia hạn<% }%>
            </h3>
        </div>
        <div class="box grid_8 omega" style="text-align: right">
            <% if (loaigiayphep == 1 && giaypheptontai)
               {%>
            <p>
                Số giấy phép :
                <%=Html.Encode(Model.SoGiayPhep) %></p>
            <p>
                <%if (Model.NgayCapPhepDoDac != null)
                  { %>
                Cấp ngày : <%= Html.Encode(Model.NgayCapPhepDoDac) %>
            
            <% } %>
                   </p>
              <% } %>
        </div>
        <div class="clear">
        </div>
        <div class="box">
            <h2>
                <a id="toggle-thongtinchung" href="#" style="cursor: pointer;">Thông tin chung</a>
            </h2>
            <div class="block" id="thongtinchung">
                <p>
                    <label class="grid_6">
                        Tên tổ chức/cá nhân :
                    </label>
                    <%= Html.TextBoxFor(m => m.TenToChuc, new { @class="text"})%>
                    <%= Html.ValidationMessageFor(m=>m.TenToChuc)%>
                </p>
                <p>
                    <label class="grid_6">
                        Quyết định thành lập/Giấy phép kinh doanh số :
                    </label>
                    <%= Html.TextBoxFor(m => m.GiayPhepKinhDoanh, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m=>m.GiayPhepKinhDoanh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Số giấy phép:
                    </label>
                    <% if (giaypheptontai == true)
                       { %>
                    <%= Html.TextBoxFor(m => m.SoGiayPhep, new { @class = "text", @disabled = "disabled" })%>
                    <% }
                       else
                       { %>
                    <%= Html.TextBoxFor(m => m.SoGiayPhep, new { @class = "text"})%>
                    <%} %>
                    <%= Html.ValidationMessageFor(m=>m.SoGiayPhep)%>
                </p>
                <p>
                    <label class="grid_6">
                        Ngày cấp phép :
                    </label>
                    <%= Html.TextBoxFor(m => m.NgayCapPhepDoDac, new { @class = "date-picker text" })%>
                </p>
                <p>
                    <label class="grid_6">
                        Tên tổ chức/cá nhân :
                    </label>
                    <%= Html.TextBoxFor(m => m.TenToChuc, new { @class="text"})%>
                    <%= Html.ValidationMessageFor(m=>m.TenToChuc)%>
                </p>
                <p>
                    <label class="grid_6">
                        Hạng của doanh nghiệp :
                    </label>
                    <%= Html.TextBoxFor(m => m.HangDoanhNghiep, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m=>m.HangDoanhNghiep)%>
                </p>
                <p>
                    <label class="grid_6">
                        Loại hình tổ chức
                    </label>
                    <%= Html.DropDownListFor(m => m.MaLoaiHinhToChuc, new SelectList(Model.loaiHinh, "MaLoaiHinhToChuc", "TenLoaiHinhToChuc", Model.MaLoaiHinhToChuc),new { style ="padding: 0.5em; background-color: #FFFFFF;border: 1px solid #BBBBBB;"})%>
                </p>
                <p>
                    <label class="grid_6">
                        Vốn pháp định :
                    </label>
                    <%= Html.TextBox("VonPhapDinh", string.Format("{0:0}", Model.VonPhapDinh), new { @class = "text" })%>
                    <!-- <%= Html.TextBoxFor(m => m.VonPhapDinh, new { @class = "text" })%> -->
                    <%= Html.ValidationMessageFor(m=>m.VonPhapDinh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Vốn lưu động :
                    </label>
                    <%= Html.TextBox("VonLuuDong", string.Format("{0:0}", Model.VonLuuDong), new { @class = "text" })%>
                    <!-- <%= Html.TextBoxFor(m => m.VonLuuDong, new { @class = "text" })%> -->
                    <%= Html.ValidationMessageFor(m=>m.VonLuuDong)%>
                </p>
                <p>
                    <label class="grid_6">
                        Số tài khoản :
                    </label>
                    <%= Html.TextBoxFor(m => m.SoTaiKhoan, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m=>m.SoTaiKhoan)%>
                </p>
                <p>
                    <label class="grid_6">
                        Tổng số cán bộ, công nhân viên (không kể cộng tác viên):
                    </label>
                    <%= Html.TextBoxFor(m => m.TongSoCanBo, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m=>m.TongSoCanBo)%>
                </p>
                <p>
                    <label class="grid_6">
                        Trụ sở chính tại :
                    </label>
                    <%= Html.TextAreaFor(m => m.TruSoChinh, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m=>m.TruSoChinh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Điện thoại cơ quan:
                    </label>
                    <%= Html.TextBoxFor(m => m.DienThoai, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m=>m.DienThoai)%>
                </p>
                <p>
                    <label class="grid_6">
                        Fax :
                    </label>
                    <%= Html.TextBoxFor(m => m.Fax, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m=>m.Fax)%>
                </p>
                <p>
                    <label class="grid_6">
                        Email :
                    </label>
                    <%= Html.TextBoxFor(m => m.Email, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m=>m.Email)%>
                </p>
            </div>
        </div>
        <div class="box">
            <h2>
                <a id="toggle-nangluc" href="#" style="cursor: pointer;">Kê khai năng lực</a>
            </h2>
            <div class="block" id="nangluc">
                <h4>
                    1. Lực lượng kỹ thuật</h4>
                <h5>a. Lực lượng kỹ thuật phân tích theo ngành nghề</h5>
                <span id="NangLuc_Validation" class="field-validation-error" style="display:none">Cần có ít nhât một lực lượng kỹ thuật</span>
                <div class="box">
                    <table class="mytable" id="editorNangLucRows">
                        <!-- Table header -->
                        <thead>
                            <tr>
                                <th>
                                    Ngành, nghề
                                </th>
                                <th>
                                    Đại học trở lên
                                </th>
                                <th>
                                    Trung cấp
                                </th>
                                <th>
                                    Công nhân kỹ thuật
                                </th>
                                <th>
                                    Loại khác
                                </th>
                                <th>
                                    &nbsp;
                                </th>
                            </tr>
                        </thead>
                        <!-- Table body -->
                        <tbody>
                            <% foreach (var item in Model.NangLucs)
                                   Html.RenderPartial("NangLucEditorRow", item);
                            %>
                        </tbody>
                    </table>
                    <%= Html.ActionLink("Thêm năng lực...", "BlankNangLucRow", new { formId = ViewContext.FormContext.FormId}, new { id = "addNangLucItem" })%>
                </div>
                <h5>b. Danh sách người chịu trách nhiệm trước pháp luật và người phụ trách kỹ thuật chính</h5>
                <span id="NhanLuc_Validation" class="field-validation-error" style="display:none">Cần có ít nhât một nhân lực</span>
                <div class="box">
                    <table class="mytable" id="editorNhanLucRows">
                        <!-- Table header -->
                        <thead>
                            <tr>
                                <th style="width: 200px;">
                                    Họ tên
                                </th>
                                <th>
                                    Chức vụ
                                </th>
                                <th>
                                    Bằng cấp
                                </th>
                                <th>
                                    Thâm niên nghề nghiệp
                                </th>
                                <th>
                                    &nbsp;
                                </th>
                            </tr>
                        </thead>
                        <!-- Table body -->
                        <tbody>
                            <% foreach (var item in Model.NhanLucs)
                                   Html.RenderPartial("NhanLucEditorRow", item);
                            %>
                        </tbody>
                    </table>
                    <%= Html.ActionLink("Thêm nhân lực...", "BlankNhanLucRow", new { formId = ViewContext.FormContext.FormId}, new { id = "addNhanLucItem" })%>
                </div>
                <h5>c. Danh sách thiết bị công nghệ</h5>
                <span id="ThietBi_Validation" class="field-validation-error" style="display:none">Cần có ít nhât một thiết bị</span>
                <div class="box">
                    <table class="mytable" id="editorThietBiRows">
                        <!-- Table header -->
                        <thead>
                            <tr>
                                <th style="width: 200px;">
                                    Tên thiết bị/Công nghệ
                                </th>
                                <th>
                                    Số Lượng
                                </th>
                                <th>
                                    Tình trạng
                                </th>
                                <th>
                                    Ghi chú
                                </th>
                                <th>
                                    &nbsp;
                                </th>
                            </tr>
                        </thead>
                        <!-- Table body -->
                        <tbody>
                            <% foreach (var item in Model.ThietBis)
                                   Html.RenderPartial("ThietBiEditorRow", item);
                            %>
                        </tbody>
                    </table>
                    <%= Html.ActionLink("Thêm thiết bị...", "BlankThietBiRow", new { formId = ViewContext.FormContext.FormId}, new { id = "addThietBiItem" })%>
                </div>
            </div>
        </div>
        <% if (loaigiayphep == 1 || loaigiayphep == 2)
           {%>
        <div class="box">
            <h2>
                <a id="toggle-baocaothhd" href="#" style="cursor: pointer;">Báo cáo tình hình hoạt động</a>
            </h2>
            <div class="block" id="baocaothhd">
                <p>
                    <label class="grid_2">
                        Từ năm:
                    </label>
                    <select class="grid_2" id="tunamselector" onchange="chageSelect();" style="padding: 0.5em;
                        background-color: #FFFFFF; border: 1px solid #BBBBBB;">
                        <% for (int j = DateTime.Now.Year; j > 1989; j--)
                           { %>
                        <option value="<%=j %>" <%=(Model.TuNam == j)? "selected='selected'":String.Empty %>>
                            <%=j %></option>
                        <%} %>
                    </select>
                    <label class="grid_3">
                        Đến năm:
                    </label>
                    <select id="Select1" class="grid_2" onchange="chageSelect();" style="padding: 0.5em;
                        background-color: #FFFFFF; border: 1px solid #BBBBBB;">
                        <% for (int j = DateTime.Now.Year; j > 1989; j--)
                           { %>
                        <option value="<%=j %>" <%=(Model.DenNam == j)? "selected='selected'":String.Empty %>>
                            <%=j %></option>
                        <%} %>
                    </select>
                </p>
                <p>
                    <label class="grid_6">
                        Doanh thu năm:
                    </label>
                    <%= Html.TextBox("DoanhThuNam", string.Format("{0:0}", Model.VonLuuDong), new { @class = "text" })%>
                    <!-- <%= Html.TextBoxFor(m => m.DoanhThuNam, new { @class = "text" })%> -->
                    <%= Html.ValidationMessageFor(m=>m.DoanhThuNam)%>
                </p>
                <p>
                    <label class="grid_6">
                        Nộp ngân sách:
                    </label>
                    <%= Html.TextBox("NopNganSach", string.Format("{0:0}", Model.VonLuuDong), new { @class = "text" })%>
                    <!-- <%= Html.TextBoxFor(m => m.NopNganSach, new { @class = "text" })%> -->
                    <%= Html.ValidationMessageFor(m=>m.NopNganSach)%>
                </p>
                <h5>
                    Danh sách công trình thực hiện</h5>
                <div class="box">
                    <table class="mytable" id="editorCongTrinhRows">
                        <!-- Table header -->
                        <thead>
                            <tr>
                                <th style="width: 200px;">
                                    Tên công trình
                                </th>
                                <th>
                                    Chủ đầu tư
                                </th>
                                <th>
                                    Công đoạn đã thi công
                                </th>
                                <th>
                                    Giá trị thực hiện
                                </th>
                                <th>
                                    Thời gian thực hiện
                                </th>
                                <th>
                                    Ghi chú
                                </th>
                                <th>
                                    &nbsp;
                                </th>
                            </tr>
                        </thead>
                        <!-- Table body -->
                        <tbody>
                            <% foreach (var item in Model.CongTrinhs)
                                   Html.RenderPartial("CongTrinhEditorRow", item);
                            %>
                        </tbody>
                    </table>
                    <%= Html.ActionLink("Thêm công trình...", "BlankCongTrinhRow", new { formId = ViewContext.FormContext.FormId}, new { id = "addCongTrinhItem" })%>
                </div>
            </div>
            <%} %>
            <div class="box">
                <h2>
                    <a id="toggle-hoso" href="#" style="cursor: pointer;">Hồ sơ đính kèm</a>
                </h2>
                <div class="block" id="hoso">
                    <% 
                        if ((loaigiayphep == 1))
                        { %>
                    <p>
                        <label>
                            Nội dung hồ sơ đính kèm gồm:</label></p>
                    <p style="padding-left: 50px;">
                        1. Giấy phép hoạt động bản đồ đã được cấp.<br />
                        2. Giấy tờ khác.
                        <br />
                    </p>
                    <%} %>
                    <p>
                        <label class="grid_6">
                            Hồ sơ đính kèm cũ :
                        </label>
                        <% // Neu tochuc co ho so thi hien thi ho so dinh kem cu 
                            if (Model.TepDinhKem != null && Model.TepDinhKem != "")
                            {%>
                        <%= Html.ActionLink("Tải xuống", "Download", new { fn = Model.TepDinhKem })%>
                    </p>
                    <%
                        }
                            else
                            { %>
                    Không tìm thấy hồ sơ đính kèm cũ
                    <%} %>
                    <p>
                        <label class="grid_6">
                            Hồ sơ đăng ký đính kèm mới:
                        </label>
                        <input type="file" id="tepdinhkem" name="tepdinhkem" />
                    </p>
                </div>
            </div>
            <% 
                if (loaigiayphep == 1)
                { %>
            <div class="box">
                <h2>
                    <a id="toggle-hoatdongmoi" href="#" style="cursor: pointer;">Đăng ký hoạt động bổ sung</a>
                </h2>
                <div class="block" id="hoatdongmoi">
                                    <p>
                        <label class="grid_6">
                            Danh sách hoạt động đã đăng ký :
                        </label>
                        <% int n = 1;
                           foreach (string j in Model.DSHoatDongDaDKs)
                           { %>
                        <p>
                            <%= n %>.
                            <%= j %><br />
                            <% n++; %>
                        </p>
                        <% } %>
                    </p>
                    <p>
                        <label class="grid_6">
                            Danh sách hoạt động bổ sung :
                        </label>
                    </p>
                    
                <div class="prefix_3">

                    <%= Html.ListBoxFor(m => m.DSHoatDongSelecteds, new MultiSelectList(Model.DSHoatDongs, "MaHoatDong", "TenHoatDong", Model.DSHoatDongSelecteds), new { size=8, @class="multi" })%>
                </div>
                </div>
            </div>
            <%} %>
            <div class="box">
                <div class="block">
                    <p>
                        <label class="grid_6">
                            Lý do :
                        </label>
                        <%= Html.TextAreaFor(m => m.LyDo, new { @class = "text" })%>
                        <%= Html.ValidationMessageFor(m=>m.LyDo)%>
                    </p>
                    <p>
                        <label class="grid_6">
                            Cam kết :
                        </label>
                        <%= Html.TextAreaFor(m => m.Camket, new { @class = "text" })%>
                        <%= Html.ValidationMessageFor(m=>m.Camket)%>
                    </p>
                </div>
                <input type="hidden" id="Save" value="0" />
                <div class="block prefix_4">
                    <button id="saveButton" class="button redmond">
                        <span class="save">Lưu lại</span></button>
                    <button id="sendButton" class="button redmond">
                        <span class="send">Gửi đi</span></button>
                </div>
            </div>
            <%} %>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

    <script src="/Scripts/multiselectable.js" type="text/javascript"></script>

    <script type="text/javascript" src="<%= Url.Content("~/Scripts/MicrosoftAjax.js") %>"></script>

    <script src="../../Scripts/swfupload.js" type="text/javascript"> </script>

    <script src="../../Scripts/jquery-asyncUpload-0.1.js" type="text/javascript"></script>

    <script type="text/javascript" src="<%= Url.Content("~/Scripts/MicrosoftMvcValidation.debug.js") %>"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $('.multi').multiselectable({
                selectableLabel: 'Danh sách hoạt động',
                selectedLabel: 'Danh sách đã chọn'
            })
        });

        $(function() {
            $('.date-picker').datepicker({
                changeDate: true,
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
                dateFormat: 'dd-mm-yy',
                onClose: function(dateText, inst) {
                    var day = $("#ui-datepicker-div .ui-datepicker-date :selected").val();
                    var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                    var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                    $(this).datepicker('setDate', new Date(year, month, dateText));
                }
            });

            $("#addCongTrinhItem").click(function() {
                $.ajax({
                    url: this.href,
                    cache: false,
                    success: function(html) { $("#editorCongTrinhRows").append(html); }
                });
                return false;
            });

            $("a.deleteCongTrinhRow").live("click", function() {
                $(this).parents("tr.editorCongTrinhRow:first").remove();
                return false;
            });

            $("#addNhanLucItem").click(function() {
                $.ajax({
                    url: this.href,
                    cache: false,
                    success: function(html) { $("#editorNhanLucRows").append(html); }
                });
                return false;
            });

            $("a.deleteNhanLucRow").live("click", function() {
                $(this).parents("tr.editorNhanLucRow:first").remove();
                return false;
            });

            $("#addThietBiItem").click(function() {
                $.ajax({
                    url: this.href,
                    cache: false,
                    success: function(html) { $("#editorThietBiRows").append(html); }
                });
                return false;
            });

            $("a.deleteThietBiRow").live("click", function() {
                $(this).parents("tr.editorThietBiRow:first").remove();
                return false;
            });

            $("#addNangLucItem").click(function() {
                $.ajax({
                    url: this.href,
                    cache: false,
                    success: function(html) { $("#editorNangLucRows").append(html); }
                });
                return false;
            });

            $("a.deleteNangLucRow").live("click", function() {
                $(this).parents("tr.editorNangLucRow:first").remove();
                return false;
            });

            $("#tepdinhkem").makeAsyncUploader({
                upload_url: "/dangkygiayphep/uploader",
                flash_url: '/Scripts/swfupload.swf',
                button_image_url: '/Content/images/blankButton.png',
                disableDuringUpload: 'INPUT[type="submit"]',
                file_types: "*.rar;*.zip",
                file_size_limit: "3072"
            });

            $('#saveButton').click(function() {
                document.getElementById("save").value = 0;
                $('#bosungForm').submit();
            });

            $('#sendButton').click(function() {
                // Luu lai
                var count1 = $("#editorNangLucRows").length;
                var count2 = $("#editorNhanLucRows").length;
                var count3 = $("#editorThietBiRows").length;
                alert(count1);
                alert(count2);
                alert(count3);
//                if (count1 == 1) {
//                    alert("chưa kê khai năng lực");
//                }
//                else if (count1 == 1) {
//                    alert("chưa liệt kê danh sách người chịu trách nhiệm");
//                }
//                else if (count3 == 1) {
//                    alert("chưa liệt kê danh sách thiết bị");
//                }
//                else {
//                    $('#bosungForm').submit();
//                }
            });

            $('#bosungForm').submit(
                function() {
                    $("#NangLuc_Validation").hide();
                    $("#NhanLuc_Validation").hide();
                    $("#ThietBi_Validation").hide();

                    var nangLucRows = $(this).find('.editorNangLucRow');
                    var nhanLucRows = $(this).find('.editorNhanLucRow');
                    var thietBiRows = $(this).find('.editorThietBiRow');

                    var nangLucSize = nangLucRows.size();
                    var nhanLucSize = nhanLucRows.size();
                    var thietBiSize = thietBiRows.size();

                    //                    for (var i = 0; i < rows.size(); i++) {
                    //                        var row = rows.get(i);
                    //                        var cols = $(row).find('input');
                    //                        var firstCol = cols.get(0);
                    //                        alert($(firstCol).val());
                    //                        if ($.trim($(firstCol).val()) == '') {
                    //                            $(row).remove();
                    //                            nhanlucSize--;
                    //                        }
                    //                    }
                    if (nangLucSize <= 0) {
                        $("#NangLuc_Validation").show();
                    }
                    if (nhanLucSize <= 0) {
                        $("#NhanLuc_Validation").show();
                    }
                    if (thietBiSize <= 0) {
                        $("#ThietBi_Validation").show();
                    }
                    var input1 = document.createElement("input");
                    input1.setAttribute("type", "hidden");
                    input1.setAttribute("name", "save");
                    input1.setAttribute("value", $('#save').val());
                    $(this).append(input1);
                    return true;
                });
        });

    </script>

</asp:Content>
<%--                    <div id="editorNangLucRows">
                        <% foreach (var item in Model.NangLucs)
                               Html.RenderPartial("NangLucEditorRow", item);
                        %>
                    </div>--%>
<%--<fieldset>
                        <p>
                            <label class="grid_4">
                                Ngành nghề :
                            </label>
                            <input class="text" type="text" id="nangluc_nganhnghe" name="nangluc_nganhnghe" />
                        </p>
                        <p>
                            <label class="grid_4">
                                Đại học trở lên :
                            </label>
                            <input class="text grid_2" id="nangluc_daihoc" name="nangluc_daihoc" />
                            <label class="grid_3">
                                Trung cấp :
                            </label>
                            <input class="text grid_2" type="text" id="Text2" name="nangluc_nganhnghe" />
                        </p>
                        <p>
                            <label class="grid_4">
                                Công nhân kỹ thuật :
                            </label>
                            <input class="text grid_2" type="text" id="Text3" name="nangluc_nganhnghe" />
                            <label class="grid_3">
                                Loại khác :
                            </label>
                            <input class="text grid_2" type="text" id="Text4" name="nangluc_nganhnghe" />
                            <span class="prefix_1">
                                <button id="AddNangLucButton" class="button redmond">
                                    <span class="add">Thêm vào</span></button>
                            </span>
                        </p>
                    </fieldset>--%>
<%-- %>/*
            $("#addNangLucItem").click(function() {
                $.ajax({
                    url: this.href,
                    cache: false,
                    success: function(html) { $("#editorNangLucRows").append(html); }
                });
                return false;
            });

            $("a.deleteNangLucRow").live("click", function() {
                $(this).parents("div.editorNangLucRow:first").remove();
                return false;
            });*/--%>