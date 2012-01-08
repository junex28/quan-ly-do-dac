<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<table class="mytable">    
    <!-- Table header -->    
        <thead>  
            <tr>  
	                        <th>TT</th>
	                        <th style="width:200px;">Ngành, nghề</th>
	                        <th>Đại học trở lên</th>
	                        <th>Trung cấp</th>
	                        <th>Công nhân kỹ thuật</th>
	                        <th>Loại khác</th>              
            </tr>  
        </thead>  
    
    <!-- Table body -->    
        <tbody>  
    		<tr>
				<td >i</td>
				<td >{nangluc.NganhNghe }</td>
				<td >{nangluc.DaiHocTroLen }</td>
				<td >{nangluc.TrungCap }</td>
				<td >{nangluc.CongNhanKyThuat }</td>
				<td >{nangluc.LoaiKhac }</td>				
			</tr>
			    		<tr>
				<td >i++</td>
				<td >{nangluc.NganhNghe }</td>
				<td >{nangluc.DaiHocTroLen }</td>
				<td >{nangluc.TrungCap }</td>
				<td >{nangluc.CongNhanKyThuat }</td>
				<td >{nangluc.LoaiKhac }</td>				
			</tr>			  
        </tbody>  
</table>