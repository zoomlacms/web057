<%@ Page Language="C#" AutoEventWireup="true" CodeFile="alipayAPI.aspx.cs" Inherits="ZoomLaCMS.alipay.alipayAPI" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>支付宝手机网站支付</title>
</head>
<body>
    <form id="form1" runat="server">
       <asp:Button runat="server" ID="BeginPay_Btn" Text="发起支付请求" OnClick="BeginPay_Btn_Click" />
    </form>
</body>
</html>
