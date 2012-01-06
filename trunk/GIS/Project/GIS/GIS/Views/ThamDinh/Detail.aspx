<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ThamDinhEditViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Details
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
    <div class="action-button">
        <%= Html.ActionLink("Danh sách thẩm định", "Index", new { id = Model.ThamDinh.GiayPhepHoatDong.MaGiayPhepHoatDong }, new { id = "danhsachButton" })%>
    </div>
    <fieldset>
        <legend>Chi tiết thẩm định</legend>
        <div class="editor-row">
            <div class="editor-label">
                Mã thẩm định:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.MaThamDinh)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Tên tổ chức:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.GiayPhepHoatDong.ToChuc.TenToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Số hiệu giấy phép:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.GiayPhepHoatDong.SoGiayPhep)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Người thẩm định:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.NguoiThamDinh)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Đại diện phía tổ chức:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.NguoiPhiaToChuc)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Ngày thẩm định:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.NgayThamDinh.Value.ToShortDateString())%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
                Tính hợp lệ:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.TinhHopLe)%>
            </div>
        </div>
        <div class="editor-row">
            <div class="editor-label">
               Năng lực nhân viên:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.NangLucNhanVien)%>
            </div>
        </div>
         <div class="editor-row">
            <div class="editor-label">
               Năng lực thiết bị:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.NangLucThietBi)%>
            </div>
        </div>      
        <div class="editor-row">
            <div class="editor-label">
               Kết luận:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.KetLuan)%>
            </div>
        </div>     
        <div class="editor-row">
            <div class="editor-label">
              Kiến nghị:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.KienNghi)%>
            </div>
        </div>        
        <div class="editor-row">
            <div class="editor-label">
              Kết quả thẩm định:
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.ThamDinh.LoaiThamDinh1.DienGiai)%>
            </div>
        </div> 
    </fieldset>

    <p>
        <%= Html.ActionLink("Edit", "Edit", new { id=Model.ThamDinh.MaThamDinh }) %> |
        <%= Html.ActionLink("Back to List", "Index", new { id=Model.ThamDinh.GiayPhepHoatDong.MaGiayPhepHoatDong})%>
    </p>

</asp:Content>


