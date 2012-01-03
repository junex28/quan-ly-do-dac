<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.Models.ThamDinh>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2> Details</h2>
    <fieldset>
        <legend>Chi tiết thẩm định</legend>
        <div class="editor-row">
            <div class="editor-label">
                Mã thẩm định:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.MaThamDinh)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Tên tổ chức:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.GiayPhepHoatDong.ToChuc.TenToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Số hiệu giấy phép:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.GiayPhepHoatDong.SoGiayPhep)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Người thẩm định:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.NguoiThamDinh)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Đại diện phía tổ chức:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.NguoiPhiaToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Ngày thẩm định:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.NgayThamDinh.Value.ToShortDateString())%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Tính hợp lệ:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.TinhHopLe)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
               Năng lực nhân viên:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.NangLucNhanVien)%>
            </div>
        </div>
         <div class="editor-row">
            <div class="editor-label">
               Năng lực thiết bị:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.NangLucThietBi)%>
            </div>
        </div>      
        <div class="editor-row">
            <div class="editor-label">
               Kết luận:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.KetLuan)%>
            </div>
        </div>     
        <div class="editor-row">
            <div class="editor-label">
              Kiến nghị:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.KienNghi)%>
            </div>
        </div>        
        <div class="editor-row">
            <div class="editor-label">
              Kiến nghị:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.LoaiThamDinh1.DienGiai)%>
            </div>
        </div> 
    </fieldset>

    <p>
        <%= Html.ActionLink("Edit", "Edit", new { id=Model.MaThamDinh }) %> |
        <%= Html.ActionLink("Back to List", "Index", new { id=Model.GiayPhepHoatDong.MaGiayPhepHoatDong})%>
    </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MapCenter" runat="server">
</asp:Content>

