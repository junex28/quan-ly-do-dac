<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<GIS.ViewModels.CongTrinhVM>" %>
<%@ Import Namespace="GIS.Helpers"%>

<tr class="editorCongTrinhRow">
    <% using(Html.BeginCollectionItem("CongTrinhRow")) { %>        
        <td> <%= Html.TextBoxFor(x => x.TenCongTrinh, new { style = "width:99%;height:96%;" })%></td> 
        <td> <%= Html.TextBoxFor(x => x.ChuDauTu, new { style = "width:99%;height:96%;" })%> </td>
        <td> <%= Html.TextBoxFor(x => x.CongDoanDaThiCong, new { style = "width:99%;height:96%;" })%></td> 
        <td> <%= Html.TextBoxFor(x => x.GiaTriThucHien, new { style = "width:99%;height:96%;" })%> </td>
        <td> <%= Html.TextBoxFor(x => x.ThoiGianThucHien, new { style = "width:99%;height:96%;" })%> </td>
        <td> <%= Html.TextBoxFor(x => x.CongDoanDaThiCong, new { style = "width:99%;height:96%;" })%> </td>
        <td> <a href="#" class="deleteCongTrinhRow">Xoá</a><td>
            <% } %>
</tr>    