﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ThamDinhEditViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Cập nhật biên bản thẩm định
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">
        var save;
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
            $("#NgayThamDinh").datepicker();
        });
        $(function() {

            $('#xetduyetButton').click(function() {
                save = 1;
                $('#xetduyetForm').submit();
            });

            $('#khongduyetButton').click(function() {
                save = 0;
                $('#xetduyetForm').submit();
            });

            $('#saveButton').click(function() {
                // Luu lai
                save = 2;
                $('#xetduyetForm').submit();
            });


            $('#xetduyetForm').submit(
                function() {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "gpid");
                    input.setAttribute("value", "<%=Model.giayphep.MaHoSo%>");
                    $(this).append(input);
                    var input = document.createElement("input1");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "save");
                    input.setAttribute("value", save);
                    $(this).append(input);
                    return true;
                });
        });
    </script>

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_19 alpha">
        <div class="box grid_10 alpha">
            <h3>
                Thẩm định hồ sơ
                <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang == 1)
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
        <div class="box grid_8 omega" style="text-align: right">
            <% if (Model.giayphep.SoGiayPhep != null)
               {%>
            <p>
                Số giấy phép :<%=Html.Encode(Model.giayphep.SoGiayPhep)%></p>
            <p>
                Cấp ngày :
                <%= Model.giayphep.NgayCapPhep == null || Model.giayphep.NgayCapPhep.ToString() == "" ? ""  :(Model.giayphep.NgayCapPhep.Value.ToShortDateString())%>
                <%} %>
        </div>
        <div class="clear">
        </div>
        <% Html.RenderPartial("ThongTinChung", Model.thongtinchung); %>
        <div class="box">
            <h2>
                <a id="toggle-thamdinh" href="#" style="cursor: pointer;">Biên bản thẩm định</a>
            </h2>
            <div class="block" id="thamdinh">
                <% using (Html.BeginForm())
                   {%>
                <p>
                    <label class="grid_6 labelnor">
                        Ngày thẩm định :
                    </label>
                    <% if (Model.ThamDinh.NgayThamDinh != null)
                       { %>
                    <%=Html.Encode(Model.ThamDinh.NgayThamDinh.Value.ToShortDateString())%>
                    <%} %>
                </p>
                <p>
                    <label class="grid_6 labelnor">
                        Thành phần cơ quan thẩm định :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.NguoiThamDinh)%>
                </p>
                <p>
                    <label class="grid_6 labelnor">
                        Thành phần tổ chức đề nghị cấp giấy phép :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.NguoiPhiaToChuc)%>
                </p>
                <p>
                    <label class="grid_6 labelnor">
                        Thẩm định kê khai lực lượng kỹ thuật :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.NangLucNhanVien)%>
                </p>
                <p>
                <p>
                    <label class="grid_6 labelnor">
                        Thẩm định năng lực thiết bị :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.NangLucThietBi)%>
                </p>
                    <label class="grid_6 labelnor">
                        Kết luận :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.KetLuan)%>
                </p>
                <p>
                    <label class="grid_6 labelnor">
                        Kiến nghị :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.KienNghi)%>
                </p>
                <% if (Model.giayphep.SoGiayPhep != null && Model.giayphep.SoGiayPhep != "")
                   { %>
                <p>
                    <label class="grid_6 labelnor">
                        Số giấy phép :
                    </label>
                    <%= Html.Encode(Model.ThamDinh.HoSoGiayPhep.SoGiayPhep)%>
                </p>
                <% }%>
                <%} %>
            </div>
        </div>
        <div class="box">
            <div class="block prefix_4">
                <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                    <span class="back">Thoát</span></button>
                <%= Html.ActionLink("Download", "Download", new { tdid = Model.ThamDinh.MaThamDinh, gpid= Model.giayphep.MaHoSo})%>
            </div>
        </div>
    </div>
</asp:Content>
