<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Orderpay.aspx.cs" Inherits="ZoomLaCMS.PayOnline.Orderpay" EnableViewStateMac="false" MasterPageFile="~/Cart/order.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<title>选择支付平台</title>
<style>
body { position:relative;}
.totalmoney{font-size:1.6em;}
.totinfo_div{display:none;}
.totinfo{color:#ccc;font-size:1.1em; cursor:pointer;}
.totinfo:hover{color:#999;}
.show_d {position: absolute; display:none; top: 0; bottom: 0; left: 0; right: 0; z-index: 2001;}
.show_d1 { width:100%; height:100%; background:rgba(0,0,0,0.5);}
.show_dialog { position:absolute; background:#FFF; padding:1em; border:1px solid #CCC; border-radius:10px; top:50%; left: 50%; -webkit-transform:translate(-50%,-50%); transform:translate(-50%,-50%);}
.main_div,.cart_site_bottom { display:none;}
</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
        <div class="pay_select" style="padding-bottom:0px;">
            <div class="pay_head">
            <%--    <div><strong>订单提交成功，请您尽快付款！</strong></div>--%>
                <div><span class="list_sp">订单号:</span><asp:Label ID="OrderNo_L" runat="server" ForeColor="Green"></asp:Label></div>
                <div>
                    <span class="list_sp">应付金额：</span>
                    <span class="totalmoney"><i class="fa fa-rmb"></i><asp:Label ID="TotalMoney_L" CssClass="" runat="server"></asp:Label></span>
                    <span class="totinfo" title="点击查看详情"> <i class="fa fa-caret-down"></i></span>
                </div>
                <div class="totinfo_div">
                    <span class="list_sp">金额详情：</span>
                    <asp:Label ID="TotalMoneyInfo_T" runat="server" />
                </div>
            </div>
            <div class="PayPlat_s">
                <div class="divline paytitle">在线支付(请选择平台)：</div>
                <ul class="list-unstyled margin_t5">
                    <asp:Repeater runat="server" ID="PayPlat_RPT">
                        <ItemTemplate>
                            <li class="payplat_li plat_item col-lg-3 col-md-4 col-sm-6 col-xs-12 text-left" title="<%#Eval("PayPlatName") %>">
                                <input type="radio" class="payplat_rad" name="payplat_rad" value="<%#Eval("PayPlatID") %>" />
                                <img src="<%#GetPlatImg()%>" class="plat_item_img" />
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                    <li class="clearfix"></li>
                </ul>
                <div runat="server" id="virtual_ul">
                    <div class="divline paytitle">虚拟钱包：</div>
                    <ul class="dashpay_ul margin_t5">
                        <li runat="server" id="purseli" title="用户余额支付" visible="false">
                            <input type="radio" name="payplat_rad" value="Purse" />
                            <div class='pay_btn'><i class="fa fa-credit-card">余额支付</i></div>
                        </li>
                        <li runat="server" id="siconli" title="用户银币支付" visible="false">
                            <input type="radio" name="payplat_rad" value="SilverCoin" />
                            <div class='pay_btn'><i class="fa fa-rouble">银币支付</i></div>
                        </li>
                        <li runat="server" id="pointli" title="用户积分支付" visible="false">
                            <input type="radio" name="payplat_rad" value="Score" />
                            <div class='pay_btn'><i class="fa fa-money">积分支付</i></div>
                        </li>
                    </ul>
                </div>
                <asp:Button ID="BtnSubmit" CssClass="i_bottom" runat="server" OnClick="BtnSubmit_Click" />
                <div class="clear"></div>
            </div>
        </div>

<div class="show_d">
<div class="show_d1">
<div class="show_dialog">
<p>户 名：聊城市天涯寻亲志愿者协会</p>
<p>帐 号：15851001040027078</p>
<p>开户行：中国农业银行股份有限公司聊城开发区支行</p>
</div>
</div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script>
$(function () {
	$(".plat_item_img").click(function () { $(this).siblings(":radio")[0].checked = true; });
	$(".dashpay_ul li").click(function () {
		$(".dashpay_ul .active").removeClass('active');
		$(this).find('input')[0].checked = true;
		$(this).addClass('active');
	});
	if ($(".payplat_rad").length > 0) { $(".payplat_rad:first")[0].checked = true; }
	$(".totinfo").click(function () {
	    var $info = $(".totinfo_div");
	    if ($info.css("display") == "none") {
	        $info.slideDown(200);
	    } else {
	        $info.slideUp(100);
	    }
	});
})
$("input[value='1']").click(function(){
    $(".show_d").show();
});
$("input[value='1']").siblings("img").click(function(){
    $(".show_d").show();
});
$(".show_d1").click(function(){
    $(".show_d").hide();
});
$("#BtnSubmit").click
</script>
</asp:Content>