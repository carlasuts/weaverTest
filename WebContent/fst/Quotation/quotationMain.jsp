<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
User user = HrmUserVarify.getUser (request , response) ;
if(user == null)  return ;
int requestid = Util.getIntValue(request.getParameter("requestid"));//请求id
int workflowid = Util.getIntValue(request.getParameter("workflowid"));//流程id
int formid = Util.getIntValue(request.getParameter("formid"));//表单id
int isbill = Util.getIntValue(request.getParameter("isbill"));//表单类型，1单据，0表单
int nodeid = Util.getIntValue(request.getParameter("nodeid"));//流程的节点id
int resourceId = user.getUID();


String tradeway = BillUtil.getLabelId(formid,0,"Tradeway");//贸易方式
String custidoffer = BillUtil.getLabelId(formid,0,"custid_offer");//报价客户号
String shape = BillUtil.getLabelId(formid,0,"shape");//外形
String producttype = BillUtil.getLabelId(formid,0,"product_type");//生产类型
String totalprice = BillUtil.getLabelId(formid,0,"total_price");//总成交价
String testuph = BillUtil.getLabelId(formid,0,"test_uph");//测试UPH
String quotationmode = BillUtil.getLabelId(formid,1,"Quotation_mode");//报价模式
String totalcost = BillUtil.getLabelId(formid,1,"total_cost");//总成本
String dealprice = BillUtil.getLabelId(formid,1,"deal_price");//成交价格
String suggestedprice = BillUtil.getLabelId(formid,1,"Suggested_price");//建议价格
String grossmargin  = BillUtil.getLabelId(formid,1,"gross_margin");//成交毛利率
String discount  = BillUtil.getLabelId(formid,1,"discount");//折扣率
String rate = BillUtil.getLabelId(formid,0,"rate");//税率
String exchange_rate = BillUtil.getLabelId(formid,0,"exchange_rate"); //汇率
String Quotation_way = BillUtil.getLabelId(formid,0,"Quotation_way");//报价方式
String overall_gross = BillUtil.getLabelId(formid,0,"overall_gross");//整体毛利率
String cost_element = BillUtil.getLabelId(formid,1,"cost_element");//成本元素
String offerreasons = BillUtil.getLabelId(formid,0,"Offerreasons");// 报价原因
String overallcost = BillUtil.getLabelId(formid,0,"overall_cost");// 整体成本

String currency = BillUtil.getLabelId(formid,0,"currency");//币种

String tester = BillUtil.getLabelId(formid,0,"tester");
String MD_HANDLER = BillUtil.getLabelId(formid,0,"MD_HANDLER");

%>

  <style type="text/css">  
    #login  
    {  
        display:none;  
        border:1em solid #3366FF;  
        height:30%;  
        width:50%;  
        position:absolute;
        top:24%; 
        left:24%;  
        z-index:2;
        background: white;  
    }  
    #over  
    {  
        width: 100%;  
        height: 100%;  
        opacity:0.8; 
        filter:alpha(opacity=80);  
        display: none;  
        position:absolute;  
        top:0;  
        left:0;  
        z-index:1;  
        background: silver;  
    }  
    </style>  
<script type="text/javascript">
	var tradeway = <%=tradeway%>;
	var custidoffer = <%=custidoffer%>;
	var shape = <%=shape%>;
	var producttype = <%=producttype%>;
	var hashours = false;	
	var testuph = <%=testuph%>;
	var totalprice = <%=totalprice%>;
	var quotationmode = <%=quotationmode%>;
	var totalcost = <%=totalcost%>;
	var dealprice = <%=dealprice%>;
	var suggestedprice = <%=suggestedprice%>;
	var grossmargin = <%=grossmargin%>;
	var discount = <%=discount%>;
	var rate = <%=rate%>;	
	var maxid = 0;
	var Quotation_way =<%=Quotation_way%>;
	var currency = <%=currency%>
	var MD_HANDLER =<%=MD_HANDLER%>;
	var tester =<%=tester%>;
	var cost_element = <%=cost_element%>
	var exchange_rate = <%=exchange_rate%>
	var nodeid = <%=nodeid%>
	var offerreasons = <%=offerreasons%>
	var overallcost = <%=overallcost%>
	
	
	jQuery(function () {// nodeid:25364 申请
		if(nodeid == 25367 || nodeid == 25368 || nodeid == 25369 || nodeid == 25376 || nodeid == 25370 || nodeid == 25372 || nodeid == 25371 || nodeid == 25373 || nodeid == 25374 || nodeid == 25375){
			jQuery("select[id^='field"+ quotationmode +"_']").each(function(index) {
				var mxid = this.id.split("_")[1];
				setCover1(quotationmode + "_" + mxid);
				setCover1(cost_element + "_" + mxid);
				setCover1(totalcost + "_" + mxid);
				setCover1(suggestedprice + "_" + mxid);
				setCover1(grossmargin + "_" + mxid);
				setCover1(discount + "_" + mxid);
			});
			setCover(offerreasons);
			setCover(tradeway);
			setCover(currency);
			setCover(producttype);
			setCover(Quotation_way);
			
			// 以下代码是用来显示自定义浏览按钮保存之后无值的情况
			var testerValue = jQuery("#field"+ tester).val();
			if(jQuery("#field"+ tester + "span").text() == "x"){// 测试机
				// jQuery("#field"+ tester + "span").text(jQuery("#field"+ tester).val());
				jQuery("#field"+ tester + "span").html('<span class="e8_showNameClass"><a>' + testerValue + '</a>&nbsp;<span class="e8_delClass" id="' + testerValue + '" style="visibility: hidden; opacity: 1;" onclick="del(event,this,2,false,{});">&nbsp;x&nbsp;</span></span>');
			}
			
			var MD_HANDLERVALUE = jQuery("#field"+ MD_HANDLER).val();
			if(jQuery("#field"+ MD_HANDLER + "span").text() == "x"){// 机械手
				// jQuery("#field"+ MD_HANDLER + "span").text(jQuery("#field"+ MD_HANDLER).val());
				jQuery("#field"+ MD_HANDLER + "span").html('<span class="e8_showNameClass"><a>' + MD_HANDLERVALUE + '</a>&nbsp;<span class="e8_delClass" id="' + MD_HANDLERVALUE + '" style="visibility: hidden; opacity: 1;" onclick="del(event,this,2,false,{});">&nbsp;x&nbsp;</span></span>');
			}
			
			//jQuery("#field162423_"+maxid+"span").html('<span class="e8_showNameClass"><a>' + arraysList[i] + '</a>&nbsp;<span class="e8_delClass" id="'+arraysList[i]+'" style="visibility: hidden; opacity: 1;" onclick="del(event,this,2,false,{});">&nbsp;x&nbsp;</span></span>'); 
		}
		
		if (nodeid==25364) {// 申请节点
			// 以下代码是用来显示自定义浏览按钮保存之后无值的情况
			var custidofferValue = jQuery("#field"+ custidoffer).val();
			if(jQuery("#field"+ custidoffer + "span").text() == "x"){// 报价客户号
				jQuery("#field"+ custidoffer + "span").html('<span class="e8_showNameClass"><a>' + custidofferValue + '</a>&nbsp;<span class="e8_delClass" id="' + custidofferValue + '" style="visibility: hidden; opacity: 1;" onclick="del(event,this,2,false,{});">&nbsp;x&nbsp;</span></span>');
			}
		}

		$("#field"+Quotation_way).bindPropertyChange(function(e){			
			if(e.value == "0" && $("#field"+tradeway).val() !='' && $("#field"+custidoffer).val() !='' && $("#field"+shape).val() !='' && $("#field"+producttype).val() !='' ){
				doappend();
			}else{
				doremove();
			}
		});
		$("#field"+tradeway).bindPropertyChange(function(){
			if($("#field"+Quotation_way+" option:selected").val() == "0" && $("#field"+tradeway).val() !='' && $("#field"+custidoffer).val() !='' && $("#field"+shape).val() !='' && $("#field"+producttype).val() !='' ){
				doappend();
			}else{
				doremove();
			}
		});
		$("#field"+custidoffer).bindPropertyChange(function(){
			if($("#field"+Quotation_way+" option:selected").val() == "0" && $("#field"+tradeway).val() !='' && $("#field"+custidoffer).val() !='' && $("#field"+shape).val() !='' && $("#field"+producttype).val() !='' ){
				doappend();
			}else{
				doremove();
			}
		});
		$("#field"+shape).bindPropertyChange(function(){
			if($("#field"+Quotation_way+" option:selected").val() == "0" && $("#field"+tradeway).val() !='' && $("#field"+custidoffer).val() !='' && $("#field"+shape).val() !='' && $("#field"+producttype).val() !='' ){
				doappend();
			}else{
				doremove();
			}
		});
		$("#field"+producttype).bindPropertyChange(function(){
			if($("#field"+Quotation_way+" option:selected").val() == "0" && $("#field"+tradeway).val() !='' && $("#field"+custidoffer).val() !='' && $("#field"+shape).val() !='' && $("#field"+producttype).val() !='' ){
				doappend();
			}else{
				doremove();
			}
		});		
		
		
		//总成交价变更

		$("#field"+totalprice).bindPropertyChange(function(){
			var total_price = $("#field" + totalprice).val();//总成交价
			var total_cost  = document.getElementById;//总成本
			var overall_cost = $("#field" + overallcost).val();// 整体成本
			var rate_do = $("#field" + rate).val();//税率
			var exchangeRate = $("#field" + exchange_rate).val();// 汇率
			if($("#field" + currency + " option:selected").val() == 0){
				$("#field"+overall_gross).val(((parseFloat(total_price) / (1 + parseFloat(rate_do)) - parseFloat(overall_cost)) / (parseFloat(total_price) / (1 + parseFloat(rate_do))) * 100).toFixed(1) + "%" );
			}else{
				$("#field"+overall_gross).val(((parseFloat(total_price) * parseFloat(exchangeRate) - parseFloat(overall_cost)) / (parseFloat(total_price) * parseFloat(exchangeRate)) * 100).toFixed(1) + "%");
			}
					
		});
		
		
		
		$("#field"+totalprice).bind('keydown',function(event){
			var producttypeValue =  $("#field" + producttype).val();
			if(event.keyCode==13){
				var totalcosttotal = 0;
				var testuphvalue = document.getElementById("field"+ testuph).value;
				$("select[id^=field"+ quotationmode +"_]").each(function(index) {
					var mxid = this.id.split("_")[1];
					var quotationmodevalue = document.getElementById("field"+ quotationmode +"_"+mxid).value;
					var totalcostvalue = document.getElementById("field"+ totalcost +"_"+mxid).value;
					if (quotationmodevalue == "1") {					
						if (testuphvalue != "") {						
							totalcostvalue = parseFloat(totalcostvalue) / parseFloat(testuphvalue) * 1000;		
							alert("totalcostvalue: " + totalcostvalue);							
						}				
						hashours = true;				
					}
					totalcosttotal += parseFloat(totalcostvalue);	
				});
				var totalpricevalue = document.getElementById("field"+ totalprice).value;
				if (totalpricevalue != "" && totalpricevalue != null) {
					if (hashours = true  && testuphvalue == "" && producttypeValue != 0) {
						$("#field"+totalprice).val("");
					} else {	
						$("select[id^=field"+ quotationmode +"_]").each(function(index) {
							var mxid = this.id.split("_")[1];
							var quotationmodevalue = document.getElementById("field"+ quotationmode +"_"+mxid).value;
							var totalcostvalue = document.getElementById("field"+ totalcost +"_"+mxid).value;							
							if (quotationmodevalue == "1") {	
								if (producttypeValue == 0) {
									$("#field"+dealprice+"_"+mxid).val(0);
								} else {
									$("#field"+dealprice+"_"+mxid).val(((parseFloat(totalcostvalue) / parseFloat(testuphvalue) * 1000 / parseFloat(totalcosttotal) * parseFloat(totalpricevalue)) / 1000 * parseFloat(testuphvalue)).toFixed(2));
								}
							} else {								
								$("#field"+dealprice+"_"+mxid).val((parseFloat(totalcostvalue) / parseFloat(totalcosttotal) * parseFloat(totalpricevalue)).toFixed(2));								
							}
							
							var dealpricevalue = document.getElementById("field"+dealprice+"_"+mxid).value;
							var ratevalue = document.getElementById("field"+rate).value;
							var suggestedpricevalue = document.getElementById("field"+suggestedprice+"_"+mxid).value;
							var exchangeRate = $("#field" + exchange_rate).val();// 汇率
							var rate_do = $("#field" + rate).val();// 税率
							var currencyValue = $("#field" + currency + " option:selected").val();// 币种 0:CNY 1:USD
							// CNY: 成交毛利率=（成交价格/（1+税点）-总成本）/（成交价格/（1+税点））
							// USD: 成交毛利率=（成交价格*汇率-总成本）/成交价格*汇率
							
							//成交毛利率
							if (currencyValue == 0) {
								if (dealpricevalue != "" && parseFloat(dealpricevalue) > 0) {
									$("#field"+grossmargin+"_"+mxid).val((((parseFloat(dealpricevalue) / (1 + parseFloat(rate_do)) - parseFloat(totalcostvalue)) / (parseFloat(dealpricevalue) / (1 + parseFloat(rate_do)))) * 100).toFixed(1) + "%");
								} else {
									$("#field"+grossmargin+"_"+mxid).val(0 + "%");
								}
							} else {
								if (dealpricevalue != "" && parseFloat(dealpricevalue) > 0) {
									$("#field"+grossmargin+"_"+mxid).val((((parseFloat(dealpricevalue) * parseFloat(exchangeRate) - parseFloat(totalcostvalue)) / (parseFloat(dealpricevalue) * parseFloat(exchangeRate))) * 100).toFixed(1) + "%");
								} else {
									$("#field"+grossmargin+"_"+mxid).val(0 + "%");
								}
							}
							//折扣率
							if (dealpricevalue != "" && parseFloat(suggestedpricevalue) > 0 && parseFloat(suggestedpricevalue) > parseFloat(dealpricevalue)) {
								$("#field"+discount+"_"+mxid).val(((parseFloat(suggestedpricevalue) - parseFloat(dealpricevalue)) / parseFloat(suggestedpricevalue) * 100).toFixed(1) + "%");
							} else {
								$("#field"+discount+"_"+mxid).val("100%");
							}
							
						});
					}
				}
			}
		});		
		
		jQuery("select[id^='field"+ quotationmode +"_']").each(function(index) {
			maxid = this.id.split("_")[1];
		});
		
		jQuery("select[id^='field"+ quotationmode +"_']").each(function(index) {
			var mxid = this.id.split("_")[1];
			$("#field"+dealprice +"_"+mxid).bind('keydown',function(event){
				var showtotal = true;
				var total = 0;
				var testuphvalue = document.getElementById("field"+ testuph).value;
				var producttypevalue = document.getElementById("field" + producttype).value;
				var ratevalue = document.getElementById("field"+rate).value;
				var dealpricevalue = document.getElementById("field"+dealprice+"_"+mxid).value;// 成交价格
				var totalcostvalue = document.getElementById("field"+totalcost+"_"+mxid).value;// 总成本
				var suggestedpricevalue = document.getElementById("field"+suggestedprice+"_"+mxid).value;
				var rate_do = $("#field" + rate).val();// 税率
				var exchangeRate = $("#field" + exchange_rate).val();// 汇率
				var currencyValue = $("#field" + currency + " option:selected").val();// 币种 0:CNY 1:USD
				// CNY: 成交毛利率=（成交价格/（1+税点）-总成本）/（成交价格/（1+税点））
				// USD: 成交毛利率=（成交价格*汇率-总成本）/成交价格*汇率
				if(event.keyCode==13){
					if (currencyValue == 0) {
						if (dealpricevalue != "" && parseFloat(dealpricevalue) > 0) {
							$("#field"+grossmargin+"_"+mxid).val((((parseFloat(dealpricevalue) / (1 + parseFloat(rate_do)) - parseFloat(totalcostvalue)) / (parseFloat(dealpricevalue) / (1 + parseFloat(rate_do)))) * 100).toFixed(1) + "%");
						} else {
							$("#field"+grossmargin+"_"+mxid).val(0 + "%");
						}
					} else {
						if (dealpricevalue != "" && parseFloat(dealpricevalue) > 0) {
							$("#field"+grossmargin+"_"+mxid).val((((parseFloat(dealpricevalue) * parseFloat(exchangeRate) - parseFloat(totalcostvalue)) / (parseFloat(dealpricevalue) * parseFloat(exchangeRate))) * 100).toFixed(1) + "%");
						} else {
							$("#field"+grossmargin+"_"+mxid).val(0 + "%");
						}
					}
					
					if (dealpricevalue != "" && parseFloat(suggestedpricevalue) > 0 && parseFloat(suggestedpricevalue) > parseFloat(dealpricevalue)) {
						$("#field"+discount+"_"+mxid).val(((parseFloat(suggestedpricevalue) - parseFloat(dealpricevalue)) / parseFloat(suggestedpricevalue) * 100).toFixed(1) + "%");
					} else {
						$("#field"+discount+"_"+mxid).val("100%");
					}					
					
					if (dealpricevalue != "") {
						for (var i=0; i<=maxid; i++) {
							var quotationmodevalue = document.getElementById("field"+ quotationmode +"_"+i).value;
							if(i != mxid) {
								var dealother = document.getElementById("field"+dealprice+"_"+i).value;
								if (dealother == "") {
									showtotal = false;
								} else {
									if (quotationmodevalue == "1" && producttypevalue != "0" ) {
										if (testuphvalue == "") {
											showtotal = false;
										} else {											
											total += (parseFloat(dealother) / parseFloat(testuphvalue) * 1000);
										}
									} else {										
										total += parseFloat(dealother);
									}
								}
							} else {
								if (quotationmodevalue == "1") {
									if (testuphvalue == "") {
										showtotal = false;										
									} else {										
										total += (parseFloat(dealpricevalue) / parseFloat(testuphvalue) * 1000);
									}
								} else {									
									total += parseFloat(dealpricevalue);
								}
							}
						}
					} else {
						showtotal = false;						
					}
					
					if (showtotal == true) {
						$("#field"+totalprice).val(total.toFixed(2));
					}
					
				}
			});
		});
		
	});	
	
	<%if(nodeid == 25367 || nodeid == 25368 || nodeid == 25369 || nodeid == 25376 || nodeid == 25370 || nodeid == 25372 || nodeid == 25371 || nodeid == 25373 || nodeid == 25374 || nodeid == 25375){%>
			if(jQuery("#field"+ tester +"span").text() == ""){
				jQuery("#field"+ tester +"span").text(jQuery("#field"+ tester).val());
			}

			if(jQuery("#field"+ MD_HANDLER +"span").text() == ""){
				jQuery("#field"+ MD_HANDLER +"span").text(jQuery("#field"+ MD_HANDLER).val());
			}
	<%}%>
	
	function doappend(){
		var custid = '';
		var pkd = '';
		var tpye = '';
		var kinds = '';
		jQuery("#login").remove();
		jQuery("#assetsbtn").remove();
		jQuery("#pricebtn").remove();
		jQuery("#costbtn").remove();
		jQuery("#over").remove();
		custid = $("#field"+custidoffer).val();	
		pkd = $("#field"+shape).val();	
		tpye = $("#field"+tradeway).val();
		kinds = $("#field"+producttype).val();
		var htmlAssetsButton ='<input id="assetsbtn" type="button" value="快速报价"/>'
		var priceFactorButton ='<input id="pricebtn" type="button" value="价格因素"/>'		
		//<div id="login"><input id="assetsbtn1" type="button" value="关闭"/><div><p><a>客户号</a><input id="custid" name="custid" value="'+custid+'"></p><p><a>外形</a><input id="pkd" name="pkd" value="'+pkd+'"></p><p><a>贸易方式</a><input id="tpye" name="tpye" value="'+tpye+'"></p><p><a>生产类型</a><input id="kinds" name="kinds" value="'+kinds+'"></p></div></div><div id="over"></div></body>'	
		jQuery("#field"+Quotation_way+"span").parent().append(htmlAssetsButton);
		jQuery("#field"+Quotation_way+"span").parent().append(priceFactorButton);		
		//var login = document.getElementById('login');  
		//var over = document.getElementById('over');
		jQuery("#assetsbtn").click(function(){
			//login.style.display = "block";  
			//over.style.display = "block";
			window.open("http://172.16.60.18:8008/interface/fst/Quotation/quotationBrowser.jsp", "快速报价", "width=900,location=no,scrollbars=yes");			
		});
		jQuery("#pricebtn").click(function(){
			//login.style.display = "block";  
			//over.style.display = "block";
			window.open("http://172.16.60.18:8008/interface/fst/Quotation/priceBrowser.jsp", "价格因素", "height=500, width=400, location=no, scrollbars=yes");			
		});
		//jQuery("#assetsbtn1").click(function(){
		//	login.style.display = "none";  
		//	over.style.display = "none";  
		//});
	}
	function doremove(){
		jQuery("#assetsbtn").remove();
		jQuery("#pricebtn").remove();
	}
	
	function setCover(field) {// 判断 除了第一个申请节点 其他的节点下拉菜单都用这个蒙版 设置成只读
		var temp = field;
		var htmlShadow = '<div id="shadow_' + temp + '"></div>';
		jQuery("#field" + temp).before(htmlShadow);
		jQuery("#shadow_" + temp).css("z-index",100);
		jQuery("#shadow_" + temp).css("height",jQuery("#field" + temp).parent().parent().css("height"));
		jQuery("#shadow_" + temp).css("width",jQuery("#field" + temp).parent().parent().css("width"));
		jQuery("#shadow_" + temp).css("top",jQuery("#field" + temp).parent().parent().offset().top);
		jQuery("#shadow_" + temp).css("left",jQuery("#field" + temp).parent().parent().offset().left);
		jQuery("#shadow_" + temp).css("position","absolute");
		jQuery("#shadow_" + temp).css("opacity",0.5);
		jQuery("#shadow_" + temp).css("background","#FFFFFF");
	}
	
		function setCover1(field) {// 判断 除了第一个申请节点 其他的节点下拉菜单都用这个蒙版 设置成只读
		var temp = field;
		var htmlShadow = '<div id="shadow_' + temp + '"></div>';
		jQuery("#field" + temp).before(htmlShadow);
		jQuery("#shadow_" + temp).css("z-index",100);
		jQuery("#shadow_" + temp).css("height",jQuery("#field" + temp).parent().css("height"));
		jQuery("#shadow_" + temp).css("width",jQuery("#field" + temp).parent().css("width"));
		jQuery("#shadow_" + temp).css("top",jQuery("#field" + temp).parent().offset().top);
		jQuery("#shadow_" + temp).css("left",jQuery("#field" + temp).parent().offset().left);
		jQuery("#shadow_" + temp).css("position","absolute");
		jQuery("#shadow_" + temp).css("opacity",0.5);
		jQuery("#shadow_" + temp).css("background","#FFFFFF");
	}
</script> 