<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Donate.aspx.cs" Inherits="ZoomLaCMS.PayOnline.Donate" MasterPageFile="~/Common/Master/Empty.master"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>水滴行善会</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div id="donate_body">
<% Call.Label("{ZL.Label id=\"全站头部\"/}");%>
<div class="donate_pic"></div>
<div class="container">
<div class="donate_con">
<div class="row">
<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
<div class="donate_con_c"><a href="javascript:;" data-money="10" class="weui-btn weui-btn_default">10元</a></div>
</div>
<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
<div class="donate_con_c"><a href="javascript:;" data-money="20" class="weui-btn weui-btn_default">20元</a></div>
</div>
<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
<div class="donate_con_c"><a href="javascript:;" data-money="50" class="weui-btn weui-btn_default">50元</a></div>
</div>
</div>
</div>
</div>
<div class="container">
<div class="weui-cells">
<div class="weui-cell">
<div class="weui-cell__hd"><label class="weui-label">其他金额</label></div>
<div class="weui-cell__bd"><ZL:TextBox ID="Money_T" Text="10" runat="server" CssClass="weui-input" placeholder="请输入要捐赠的金额" AllowEmpty="false" ValidType="FloatPostive" /></div>
</div>
</div>
<asp:Button ID="Donate_B" runat="server" CssClass="weui-btn weui-btn_primary margin_top20" Text="捐赠" OnClick="Donate_B_Click" />
</div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style>
.home_nav .navbar-right { display:none;}
.Search_top_overlay { background:rgba(255, 0, 0, 0.3);}
</style>
<script>
$(".donate_con_c a").click(function () {
    var $this = $(this);
    var money = $this.data("money");
	$("#Money_T").val(money);
    $("#Donate_B").click();
});
//---------------------手机下右侧导航菜单效果
$(function () {
    $('button.navbar-toggle').click(function () {
        $('body').toggleClass('out');
        $('nav.navbar-fixed-top').toggleClass('out');
        if ($('body').hasClass('out')) {
            $(this).focus();
        }
        else {
            $(this).blur();
        }
    });
});
$(document).click(function (e) {
    if (!$(e.target).closest('.navbar-collapse, button.navbar-toggle').length && $('body').hasClass('out')) {
        e.preventDefault();
        $('button.navbar-toggle').trigger('click');
    }
}).keyup(function (e) {
    if (e.keyCode == 27 && $('body').hasClass('out')) {
        $('button.navbar-toggle').trigger('click');
    }
});
</script>
</asp:Content>