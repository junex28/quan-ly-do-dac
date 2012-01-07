﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div id="chart1" style="width:600px; height:250px;"></div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

<%--<script type="text/javascript" src="../src/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="../src/plugins/jqplot.pointLabels.min.js"></script>
	--%>
	<link type="text/css" rel="Stylesheet" href="../../Scripts/chart/jquery.jqplot.min.css" />
	<script type="text/javascript" src="../../Scripts/chart/jquery.min.js"></script>
	<script type="text/javascript" src="../../Scripts/chart/jquery.jqplot.min.js"></script>
	<script type="text/javascript" src="../../Scripts/chart/jqplot.barRenderer.js"></script>
	<script type="text/javascript" src="../../Scripts/chart/jqplot.barRenderer.min.js"></script>
	<script type="text/javascript" src="../../Scripts/chart/jqplot.categoryAxisRenderer.min.js"></script>
	
	<%--<script type="text/javascript">
	    jQuery(document).ready(function() {
	    urlDataJSON = '<%= Url.Action("DataToJSON","ThamDinh") %>';
	        $.getJSON(urlDataJSON, "", function(data) {
	            var dataLines = [];
	            var dataLabels = "";
	            $.each(data, function(entryindex, entry) {
	                dataLines.push(entry['Serie']);
	                dataLabels = dataLabels + entry['Name'];
	            });
	            Plot(dataLines, dataLabels);
	        });
	    });

	        //Data from database is already an array!
	        plot = $.jqplot('chart1', dataLines, options);
	        plot.redraw(); // gets rid of previous axis tick markers
	    }
	</script>--%>
	
	<script type="text/javascript">
	    $(document).ready(function() {
	        var s1 = [2, 6, 7, 10];
	        var s2 = [7, 5, 3, 4];
	        var s3 = [14, 9, 3, 8];
	        var ticks = ['TC Nhà nước', 'TC ngoài Nhà nước', 'TC CT-XH', 'TC nước ngoài'];
	        plot3 = $.jqplot('chart1', [s1, s2, s3], {
	            // Tell the plot to stack the bars.
	            stackSeries: true,
	            captureRightClick: true,
	            seriesDefaults: {
	                renderer: $.jqplot.BarRenderer,
	                rendererOptions: {
	                    // Put a 30 pixel margin between bars.
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
	                    tickOptions: { formatString: '$%d' }
	                }
	            },
	            legend: {
	                show: true,
	                location: 'e',
	                placement: 'outside'
	            }
	        });
	        $('#chart1').bind('jqplotDataClick',
                function(ev, seriesIndex, pointIndex, data) {
                    $('#info3').html('series: ' + seriesIndex + ', point: ' + pointIndex + ', data: ' + data);
                }
            );
	    });
</script>
</asp:Content>
