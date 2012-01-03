<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.Models.ThamDinh>" %>

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
     <div class="editor-row">
            <div class="editor-label">
                <%= Html.Encode("Tình trạng hiện tại")%>
            </div>
            <div class="editor-field">
                <%= Html.Encode(Model.giayphep.TinhTrangGiayPhep.DienGiai)%>
            </div>
        </div>

</asp:Content>

