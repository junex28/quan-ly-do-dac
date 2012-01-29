<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

<%@ Import Namespace="GIS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Đăng ký hồ sơ giấy phép
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.EnableClientValidation(); %>
    <% using (Html.BeginForm("TaoMoi", "DangKyGiayPhep", FormMethod.Post, new { enctype = "multipart/form-data" , id = "taomoiForm" }))
       {
           // Cac loai tinh trang
           int loaigiayphep = 0; // xin cap giay phep moi 
           // loaigiayphep = 1;  xin cap giay phep bosung 
           // loaigiayphep = 2; // xin cap giay phep gia han 
           var save = "1";
    %>
    <input id="save" type="hidden" value="<%=save%>"/>
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
            <% if (false)
               {%>
            <p>
                Số giấy phép :{SoGiayPhep}</p>
            <p>
                Cấp ngày : {NgayCapPhep}
            </p>
            <%  } %>
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
                    <%= Html.TextBoxFor(m => m.VonPhapDinh, new { @class = "text" })%>
                    <%= Html.ValidationMessageFor(m=>m.VonPhapDinh)%>
                </p>
                <p>
                    <label class="grid_6">
                        Vốn lưu động :
                    </label>
                    <%= Html.TextBoxFor(m => m.VonLuuDong, new { @class = "text" })%>
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
                <h5>
                    a. Lực lượng kỹ thuật phân tích theo ngành nghề</h5>
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
                <h5>
                    b. Danh sách người chịu trách nhiệm trước pháp luật và người phụ trách kỹ thuật
                    chính</h5>
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
                <h5>
                    c. Danh sách thiết bị công nghệ</h5>
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
            </div>
        </div>
        <%} %>
        <div class="box">
            <h2>
                <a id="toggle-hoso" href="#" style="cursor: pointer;">Hồ sơ đính kèm</a>
            </h2>
            <div class="block" id="hoso">
                <% 
                    if ((loaigiayphep == 0))
                    { %>
                <p>
                    <label>
                        Nội dung hồ sơ đính kèm gồm:</label></p>
                <p style="padding-left: 50px;">
                    1. Bản sao quyết định thành lập hoặc Giấy phép Đăng ký kinh doanh.<br />
                    2. Bản sao quyết định bổ nhiệm.
                    <br />
                    3. Điều lệ hoặc quy chế hoạt động.
                    <br />
                    4. Bản sao văn bằng chứng chỉ của người chịu trách nhiệm trước pháp luật.<br />
                    5. Bản sao văn bằng chứng chỉ của người phụ trách kỹ thuật chính.<br />
                    6. Giấy tờ khác.
                    <br />
                </p>
                <%} %>
                <% // Neu tochuc co ho so thi hien thi ho so dinh kem cu 
                    var hosocu = false;
                    if (hosocu)
                    {%>
                <p>
                    <label class="grid_6">
                        Hồ sơ đính kèm cũ :
                    </label>
                    Tải xuống
                </p>
                <%
                    }  %>
                <p>
                    <label class="grid_6">
                        Hồ sơ đăng ký đính kèm mới:
                    </label>
                    <input type="file" id="tepdinhkem" name="tepdinhkem" />
                </p>
            </div>
        </div>
        <% 
            if (loaigiayphep == 0)
            { %>
        <div class="box">
            <h2>
                <a id="toggle-hoatdongmoi" href="#" style="cursor: pointer;">Đăng ký hoạt động mới</a>
            </h2>
            <div class="block prefix_3" id="hoatdongmoi">
                <%= Html.ListBoxFor(m => m.DSHoatDongSelecteds, new MultiSelectList(Model.DSHoatDongs, "MaHoatDong", "TenHoatDong", Model.DSHoatDongSelecteds), new { size=8, @class="multi" })%>
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
                $('#taomoiForm').submit();
            });

            $('#sendButton').click(function() {
                // Luu lai
                var count1 = $("#editorNangLucRows").length;
                var count2 = $("#editorNhanLucRows").length;
                var count3 = $("#editorThietBiRows").length;
//                //var count4 = $("#hoatdongmoi").items.count();
//                //alert(count4);
//                //alert(count);
                if (count1 == 1) {
                    alert("chưa kê khai năng lực");
                }
                else if (count1 == 1) {
                    alert("chưa liệt kê danh sách người chịu trách nhiệm");
                }
                else if (count3 == 1) {
                    alert("chưa liệt kê danh sách thiết bị");
                }
                else {
                    $('#taomoiForm').submit();
                }
            });

            $('#taomoiForm').submit(
                function() {
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