﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PPC.aspx.cs" Inherits="ZoomLaCMS.Common.PPC" MasterPageFile="~/Common/Master/Empty.master"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<link href="/App_Themes/V3.css" rel="stylesheet" /><style>.form-control{display:inline-block;}</style>
<script type="text/javascript" src="/JS/Controls/ZL_PCC.js"></script>
<title>多级选择</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div id="three_div" runat="server" visible="false" style="padding-top:5px;padding-left:5px;">
<script src="/JS/ICMS/area.js"></script>
<select id="tbProvince" class="form-control text_200_auto"></select>
<select id="tbCity" class="form-control text_200_auto"></select>
<select id="tbCounty" class="form-control text_200_auto"></select>
<script>
    $(function () {
        var pcc = new ZL_PCC("tbProvince", "tbCity", "tbCounty");
        $("#address").val('<%=FValue %>');
        if ($("#address").val() != "") {
            var defdata = $("#address").val().split(',');
            pcc.SetDef(defdata[0], defdata[1], defdata[2]);
        }
        pcc.ProvinceInit();
        $("select").change(function () {
            parent.SetCitys('<%=FieldName %>', $("#tbProvince").val() + ',' + $("#tbCity").val() + ',' + $("#tbCounty").val())
        });
    });
</script>
</div>
<div runat="server" id="school_div" visible="false" style="padding-top:5px;padding-left:5px;">
    <script src="/JS/ICMS/AreaSchool.js"></script>
    <select id="tbProvince" class="form-control text_200_auto"></select>
    <select id="tbCity" class="form-control text_200_auto"></select>
    <select id="tbCounty" class="form-control text_200_auto" style="display:none;"></select>
    <script>
        $(function () {
            var pcc = new ZL_PCC("tbProvince", "tbCity", "tbCounty");
               $("#address").val('<%=FValue %>');
        if ($("#address").val() != "") {
            var defdata = $("#address").val().split(',');
            pcc.SetDef(defdata[0], defdata[1], defdata[2]);
        }
       pcc.ProvinceInit();
        $("select").change(function () {
            parent.SetCitys('<%=FieldName %>', $("#tbProvince").val() + ',' + $("#tbCity").val())
        });
    });
    </script>
</div>    
<div id="four_div" runat="server" visible="false" style="padding-top:5px;padding-left:5px;">
<script src="http://code.z01.com/four.js"></script>
<select id="tbProvince" class="form-control text_200_auto"></select>
<select id="tbCity" class="form-control text_200_auto"></select>
<select id="tbCounty" class="form-control text_200_auto"></select>
<select id="tbSTown" class="form-control text_200_auto"></select>
<script type="text/javascript">
    $(function () {
        var pcc = new ZL_PCC("tbProvince", "tbCity", "tbCounty", "tbSTown");
        $("#address").val('<%:FValue %>');
        if ($("#address").val() != "") {
            var defdata = $("#address").val().split(',');
            pcc.SetDef(defdata[0], defdata[1], defdata[2], defdata[3]);
        }
        pcc.ProvinceInit();
        $("select").change(function () {
            parent.SetCitys('<%=FieldName %>', $("#tbProvince").val() + ',' + $("#tbCity").val() + ',' + $("#tbCounty").val() + ',' + $("#tbSTown").val())
            });
    });
</script>
</div>
<input id="address" runat="server" type="hidden" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <asp:Literal runat="server" ID="CSS_L"></asp:Literal>
   <%-- <style type="text/css">
        .text_200_auto {display:block;margin-bottom:3px;width:200px;}
    </style>--%>
    <script>
        //AreaMod-- > CityList-- > CountyList-- > StownList
        //function GetBy(arr, name) {
        //    for (var i = 0; i < arr.length; i++) {
        //        if (arr[i].Name == name) {
        //            return arr[i];
        //        }
        //    }
        //    return null;
        //}
        //var cityArr = GetBy(AreaMod, "江西省").CityList;
        //var countyArr = GetBy(cityArr, "南昌市").CountyList;
    </script>
</asp:Content>
