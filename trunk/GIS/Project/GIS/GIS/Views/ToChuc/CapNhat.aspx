<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thay đổi thông tin tổ chức
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

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <%= Html.ValidationSummary(true) %>
        
    <div class="action-button">
        <%= Html.ActionLink("Danh sách tổ chức", "Index", null, new { id = "danhsachButton" })%>
    </div>
    <% using (Html.BeginForm()) {%>
        <fieldset class="formVertical">
            <div class="span subHeader"><h3>Thông Tin Chung </h3></div>
            <div class="span subContent">
			    <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.TenToChuc) %></dt>
                    <dd>
                        <%= Html.TextBox("TenToChuc",Model.toChuc.TenToChuc, new { @disabled = "disabled" })%>
                        <%= Html.ValidationMessageFor(model => model.toChuc.TenToChuc)%>
                    </dd>
                </dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.GiayPhepKinhDoanh) %></dt>
				    <dd>
				        <%= Html.TextBox("GiayPhepKinhDoanh",Model.toChuc.GiayPhepKinhDoanh)%>
                        <%= Html.ValidationMessageFor(model => model.toChuc.GiayPhepKinhDoanh)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.LoaiHinhToChuc.TenLoaiHinhToChuc) %></dt>
				    <dd>
                        <%= Html.DropDownList("MaLoaiToChuc", new SelectList(Model.loaiHinh, "MaLoaiHinhToChuc", "TenLoaiHinhToChuc", Model.toChuc.MaLoaiHinhToChuc)) %>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.TruSoChinh) %></dt>
				    <dd>
				        <%= Html.TextBox("TruSoChinh",Model.toChuc.TruSoChinh)%>
                        <%= Html.ValidationMessageFor(model => model.toChuc.TruSoChinh)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.NguoiDaiDien) %></dt>
				    <dd>
				        <%= Html.TextBox("NguoiDaiDien",Model.toChuc.NguoiDaiDien)%>
                        <%= Html.ValidationMessageFor(model => model.toChuc.NguoiDaiDien)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.DienThoai) %></dt>
				    <dd>
				        <%= Html.TextBox("DienThoai",Model.toChuc.DienThoai)%>
                        <%= Html.ValidationMessageFor(model => model.toChuc.NguoiDaiDien)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.Email) %></dt>
				    <dd>
				        <%= Html.TextBox("Email", Model.toChuc.Email)%>
                        <%= Html.ValidationMessageFor(model => model.toChuc.Email)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.Fax) %></dt>
				    <dd>
				        <%= Html.TextBox("Fax",Model.toChuc.Fax)%>
                        <%= Html.ValidationMessageFor(model => model.toChuc.Fax)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.SoTaiKhoan) %></dt>
				    <dd>
				        <%= Html.TextBox("SoTaiKhoan",Model.toChuc.SoTaiKhoan)%> (* Ngân hàng VietcomBank)
                        <%= Html.ValidationMessageFor(model => model.toChuc.SoTaiKhoan)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.TongSoCanBo) %></dt>
                    <dd>
                        <%= Html.TextBox("TongSoCanBo",Model.toChuc.TongSoCanBo)%>
                        <%= Html.ValidationMessageFor(model => model.toChuc.TongSoCanBo)%>
                    </dd>
                </dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.toChuc.KichHoat) %></dt>
                    <dd>
                        <%= Html.RadioButton("KichHoat",true, Model.toChuc.KichHoat == true)%>
                        Bật
                        <%= Html.RadioButton("KichHoat", false, Model.toChuc.KichHoat == false)%>
                        Tắt
                    </dd>
                </dl>
            </div>
        </fieldset>
        <input class="formVertical" type="submit" value="Lưu lại" />
    <% } %>
</asp:Content>
