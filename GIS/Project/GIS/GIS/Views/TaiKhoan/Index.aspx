<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Quản lý tài khoản
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <div class="grid_12 alpha">
        <div class="box">
         <button id="detailButton" class="button redmond">
         <span class="detail">Chi tiết</span></button>
        <button id="editButton" class="button redmond">
         <span class="edit">Sửa</span></button>
        <button id="deleteButton" class="button redmond">
        <span class="delete">Xóa</span></button>
        <button id="enableButton" class="button redmond">
        <span class="unlock">Kích hoạt</span></button>
        </div>
       
 </div>
      <div class="grid_7 omega">
        <div class="box">
            <form>
            <p>
            <input class="text grid_4" type="text" size="17" id="item" onkeydown="doSearch(arguments[0]||event)" />
            <button class="btnSearch" onclick="gridReload()" id="submitButton">
                <span class="search"></span>
            </button>
            </p>
            <p>            
            <input type="checkbox" id="autosearch" onclick="enableAutosubmit(this.checked)" />
                &nbsp;Tự động</p>
            <div id="search" style="visibility: hidden; width: 10px; height: 10px">
             </div>
            </form>
       
    </div></div>
     <div class="clear">
    </div>
    <div class="box">
        <table id="grid"></table>
        <div id="pager"></div>
    </div>
    
    <% using (Html.BeginForm("ChiTiet", "TaiKhoan", FormMethod.Get, new { id = "detailForm" })) { } %>
    <% using (Html.BeginForm("CapNhat", "TaiKhoan", FormMethod.Get, new { id = "editForm" })) { } %>
    <% using (Html.BeginForm("Xoa", "TaiKhoan", FormMethod.Post, new { id = "deleteForm" })) { } %>
    <% using (Html.BeginForm("KichHoat", "TaiKhoan", FormMethod.Post, new { id = "enableForm" })) { } %>
  

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
   <script type="text/javascript">
       $(function() {        
           $('#enableButton').button({
                icons: 
                    {
                        primary: "ui-icon-unlocked"   
                    }
               });
           $('#editButton').click(function() {
               $('#editForm').submit();
           });

           $('#deleteButton').click(function() {
               $('#deleteForm').submit();
           });

           $('#detailButton').click(function() {
               $('#detailForm').submit();
           });

           $("#grid").jqGrid({
               url: '<%= Url.Action("ListData","TaiKhoan") %>',
               editurl: '',
               mtype: "GET",
               datatype: "json",
               colNames: ['Mã Tài Khoản', 'Tên Tài Khoản', 'Nhóm Người dùng', 'Họ và Tên', 'Email', 'Tình Trạng'],
               colModel: [
                { name: 'MaTaiKhoan', index: 'MaTaiKhoan', width: 10, align: 'left', sortable: false },
                { name: 'TenTaiKhoan', index: 'TenTaiKhoan', width: 40, align: 'left', sortable: true },
                { name: 'NhomNguoiDung', index: 'NhomNguoiDung', width: 40, align: 'left', sortable: true },
                { name: 'HoTen', index: 'HoTen', width: 40, align: 'left', sortable: true },
                { name: 'Email', index: 'Email', width: 40, align: 'left', sortable: false },
                { name: 'TinhTrang', index: 'TinhTrang', width: 50, align: 'left', sortable: true}],
               page: '<%= ViewData["page"] %>',
               rowNum: 20,
               rowList: [10, 20, 50],
               pager: '#pager',
               sortname: 'MaTaiKhoan',
               sortorder: "asc",
               viewrecords: true,
               autowidth: true,
               multiselect: true,
               height: '400px',
               ondblClickRow: function(id) {
                   // Do something here
               }
           });

           $('#detailForm').submit(function() {
               var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
               if (!selr || selr.length < 1) {
                   alert('Chưa chọn tài khoản nào');
               } else if (selr.length == 1) {
                   var input = document.createElement("input");
                   input.setAttribute("type", "hidden");
                   input.setAttribute("name", "id");
                   input.setAttribute("value", selr[0]);
                   $(this).append(input);
                   return true;
               } else {
                   alert("Chọn chỉ một tài khoản để xem chi tiết!");
               }
               return false;
           });

           $('#editForm').submit(function() {
               var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
               if (!selr || selr.length < 1) {
                   alert('Chưa chọn tài khoản nào');
               } else if (selr.length == 1) {
                   var input = document.createElement("input");
                   input.setAttribute("type", "hidden");
                   input.setAttribute("name", "id");
                   input.setAttribute("value", selr[0]);
                   $(this).append(input);
                   return true;
               } else {
                   alert("Chọn chỉ một tài khoản để chỉnh sửa!");
               }
               return false;
           });

           $('#deleteForm').submit(function() {
               var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
               if (!selr || selr.length <= 0) {
                   alert('Chưa chọn tài khoản nào');
               } else {
                   var isOk = confirm("Bạn muốn xóa những tài khoản này?");
                   if (isOk) {
                       for (var i = 0; i < selr.length; i++) {
                           var input = document.createElement("input");
                           input.setAttribute("type", "hidden");
                           input.setAttribute("name", "ids");
                           input.setAttribute("value", selr[i]);
                           $(this).append(input);
                       }
                       return true;
                   }
               }
               return false;
           });
       });
    </script>
</asp:Content>
