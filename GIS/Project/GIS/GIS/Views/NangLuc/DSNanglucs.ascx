<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IList<GIS.Models.NangLucKeKhai>>" %>

<table class="mytable">    
    <!-- Table header -->    
        <thead>  
            <tr>  
	                        <th>TT</th>
	                        <th>Ngành, nghề</th>
	                        <th>Đại học trở lên</th>
	                        <th>Trung cấp</th>
	                        <th>Công nhân kỹ thuật</th>
	                        <th>Loại khác</th>              
            </tr>  
        </thead>  
    
    <!-- Table body -->    
        <tbody>  
        <%  var i = 0;
            foreach (var item in Model)
            {
                i++;%>
    		<tr>
				<td ><%=i %></td>
				<td ><%= item.NganhNghe %> </td>
				<td ><%= item.SoTrenDaiHoc.ToString() %></td>
				<td ><%= item.SoTrungCap.ToString() %></td>
				<td ><%= item.SoCongNhanKyThuat.ToString() %></td>
				<td ><%= item.LoaiKhac.ToString() %></td>				
			</tr>	
			<%       
          }
    %>		  
        </tbody>  
</table>
