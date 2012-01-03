﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.ViewModels.RegisterViewModel>" %>
<%@ Import Namespace="GIS.Helpers" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
   Đăng ký tài khoản
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
    <script type="text/javascript">
        $(function() {
        $("input[type=submit]").button();
        $("input[type=reset]").button();
        });
    </script>
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <% Html.EnableClientValidation(); %>    
    <%= Html.ValidationSummary(true, "Tài khoản tạo thất bại. Xin vui lòng sửa lỗi và nhập lại.") %>

    <% using (Html.BeginForm())
       {  %>     
    <div>
        <fieldset class="formVertical">
             <div class="span subHeader"><h3>Đăng ký tài khoản mới </h3></div>
             <div class="span subContent">
                  <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.TenTaiKhoan) %>
                </dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.TenTaiKhoan) %>
                    <%= Html.ValidationMessageFor(m => m.TenTaiKhoan) %>
                </dd>
            </dl>
           <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.Email) %>
                </dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.Email) %>
                    <%= Html.ValidationMessageFor(m => m.Email) %>
               </dd>
           </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.MatKhau) %>
                </dt>
                <dd>
                    <%= Html.PasswordFor(m => m.MatKhau) %>
                    <%= Html.ValidationMessageFor(m => m.MatKhau) %>
               </dd>
           </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.NhapLaiMatKhau) %>
                </dt>
                <dd>
                    <%= Html.PasswordFor(m => m.NhapLaiMatKhau) %>
                    <%= Html.ValidationMessageFor(m => m.NhapLaiMatKhau) %>
               </dd>
           </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.HoTen) %>
                </dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.HoTen)%>
                    <%= Html.ValidationMessageFor(m => m.HoTen) %>
               </dd>
           </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.DiaChi) %>
                </dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.DiaChi)%>
                    <%= Html.ValidationMessageFor(m => m.DiaChi) %>
               </dd>
           </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.CMND) %>
                </dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.CMND)%>
                    <%= Html.ValidationMessageFor(m => m.CMND) %>
               </dd>
           </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.Coquan) %>
                </dt>
                <dd>
                    <%= Html.TextBoxFor(m => m.Coquan)%>
                    <%= Html.ValidationMessageFor(m => m.Coquan) %>
               </dd>
           </dl>
            <dl class="span w16">
                <dt class="w4">
                    <%= Html.LabelFor(m => m.Captcha) %>
                </dt>
                <dd>
                      <%= Html.Captcha("myCaptcha") %>
               </dd>
           </dl>
            <dl class="span w16">
                <dt class="w4">
                Nhập ký tự ở trên :
                </dt>
                <dd>
                      <%= Html.TextBoxFor(m => m.Captcha) %>
                      <%= Html.ValidationMessageFor( m => m.Captcha  ) %>          
               </dd>
           </dl>
            </div>
            <br />

        </fieldset>        
    </div>
            <input  class="formVertical" type="reset"  value="Làm mới" />
            <input  type="submit" value="Đăng ký" />
            
    <% } %>
</asp:Content>
