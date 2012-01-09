<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IList<GIS.Models.NhanLuc>>" %>

<table class="mytable">    
    <!-- Table header -->    
        <thead>  
            <tr>  
	                        <th>TT</th>
	                        <th style="width:200px;">Họ tên</th>
	                        <th>Chức vụ</th>
	                        <th>Bằng cấp</th>
	                        <th>Thâm niên nghề nghiệp</th>
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
				<td ><%= item.HoTen %></td>
				<td ><%= item.ChucVu %></td>
				<td ><%= item.TrinhDoHocVan %></td>
				<td ><%= item.ThamNien %></td>		
			</tr>
			<%} %>		  
        </tbody>  
</table>