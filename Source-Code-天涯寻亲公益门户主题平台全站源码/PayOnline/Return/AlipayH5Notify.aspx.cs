using Aop.Api.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.AppCode.Base;
using ZoomLa.BLL;

namespace ZoomLaCMS.PayOnline.Return
{
    public partial class AlipayH5Notify : Base_PayPage
    {
        public override string PayPlat
        {
            get
            {
                return "支付宝手机网页支付";
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (CheckSign())
                {
                    //返回的信息标识交易是否成功,TRADE_FINISHED为不支持退款的交易
                    if (Request["trade_status"].Equals("TRADE_SUCCESS") || Request["trade_status"].Equals("TRADE_FINISHED"))
                    {
                        string payno = Request["out_trade_no"];
                        double money = Convert.ToDouble(Request.Form["receipt_amount"]);
                        PaySuccess(payno,money);
                    }
                    else { PayFailed(Request["trade_status"]); }
                    Response.Write("success");
                }
                else
                {
                    Log("[" + PayPlat + "]签名验证失败,返回:" + ServerReturn);
                    Response.Write("success");
                }
            }
            catch (Exception ex) { Log("[" + PayPlat + "]出错,原因:" + ex.Message + ",返回:" + ServerReturn); }
        }
        public override bool CheckSign()
        {
            Dictionary<string, string> paramsMap = new Dictionary<string, string>();
            foreach (string key in Request.Form.AllKeys)
            {
                //不要进行urldecode处理,或仅不对sign处理
                paramsMap.Add(key, Request.Form[key]);
            }
            //SACheckV1(IDictionary<string, string> parameters, string publicKeyPem, string charset, string signType, bool keyFromFile)
            //验证时其会自动去除 sign与signType
            bool checkSign = AlipaySignature.RSACheckV1(paramsMap, alipay_public_key, "UTF-8", "RSA2", false);
            return checkSign;
        }
        public static string alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnH/qMZfbxFgiafiNKKEgEY0F8E26S/7tdbehV7auZL2pVqRlTXUghETsRqmjfkWPzFv4tsMSSSuJdyYnPfMBPpC7DLvx4C+K51DFUqy/tz0mantkggINWG8L0qO9nReNIVZUkxFOHjYEql3Q28gLm2VyIoHtaQEPViBwy07NZ1C+HlajCLca/8g+PgclvPWreX7XJKVvjNG+xYgo69gPgFgHRiEr+tiRfGo0gFaRLe52EXiNYr9tDPir7dDk0FJiqmTpiSZqq0M0TglMCsar3URFIwEPr+efZ2VAcHdluVWjf7s6sU/IKQZRR8lXM5pLCyHWBemrMA9GXzItPdBD6wIDAQAB";

    }
}