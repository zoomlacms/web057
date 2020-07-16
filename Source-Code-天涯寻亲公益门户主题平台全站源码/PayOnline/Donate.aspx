<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Donate.aspx.cs" Inherits="ZoomLaCMS.PayOnline.Donate" MasterPageFile="~/Common/Master/Empty.master" debug="true"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>爱心捐赠</title>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
wx.config({
	appId: '<%=appMod.APPID%>', // 必填，公众号的唯一标识
	debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	jsApiList: ["onMenuShareAppMessage", "onMenuShareTimeline"], // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	nonceStr: '<%=nonceStr%>', // 必填，生成签名的随机串
	signature: '<%=paySign%>',// 必填，签名，见附录1
	timestamp: '<%=timestr%>' // 必填，生成签名的时间戳
});
wx.ready(function () {
	// config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
	wx.onMenuShareAppMessage({
		title: '我是<%Call.Label("{ZL.Label id=\"获取当前登录用户真实姓名\" /}"); %>,我为天涯寻亲出力！', // 分享标题
		desc: '岁月稀释不了亲情的血，距离分不开相拥的心；风雨挡不住寻亲的脚步，山河拦不断团圆的信念。', // 分享描述
		link: '<%Call.Label("{$SiteURL/}");%>/wxpromo.aspx?r=/PayOnline/Donate.aspx', // 分享链接
		imgUrl: '<%Call.Label("{$SiteURL/}");%>/UploadFiles/logo.png', // 分享图标
		type: '', // 分享类型,music、video或link，不填默认为link
		dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
		success: function () {
			// 用户确认分享后执行的回调函数
		},
		cancel: function () {
			// 用户取消分享后执行的回调函数
		}
	});
	wx.onMenuShareTimeline({
		title: '我是<%Call.Label("{ZL.Label id=\"获取当前登录用户真实姓名\" /}"); %>,我为天涯寻亲出力', // 分享标题
		desc: '岁月稀释不了亲情的血，距离分不开相拥的心；风雨挡不住寻亲的脚步，山河拦不断团圆的信念。', // 分享描述
		link: '<%Call.Label("{$SiteURL/}");%>/wxpromo.aspx?r=/PayOnline/Donate.aspx', // 分享链接
		imgUrl: '<%Call.Label("{$SiteURL/}");%>/UploadFiles/logo.png', // 分享图标
		success: function () {
			// 用户确认分享后执行的回调函数
		},
		cancel: function () {
			// 用户取消分享后执行的回调函数
		}
	});
});
</script>
<style>
.height80 { height:50px;}
</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div id="donate_body">
<div class="hidden-xs">
<% Call.Label("{ZL.Label id=\"全站头部\"/}");%>
</div>
<% Call.Label("{ZL.Label id=\"微信端头部\"/}");%>

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
<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
<div class="donate_con_c"><a href="javascript:;" data-money="100" class="weui-btn weui-btn_default">100元</a></div>
</div>
</div>
</div>
</div>
<div class="container">
<div class="weui-cells">
<div class="weui-cell">
<div class="weui-cell__hd"><label class="weui-label"><i class="fa fa-pencil"></i>其他金额</label></div>
<div class="weui-cell__bd"><ZL:TextBox ID="Money_T" runat="server" CssClass="form-control" placeholder="请输入要捐赠的金额" AllowEmpty="false" ValidType="FloatPostive" /></div>
</div>
</div>
<asp:LinkButton ID="Donate_B" runat="server" OnClick="Donate_B_Click" CssClass="weui-btn weui-btn_primary margin_top20"><i class="fa fa-heart"></i> 捐赠</asp:LinkButton>
<a href="/Class_15/NodeHot.aspx" class="weui-btn weui-btn_default"><i class="fa fa-file-text"></i> 明细</a>
</div>
</div>
<% Call.Label("{ZL.Label id=\"微信弹出菜单\"/}");%>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style>
.home_nav .navbar-right { display:none;}
.Search_top_overlay { background:rgba(255, 0, 0, 0.3);}
.weui-cells:before { border-top:none;}
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
//微信弹出菜单效果
$(function(){
	//menu float
	var menufloatclicknumber=0;
	function menufloatin(){
		$(".menu-c").removeClass("out");
		$("#menufloat").addClass("show")
		$(".mask_menu").fadeIn();
		$("#menufloat-c").show();
		$(".menu-c-inner").removeClass("outer");
		$(".menu-c-inner").addClass("in")
		$(".menu-c-inner a").show();
		menufloatclicknumber=1;
	}
	function menufloatout(){
		$("#menufloat").removeClass("show")
		$(".mask_menu").fadeOut();
		$(".menu-c-inner").removeClass("in")
		$(".menu-c-inner").addClass("outer")
		$(".menu-c-inner a").hide();
		$(".menu-c").addClass("out");
		menufloatclicknumber=0;		
	}	   
	$("#menufloat").click(function(){
		if(menufloatclicknumber==0){ menufloatin(); }
		else { menufloatout();}			 	
	})
	$(".mask_menu").click(function(){
		menufloatout(); 
	})
});
</script>
</asp:Content>