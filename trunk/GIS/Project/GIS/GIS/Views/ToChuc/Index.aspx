<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Danh sách tổ chức
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script type="text/javascript">
        $(function() {
            $('#newButton').click(function() {
            $.ajax({
                type:'GET',
                url: '/ToChuc/TaoMoi'
                });
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
                caption: 'DANH SÁCH TỔ CHỨC',
                url: '<%= Url.Action("ListData","ToChuc") %>',
                editurl: '',
                mtype: "GET",
                datatype: "json",
                colNames: ['Mã Tổ Chức', 'Tên Tổ Chức', 'Người đại diện', 'Trụ Sở Chính', "Điện thoại"],
                colModel: [
                { name: 'MaToChuc', index: 'MaToChuc', width: 10, align: 'left', sortable: false },
                { name: 'TenToChuc', index: 'TenToChuc', width: 40, align: 'left', sortable: true },
                { name: 'NguoiDaiDien', index: 'SoGiayPhep', width: 40, align: 'left', sortable: false },
                { name: 'TruSoChinh', index: 'TruSoChinh', width: 50, align: 'left', sortable: false },
                { name: 'DienThoai', index: 'DienThoai', width: 40, align: 'left', sortable: false}],
                page: '<%= ViewData["page"] %>',
                rowNum: 20,
                rowList: [10, 20, 50],
                pager: '#pager',
                sortname: 'MaToChuc',
                sortorder: "asc",
                viewrecords: true,
                autowidth: true,
                multiselect: true,
                height: '400px',
                ondblClickRow: function(id) {
                    // Do something here
                }
            });


            //            $('#newForm').submit(function() {

            //                    var input = document.createElement("input");
            //                    input.setAttribute("type", "hidden");
            //                    input.setAttribute("name", "id");
            //                    input.setAttribute("value", selr[0]);
            //                    $(this).append(input);
            //                    return true;
            //                } else {
            //                    alert("Chọn chỉ một tổ chức để chỉnh sửa!");
            //                }
            //                return false;
            //            });
            $('#detailForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length < 1) {
                    alert('Chưa chọn tổ chức nào');
                } else if (selr.length == 1) {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", selr[0]);
                    $(this).append(input);
                    return true;
                } else {
                    alert("Chọn chỉ một tổ chức để xem chi tiết!");
                }
                return false;
            });

            $('#editForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length < 1) {
                    alert('Chưa chọn tổ chức nào');
                } else if (selr.length == 1) {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", selr[0]);
                    $(this).append(input);
                    return true;
                } else {
                    alert("Chọn chỉ một tổ chức để chỉnh sửa!");
                }
                return false;
            });


            $('#deleteForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length <= 0) {
                    alert('Chưa chọn tổ chức nào');
                } else {
                    var isOk = confirm("Bạn muốn xóa những tổ chức này?");
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

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <%--<h2>Danh Sách Tổ Chức</h2>--%>
    <div class="box">
        <button id="newButton" class="button redmond"><span class="detail">Tạo mới</span></button>
        <button id="detailButton" class="button redmond"><span class="detail">Chi tiết</span></button>
        <button id="editButton" class="button redmond"><span class="edit">Sửa</span></button>
        <button id="deleteButton" class="button redmond"><span class="delete">Xóa</span></button>
    </div>
    <div class="box">
            <table id="grid"></table>
            <div id="pager"></div>
    </div>

    <% using (Html.BeginForm("ChiTiet", "ToChuc", FormMethod.Get, new { id = "detailForm" })) { } %>
    <% using (Html.BeginForm("CapNhat", "ToChuc", FormMethod.Get, new { id = "editForm" })) { } %>
    <% using (Html.BeginForm("Xoa", "ToChuc", FormMethod.Post, new { id = "deleteForm" })) { } %>
    
</asp:Content>
