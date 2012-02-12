<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.Moc>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    CapNhat
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <% using (Html.BeginForm("CapNhat", "qlmoc", FormMethod.Post, new { id = "editForm" }))
    {%>
    <div class="grid_19 alpha">
        <div class="box">
            <div class="block">
                <p>
                    <label class="grid_6">
                        Số hiệu mốc :
                    </label>
                    <%=Html.Encode(Model.soHieu)%>
                </p>
                <p>
                    <label class="grid_6">
                        Loại mốc:
                    </label>
                    <% if (Model.loaiMoc == 1)
                       {%>
                    Mốc tọa độ
                    <%} %>
                    <% else if (Model.loaiMoc == 2)
                        {%>
                    Mốc độ cao
                    <%} %>
                    <% else if (Model.loaiMoc == 3)
                        {%>
                    Mốc trọng lực
                    <%} %>
                </p>
                <p>
                    <label class="grid_6">
                        Năm thành lập:
                    </label>
                    <%= Html.Encode(Model.namThanhLap)%>
                </p>
                <p>
                    <label class="grid_6">
                        Hệ quy chiếu:
                    </label>
                    <%= Html.Encode(Model.heQuyChieu)%>
                </p>
                <p>
                    <label class="grid_6">
                        Cấp hạng mốc :
                    </label>
                    <% if (Model.capHang == 1)
                       {%>
                    Cấp I
                    <%} %>
                    <% if (Model.capHang == 2)
                       {%>
                    Cấp II
                    <%} %>
                    <% if (Model.capHang == 3)
                       {%>
                    Cấp III
                    <%} %>
                </p>
                <p>
                    <label class="grid_6">
                        Tình trạng :
                    </label>
                    <select id="selector"  style="padding: 0.5em; background-color: #FFFFFF;
                        border: 1px solid #BBBBBB;">
                        
                        <option value="1" selected = '<%= Model.loaiMoc == 1 ? "selected" : string.Empty %>'>Còn tốt</option>
                        <option value="2" selected = '<%= Model.loaiMoc == 2 ? "selected" : string.Empty %>'>Đang sửa chữa</option>
                        <option value="3" selected = '<%= Model.loaiMoc == 3 ? "selected" : string.Empty %>'>Không còn sử dụng</option>
                    </select>
                </p>
                <% } %>
            </div>
        </div>
        <div class="box">
            <div class="block prefix_4">
                <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                    <span class="back">Thoát</span></button>
                <button id="editButton" class="button redmond" >
                    <span class="Chỉnh sửa">Chỉnh sửa </span>
                </button>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
    $(function() {
    $('#editButton').click(function() {
            $('#editForm').submit();
        });

        $('#editForm').submit(
                function() {
                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "id");
                    input.setAttribute("value", "<%=Model.objId%>");
                    $(this).append(input);
                    var input1 = document.createElement("input");
                    input1.setAttribute("type", "hidden");
                    input1.setAttribute("name", "loai");
                    input1.setAttribute("value", "<%=Model.loaiMoc%>");
                    $(this).append(input1);
                    return true;
                });
    });
       </script>
</asp:Content>
