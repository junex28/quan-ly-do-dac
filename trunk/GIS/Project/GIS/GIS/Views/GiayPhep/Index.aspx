<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Danh sách giấy phép
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
                    alert('Chưa chọn giấy phép nào');
                } else if (selr.length == 1) {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", selr[0]);
                    $(this).append(input);
                    return true;
                } else {
                    alert("Chọn chỉ một giấy phép để xem chi tiết!");
                }
                return false;
            });

            $('#editForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length < 1) {
                    alert('Chưa chọn giấy phép nào');
                } else if (selr.length == 1) {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", selr[0]);
                    $(this).append(input);
                    return true;
                } else {
                    alert("Chọn chỉ một giấy phép để chỉnh sửa!");
                }
                return false;
            });

            $('#deleteForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length <= 0) {
                    alert('Chưa chọn giấy phép nào');
                } else {
                    var isOk = confirm("Bạn muốn xóa những giấy phép này?");
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

            var actionUrl ='<%= Url.Action("ListData", "QLGiayPhep", new { sid = "PLACEHOLDER" } ) %>';
            //var s = $("#selector").val();
            var st = actionUrl.replace('PLACEHOLDER', 0);

            $("#grid").jqGrid({
                //editurl: '',
                url: st,
                mtype: "GET",
                datatype: "json",
                //postdata: { sId: 0 },
                colNames: ['Mã giấy phép', 'Tên tổ chức', 'Ngày xin phép', 'Tình trạng giấy phép'],
                colModel: [
                { name: 'MaGiayPhepHoatDong', index: 'MaGiayPhepHoatDong', width: 10, align: 'left', sortable: false },
                { name: 'TenToChuc', index: 'TenToChuc', width: 50, align: 'left', sortable: true },
                { name: 'NgayXinPhep', index: 'NgayXinPhep', width: 40, align: 'left', sortable: true },
                { name: 'TinhTrangGiayPhep', index: 'SoGiayPhep', width: 50, align: 'left', sortable: false}],
                page: '<%= ViewData["page"] %>',
                rowNum: 20,
                rowList: [10, 20, 50],
                pager: '#pager',
                sortname: 'MaGiayPhepHoatDong',
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
            //salert($("#selector").val());
            actionUrl = '<%= Url.Action("ListData", "QLGiayPhep", new { sid = "PLACEHOLDER" } ) %>';
            st = actionUrl.replace('PLACEHOLDER', $("#selector").val());
            $("#grid").setGridParam({ url: st}).trigger('reloadGrid');

            }
    </script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
    <label>Xem danh sach giay phep theo: </label>
    <select id="selector" onchange="chageSelect();">
      <option value="0" selected = "selected">Tất cả</option>
      <option value="1">DS xin mới đang chờ thẩm định</option>
      <option value="2">DS xin mới không đủ điều kiện</option>
      <option value="3">DS giấy phép hết hạn</option>
      <option value="3">DS xin mới đủ điều kiện</option>
      <option value="4">DS xin bổ sung hoạt động</option>
      <option value="5">DS xin bổ sung hoạt động thất bại</option>
      <option value="6">DS xin bổ sung hoạt động thành công</option>
      <option value="7">DS xin gia hạn</option>
      <option value="8">DS xin gia hạn thất bại</option>
      <option value="9">DS xin gia hạn thành công</option>
    </select>
    </div>
   
    <div class="action-button">
        <button id="detailButton">Chi tiết</button>
        <button id="editButton">Sửa</button>
        <button id="deleteButton">Xóa</button>
    </div>
    
   
    <div class="gridpage">
        <table id="grid"></table>
        <div id="pager"></div>
    </div>
    
    <% using (Html.BeginForm("Detail", "QLGiayPhep", FormMethod.Get, new { id = "detailForm" })) { } %>
    <% using (Html.BeginForm("Edit", "QLGiayPhep", FormMethod.Get, new { id = "editForm" })) { } %>
    <% using (Html.BeginForm("Delete", "QLGiayPhep", FormMethod.Post, new { id = "deleteForm" })) { } %>
    
</asp:Content>


