<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.Moc>" %>
--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Danh sách mốc
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
                <span class="delete">Hủy</span></button>
        </div>
        <div class="box">
            <label>
                Danh sách mốc công trình:
            </label>
            <form>
            <select id="selector" onchange="chageSelect();" style="padding: 0.5em; background-color: #FFFFFF;
                border: 1px solid #BBBBBB;">
                <option value="1">DS mốc tọa độ</option>
                <option value="2">DS mốc độ cao</option>
                <option value="3">DS mốc trọng lực</option>
            </select>
            </form>
        </div>
    </div>
    <!-- Tim Kiem -->
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
    <!-- Lua chon danh sach giay phep -->
    <div class="clear">
    </div>
    <div class="box">
        <table id="grid">
        </table>
        <div id="pager">
        </div>
    </div>
    <% using (Html.BeginForm("chitiet", "qlmoc", FormMethod.Get, new { id = "detailForm" })) { } %>
    <% using (Html.BeginForm("CapNhap", "qlmoc", FormMethod.Get, new { id = "editForm" })) { } %>
    <% using (Html.BeginForm("HuyGiayPhep", "QLGiayPhep", FormMethod.Post, new { id = "deleteForm" })) { } %>
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">

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

            $('#detailForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length < 1) {
                    alert('Chưa chọn mốc công trình nào');
                } else if (selr.length == 1) {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", selr[0]);
                    $(this).append(input);

                    var input1 = document.createElement("input");
                    input1.setAttribute("type", "hidden");
                    input1.setAttribute("name", "loai");
                    input1.setAttribute("value", $("#selector").val());
                    $(this).append(input1);
                    return true;
                } else {
                    alert("Chọn chỉ một mốc để xem chi tiết!");
                }
                return false;
            });

            $('#editForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length < 1) {
                    alert('Chưa chọn mốc nào');
                } else if (selr.length == 1) {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", selr[0]);
                    $(this).append(input);

                    var input1 = document.createElement("input");
                    input1.setAttribute("type", "hidden");
                    input1.setAttribute("name", "loai");
                    input1.setAttribute("value", $("#selector").val());
                    alert($("#selector").val());
                    return true;
                } else {
                    alert("Chọn chỉ một mốc để chỉnh sửa!");
                }
                return false;
            });

            $('#deleteForm').submit(function() {
                var selr = jQuery('#grid').jqGrid('getGridParam', 'selarrrow');
                if (!selr || selr.length <= 0) {
                    alert('Chưa chọn mốc nào');
                } else {
                    var isOk = confirm("Bạn muốn Hủy những mốc này?");
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

            var actionUrl = '<%= Url.Action("ListData", "QLMoc", new { sid = "PLACEHOLDER"} ) %>';
            var st = actionUrl.replace('PLACEHOLDER', $("#selector").val());

            $("#grid").jqGrid({
                caption: 'DANH SÁCH MỐC CÔNG TRÌNH',
                url: st,
                mtype: "GET",
                datatype: "json",
                colNames: ['Số hiệu mốc', 'năm thành lập', 'Tình trạng', 'cấp hạng'],
                colModel: [
                { name: 'SoHieu', index: 'SoHieu', width: 50, align: 'left', sortable: true },
                { name: 'NamThanhLap', index: 'NamThanhLap', width: 40, align: 'left', sortable: false },
                { name: 'TinhTrang', index: 'TinhTrang', width: 50, align: 'left', sortable: false },
                { name: 'CapHang', index: 'CapHang', width: 50, align: 'left', sortable: false}],
                page: '<%= ViewData["page"] %>',
                rowNum: 20,
                rowList: [10, 20, 50],
                pager: '#pager',
                sortname: 'SoHieu',
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
            gridReload();
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
            actionUrl = '<%= Url.Action("ListData", "QLMoc", new { sid = "PLACEHOLDER", search ="PLACEHOLDER1" } ) %>';
            var st1 = actionUrl.replace('PLACEHOLDER', gp);
            st = st1.replace('PLACEHOLDER1', search);
            jQuery("#grid").setGridParam({ url: st }).trigger('reloadGrid');
        }
        function enableAutosubmit(state) {
            flAuto = state;
            jQuery("#searchButton").attr("disabled", state);
        } 
    </script>

</asp:Content>