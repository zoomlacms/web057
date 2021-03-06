﻿using Aop.Api;
using Aop.Api.Request;
using Aop.Api.Response;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.Common;

namespace ZoomLaCMS.alipay
{
    public partial class alipayAPI : System.Web.UI.Page
    {
         static IAopClient client = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            client = GetAlipayClient();
        }
        // 初始化alipayClient对象
        private static IAopClient GetAlipayClient()
        {
            //支付宝网关地址
            // -----沙箱地址-----
            //string serverUrl = "http://openapi.alipaydev.com/gateway.do";
            // -----线上地址-----
             string serverUrl = "https://openapi.alipay.com/gateway.do";
            //商户私钥
            //string privateKeyPem = GetCurrentPath() + "rsa_private_key.pem";

            IAopClient client = new DefaultAopClient(serverUrl, AlipayConfig.appid, function.VToP(AlipayConfig.private_key),"json", "1.0", "RSA2", AlipayConfig.alipay_public_key, AlipayConfig.charset, true);

            return client;
        }
        public void wapPay(string content) {
            //设置将发送到客户端的响应的内容类型
            AlipayTradeWapPayResponse alipayResponse = pay(content);
            string from = alipayResponse.Body;
            //输出支付宝返回的表单页面
            //printHtml(from);
            Response.Write(from);
        }
        public static AlipayTradeWapPayResponse pay(string content)
        {
            // 创建API对应的request
            AlipayTradeWapPayRequest alipayRequest = new AlipayTradeWapPayRequest();
            // 在公共参数中设置回跳和通知地址(应用提供给支付宝的请求路径),沙箱模式中不起作用(不知道是不是这个原因,支付宝技术客服告诉我正式上线后就没问题)
            alipayRequest.SetReturnUrl("http://www.tianyaxunqin.com/PayOnline/Return/AlipayH5.aspx");
            alipayRequest.SetNotifyUrl("http://www.tianyaxunqin.com/PayOnline/Return/AlipayH5Notify.aspx");
            alipayRequest.BizContent = content;
            // 填充业务参数
            //alipayRequest.setBizContent(content);
            AlipayTradeWapPayResponse alipayResponse = client.pageExecute(alipayRequest);
            return alipayResponse;
        }

        protected void BeginPay_Btn_Click(object sender, EventArgs e)
        {
            //yyyyMMddHHmmssss
            //20150320010101002
            string content = "{" +
                "\"out_trade_no\":\""+DateTime.Now.ToString("yyyyMMddHHmmss")+"\"," +
                "\"total_amount\":\"0.01\"," +
                "\"subject\":\"Iphone6\"," +
                "\"seller_id\":\"2088521125880200\"," +
                "\"product_code\":\"QUICK_WAP_PAY\"" +
                "}";
            wapPay(content);
        }
    }
    public class AlipayConfig
    {
        //支付宝网关地址
        public static string gateway_url = "https://openapi.alipay.com/gateway.do";
        //支付宝公钥
        public static string alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxOW0X5SiwE29TwZ5lDb0ljftI0ZetyhsiS6aHxueO2wrE8CQavOpS5v6ABJtmGX9I58tKESEnHHs+ocZBB/iGDrFWeZe41GVrvf8I0Qe+IPnhr0scVHuS43vcm2fwBg+i+oLFlyh2dKNERIAFkuAyNGSXRVuuft1WlLEobZ8Yy5FhlDC2eyFDmT9ZzztEDl1fPzr+Dqt9AO+e3FAKn0rdjq1ZKuqKJoMQbYX+3LXlOtSO8ePxUYKCQ3foehgg/ohncMYsxuzqk2+b6AHa5P/eqs53bJXhoRKFnTTwFWFaxbAtIyQnQy9nCZFl6/RP6L7OiPHmdWuKVQd3GG2oDaWgwIDAQAB";
        //商户私钥
        public static string private_key = "/Test/rsa_private_key.pem";
        //应用id
        public static string appid = "2017012205352621";
        //编码格式
        public static string charset = "UTF-8";
        //public static string token = "";
        //返回数据格式
        public static string format = "json";
        //签名方式
        public static string signtype = "RSA2";
    }
}