<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

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
    		<tr>
				<td >i</td>
				<td >{nhanluc.HoTen }</td>
				<td >{nhanluc.ChucVu }</td>
				<td >{nhanluc.BangCap }</td>
				<td >{nhanluc.ThamNienNgheNghiep }</td>		
			</tr>
			    		<tr>
				<td >i++</td>
				<td >{nhanluc.HoTen }</td>
				<td >{nhanluc.ChucVu }</td>
				<td >{nhanluc.BangCap }</td>
				<td >{nhanluc.ThamNienNgheNghiep }</td>				
			</tr>			  
        </tbody>  
</table>