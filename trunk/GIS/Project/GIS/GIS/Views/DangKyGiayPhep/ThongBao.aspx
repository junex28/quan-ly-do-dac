<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Thông báo
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Thông báo</h2>
    <span style="color: Red">
        <% var i = Model;
            string iStr = i.ToString();
            switch (iStr)
            {
                case "1":
                    {%>
        Bạn đã gửi một hồ sơ đăng ký giấy phép mới. Hồ sơ đang được thẩm định.<br />
        Click vào <a href="/dangkygiayphep/chitiet">đây</a>
        <% }break; 
            case "2":{%>
        Tổ chức này hiện tại chưa được cấp phép hoạt động đo đạc bản đồ.<br /> Vui
        lòng gửi hồ sơ đăng ký giấy phép mới tại <a href="/dangkygiayphep/taomoi">đây</a>
        <% } break;
           case "3":{%>
        Giấy phép được cấp cho tổ chức này đã hết hạn. <br />Vui lòng gửi hồ sơ đăng
        ký giấy phép mới tại <a href="/dangkygiayphep/taomoi">đây</a>
        <% } break;
           case "4":{%>
        Bạn đã gủi một hồ sơ đăng ký mới. Hồ sơ đã được thẩm định thành công.<br />
        Vui lòng không gửi thêm hồ sơ khác.
        <% } break;
           case "5":{%>
        Tổ chức hiện tại đã được cấp phép hoạt động. <br /> Vui lòng không gửi thêm
        hồ sơ đăng ký khác.
        <% } break;
          case "6":{%>
        Bạn đã gửi một hồ sơ xin bổ sung hoạt động. Hồ sơ đang chờ thẩm định.
        <% } break;
        case "7":{%>
        Hồ sơ xin bổ sung hoạt động được xét duyệt.
        <% } break;
           case "8":{%>
         Bạn đã được cấp giấy phép hoạt động. Xin vui lòng không gửi thêm hồ sơ
        xin phép mới.
        <% } break;
          case "9":{%>
          Bạn đã gửi một hồ sơ xin gia hạn giấy phép hoạt động.Hồ sơ đang được
        thẩm định.<br /> Xin vui lòng không gửi thêm hồ sơ xin phép mới.
        <% } break;
        case "10":{%>
           Bạn đã gửi một hồ sơ xin gia hạn giấy phép hoạt động nhưng kết quả không
        đạt. <br />Vui lòng gửi lại hồ sơ đăng ký gia hạn tại <a href="">đây</a>
        <% } break;
         case "11":{%>
          Bạn đã gửi một hồ sơ xin gia hạn giấy phép hoạt động.Hồ sơ đang được
        thẩm định. <br />Xin vui lòng không gửi thêm hồ sơ xin phép mới.
        <% } break;
          case "12":{%>
           Giấy phép hoạt động của tổ chức này hiện tại đã bị hủy. <br />Vui lòng gửi
        hồ sơ đăng ký giấy phép mới tại <a href="/dangkygiayphep/taomoi">đây </a>
        <% } break;
           case "13":{%>
           Giấy phép của tổ chức này vẫn hoạt động bình thường, chưa đến thời
        gian gia hạn. <br />Chúng tôi sẽ nhận hồ sơ xin gia hạn trước khi giấy phép hết
        hạn ít nhất 30 ngày và nhiều nhất là 60 ngày.<br /> Vui lòng gửi hồ sơ gia
        hạn trong thời gian quy đinh. Xin cảm ơn! </span>
        <% } break;
         case "14":{%>
           Không tìm thấy chi tiết hồ sơ đang được thẩm định</span>
        <% } break;
         case "20":{%>
              Gửi hồ sơ đăng ký thành công. Hồ sơ đã được lưu và chờ thẩm định. </span>
        <% } break;
         case "21":{%>
           Gửi hồ sơ đăng ký không thành công. Vui lòng nhấn vào <a href="/dangkygiayphep/taomoi">
        đây </a>nếu bạn muốn thử điền lại. </span>
        <% } break;
         case "22":{%>
             Lưu hồ sơ thành công. Thông tin chung, danh sách thiết bị, danh sách người
    chịu trách nhiệm,<br /> báo cáo công trình, danh sách lực lượng kỹ thuật phân
    tích sẽ được lưu lại. </span>
        <% } break;
         case "23":{%>
          Lưu hồ sơ không thành công. Vui lòng kiểm tra lại thông tin đã điền.
           </span>
        <% } break;
            }
          %>     
               
    <br />
    <input class="button redmond" type="button" value="Trở về" onclick="window.location.href='/trangchu/index'" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
