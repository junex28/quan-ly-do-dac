<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.Models.ToChuc>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thêm tổ chức
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script type="text/javascript">
        $(function() {
            $("input[type=submit]").button();
            $('#danhsachButton').button({
                icons:
                    {
                        primary: "ui-icon-document"
                    }
            });
        });
        
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Create</h2>
    <% Html.EnableClientValidation(); %>    
    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>

        <fieldset>
            <legend>Fields</legend>
            <dl class="span w16">
			    <dt class="w4"><%= Html.LabelFor(model => model.LoaiHinhToChuc.TenLoaiHinhToChuc) %></dt>
			    <dd>
                    <%= Html.DropDownList("MaLoaiHinhToChuc",(IEnumerable<SelectListItem>)ViewData["loaihinh"]) %>
			    </dd>
			</dl>
            <div class="editor-label">
                <%= Html.LabelFor(model => model.TenToChuc) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.TenToChuc) %>
                <%= Html.ValidationMessageFor(model => model.TenToChuc) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.GiayPhepKinhDoanh) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.GiayPhepKinhDoanh) %>
                <%= Html.ValidationMessageFor(model => model.GiayPhepKinhDoanh) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.NguoiDaiDien) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.NguoiDaiDien) %>
                <%= Html.ValidationMessageFor(model => model.NguoiDaiDien) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.TruSoChinh) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.TruSoChinh) %>
                <%= Html.ValidationMessageFor(model => model.TruSoChinh) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.SoTaiKhoan) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SoTaiKhoan) %>
                <%= Html.ValidationMessageFor(model => model.SoTaiKhoan) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.DienThoai) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.DienThoai) %>
                <%= Html.ValidationMessageFor(model => model.DienThoai) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Fax) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.Fax) %>
                <%= Html.ValidationMessageFor(model => model.Fax) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Email) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.Email) %>
                <%= Html.ValidationMessageFor(model => model.Email) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.TongSoCanBo) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.TongSoCanBo) %>
                <%= Html.ValidationMessageFor(model => model.TongSoCanBo) %>
            </div>
           
           <dt class="w4"><%= Html.LabelFor(model => model.KichHoat) %></dt>
                    <dd>
                        <%= Html.RadioButtonFor(model => model.KichHoat,true)%>
                        Bật
                        <%= Html.RadioButtonFor(model => model.KichHoat, false, new { @checked="checked"})%>
                        Tắt
                    </dd>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.KichHoat) %>
                <%= Html.ValidationMessageFor(model => model.KichHoat) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.TepDinhKem) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.TepDinhKem) %>
                <%= Html.ValidationMessageFor(model => model.TepDinhKem) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.MaTaiKhoan) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.MaTaiKhoan) %>
                <%= Html.ValidationMessageFor(model => model.MaTaiKhoan) %>
            </div>
            
            <p>
                <input type="submit" value="Create" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%= Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>


