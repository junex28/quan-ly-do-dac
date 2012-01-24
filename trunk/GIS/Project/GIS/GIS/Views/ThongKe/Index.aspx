<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div>
 <input name="Nam" id="namid" class="date-picker" />
</div>
    <div class="box">
        <div id="chart1" style="width:500px; height:250px;"></div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

<%--<script type="text/javascript" src="../src/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="../src/plugins/jqplot.pointLabels.min.js"></script>
	--%>
	<link type="text/css" rel="Stylesheet" href="../../Scripts/chart/jquery.jqplot.min.css" />
	<%--<script type="text/javascript" src="../../Scripts/chart/jquery.min.js"></script>--%>
	<script type="text/javascript" src="../../Scripts/chart/jquery.jqplot.min.js"></script>
	<script type="text/javascript" src="../../Scripts/chart/jqplot.barRenderer.js"></script>
	<script type="text/javascript" src="../../Scripts/chart/jqplot.barRenderer.min.js"></script>
	<script type="text/javascript" src="../../Scripts/chart/jqplot.categoryAxisRenderer.min.js"></script>
	
	<script type="text/javascript">	    
	    $(document).ready(function() {
	        // var s1 = [2, 6, 7, 10];
	        // var s2 = [7, 5, 3, 4];
	        // var s3 = [14, 9, 3, 8];

	        /* Dynamic data*/

	    urlDataJSON = '/thongke/DataToJSON';
	        $.getJSON(urlDataJSON, "", function(data) {
	            var dataLines = [];
	            var dataLabels = "";
	            $.each(data, function(entryindex, entry) {
	                dataLines.push(entry['SoLieu']);
	                dataLabels = dataLabels + entry['LoaiCapPhep'];
      	            });	            
                Plot(dataLines, dataLabels);
	         });
	    });

	    function Plot(dataLines, dataLabels) {
	        var ticks = ['TC Nhà nước', 'TC ngoài Nhà nước', 'TC CT-XH', 'TC nước ngoài'];
	        s1 = dataLines[0].slice();
	        s2 = dataLines[1].slice();
	        s3 = dataLines[2].slice();

	        plot = $.jqplot('chart1', [s1, s2, s3], {
	            // Tell the plot to stack the bars.
	            stackSeries: true,
	            captureRightClick: true,
	            seriesDefaults: {
	                renderer: $.jqplot.BarRenderer,
	                rendererOptions: {
	                    // Put a 40 pixel margin between bars.
	                    barMargin: 30,
	                    highlightMouseDown: true
	                },
	                pointLabels: { show: true }
	            },
	            series: [
                    { label: 'Lần đầu' },
                    { label: 'Gia hạn' },
                    { label: 'Bổ sung hoạt động'}],
	            axes: {
	                xaxis: {
	                    renderer: $.jqplot.CategoryAxisRenderer,
	                    ticks: ticks
	                },
	                yaxis: {
	                    padMin: 0,
	                    pad: 1.05,
	                    tickOptions: { formatString: '%d' }
	                }
	            },
	            legend: {
	                show: true,
	                location: 'e',
	                placement: 'outside'
	            }
	        });
	        plot.redraw(); // gets rid of previous axis tick markers
	    }
	    
    $(function() {
        $('.date-picker').datepicker({
           // changeMonth: true,
            changeYear: true,
            showButtonPanel: true,
            dateFormat: 'yy',
            onClose: function(dateText, inst) {
                //var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).val($.datepicker.formatDate('yy', new Date(Now.year)));
            }
        });
    });

</script>
    <style type="text/css">
    .ui-datepicker-calendar {
        display: none;
        }
    </style>
</asp:Content>
