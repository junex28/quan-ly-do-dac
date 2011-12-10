<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucListViewModel>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>List</title>
    <link rel="stylesheet" type="text/css" media="screen" href="../../Content/redmond/jquery-ui-1.8.16.custom.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../../Content/ui.jqgrid.css" />

    <script src="../../Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../../Scripts/i18n/grid.locale-en.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.jqGrid.min.js" type="text/javascript"></script>
<%--    <script src="../../Scripts/gridview/ToChucs.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
		$(function(){
			$('.ui-state-default').hover(
				function(){ $(this).addClass('ui-state-hover'); }, 
				function(){ $(this).removeClass('ui-state-hover'); }
			);
			$('.ui-state-default').click(function(){ $(this).toggleClass('ui-state-active'); });
});
$(document).ready(function() {
    ToChucs.setupGrid($("#grid"), $("#pager"));
});

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
                { name: 'LoaiHinhToChuc', index: 'LoaiHinhToChuc', width: 40, align: 'left', sortable: true},
                { name: 'SoGiayPhep', index: 'SoGiayPhep', width: 40, align: 'left', sortable: false},
                { name: 'ThoiGianHetHan', index: 'ThoiGianHetHan', width: 40, align: 'left', sortable: true},
                { name: 'DienThoai', index: 'DienThoai', width: 40, align: 'left', sortable: false},
                { name: 'TruSoChinh', index: 'TruSoChinh', width: 50, align: 'left', sortable: false}] ,               
            page: <%= Model.page%>,
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

	</script>
    <style type="text/css">
        span.ui-icon {float: left; margin: 0 4px;}
        span.ui-button-text {float: left; width: 80px;}
        ul {margin: 0; padding: 0;}
		li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
		.gridpage 
		{
		    margin: 10px 10px;
		    }
		.custom-fsize
		{
		    font-size: 0.8em !important;
		    }
    </style>

</head>
<body>
    <div>
        <h2>
            My Grid Data</h2>
        <div class="gridpage">	
            <a href="#" class="ui-button ui-button-text-icon ui-widget ui-state-default ui-corner-all">
			    <span class="ui-button-icon-primary ui-icon ui-icon-plus"></span>
			    <span class="custom-fsize ui-button-text ">Tạo mới</span>
		    </a>    
		    <br />
		    <br />
            <table id="grid" class="scroll" cellpadding="0" cellspacing="0">
            </table>
            <div id="pager" class="scroll" style="text-align: center;">
            </div>

        </div>

    </div>
</body>
</html>
