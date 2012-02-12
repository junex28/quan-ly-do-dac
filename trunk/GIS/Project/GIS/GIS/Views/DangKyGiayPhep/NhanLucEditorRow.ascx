<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<GIS.ViewModels.NhanLucVM>" %>
<%@ Import Namespace="GIS.Helpers" %>

<tr class="editorNhanLucRow">
    <% using(Html.BeginCollectionItem("NhanLucRow")) { %>
        <td> <%= Html.TextBoxFor(x => x.HoTen, new { style = "width:99%;height:96%;" })%></td>
        <td> <%= Html.TextBoxFor(x => x.ChucVu, new { style = "width:99%;height:96%;" })%> </td>
        <td> <%= Html.TextBoxFor(x => x.TrinhDoHocVan, new { style = "width:99%;height:96%;" })%></td>
        <td> <%= Html.TextBoxFor(x => x.ThamNien, new { style = "width:99%;height:96%;" })%> </td>
        <td> <a href="#" class="deleteNhanLucRow">Xoá</a></td>
    <% } %>
</tr>