<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ThamDinhEditViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Cập nhật biên bản thẩm định
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
        $(function() {
            $("#NgayThamDinh").datepicker();
        });
        $(function() {

            $('#xetduyetButton').click(function() {
                $('#xetduyetForm').submit();
            });

            $('#khongduyetButton').click(function() {
                $('#khongduyet').val() = 1;
                $('#xetduyetForm').submit();
            });

            $('#saveButton').click(function() {
                // Luu lai
                $('#Save').val() = 1;
            });


            $('#xetduyetForm').submit(
                function() {

                    var input = document.createElement("input");
                    input.setAttribute("type", "hidden");
                    input.setAttribute("name", "gpid");
                    input.setAttribute("value", "<%=Model.giayphep.MaHoSo%>");
                    $(this).append(input);
                    return true;
                });
        });
    </script>

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
      <div class="grid_19 alpha">
      <div class="box grid_10 alpha">  
        <h3>
            Thẩm định hồ sơ
            <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang ==1)
               {%>
            đăng ký giấy phép<% }
               else if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang == 9)
               {%>
            đăng ký bổ sung hoạt động<% }
               else if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang == 6)
               {%>
            đăng ký gia hạn<% }%>
        </h3>
      </div>
      <div class="box grid_8 omega" style="text-align:right">
      <% if (Model.giayphep.TinhTrangGiayPhep.MaTinhTrang != 1)
         {%> 
         <p> Số giấy phép :<%=Html.Encode(Model.giayphep.SoGiayPhep)%></p>
         <% if (Model.giayphep.NgayCapPhep != null)
            {%>
         <p> Cấp ngày : <%=Html.Encode(Model.giayphep.NgayCapPhep.Value.ToShortDateString())%>   </p> 
        <% }
            else
            {%>
       <p> Cấp ngày :</p> 
       <%} %>
       <%  }%>
      </div>
      <div class="clear"></div> 
     <% Html.RenderPartial("ThongTinChung", Model.thongtinchung); %>
    <div class="box">
        <h2>
            <a id="toggle-thamdinh" href="#" style="cursor: pointer;">Biên bản thẩm định</a>
        </h2>
        <div class="block" id="thamdinh">
            <% Html.EnableClientValidation(); %>
            <%= Html.ValidationSummary(true) %>
            <% using (Html.BeginForm("Edit", "ThamDinh", FormMethod.Post, new { id = "xetduyetForm"}))  
               {%>
            <p>
                <label class="grid_6">
                    Ngày thẩm định :
                </label>
                <%=Html.TextBoxFor(m=>m.ThamDinh.NgayThamDinh) %>
            </p>
            <p>
                <label class="grid_6">
                    Thành phần cơ quan thẩm định :
                </label>
                <%= Html.TextAreaFor(m=>m.ThamDinh.NguoiThamDinh) %>
                <%= Html.ValidationMessageFor(m => m.ThamDinh.NguoiThamDinh)%>
            </p>
            <p>
                <label class="grid_6">
                    Thành phần tổ chức đề nghị cấp giấy phép :
                </label>
                <%= Html.TextAreaFor(m=>m.ThamDinh.NguoiPhiaToChuc) %>
                <%= Html.ValidationMessageFor(m => m.ThamDinh.NguoiPhiaToChuc)%>
            </p>
            <p>
                <label class="grid_6">
                    Thẩm định kê khai lực lượng kỹ thuật :
                </label>
                <%= Html.TextAreaFor(m=>m.ThamDinh.NangLucNhanVien) %>
                <%= Html.ValidationMessageFor(m => m.ThamDinh.NangLucNhanVien)%>
            </p>
            <p>
                <label class="grid_6">
                    Kết luận
                </label>
                <%= Html.TextAreaFor(m=>m.ThamDinh.KetLuan) %>
                <%= Html.ValidationMessageFor(m => m.ThamDinh.KetLuan)%>
            </p>
            <p>
                <label class="grid_6">
                    Kiến nghị :
                </label>
                <%= Html.TextAreaFor(m=>m.ThamDinh.KienNghi) %>
                <%= Html.ValidationMessageFor(m => m.ThamDinh.KienNghi)%>
            </p>
            <% if (true)
               { %>
            <p>
                <label class="grid_6">
                   Số giấy phép :
                </label>
                <%= Html.TextBoxFor(m => m.ThamDinh.HoSoGiayPhep.SoGiayPhep)%>
                <%= Html.ValidationMessageFor(m => m.ThamDinh.HoSoGiayPhep.SoGiayPhep)%>
            </p>
            
            <% }
            }
                %>
        </div>
    </div>
    <div class="box">
        <div class="block prefix_4">
            <button id="backButton" class="button redmond" onclick="window.location.href='./'">
                <span class="back">Thoát</span></button>
            <button id="Button1" class="button redmond">
                <span class="khongduyet">Không Duyệt</span></button>
            <button id="xetduyetButton" class="button redmond">
                <span class="duyet">Duyệt</span></button>
        </div>
    </div>
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
    <input class="formVertical" type="reset" value="Làm mới" />
    <input type="submit" value="Lưu lại" />
</asp:Content>
