<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    List
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="gridpage">
        <a href="#" class="ui-button ui-button-text-icon ui-widget ui-state-default ui-corner-all">
            <span class="ui-button-icon-primary ui-icon ui-icon-plus"></span><span class="custom-fsize ui-button-text ">
                Tạo mới</span> </a>
        <br />
        <br />
        <table id="grid" class="scroll" cellpadding="0" cellspacing="0">
        </table>
        <div id="pager" class="scroll" style="text-align: center;">
        </div>
    </div>

    <script type="text/javascript">
        $(function() {
            $('.ui-state-default').hover(
				function() { $(this).addClass('ui-state-hover'); },
				function() { $(this).removeClass('ui-state-hover'); }
			);
            $('.ui-state-default').click(function() { $(this).toggleClass('ui-state-active'); });

            var ToChucs = {
                setupGrid: function(grid, pager) {
                    grid.jqGrid({
                        url: '<%= Url.Action("ListData","ToChuc") %>',
                        mtype: "GET",
                        datatype: "json",
                        colNames: ['', 'Mã Tổ Chức', 'Tên Tổ Chức', 'Loại Hình Tổ Chức', 'Số Giấy Phép', 'Thời Gian Hết Hạn', 'Điện Thoại', 'Trụ Sở Chính'],
                        colModel: [
                        { name: 'Action', index: 'Action', width: 30, align: 'left', sortable: false, resizable: false },
                        { name: 'MaToChuc', index: 'MaToChuc', width: 10, align: 'left', sortable: false },
                        { name: 'TenToChuc', index: 'TenToChuc', width: 40, align: 'left', sortable: true },
                        { name: 'LoaiHinhToChuc', index: 'LoaiHinhToChuc', width: 40, align: 'left', sortable: true },
                        { name: 'SoGiayPhep', index: 'SoGiayPhep', width: 40, align: 'left', sortable: false },
                        { name: 'ThoiGianHetHan', index: 'ThoiGianHetHan', width: 40, align: 'left', sortable: true },
                        { name: 'DienThoai', index: 'DienThoai', width: 40, align: 'left', sortable: false },
                        { name: 'TruSoChinh', index: 'TruSoChinh', width: 50, align: 'left', sortable: false}],
                        page: '<%= ViewData["page"] %>',
                        rowNum: 10,
                        rowList: [10, 20, 50],
                        pager: pager,
                        sortname: 'MaToChuc',
                        sortorder: "asc",
                        viewrecords: true,
                        multiselect: false,
                        width: '100%',
                        height: '100%',
                        autowidth: true,
                        rownumbers: true,
                        caption: 'Quản Lý Tổ Chức'
                    });
                }
            };
            ToChucs.setupGrid($("#grid"), $("#pager"));
        });
    </script>

</asp:Content>
