<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.Models.ThamDinh>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thay đổi biên bản thẩm định
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
        <%= Html.ActionLink("Danh sách thẩm định", "Index", null, new { id = "danhsachButton" })%>
    </div>
    <% using (Html.BeginForm()) {%>
        <fieldset class="formVertical">
            <div class="span subHeader"><h3>Thông Tin Chung </h3></div>
            <div class="span subContent">
			    <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.MaThamDinh) %></dt>
                    <dd>
                        <%= Html.TextBox("MaThamDinh",Model.MaThamDinh)%>
                    </dd>
                </dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.GiayPhepHoatDong.ToChuc.TenToChuc) %></dt>
				    <dd>
				        <%= Html.TextBox("TenToChuc",Model.GiayPhepHoatDong.ToChuc.TenToChuc, new {@disabled="disabled"})%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.GiayPhepHoatDong.SoGiayPhep) %></dt>
				    <dd>
				        <%= Html.TextBox("SoGiayPhep",Model.GiayPhepHoatDong.SoGiayPhep, new {@disabled="disabled"})%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.NguoiThamDinh) %></dt>
				    <dd>
				        <%= Html.TextBox("NguoiThamDinh",Model.NguoiThamDinh)%>
                        <%= Html.ValidationMessageFor(model => model.NguoiThamDinh)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.NguoiPhiaToChuc) %></dt>
				    <dd>
				        <%= Html.TextBox("NguoiPhiaToChuc",Model.NguoiPhiaToChuc)%>
                        <%= Html.ValidationMessageFor(model => model.NguoiPhiaToChuc)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.TinhHopLe) %></dt>
				    <dd>
				        <%= Html.TextBox("TinhHopLe",Model.TinhHopLe)%>
                        <%= Html.ValidationMessageFor(model => model.TinhHopLe)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.NangLucNhanVien) %></dt>
				    <dd>
				        <%= Html.TextBox("NangLucNhanVien", Model.NangLucNhanVien)%>
                        <%= Html.ValidationMessageFor(model => model.NangLucNhanVien)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.NangLucThietBi) %></dt>
				    <dd>
				        <%= Html.TextBox("NangLucThietBi",Model.NangLucThietBi)%>
                        <%= Html.ValidationMessageFor(model => model.NangLucThietBi)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.KetLuan) %></dt>
				    <dd>
				        <%= Html.TextBox("KetLuan",Model.KetLuan)%>
                        <%= Html.ValidationMessageFor(model => model.KetLuan)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.KienNghi) %></dt>
                    <dd>
                        <%= Html.TextBox("KienNghi",Model.KienNghi)%>
                        <%= Html.ValidationMessageFor(model => model.KienNghi)%>
                    </dd>
                </dl>
<%--                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.LoaiThamDinh) %></dt>
				    <dd>
                        <%= Html.CheckBoxFor%>
				    </dd>
				</dl>--%>
            </div>
        </fieldset>
        <input class="formVertical" type="submit" value="Lưu lại" />
    <% } %>
</asp:Content>