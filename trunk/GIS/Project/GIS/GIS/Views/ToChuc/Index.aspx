<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.Helpers.PaginatedList<GIS.Models.ToChuc>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
      Danh sách tổ chức
    </h2>


    <p>
    <%=Html.ActionLink("Tạo mới", "Create")%>
    </p>
<table>
    <tr>
        <th></th>
        <th>Tên tổ chức</th>
        <th>Giấy phép kinh doanh</th>
        <th>Điện thoại</th>
        <th>Email</th>
        <th>Tổng số cán bộ</th>
        <th>Tình trạng</th>        
    </tr>

    <%
            foreach(var item in Model)
            { 
     %>
                <tr>
                    <td>
                        <%=Html.ActionLink("Chi tiết", "Details", new { id = item.MaToChuc })%> | 
                        <%=Html.ActionLink("Thay đổi", "Edit", new { id = item.MaToChuc })%> | 
                        <%=Html.ActionLink("Xoá", "Delete", new { id = item.MaToChuc })%>
                    </td>
                    <td><%=item.TenToChuc%></td>
                    <td><%=item.GiayPhepKinhDoanh %></td>
                    <td><%=item.DienThoai %></td>
                    <td><%=item.Email %></td>
                    <td><%=item.TongSoCanBo %></td>
                    <td><%=item.KichHoat %></td>
                </tr>
    <%       
            }
    %>
</table>
    <div class="pagination">

        <% if (Model.HasPreviousPage) { %>

            <%= Html.RouteLink("< Lùi", 
                               "DSToChuc", 
                               new { page=(Model.PageIndex-1) }) %>
          
        <% } %>
        
        <% if (Model.HasNextPage) { %>
        
            <%= Html.RouteLink("Tiếp >", 
                               "DSToChuc", 
                               new { page = (Model.PageIndex + 1) })%>
                              
        
        <% } %>    

    </div>

</table>

</asp:Content>
