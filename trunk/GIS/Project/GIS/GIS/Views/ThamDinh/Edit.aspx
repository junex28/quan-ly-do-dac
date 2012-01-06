<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ThamDinhEditViewModel>" %>

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
     <script type="text/javascript">

         $(function() {
             $(".datepicker").datepicker({
             duration: '',
                 dateFormat:'dd/mm/yy',
                 changeMonth: true,
                 changeYear: true,
                 constrainInput: false 
             });
         });

    </script>
    <style type="text/css">
    .ui-datepicker table{
        display: none;
    }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <%= Html.ValidationSummary(true) %>
    
    <div class="action-button">
        <%= Html.ActionLink("Danh sách thẩm định", "Index",null, new { id = "danhsachButton" })%>
    </div>
    <% using (Html.BeginForm()) {%>
        <fieldset class="formVertical">
            <div class="span subHeader"><h3>Thông Tin Chung </h3></div>
            <div class="span subContent">
			    <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.MaThamDinh) %></dt>
                    <dd>
                        <%= Html.TextBox("MaThamDinh", Model.ThamDinh.MaThamDinh, new { @disabled = "disabled"})%>
                    </dd>
                </dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.GiayPhepHoatDong.ToChuc.TenToChuc)%></dt>
				    <dd>
				        <%= Html.TextBox("TenToChuc", Model.ThamDinh.GiayPhepHoatDong.ToChuc.TenToChuc, new { @disabled = "disabled" })%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.GiayPhepHoatDong.SoGiayPhep)%></dt>
				    <dd>
				        <%= Html.TextBox("SoGiayPhep", Model.ThamDinh.GiayPhepHoatDong.SoGiayPhep, new { @disabled = "disabled" })%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.NgayThamDinh)%></dt>
				    <dd>
				        <%= Html.TextBox("NgayThamDinh", Model.ThamDinh.NgayThamDinh, new { @class="datepicker"})%>
                        <%= Html.ValidationMessageFor(model => model.ThamDinh.NgayThamDinh)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.NguoiThamDinh)%></dt>
				    <dd>
				        <%= Html.TextBox("NguoiThamDinh", Model.ThamDinh.NguoiThamDinh)%>
                        <%= Html.ValidationMessageFor(model => model.ThamDinh.NguoiThamDinh)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.NguoiPhiaToChuc)%></dt>
				    <dd>
				        <%= Html.TextBox("NguoiPhiaToChuc", Model.ThamDinh.NguoiPhiaToChuc)%>
                        <%= Html.ValidationMessageFor(model => model.ThamDinh.NguoiPhiaToChuc)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.TinhHopLe)%></dt>
				    <dd>
				        <%= Html.TextBox("TinhHopLe", Model.ThamDinh.TinhHopLe)%>
                        <%= Html.ValidationMessageFor(model => model.ThamDinh.TinhHopLe)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.NangLucNhanVien)%></dt>
				    <dd>
				        <%= Html.TextBox("NangLucNhanVien", Model.ThamDinh.NangLucNhanVien)%>
                        <%= Html.ValidationMessageFor(model => model.ThamDinh.NangLucNhanVien)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.NangLucThietBi)%></dt>
				    <dd>
				        <%= Html.TextBox("NangLucThietBi", Model.ThamDinh.NangLucThietBi)%>
                        <%= Html.ValidationMessageFor(model => model.ThamDinh.NangLucThietBi)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.KetLuan)%></dt>
				    <dd>
				        <%= Html.TextBox("KetLuan", Model.ThamDinh.KetLuan)%>
                        <%= Html.ValidationMessageFor(model => model.ThamDinh.KetLuan)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.KienNghi)%></dt>
                    <dd>
                        <%= Html.TextBox("KienNghi", Model.ThamDinh.KienNghi)%>
                        <%= Html.ValidationMessageFor(model => model.ThamDinh.KienNghi)%>
                    </dd>
                </dl>
               <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(model => model.ThamDinh.LoaiThamDinh1.DienGiai) %></dt>
				    <dd>
                        <%= Html.DropDownList("LoaiThamDinh", new SelectList(Model.loaiThamDinh, "MaLoaiThamDinh", "DienGiai", Model.ThamDinh.LoaiThamDinh))%>
				    </dd>
				</dl>
            </div>
        </fieldset>
        <input class="formVertical" type="submit" value="Lưu lại" />
    <% } %>
</asp:Content>