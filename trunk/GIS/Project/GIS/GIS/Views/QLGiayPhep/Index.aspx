<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Danh sách giấy phép
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">

        $(function() {
            //var selectedId;
            //find all form with class jqtransform and apply the plugin
            $("form.jqtransform").jqTransform();

            $('#editButton').click(function() {
                $('#editForm').submit();
            });

            $('#deleteButton').click(function() {
                $('#deleteForm').submit();
            });

            $('#detailButton').click(function() {
                $('#detailForm').submit();
            });

            $('#thamdinhButton').click(function() {
                $('#thamdinhButton').submit();
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

            $('#thamdinhForm').submit(function() {
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

            var actionUrl = '<%= Url.Action("ListData", "QLGiayPhep", new { sid = "PLACEHOLDER" } ) %>';
            //var s = $("#selector").val();
            var st = actionUrl.replace('PLACEHOLDER', 0);

            $("#grid").jqGrid({
                //editurl: '',
                caption: 'DANH SÁCH GIẤY PHÉP',
                url: st,
                mtype: "GET",
                datatype: "json",
                //postdata: { sId: 0 },
                colNames: ['Mã hồ sơ', 'Tên tổ chức', 'Ngày xin phép', 'Tình trạng giấy phép'],
                colModel: [
                { name: 'MaHoSo', index: 'MaHoSo', width: 50, align: 'left', sortable: false },
                { name: 'TenToChuc', index: 'TenToChuc', width: 50, align: 'left', sortable: true },
                { name: 'NgayXinPhep', index: 'NgayXinPhep', width: 40, align: 'left', sortable: true },
                { name: 'TinhTrangGiayPhep', index: 'TinhTrangGiayPhep', width: 50, align: 'left', sortable: false}],
                page: '<%= ViewData["page"] %>',
                rowNum: 20,
                rowList: [10, 20, 50],
                pager: '#pager',
                sortname: 'MaHoSo',
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
            $("#grid").setGridParam({ url: st }).trigger('reloadGrid');
        }

        var timeoutHnd;
        var flAuto = false;
        function doSearch(ev) {
            if (ev.keyCode == 13) {
                timeoutHnd = setTimeout(gridReload, 500);
                return;
            }
            if (!flAuto) return;
            // var elem = ev.target||ev.srcElement;
            if (timeoutHnd) {
                clearTimeout(timeoutHnd)
            }
            if ((ev.keyCode >= 65 && ev.keyCode <= 90) || ev.keyCode == 8 || ev.keyCode == 46 || (ev.keyCode >= 48 && ev.keyCode <= 57) || (ev.keyCode >= 96 && ev.keyCode <= 105)) {
                timeoutHnd = setTimeout(gridReload, 500)
            }
        }
        function gridReload() {
            var search = $('#item').val();
            var gp = $("#selector").val();
            jQuery("#grid").setGridParam({ url: "QLGiayPhep/ListData?sid=" + gp + "&search=" + search, page: 1 }).trigger("reloadGrid");
        }
        function enableAutosubmit(state) {
            flAuto = state;
            jQuery("#submitButton").attr("disabled", state);
        } 
    </script>

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Thanh cong cu -->
    <div class="grid_12 alpha">
        <div class="box">
            <button id="detailButton" class="button redmond">
                <span class="detail">Chi tiết</span></button>
            <button id="editButton" class="button redmond">
                <span class="edit">Sửa</span></button>
            <button id="deleteButton" class="button redmond">
                <span class="delete">Xóa</span></button>
            <button id="thamdinhButton" class="button redmond">
                <span class="validation">Thẩm định</span></button>
        </div>
        <div class="box">
            <form class="jqtransform">
            <label>
                Danh sách giấy phép:
            </label>
            <select id="selector" onchange="chageSelect();">
                <option value="0" selected="selected">Tất cả</option>
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
            </form>
        </div>
    </div>
    <!-- Tim Kiem -->
    <div class="grid_7 omega">
        <div class="box">            
            <form class="jqtransform">
            <input type="text" size="17" id="item" onkeydown="doSearch(arguments[0]||event)" />
            <button class="btnSearch" onclick="gridReload()" id="submitButton">
                <span class="search"></span></button><br/>
            <input type="checkbox" id="autosearch" onclick="enableAutosubmit(this.checked)" />
            <p>&nbsp;Tự động</p>
            <div id="search" style="visibility: hidden; width: 10px; height: 10px">
            </form>
            </div>
        </div>
    </div>
    <!-- Lua chon danh sach giay phep -->
    <div class="clear">
    </div>
    <div class="box">
        <table id="grid">
        </table>
        <div id="pager">
        </div>
    </div>
    <% using (Html.BeginForm("chitiet", "qlgiayphep", FormMethod.Get, new { id = "detailForm" })) { } %>
    <% using (Html.BeginForm("Edit", "QLGiayPhep", FormMethod.Get, new { id = "editForm" })) { } %>
    <% using (Html.BeginForm("Create", "ThamDinh", FormMethod.Get, new { id = "thamdinhForm" })) { } %>
    <% using (Html.BeginForm("Delete", "QLGiayPhep", FormMethod.Post, new { id = "deleteForm" })) { } %>
</asp:Content>
