<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IList<GIS.Models.BaoCaoCongTrinh>>" %>

<table class="mytable">    
    <!-- Table header -->    
          <thead>
                            <tr>
                                <th>
                                    STT
                                </th>
                                <th style="width: 200px;">
                                    Tên công trình
                                </th>
                                <th>
                                    Chủ đầu tư
                                </th>
                                <th>
                                    Công đoạn đã thi công
                                </th>
                                <th>
                                    Giá trị thực hiện
                                </th>
                                <th>
                                    Thời gian thực hiện
                                </th>
                                <th>
                                    Ghi chú
                                </th>
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
				<td ><%= item.TenCongTrinh %> </td>
				<td ><%= item.ChuDauTu %></td>
				<td ><%= item.CongDoanDaThiCong %></td>
				<td ><%= item.GiaTriDaThucHien%></td>
				<td ><%= item.ThoiGianThucHien %></td>				
				<td ><%= item.GhiChu %></td>				
				
			</tr>	
			<%       
          }
    %>		  
        </tbody>  
</table>
