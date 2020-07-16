using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using ZoomLa.Common;
using System.Xml;
using ZoomLa.BLL;
using ZoomLa.Model;
using Newtonsoft.Json;
using System.Web.Security;
using ZoomLa.Components;
using ZoomLa.Model.Plat;
using ZoomLa.BLL.Plat;
using Newtonsoft.Json.Linq;
using ZoomLa.BLL.WxPayAPI;
using ZoomLa.BLL.User.Addon;
using ZoomLa.Model.User;

namespace ZoomLaCMS.PayOnline
{
    public partial class Donate : System.Web.UI.Page
    {
		public string timestr = "";
	    public string paySign = "";
	    public string nonceStr = "Wm3WZYTPz0wzccnW";
        B_Payment payBll = new B_Payment();
        B_OrderList orderBll = new B_OrderList();
        B_User buser = new B_User();
        M_UserInfo mu = new M_UserInfo();
		B_WX_APPID appBll = new B_WX_APPID();
		public M_WX_APPID appMod = new M_WX_APPID();
		B_UserAPP uappBll = new B_UserAPP();
		M_UserAPP uappMod = new M_UserAPP();
		M_WX_User wuserMod = new M_WX_User();
        public double Money { get { return DataConverter.CDouble(Request.QueryString["money"]); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
				M_UserInfo mu = buser.GetLogin();
				int appid = DataConverter.CLng(Request.QueryString["appid"]);
				
				if (mu != null && mu.UserID > 0)
				{
					try
					{
						TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
						timestr = Convert.ToInt64(ts.TotalSeconds).ToString();
						if (appid == 0)
							appid = 1;
						WxAPI wxapi = WxAPI.Code_Get(appid);
						appMod = appBll.SelReturnModel(appid);
	
						uappMod = uappBll.SelModelByUid(mu.UserID, "wechat");
						wuserMod = wxapi.GetWxUserModel(uappMod.OpenID);
	
						//userface.Src = wuserMod.HeadImgUrl;
						//userface.Alt = wuserMod.Name;
						//NickName.Text = wuserMod.Name;
	
						string jsapi_ticket = APIHelper.GetWebResult("https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + wxapi.AccessToken + "&type=jsapi");
						JObject jsapi_obj = (JObject)JsonConvert.DeserializeObject(jsapi_ticket);
						string stringA = "jsapi_ticket=" + jsapi_obj["ticket"].ToString() + "&noncestr=" + nonceStr + "&timestamp=" + timestr + "&url=" + Request.Url.AbsoluteUri;
						paySign = EncryptHelper.SHA1(stringA).ToLower();
	
						
					}
					catch (Exception ex) 
					{
						
					}
				}
                if (Money > 0) { GetDonate(Money); }
            }
        }
        protected void Donate_B_Click(object sender, EventArgs e)
        {
			
            double IMoney = DataConverter.CDouble(Money_T.Text);
            GetDonate(IMoney);
        }
        public void GetDonate(double Money)
        {
            if (Money < 0.01) { function.WriteErrMsg("请输入有效的金额"); }
			if (Money < 1) { function.WriteErrMsg("请至少捐赠1元"); }
            //mu = buser.SelReturnModel(Identity);
            mu = buser.GetLogin();
            M_OrderList Odata = orderBll.NewOrder(mu, M_OrderList.OrderEnum.Donate);
            Odata.Ordermessage = "打赏：" + Money + "元";
			//function.WriteErrMsg(Money.ToString());
            Odata.Ordersamount = Money;
            Odata.Userid = mu.IsNull ? Int32.MaxValue : mu.UserID;
            Odata.Balance_price = Odata.Ordersamount;
            Odata.Specifiedprice = Odata.Ordersamount;
            Odata.id = orderBll.insert(Odata);

            M_Payment payMod = payBll.CreateByOrder(Odata);
            payMod.Remark = "打赏：" + Money + "元";
            payMod.SysRemark = "donate";
            payMod.PaymentID = payBll.Add(payMod);
			//选择线下支付还是微信支付
			Response.Redirect("/PayOnline/Orderpay.aspx?PayNo=" + payMod.PayNo + "&OrderCode=" + Odata.OrderNo);
            //判断是不是来自微信
			/*
            if (DeviceHelper.GetBrower() == DeviceHelper.Brower.Micro)
            {
                //弹出微信支付窗口
                Response.Redirect("/PayOnline/wxpay_mp.aspx?PayNo=" + payMod.PayNo);
            }
            else
            {
                Response.Redirect("/PayOnline/Orderpay.aspx?PayNo=" + payMod.PayNo + "&OrderCode=" + Odata.OrderNo);
            }
			*/
        }
    }
}