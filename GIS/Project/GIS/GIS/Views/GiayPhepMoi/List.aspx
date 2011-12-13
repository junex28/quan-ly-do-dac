<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>List</title>
    <link rel="stylesheet" type="text/css" media="screen" href="../../Content/redmond/jquery-ui-1.8.16.custom.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../../Content/ui.jqgrid.css" />

    <script src="../../Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../../Scripts/i18n/grid.locale-en.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.jqGrid.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var count1;
        var p1 = <%= ViewData["page"] %>;
        alert(p1);
        var p2 = <%= ViewData["page"] %>;
        alert(p2);
        function returnPage1() {
        alert("aa");
                p1 = 1;
                alert(p1);
                alert(p2);
            }
            function returnPage2() {
                p2 = 1;
            }
		$(function(){
			$('.ui-state-default').hover(
				function(){ $(this).addClass('ui-state-hover'); }, 
				function(){ $(this).removeClass('ui-state-hover'); }
			);
			$('.ui-state-default').click(function(){ $(this).toggleClass('ui-state-active'); });
});
$(document).ready(function() {
    GiayPhepMoi1.setupGrid($("#grid1"), $("#pager1"));
});

var GiayPhepMoi1 = {
    setupGrid: function(grid1, pager1) {
        grid1.jqGrid({
            url: '<%= Url.Action("ListData1","GiayPhepMoi") %>',
            mtype: "GET",
            datatype: "json",
            colNames: ['', 'Mã', 'Tên Tổ Chức', 'Ngày xin phép', 'Người đại diện', 'Trụ sở chính'],
            colModel: [
                { name: 'Action', index: 'Action', width: 30, align: 'left', sortable: false, resizable: false },
                { name: 'MaGiayPhepHoatDong', index: 'MaGiayPhepHoatDong', width: 10, align: 'left', sortable: false },
                { name: 'TenToChuc', index: 'TenToChuc', width: 40, align: 'left', sortable: true },
                { name: 'NgayXinPhep', index: 'NgayXinPhep', width: 40, align: 'left', sortable: true},
                { name: 'NguoiDaiDien', index: 'NguoiDaiDien', width: 40, align: 'left', sortable: false},
                { name: 'TruSoChinh', index: 'TruSoChinh', width: 40, align: 'left', sortable: true}],
             
            page: p1,
            rowNum: 10,
            rowList: [10, 20, 50],
            pager: pager1,
            sortname: 'MaGiayPhepHoatDong',
            sortorder: "asc",
            viewrecords: true,
            multiselect: false,
            width: '100%',
            height: '100%',
            autowidth: true,
            rownumbers: true,
            caption: 'Quản Lý giấy phép'
        });

    }
};

	</script>
	<script type="text/javascript">
	    $(function() {
	        $('.ui-state-default').hover(
				function() { $(this).addClass('ui-state-hover'); },
				function() { $(this).removeClass('ui-state-hover'); }
			);
	        $('.ui-state-default').click(function() { $(this).toggleClass('ui-state-active'); });
	    });
	    $(document).ready(function() {
	        GiayPhepMoi2.setupGrid($("#grid2"), $("#pager2"));
	    });

	    var GiayPhepMoi2 = {
	        setupGrid: function(grid2, pager2) {
	            grid2.jqGrid({
	                url: '<%= Url.Action("ListData2","GiayPhepMoi") %>',
	                mtype: "GET",
	                datatype: "json",
	                colNames: ['', 'Mã', 'Tên Tổ Chức', 'Ngày xin phép', 'Người đại diện', 'Trụ sở chính'],
	                colModel: [
                { name: 'Action', index: 'Action', width: 30, align: 'left', sortable: false, resizable: false },
                { name: 'MaGiayPhepHoatDong', index: 'MaGiayPhepHoatDong', width: 10, align: 'left', sortable: false },
                { name: 'TenToChuc', index: 'TenToChuc', width: 40, align: 'left', sortable: true },
                { name: 'NgayXinPhep', index: 'NgayXinPhep', width: 40, align: 'left', sortable: true },
                { name: 'NguoiDaiDien', index: 'NguoiDaiDien', width: 40, align: 'left', sortable: false },
                { name: 'TruSoChinh', index: 'TruSoChinh', width: 40, align: 'left', sortable: true}],
	                page: p2,
	                rowNum: 10,
	                rowList: [10, 20, 50],
	                pager: pager2,
	                sortname: 'MaGiayPhepHoatDong',
	                sortorder: "asc",
	                viewrecords: true,
	                multiselect: false,
	                width: '100%',
	                height: '100%',
	                autowidth: true,
	                rownumbers: true,
	                caption: 'Quản Lý giấy phép'
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
 <!--div>
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

    </div-->
    
    <script type="text/javascript">
        $(function() {
            $("#tabs").tabs();
        });
	</script>



<div class="demo">

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">DS mới chưa thẩm định</a></li>
		<li><a href="#tabs-2">DS đã thẩm định đủ điều kiện</a></li>
		<li><a href="#tabs-3">Aenean lacinia</a></li>
	</ul>
	<div id="tabs-1" onclick="returnPage1();">
        <h2>
            My Grid Data</h2>
        <div class="gridpage">	
            <a href="#" class="ui-button ui-button-text-icon ui-widget ui-state-default ui-corner-all">
			    <span class="ui-button-icon-primary ui-icon ui-icon-plus"></span>
			    <span class="custom-fsize ui-button-text ">Tạo mới</span>
		    </a>    
		    <br />
		    <br />
            <table id="grid1" class="scroll" cellpadding="0" cellspacing="0">
            </table>
            <div id="pager1" class="scroll" style="text-align: center;">
            </div>
    </div>
	</div>
	<div id="tabs-2" onclick="returnPage1();>
		 <h2>
            My Grid Data</h2>
        <div class="gridpage">	
            <a href="#" class="ui-button ui-button-text-icon ui-widget ui-state-default ui-corner-all">
			    <span class="ui-button-icon-primary ui-icon ui-icon-plus"></span>
			    <span class="custom-fsize ui-button-text ">Tạo mới</span>
		    </a>    
		    <br />
		    <br />
            <table id="grid2" class="scroll" cellpadding="0" cellspacing="0">
            </table>
            <div id="pager2" class="scroll" style="text-align: center;">
            </div>
	</div>
	
</div>

	<div id="tabs-3">
		<p>Mauris eleifend est et turpis. Duis id erat. Suspendisse potenti. Aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. Vestibulum non ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce sodales. Quisque eu urna vel enim commodo pellentesque. Praesent eu risus hendrerit ligula tempus pretium. Curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
		<p>Duis cursus. Maecenas ligula eros, blandit nec, pharetra at, semper at, magna. Nullam ac lacus. Nulla facilisi. Praesent viverra justo vitae neque. Praesent blandit adipiscing velit. Suspendisse potenti. Donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. Nam scelerisque. Donec non libero sed nulla mattis commodo. Ut sagittis. Donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. Aenean vehicula velit eu tellus interdum rutrum. Maecenas commodo. Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p>
	</div>
</div>
</div><!-- End demo -->


<!--div class="demo-description" style="display: none; ">
<p>Click tabs to swap between content that is broken into logical sections.</p>
</div--><!-- End demo-description -->

</body>
</html>

