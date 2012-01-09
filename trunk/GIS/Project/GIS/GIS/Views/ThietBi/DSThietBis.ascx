<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IList<GIS.Models.ThietBi>>" %>
<table class="mytable">
    <!-- Table header -->
    <thead>
        <tr>
            <th>
                TT
            </th>
            <th style="width: 200px;">
                Tên, mã hiệu của thiết bị, công nghệ
            </th>
            <th>
                Số lượng
            </th>
            <th>
                Tình trạng thiết bị
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
            <td>
                <%=i %>
            </td>
            <td>
                <%= item.TenThietBi_CongNghe %>
            </td>
            <td>
                <%= item.SoLuong %>
            </td>
            <td>
                <%= item.TinhTrang %>
            </td>
            <td>
                <%= item.GhiChu %>
            </td>
        </tr>
        <%} %>	
    </tbody>
</table>
