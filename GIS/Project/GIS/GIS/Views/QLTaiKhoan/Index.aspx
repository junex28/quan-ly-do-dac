<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.Models.TaiKhoan>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Thanh cong cu -->
    <div class="grid_12 alpha">
        <div class="box">
            <button id="detailButton" class="button redmond">
                <span class="detail">Chi tiết</span></button>
            <button id="editButton" class="button redmond">
                <span class="edit">Chỉnh sửa</span></button>
            <button id="deleteButton" class="button redmond">
                <span class="delete">Xóa</span></button>
        </div>
    </div>
    <div class="grid_7 omega">
        <div class="box">
            <p>
                <input class="text grid_4" type="text" size="17" id="item" onkeydown="doSearch(arguments[0]||event)" />
                <button class="btnSearch" id="searchButton" onclick="gridReload()">
                    <span class="search"></span>
                </button>
            </p>
            <p>
                <input type="checkbox" id="autosearch" onclick="enableAutosubmit(this.checked)" />
                &nbsp;Tự động</p>
            <div id="search" style="visibility: hidden; width: 10px; height: 10px">
            </div>
        </div>
    </div>
        <div class="clear">
    </div>
     <div class="box">
            <table id="grid"></table>
            <div id="pager"></div>
    </div>

    <% using (Html.BeginForm("chitiet", "QLTaiKhoan", FormMethod.Get, new { id = "detailForm" })) { } %>
    <% using (Html.BeginForm("CapNhat", "QLTaiKhoan", FormMethod.Get, new { id = "editForm" })) { } %>
    <% using (Html.BeginForm("TaoMoi", "QLTaiKhoan", FormMethod.Get, new { id = "taomoiForm" })) { } %>
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">

        $(function() {
            //var selectedId;

            $('#editButton').click(function() {
                $('#editForm').submit();
            });

            $('#deleteButton').click(function() {
                $('#deleteForm').submit();
            });

            $('#detailButton').click(function() {
                $('#detailForm').submit();
            });

            $('#btnSearch').click(function() {
                gridReload();
            });


            $('#detailForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length < 1) {
                    alert('Chưa chọn tài khoản nào');
                } else if (selr.length == 1) {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", selr[0]);
                    $(this).append(input);
                    return true;
                } else {
                    alert("Chọn chỉ một tài khoản để xem chi tiết!");
                }
                return false;
            });

            $('#editForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length < 1) {
                    alert('Chưa chọn tài khoản nào');
                } else if (selr.length == 1) {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", selr[0]);
                    $(this).append(input);
                    return true;
                } else {
                    alert("Chọn chỉ một tài khoản để chỉnh sửa!");
                }
                return false;
            });
            $('#deleteForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length <= 0) {
                    alert('Chưa chọn tài khoản nào');
                } else {
                    var isOk = confirm("Bạn muốn xóa tài khoản này?");
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

            var actionUrl = '<%= Url.Action("ListData", "QLTaiKhoan", new { search = "PLACEHOLDER"} ) %>';
            //var actionUrl = '<%= Url.Action("ListData", "QLGiayPhep", new { sid = "PLACEHOLDER", search = "PLACEHOLDER1"} ) %>';
            //var s = $("#selector").val();
            var st = actionUrl.replace('PLACEHOLDER', $("#item").val());
            $("#grid").jqGrid({
                //editurl: '',
                caption: 'DANH SÁCH TÀI KHOẢN',
                url: st,
                mtype: "GET",
                datatype: "json",
                colNames: ['Mã tài khoản', 'Tên tài khoản', 'Họ tên', 'Cơ quan', 'Địa chỉ', 'Email'],
                colModel: [
                { name: 'MaTaiKhoan', index: 'MaTaiKhoan', width: 50, align: 'left', sortable: false },
                { name: 'TenTaiKhoan', index: 'TenTaiKhoan', width: 50, align: 'left', sortable: true },
                 { name: 'HoTen', index: 'HoTen', width: 50, align: 'left', sortable: true },
                  { name: 'CoQuan', index: 'CoQuan', width: 50, align: 'left', sortable: true },
                { name: 'DiaChi', index: 'DiaChi', width: 40, align: 'left', sortable: false },
                { name: 'Email', index: 'Email', width: 50, align: 'left', sortable: false}],
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

            function gridReload() {
                var search = $('#item').val();
                actionUrl = '<%= Url.Action("ListData", "QLTaiKhoan", new {search ="PLACEHOLDER" } ) %>';
                st = st.replace('PLACEHOLDER', search);
                jQuery("#grid").setGridParam({ url: st }).trigger('reloadGrid');
            }
        });
    </script>

</asp:Content>
