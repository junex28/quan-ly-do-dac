<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<GIS.Models.ToChuc>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Thong tin muon xoa
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">    
Ban thuc su muon xoa ? 
 <% using (Html.BeginForm()) { %>
               
      <fieldset style="margin-top:2%;">
            <legend style="font-size: 1.0em;">Xoa To Chuc</legend>
            <div class="display-label"><b>Ten To Chuc</b></div><br />
            <div class="display-field"><%=Html.Encode(Model.TenToChuc) %></div><br />
            
            <div class="display-label"><b>Ten To Chuc</b></div><br />
            <div class="display-field"><%=Html.Encode(Model.TruSoChinh) %></div><br />   
            
            <div class="display-label"><b>So Giay Phep Hoat Dong</b></div><br />
            <div class="display-field">Chua co</div><br />
             
            <div class="display-label"><b>Thoi gian het han giay phep</b></div><br />
            <div class="display-field">Chua co</div><br />
                              
        </fieldset>
          <p>
            <input name="confirmButton" type="submit" class="button" value="Xoa" /> | <%=Html.ActionLink("Quay lai","List")%>
          </p>
    <% } %>
</asp:Content>
