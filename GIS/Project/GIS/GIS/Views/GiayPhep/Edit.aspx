<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.GiayPhepDetailModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thay đổi thông tin giấy phép
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
    </script>

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <%= Html.ValidationSummary(true) %>
    <div class="action-button">
        <%= Html.ActionLink("Danh sách giấy phép", "Index", null, new { id = "danhsachButton" })%>
    </div>
    <% using (Html.BeginForm())
       {%>
    <fieldset class="formVertical">
        <div class="span subHeader">
            <h3>
                Thông Tin Chung
            </h3>
        </div>
        <div class="span subContent">
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(model => model.giayphep.ToChuc.TenToChuc) %></dt>
                <dd>
                    <%= Html.TextBox("Tên tổ chức", Model.giayphep.ToChuc.TenToChuc, new { @disabled = "disabled" })%>
                </dd>
            </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(model => model.giayphep.SoGiayPhep) %></dt>
                <dd>
                    <%= Html.TextBox("Số giấy phép", Model.giayphep.SoGiayPhep)%>
                    <%= Html.ValidationMessageFor(model => model.giayphep.SoGiayPhep)%>
                </dd>
            </dl>
        </div>
        <dl class="span w16">
            <dt class="w4">
                <%= Html.LabelFor(model => model.giayphep.NgayXinPhep)%></dt>
            <dd>
                <%= Html.TextBox("Ngày xin phép", Model.giayphep.NgayXinPhep.Value.ToShortDateString(), new { @class = "date-picker" ,@disabled="disabled"})%>
                <%= Html.ValidationMessageFor(model => model.giayphep.NgayXinPhep)%>
            </dd>
        </dl>
        <dl class="span w16">
            <dt class="w4">
                <%= Html.LabelFor(model => model.giayphep.LyDoXinPhep) %></dt>
            <dd>
                <%= Html.TextBox("Lý do xin phép", Model.giayphep.LyDoXinPhep, new { @disabled = "disabled" })%>
                <%= Html.ValidationMessageFor(model => model.giayphep.LyDoXinPhep)%>
            </dd>
        </dl>
        <dl class="span w16">
            <dt class="w4">
                <%= Html.LabelFor(model => model.giayphep.CamKetXinPhep) %></dt>
            <dd>
                <%= Html.TextBox("Cam kết xin phép", Model.giayphep.CamKetXinPhep, new { @disabled = "disabled" })%>
                <%= Html.ValidationMessageFor(model => model.giayphep.CamKetXinPhep)%>
            </dd>
        </dl>
        <dl class="span w16">
            <dt class="w4">
                <%= Html.LabelFor(model => model.giayphep.NgayCapPhep) %></dt>
            <dd>
                <%= Html.TextBox("Ngày cấp phép", Model.giayphep.NgayCapPhep, new { @class="date-picker"})%>
                <%= Html.ValidationMessageFor(model => model.giayphep.NgayCapPhep)%>
            </dd>
        </dl>
        <dl class="span w16">
            <dt class="w4">
                <%= Html.LabelFor(model => model.giayphep.LyDoCapPhep) %></dt>
            <dd>
                <%= Html.TextBox("Lý do cấp phép", Model.giayphep.LyDoCapPhep)%>
                <%= Html.ValidationMessageFor(model => model.giayphep.LyDoCapPhep)%>
            </dd>
        </dl>
    </fieldset>
    <fieldset class="formVertical">
        <div class="span subHeader">
            <h3>
                Thông Tin gia hạn
            </h3>
        </div>
        <div>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(model => model.giayphep.NgayXinGiaHan) %></dt>
                <dd>
                    <%= Html.TextBox("Ngày xin gia hạn", Model.giayphep.NgayXinGiaHan, new { @disabled = "disabled" })%>
                    <%= Html.ValidationMessageFor(model => model.giayphep.NgayXinGiaHan)%>
                </dd>
            </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(model => model.giayphep.LyDoGiaHan) %></dt>
                <dd>
                    <%= Html.TextBox("Lý do gia hạn", Model.giayphep.LyDoGiaHan, new { @disabled = "disabled" })%>
                    <%= Html.ValidationMessageFor(model => model.giayphep.LyDoGiaHan)%>
                </dd>
            </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(model => model.giayphep.NgayGiaHan) %></dt>
                <dd>
                    <%= Html.TextBox("Ngày gia hạn", Model.giayphep.NgayGiaHan, new { @disabled = "disabled" })%>
                    <%= Html.ValidationMessageFor(model => model.giayphep.NgayGiaHan)%>
                </dd>
            </dl>
        </div>
        
            <div class="span subHeader">
                <h3>
                    Thông tin bổ sung hoạt động</h3>
            </div>
            <div class="span subContent">
                <dl class="span w16">
                    <dt class="w4">
                        <%= Html.LabelFor(model => model.giayphep.NgayXinBoSung) %></dt>
                    <dd>
                        <%= Html.TextBox("Ngày xin bổ sung", Model.giayphep.NgayXinBoSung, new { @disabled = "disabled" })%>
                        <%= Html.ValidationMessageFor(model => model.giayphep.NgayXinBoSung)%>
                    </dd>
                </dl>
                <dl class="span w16">
                    <dt class="w4">
                        <%= Html.LabelFor(model => model.giayphep.CamKetBoSung) %></dt>
                    <dd>
                        <%= Html.TextBox("Cam kết bổ sung", Model.giayphep.CamKetBoSung,new {@disabled = "disabled"})%>
                        <%= Html.ValidationMessageFor(model => model.giayphep.CamKetBoSung)%>
                    </dd>
                </dl>
            </div>
            </fieldset>
            <fieldset>
            <div class="span subHeader">
                <h3>
                    Lĩnh vực hoạt động</h3>
            </div>
            <br/>
            <p>
                <div>
                    <table frame="border">
                        <tr>
                            <td>
                                Mã đăng ký
                            </td>
                            <td>
                                Tên hoạt động
                            </td>
                            <td>
                                Loại hoạt động
                            </td>
                            <td>
                                Ngày bổ sung
                            </td>
                            <td>
                                Tình trạng
                            </td>
                        </tr>
                        <% foreach (var item in Model.DangKy)
                           {%>
                        <tr>
                            <% String str = "";
                               if (item.LaBoSung != null)
                               {
                                   if (item.LaBoSung == true)
                                       str = "Bổ sung";
                                   else str = "Không phải bổ sung";
                               }%>
                            <td>
                                <%=Html.Encode(item.MaDangKyHoatDong)%>
                            </td>
                            <td>
                                <%=Html.Encode(item.HoatDong.TenHoatDong)%>
                            </td>
                            <td>
                                <%=Html.Encode(str)%>
                            </td>
                            <td>
                                <%=Html.Encode(item.NgayBoSung.Value.ToShortDateString())%>
                            </td>
                            <td>
                                <%=Html.Encode(item.TinhTrangXetDuyet.DienGiai)%>
                            </td>
                        </tr>
                        <%} %>
                    </table>
                </div>
        </p>
        <%-- <div class="span subContent">
                <select class="multiselect" multiple="multiple" name="alo" disabled=disabled>
                    <% foreach (var item in (MultiSelectList)ViewData["hoatdong"])
                       { %>
                    <option disabled="disabled" value="<%=item.Value%>" <%=item.Selected? "selected='selected'":String.Empty %>>
                        <%=item.Text%></option>
                    <% } %>
                </select>
            </div>
        </div>--%>
    </fieldset>
    <input class="formVertical" type="submit" value="Lưu lại" />

    <script type="text/javascript">

        $(function() {
            $("input[type=submit]").button();
            $(".multiselect").multiselectable({
                selectedLabel: 'Hoạt động ',
                selectableLabel: 'Hoạt động xin phép'
            });
            $("")
        });
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

    </script>

    <style>
        .ui-datepicker table
        {
            display: none;
        }
    </style>
    <% } %>
</asp:Content>
