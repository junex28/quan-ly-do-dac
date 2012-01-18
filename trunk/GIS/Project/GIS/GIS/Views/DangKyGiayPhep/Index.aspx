﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

<%@ Import Namespace="GIS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Đăng ký hồ sơ giấy phép
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.EnableClientValidation(); %>
    <% using (Html.BeginForm("DangKy","DangKyGiayPhep", FormMethod.Post ,new { enctype = "multipart/form-data" }))
       { %>
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
                                <th> &nbsp;</th>
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
                    
                    <div id="nanglucresult">
                    </div>
                </div>
                <h5>
                    b. Danh sách người chịu trách nhiệm trước pháp luật và người phụ trách kỹ thuật
                    chính</h5>
                <div class="box">
                  <table class="mytable" id="editorNhanLucRows">
                        <!-- Table header -->
                        <thead>
                            <tr>
 	                        <th style="width:200px;">Họ tên</th>
	                        <th>Chức vụ</th>
	                        <th>Bằng cấp</th>
	                        <th>Thâm niên nghề nghiệp</th>
                            <th> &nbsp;</th>
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
 	                        <th style="width:200px;">Tên thiết bị/Công nghệ</th>
	                        <th>Số Lượng</th>
	                        <th>Tình trạng</th>
	                        <th>Ghi chú</th>
                            <th> &nbsp;</th>
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
            <div class="box">
            <h2>
                <a id="toggle-hoso" href="#" style="cursor: pointer;">Hồ sơ đính kèm</a>
            </h2>
            <div class="block" id="hoso">
                <p>
                    <label class="grid_6">
                        Hồ sơ đăng ký đính kèm :
                    </label>                    
                    <input type="file" id="tepdinhkem" name="tepdinhkem" />

                </p>
            </div>
        </div>
        </div>
        <%} %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="<%= Url.Content("~/Scripts/MicrosoftAjax.js") %>"></script>
    <script src="../../Scripts/swfupload.js" type="text/javascript"> </script>
    <script src="../../Scripts/jquery-asyncUpload-0.1.js" type="text/javascript"></script>   
    <script type="text/javascript" src="<%= Url.Content("~/Scripts/MicrosoftMvcValidation.debug.js") %>"></script>
    <script type="text/javascript">
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