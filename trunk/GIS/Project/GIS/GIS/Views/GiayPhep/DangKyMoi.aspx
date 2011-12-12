<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    DangKyMoi
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<% using (Html.BeginForm())
   { %>
    <fieldset class="formVertical">
        <div class="span subHeader"><h3>Thông Tin Chung </h3></div>
        <div class="span subContent">
			<dl class="span w16">
				<dt class="w4"><label>Tên tổ chức</label></dt>
				<dd><input type="text" class="w23" /></dd>
			</dl>
			<dl class="span w16">
				<dt class="w4"><label>Loại tổ chức</label></dt>
				<dd><select class="w23"></select></dd>
			</dl>
			<dl class="span w16">
				<dt class="w4"><label>Người đại diện</label></dt>
				<dd><input type="text" class="w23" /></dd>
			</dl>
			<dl class="span w16">
				<dt class="w4"><label>Số cán bộ</label></dt>
				<dd><input type="text" class="w23" /></dd>
			</dl>
			<dl class="span w16">
				<dt class="w4"><label>QDDTL/GPKD</label></dt>
				<dd><input type="text" class="w23" /></dd>
			</dl>
			<dl class="span w16">
				<dt class="w4"><label>Email</label></dt>
				<dd><input type="text" class="w23" /></dd>
			</dl>
			<dl class="span w16">
				<dt class="w4"><label>Trụ sở chính</label></dt>
				<dd><input type="text" class="w23" /></dd>
			</dl>
			<dl class="span w16">
				<dt class="w4"><label>Số tài khoản</label></dt>
				<dd><input type="text" class="w23" /></dd>
			</dl>
			<dl class="span w16">
				<dt class="w4"><label>Số điện thoại</label></dt>
				<dd><input type="text" class="w23" /></dd>
			</dl>
			<dl class="span w16">
				<dt class="w4"><label>Fax</label></dt>
				<dd><input type="text" class="w23" /></dd>
			</dl>
        </div>
    </fieldset>
    <fieldset class="formVertical">
        <div class="span subHeader"><h3>Lĩnh vực hoạt động</h3></div>
        <div class="span subContent">
            <select class="multiselect" multiple="multiple" name="alo">
                <option value="1" selected="selected">1</option>
                <option value="2">2</option>
            </select>
        </div>
    </fieldset>
    <fieldset class="formVertical">
        <div class="span subHeader"><h3>Tệp đính kèm</h3></div>
        <div class="span subContent">
			<input type="file" />
        </div>
    </fieldset>
	<input class="formVertical jui-button" type="submit" value="Đăng ký" />
    <script type="text/javascript">
        $(function() {
            $(".multiselect").multiselectable({
                selectedLabel: 'Đã được cấp phép',
                selectableLabel: 'Chưa được cấp phép'
            });
        });
    </script>
<% } %>
</asp:Content>