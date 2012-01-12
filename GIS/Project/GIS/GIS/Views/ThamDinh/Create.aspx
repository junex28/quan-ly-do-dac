<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ThamDinhEditViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thêm biên bản thẩm định
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">

    <script type="text/javascript">

	$(function() {
		$( "#NgayThamDinh" ).datepicker();
	});
        
    </script>

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="grid_19 alpha">
        <h3>
            Thẩm định hồ sơ
            <% if (false)
               {%>
            đăng ký giấy phép<% }
               else if (false)
               {%>
            đăng ký bổ sung hoạt động<% }
               else if (true)
               {%>
            đăng ký gia hạn<% }%>
        </h3>
       
     <% Html.RenderPartial("ThongTinChung", Model.thongtinchung); %>
    <div class="box">
        <h2>
            <a id="toggle-thamdinh" href="#" style="cursor: pointer;">Biên bản thẩm định</a>
        </h2>
        <div class="block" id="thamdinh">
            <% Html.EnableClientValidation(); %>
            <%= Html.ValidationSummary(true) %>
            <% using (Html.BeginForm("Create", "ThamDinh"))
               {%>
            <p>
                <label class="grid_6">
                    Ngày thẩm định :
                </label>
                <%=Html.TextBoxFor(m=>m.NgayThamDinh) %>
            </p>
            <p>
                <label class="grid_6">
                    Thành phần cơ quan thẩm định :
                </label>
                <%= Html.TextAreaFor(m=>m.NguoiThamDinh) %>
                <%= Html.ValidationMessageFor(m => m.NguoiThamDinh)%>
            </p>
            <p>
                <label class="grid_6">
                    Thành phần tổ chức đề nghị cấp giấy phép :
                </label>
                <%= Html.TextAreaFor(m=>m.NguoiPhiaToChuc) %>
                <%= Html.ValidationMessageFor(m => m.NguoiPhiaToChuc)%>
            </p>
            <p>
                <label class="grid_6">
                    Thẩm định kê khai lực lượng kỹ thuật :
                </label>
                <%= Html.TextAreaFor(m=>m.NangLucNhanVien) %>
                <%= Html.ValidationMessageFor(m => m.NangLucNhanVien)%>
            </p>
            <p>
                <label class="grid_6">
                    Kết luận
                </label>
                <%= Html.TextAreaFor(m=>m.KetLuan) %>
                <%= Html.ValidationMessageFor(m => m.KetLuan)%>
            </p>
            <p>
                <label class="grid_6">
                    Kiến nghị :
                </label>
                <%= Html.TextAreaFor(m=>m.KienNghi) %>
                <%= Html.ValidationMessageFor(m => m.KienNghi)%>
            </p>
            
            <% } %>
        </div>

    </div>
    <div class="box">
        <div class="block prefix_4">
            <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                <span class="back">Thoát</span></button>
            <button id="Button1" class="button redmond">
                <span class="khongduyet">Không Duyệt</span></button>
            <button id="thamdinhButton" class="button redmond">
                <span class="duyet">Duyệt</span></button>
        </div>
    </div>
</asp:Content>
