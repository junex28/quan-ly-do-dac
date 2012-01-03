<%@ Page  Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.ToChucDetailViewModel>" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thông tin tổ chức
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="../../Scripts/swfupload.js" type="text/javascript"> </script>
    <script src="../../Scripts/jquery-asyncUpload-0.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function() {
            $("input[type=submit]").button();
            $("input[type=reset]").button();
        });
    </script>
    
    <script type="text/javascript">
        $(function() {
            $("#tepdinhkem").makeAsyncUploader({
                upload_url: "/ToChuc/Uploader",
                flash_url: '/Scripts/swfupload.swf',
                button_image_url: '/Content/images/blankButton.png',
                disableDuringUpload: 'INPUT[type="submit"]',
                file_types : "*.rar;*.zip",
                file_size_limit: "3072"
            });
        });      
    </script>
    
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.EnableClientValidation(); %>
    <%= Html.ValidationSummary(true) %>        
    <% using (Html.BeginForm("TaoMoi","ToChuc", FormMethod.Post ,new { enctype = "multipart/form-data" })) {%>
        <fieldset class="formVertical">
            <div class="span subHeader"><h3>Thông Tin Tổ Chức </h3></div>
            <div class="span subContent">
			    <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.TenToChuc) %></dt>
                    <dd>
                        <%= Html.TextBoxFor(m => m.TenToChuc)%>
                        <%= Html.ValidationMessageFor(m => m.TenToChuc)%>
                    </dd>
                </dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.GiayPhepKinhDoanh) %></dt>
				    <dd>
				        <%= Html.TextBoxFor(m =>m.GiayPhepKinhDoanh)%>
                        <%= Html.ValidationMessageFor(m => m.GiayPhepKinhDoanh)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.LoaiHinhToChuc) %></dt>
				    <dd>
                        <%= Html.DropDownListFor(m => m.MaLoaiHinhToChuc, new SelectList(Model.loaiHinh, "MaLoaiHinhToChuc", "TenLoaiHinhToChuc")) %>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.TruSoChinh) %></dt>
				    <dd>
				        <%= Html.TextBoxFor(m => m.TruSoChinh)%>
                        <%= Html.ValidationMessageFor(m => m.TruSoChinh)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.NguoiDaiDien) %></dt>
				    <dd>
				        <%= Html.TextBoxFor(m=> m.NguoiDaiDien)%>
                        <%= Html.ValidationMessageFor(m => m.NguoiDaiDien)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.DienThoai) %></dt>
				    <dd>
				        <%= Html.TextBoxFor(m => m.DienThoai)%>
                        <%= Html.ValidationMessageFor(m => m.DienThoai)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.Email) %></dt>
				    <dd>
				        <%= Html.TextBoxFor(m =>m.Email)%>
                        <%= Html.ValidationMessageFor(m => m.Email)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.Fax) %></dt>
				    <dd>
				        <%= Html.TextBoxFor(m => m.Fax)%>
                        <%= Html.ValidationMessageFor(m => m.Fax)%>
				    </dd>
				</dl>
				<dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.SoTaiKhoan) %></dt>
				    <dd>
				        <%= Html.TextBoxFor(m => m.SoTaiKhoan)%> (* Ngân hàng VietcomBank)
                        <%= Html.ValidationMessageFor(m => m.SoTaiKhoan)%>
				    </dd>
				</dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.TongSoCanBo) %></dt>
                    <dd>
                        <%= Html.TextBoxFor(m =>m.TongSoCanBo)%>
                        <%= Html.ValidationMessageFor(m => m.TongSoCanBo)%>
                    </dd>
                </dl>
                <dl class="span w16">
				    <dt class="w4"><%= Html.LabelFor(m => m.TepDinhKem) %></dt>
                    <dd>
                    <p>
                      <input type="file" id="tepdinhkem" name="tepdinhkem" />
                    </p>
                         
                    </dd>
                </dl>
            </div>
        </fieldset>
        <input  class="formVertical" type="reset"  value="Làm mới" />
        <input  type="submit" value="Lưu lại" />
    <% } %>
</asp:Content>
