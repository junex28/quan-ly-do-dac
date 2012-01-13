<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ThamDinhEditViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thêm biên bản thẩm định
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
    <fieldset class="formVertical">
        <div class="span subHeader">
            <h3>
                Thông Tin giấy phép
            </h3>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Mã giấy phép:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.MaHoSo)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Tên tổ chức:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.ToChuc.TenToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Loại đăng ký:
            </div>
            <div class="editor-field">
                <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang > 8 && Model.giayphep.TinhTrangGiayPhep.MaTinhTrang < 12)
                   { %>
                Đăng ký gia hạn
                <%}
                   else if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang > 5 && Model.giayphep.TinhTrangGiayPhep.MaTinhTrang < 9)
                   { %>
                Đăng ký bổ sung hoạt động
                <%}
                   else
                   {  %>
                Đăng ký giấy phép mới
                <%} %>
            </div>
        </div>
        
    </fieldset>
    <% Html.EnableClientValidation(); %>
    <%= Html.ValidationSummary(true) %>
    <% using (Html.BeginForm("Create", "ThamDinh", new { gpid = Model.giayphep.MaHoSo}))
       { %>
    <fieldset class="formVertical">
        <div class="span subHeader">
            <h3>
                Thông Tin thẩm định
            </h3>
        </div>
      <div class="span subContent">
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.NguoiThamDinh)%></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.NguoiThamDinh)%>
                    <%= Html.ValidationMessageFor(m => m.NguoiThamDinh)%>
                </dd>
            </dl>
            
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.NguoiPhiaToChuc)%></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.NguoiPhiaToChuc)%>
                    <%= Html.ValidationMessageFor(m => m.NguoiPhiaToChuc)%>
                </dd>
            </dl>
            
         <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.NgayThamDinh)%></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.NgayThamDinh)%>
                    <%= Html.ValidationMessageFor(m => m.NgayThamDinh)%>
                </dd>
            </dl>
            
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.TinhHopLe)%></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.TinhHopLe)%>
                    <%= Html.ValidationMessageFor(m => m.TinhHopLe)%>
                </dd>
            </dl>
            
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.NangLucNhanVien)%></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.NangLucNhanVien)%>
                    <%= Html.ValidationMessageFor(m => m.NangLucNhanVien)%>
                </dd>
            </dl>
            
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.NangLucThietBi)%></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.NangLucThietBi)%>
                    <%= Html.ValidationMessageFor(m => m.NangLucThietBi)%>
                </dd>
            </dl>
            
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.KetLuan)%></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.KetLuan)%>
                    <%= Html.ValidationMessageFor(m => m.KetLuan)%>
                </dd>
            </dl>
            
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.KienNghi)%></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.KienNghi)%>
                    <%= Html.ValidationMessageFor(m => m.KienNghi)%>
                </dd>
            </dl>
<%--
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.NguoiPhiaToChuc) %></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.NguoiPhiaToChuc)%>
                    <%= Html.ValidationMessageFor(m => m.NguoiPhiaToChuc)%>
                </dd>
            </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.TinhHopLe) %></dt>
                <dd>
                    <%= Html.TextBoxFor(m=> m.TinhHopLe)%>
                    <%= Html.ValidationMessageFor(m => m.TinhHopLe)%>
                </dd>
            </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.NangLucNhanVien) %></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.NangLucNhanVien)%>
                    <%= Html.ValidationMessageFor(m => m.NangLucNhanVien)%>
                </dd>
            </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.NangLucThietBi) %></dt>
                <dd>
                    <%= Html.TextBoxFor(m =>m.NangLucThietBi)%>
                    <%= Html.ValidationMessageFor(m => m.NangLucThietBi)%>
                </dd>
            </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.KetLuan) %></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.KetLuan)%>
                    <%= Html.ValidationMessageFor(m => m.KetLuan)%>
                </dd>
            </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.KienNghi) %></dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.KienNghi)%>
                    <%= Html.ValidationMessageFor(m => m.KienNghi)%>
                </dd>
            </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.LoaiThamDinh) %></dt>
                <dd>
                    <%= Html.DropDownListFor(m => m.LoaiThamDinh, new SelectList(Model.loaiThamDinh, "MaLoaiThamDinh", "DienGiai")) %>
                </dd>
            </dl>--%>
       </div>
    </fieldset>
    <input class="formVertical" type="reset" value="Làm mới" />
    <input type="submit" value="Lưu lại" />
    <% } %>
</asp:Content>
