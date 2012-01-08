<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
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
        <tr>
            <td>
                i
            </td>
            <td>
                {thietbi.TenThietBi }
            </td>
            <td>
                {thietbi.SoLuong }
            </td>
            <td>
                {thietbi.TinhTrangThietBi }
            </td>
            <td>
                {thietbi.GhiChu }
            </td>
        </tr>
        <tr>
            <td>
                i++
            </td>
            <td>
                {thietbi.TenThietBi }
            </td>
            <td>
                {thietbi.SoLuong }
            </td>
            <td>
                {thietbi.TinhTrangThietBi }
            </td>
            <td>
                {thietbi.GhiChu }
            </td>
        </tr>
    </tbody>
</table>
