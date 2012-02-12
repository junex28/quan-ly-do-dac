<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<GIS.ViewModels.ThietBiVM>" %>
<%@ Import Namespace="GIS.Helpers"%>

<tr class="editorThietBiRow">
    <% using(Html.BeginCollectionItem("ThietBiRow")) { %>        
        <td> <%= Html.TextBoxFor(x => x.TenThietBi_CongNghe, new { style = "width:99%;height:96%;" })%></td> 
        <td> <%= Html.TextBoxFor(x => x.SoLuong, new { style = "width:99%;height:96%;" })%> </td>
        <td> <%= Html.TextBoxFor(x => x.TinhTrang, new { style = "width:99%;height:96%;" })%></td> 
        <td> <%= Html.TextBoxFor(x => x.GhiChu, new { style = "width:99%;height:96%;" })%> </td>
        <td> <a href="#" class="deleteThietBiRow">Xoá</a></td>
            <% } %>
</tr>