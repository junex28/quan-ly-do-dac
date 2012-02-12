<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<GIS.ViewModels.NangLucVM>" %>
<%@ Import Namespace="GIS.Helpers"%>

<%--<div class="editorNangLucRow">
    <% using(Html.BeginCollectionItem("NangLucRow")) { %>
        Ngành nghề: <%= Html.TextBoxFor(x => x.NganhNghe) %> 
        Đại học: <%= Html.TextBoxFor(x => x.Daihoc , new { size = 4 }) %> 
        Trung cấp: <%= Html.TextBoxFor(x => x.TrungCap , new { size = 4 }) %> 
        Công nhân: <%= Html.TextBoxFor(x => x.CongNhan , new { size = 4 }) %> 
        Loại khác: <%= Html.TextBoxFor(x => x.LoaiKhac , new { size = 4 }) %> 
        <a href="#" class="deleteNangLucRow">delete</a>
        
        <%= Html.ValidationMessageFor(x => x.NganhNghe) %>
        <%= Html.ValidationMessageFor(x => x.TrungCap) %>
        <%= Html.ValidationMessageFor(x => x.LoaiKhac) %>
        <%= Html.ValidationMessageFor(x => x.CongNhan) %>
        <%= Html.ValidationMessageFor(x => x.Daihoc) %>
    <% } %>
</div>     --%>
<tr class="editorNangLucRow">
    <% using(Html.BeginCollectionItem("NangLucRow")) { %>        
        <td> <%= Html.TextBoxFor(x => x.NganhNghe, new { style = "width:99%;height:96%;" }) %></td> 
        <td> <%= Html.TextBoxFor(x => x.Daihoc, new { style = "width:99%;height:96%;" })%> </td>
        <td> <%= Html.TextBoxFor(x => x.TrungCap, new { style = "width:99%;height:96%;" })%></td> 
        <td> <%= Html.TextBoxFor(x => x.CongNhan, new { style = "width:99%;height:96%;" })%> </td>
        <td> <%= Html.TextBoxFor(x => x.LoaiKhac, new { style = "width:99%;height:96%;" })%> </td>
        <td> <a href="#" class="deleteNangLucRow">Xoá</a></td>
            <% } %>
</tr>    