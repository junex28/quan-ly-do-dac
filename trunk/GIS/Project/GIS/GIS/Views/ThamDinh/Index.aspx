 <%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Danh sách thẩm định
</asp:Content>


<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script type="text/javascript">

        $(function() {
            //var selectedId;
            $('#detailButton').button({

                icons:
                    {
                        primary: "ui-icon-document-b"
                    }
            });

            $('#editButton').button({
                icons:
                    {
                        primary: "ui-icon-pencil"
                    }
            });

            $('#deleteButton').button({
                icons:
                    {
                        primary: "ui-icon-trash"
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

            $('#detailForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length < 1) {
                    alert('Chưa chọn biên bản thẩm định nào');
                } else if (selr.length == 1) {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", selr[0]);
                    $(this).append(input);
                    return true;
                } else {
                    alert("Chọn chỉ một biên bản thẩm định để xem chi tiết!");
                }
                return false;
            });

            $('#editForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length < 1) {
                    alert('Chưa chọn  biên bản thẩm định nào');
                } else if (selr.length == 1) {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", selr[0]);
                    $(this).append(input);
                    return true;
                } else {
                alert("Chọn chỉ một biên bản thẩm định để chỉnh sửa!");
                }
                return false;
            });

            $('#deleteForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length <= 0) {
                    alert('Chưa chọn biên bản thẩm định nào');
                } else {
                var isOk = confirm("Bạn muốn xóa những biên bản thẩm định này?");
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

            var actionUrl ='<%= Url.Action("ListData", "ThamDinh", new { sid = "PLACEHOLDER" } ) %>';
            var st = actionUrl.replace('PLACEHOLDER', '<%= ViewData["id"]%>');

            $("#grid").jqGrid({
                //editurl: '',
                url: st,
                mtype: "GET",
                datatype: "json",
                //postdata: { sId: 0 },
                colNames: ['Mã thẩm định', 'Tên tổ chức', 'Ngày thẩm định',  'kiến nghị' , 'Tình trạng thẩm định'],
                colModel: [
                { name: 'MaThamDinh', index: 'MaThamDinh', width: 10, align: 'left', sortable: false },
                { name: 'TenToChuc', index: 'TenToChuc', width: 50, align: 'left', sortable: true },
                { name: 'NgayThamDinh', index: 'NgayThamDinh', width: 40, align: 'left', sortable: true },
                { name: 'KienNghi', index: 'KienNghi', width: 50, align: 'left', sortable: false},
                { name: 'LoaiThamDinh', index: 'LoaiThamDinh', width: 50, align: 'left', sortable: false}],
                page: '<%= ViewData["page"] %>',
                rowNum: 20,
                rowList: [10, 20, 50],
                pager: '#pager',
                sortname: 'MaThamDinh',
                sortorder: "asc",
                viewrecords: true,
                autowidth: true,
                multiselect: true,
                height: '400px',
                ondblClickRow: function(id) {
                    // Do something here
                }
            });
        });
        function chageSelect() {
            actionUrl = '<%= Url.Action("ListData", "ThamDinh", new { sid = "PLACEHOLDER" } ) %>';
            st = actionUrl.replace('PLACEHOLDER', $("#selector").val());
            $("#grid").setGridParam({ url: st}).trigger('reloadGrid');

            }
    </script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="action-button">
        <button id="detailButton">Chi tiết</button>
        <button id="editButton">Sửa</button>
        <button id="deleteButton">Xóa</button>
    </div>
    <div class="gridpage">
        <table id="grid"></table>
        <div id="pager"></div>
    </div>
    
    <% using (Html.BeginForm("Detail", "ThamDinh", FormMethod.Get, new { id = "detailForm" })) { } %>
    <% using (Html.BeginForm("Edit", "ThamDinh", FormMethod.Get, new { id = "editForm" })) { } %>
    <% using (Html.BeginForm("Delete", "ThamDinh", FormMethod.Post, new { id = "deleteForm" })) { } %>
    
</asp:Content>



