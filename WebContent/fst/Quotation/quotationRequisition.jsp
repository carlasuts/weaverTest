<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css></HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
int userID = user.getUID();

String id =Util.null2String(request.getParameter("id"));
String searchText = Util.null2String(request.getParameter("searchText"));
String process_number = Util.null2String(request.getParameter("process_number"));
String LASTNAME = Util.null2String(request.getParameter("LASTNAME"));
String createtime = Util.null2String(request.getParameter("createtime"));
String State_form = Util.null2String(request.getParameter("State_form"));
String Quotation_way = Util.null2String(request.getParameter("Quotation_way"));
String CUSTID = Util.null2String(request.getParameter("CUSTID"));
String shape = Util.null2String(request.getParameter("shape"));
String product_type = Util.null2String(request.getParameter("product_type"));
String Tradeway = Util.null2String(request.getParameter("Tradeway"));
String currency = Util.null2String(request.getParameter("currency"));
String endtime = Util.null2String(request.getParameter("endtime"));
String exchange_rate = Util.null2String(request.getParameter("exchange_rate"));
String gold_price = Util.null2String(request.getParameter("gold_price"));
String Copper_prices = Util.null2String(request.getParameter("Copper_prices"));
String test_uph = Util.null2String(request.getParameter("test_uph"));
String overall_cost = Util.null2String(request.getParameter("overall_cost"));
String total_price = Util.null2String(request.getParameter("total_price"));
String overall_gross = Util.null2String(request.getParameter("overall_gross"));
String thou_tal_cost_assy = Util.null2String(request.getParameter("thou_tal_cost_assy"));
String pack_tal_cost_pack = Util.null2String(request.getParameter("pack_tal_cost_pack"));
String test_tal_cost_thou = Util.null2String(request.getParameter("test_tal_cost_thou"));
String assembleprice = Util.null2String(request.getParameter("assembleprice"));
String packageprice = Util.null2String(request.getParameter("packageprice"));
String thoutestprice = Util.null2String(request.getParameter("thoutestprice"));
String assemblegross = Util.null2String(request.getParameter("assemblegross"));
String packagegross = Util.null2String(request.getParameter("packagegross"));
String thoutestgross = Util.null2String(request.getParameter("thoutestgross"));
String totaldiscount = Util.null2String(request.getParameter("totaldiscount"));
String assemblediscount = Util.null2String(request.getParameter("assemblediscount"));
String thoutestdiscount = Util.null2String(request.getParameter("thoutestdiscount"));
String packagediscount = Util.null2String(request.getParameter("packagediscount"));
String salesarea = Util.null2String(request.getParameter("salesarea"));
String businessgroup = Util.null2String(request.getParameter("businessgroup"));
String On_demand = Util.null2String(request.getParameter("On_demand"));
String isDeal = Util.null2String(request.getParameter("isDeal"));
String failurereason = Util.null2String(request.getParameter("failurereason"));
String actuarialstarttime = Util.null2String(request.getParameter("actuarialstarttime"));
String actuarialendtime = Util.null2String(request.getParameter("actuarialendtime"));
String addbondingcost = Util.null2String(request.getParameter("addbondingcost"));
String addbondingprice = Util.null2String(request.getParameter("addbondingprice"));
String addchipcost = Util.null2String(request.getParameter("addchipcost"));
String addchipprice = Util.null2String(request.getParameter("addchipprice"));
String goldvolatilecost = Util.null2String(request.getParameter("goldvolatilecost"));
String goldvolatileprice = Util.null2String(request.getParameter("goldvolatileprice"));
String coppervolatilecost = Util.null2String(request.getParameter("coppervolatilecost"));
String coppervolatileprice = Util.null2String(request.getParameter("coppervolatileprice"));
String Wire_bonding = Util.null2String(request.getParameter("Wire_bonding"));
String Wire_diameter = Util.null2String(request.getParameter("Wire_diameter"));
String Chip_number = Util.null2String(request.getParameter("Chip_number"));
String artifi_thou = Util.null2String(request.getParameter("artifi_thou"));
String deprect_thou = Util.null2String(request.getParameter("deprect_thou"));
String power_thou = Util.null2String(request.getParameter("power_thou"));
String maintain_thou = Util.null2String(request.getParameter("maintain_thou"));
String other_thou = Util.null2String(request.getParameter("other_thou"));
String Advocate_material = Util.null2String(request.getParameter("Advocate_material"));
String Other_materials = Util.null2String(request.getParameter("Other_materials"));
String mat_pack = Util.null2String(request.getParameter("mat_pack"));
String Custexpectprice = Util.null2String(request.getParameter("Custexpectprice"));
String strikeprice = Util.null2String(request.getParameter("strikeprice"));
String marketprice = Util.null2String(request.getParameter("marketprice"));

String sqlwhere = " where 1 = 1 ";

if(!searchText.equals("")){
	sqlwhere += " and (process_number like '%" + searchText + "%' or LASTNAME like '%" + searchText + "%' or createtime like '%" + searchText + "%'";			
	sqlwhere += " or State_form like '%" + searchText + "%' or Quotation_way like '%" + searchText + "%' or CUSTID like '%" + searchText + "%'";
	sqlwhere += " or shape like '%" + searchText + "%' or product_type like '%" + searchText + "%' or Tradeway like '%" + searchText + "%'";
	sqlwhere += " or currency like '%" + searchText + "%' or endtime like '%" + searchText + "%' or exchange_rate like '%" + searchText + "%'";
	sqlwhere += " or gold_price like '%" + searchText + "%' or Copper_prices like '%" + searchText + "%' or test_uph like '%" + searchText + "%'";
	sqlwhere += " or overall_cost like '%" + searchText + "%' or total_price like '%" + searchText + "%' or overall_gross like '%" + searchText + "%'";
	sqlwhere += " or thou_tal_cost_assy like '%" + searchText + "%' or pack_tal_cost_pack like '%" + searchText + "%' or test_tal_cost_thou like '%" + searchText + "%'";
	sqlwhere += " or assembleprice like '%" + searchText + "%' or packageprice like '%" + searchText + "%' or thoutestprice like '%" + searchText + "%'";
	sqlwhere += " or assemblegross like '%" + searchText + "%' or packagegross like '%" + searchText + "%' or thoutestgross like '%" + searchText + "%'";
	sqlwhere += " or totaldiscount like '%" + searchText + "%' or assemblediscount like '%" + searchText + "%' or thoutestdiscount like '%" + searchText + "%'";
	sqlwhere += " or packagediscount like '%" + searchText + "%' or salesarea like '%" + searchText + "%' or businessgroup like '%" + searchText + "%'";
	sqlwhere += " or On_demand like '%" + searchText + "%' or isDeal like '%" + searchText + "%' or failurereason like '%" + searchText + "%'";
	sqlwhere += " or actuarialendtime like '%" + searchText + "%' or actuarialendtime like '%" + searchText + "%' or addbondingcost like '%" + searchText + "%'";
	sqlwhere += " or addbondingprice like '%" + searchText + "%' or addchipcost like '%" + searchText + "%' or addchipprice like '%" + searchText + "%'";
	sqlwhere += " or goldvolatilecost like '%" + searchText + "%' or goldvolatileprice like '%" + searchText + "%' or coppervolatilecost like '%" + searchText + "%'";
	sqlwhere += " or coppervolatileprice like '%" + searchText + "%' or Wire_bonding like '%" + searchText + "%' or Wire_diameter like '%" + searchText + "%'";
	sqlwhere += " or Chip_number like '%" + searchText + "%' or artifi_thou like '%" + searchText + "%' or deprect_thou like '%" + searchText + "%'";
	sqlwhere += " or power_thou like '%" + searchText + "%' or maintain_thou like '%" + searchText + "%' or other_thou like '%" + searchText + "%'";
	sqlwhere += " or Advocate_material like '%" + searchText + "%' or Other_materials like '%" + searchText + "%' or mat_pack like '%" + searchText + "%'";
	sqlwhere += " or Custexpectprice like '%" + searchText + "%' or strikeprice like '%" + searchText + "%' or marketprice like '%" + searchText + "%' )";
	
}

int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "报价申请单";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;	
	RCMenu += "{导出,javascript:doDownload(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow>
		<tr>
		<td valign="top" >
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="quotationRequisition.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>查询</td>
			<td class=FIELD width='10%'>
			<input type=text id='searchText' name='searchText' value='<%=searchText%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;			
			<input type="button" value="导出" onclick="javascript:window.location.href='quotationRequisition.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="600%">
			<tr>
				<td valign="top">
		        	<%
					String backfields = " id, process_number, LASTNAME, createtime, State_form, Quotation_way, CUSTID, shape, product_type, Tradeway, currency, exchange_rate, " + 
										" gold_price, Copper_prices, test_uph, overall_cost, total_price, overall_gross, thou_tal_cost_assy, pack_tal_cost_pack, test_tal_cost_thou, " +
										" assembleprice, packageprice, thoutestprice, assemblegross, packagegross, thoutestgross, totaldiscount, assemblediscount, thoutestdiscount, " +
										" packagediscount, salesarea, businessgroup, On_demand, isDeal, failurereason, addbondingcost, addbondingprice," + 
										" addchipcost, addchipprice, goldvolatilecost, goldvolatileprice, coppervolatilecost, coppervolatileprice, Wire_bonding, Wire_diameter, Chip_number," + 
										" artifi_thou, deprect_thou, power_thou, maintain_thou, other_thou, Advocate_material, Other_materials, mat_pack, Custexpectprice, strikeprice, marketprice, " +
										" ACTUARIALSTARTTIME, ACTUARIALENDTIME, ENDTIME  ";
		            String fromSql = 	" (SELECT DISTINCT A.*, B.LASTOPERATEDATE AS ENDTIME, C.RECEIVEDATE AS ACTUARIALSTARTTIME, D.RECEIVEDATE AS ACTUARIALENDTIME FROM " +
										" (select tb.id, tb.requestid ,process_number, (select LASTNAME from HRMRESOURCE h where Createpersonnel = h.id) as LASTNAME, createtime, State_form, " +
										" (select SELECTNAME from (SELECT SELECTVALUE, SELECTNAME FROM workflow_selectitem " + 										
										" WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -205 AND fieldname = 'Quotation_way')) where SELECTVALUE = tb.Quotation_way) as Quotation_way, " +
										" CUSTID, shape, (select SELECTNAME from (SELECT SELECTVALUE, SELECTNAME FROM workflow_selectitem " +
										" WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -205 AND fieldname = 'product_type')) where SELECTVALUE = tb.product_type) as product_type, " +
										" (select SELECTNAME from (SELECT SELECTVALUE, SELECTNAME FROM workflow_selectitem " +
										" WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -205 AND fieldname = 'Tradeway')) where SELECTVALUE = tb.Tradeway) as Tradeway, " +
										" (select SELECTNAME from (SELECT SELECTVALUE, SELECTNAME FROM workflow_selectitem " +
										" WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -205 AND fieldname = 'currency')) where SELECTVALUE = tb.currency) as currency, " +
										" exchange_rate, gold_price, Copper_prices, test_uph, overall_cost, total_price, overall_gross, thou_tal_cost_assy, pack_tal_cost_pack, " +
										" test_tal_cost_thou, (select deal_price from FORMTABLE_MAIN_205_DT1 where mainid = TB.id and cost_element = 1) as assembleprice, " +
										" (select deal_price from FORMTABLE_MAIN_205_DT1 where mainid = TB.id and cost_element = 2) as packageprice, " +
										" (select deal_price from FORMTABLE_MAIN_205_DT1 where mainid = TB.id and cost_element = 0 and Quotation_mode = 0) as thoutestprice, " +
										" (select gross_margin from FORMTABLE_MAIN_205_DT1 where mainid = TB.id and cost_element = 1) as assemblegross, " +
										" (select gross_margin from FORMTABLE_MAIN_205_DT1 where mainid = TB.id and cost_element = 2) as packagegross, " +
										" (select gross_margin from FORMTABLE_MAIN_205_DT1 where mainid = TB.id and cost_element = 0 and Quotation_mode = 0) as thoutestgross, " +
										" (select round(((sum(suggested_price) - sum(deal_price)) / sum(suggested_price)), 3) from FORMTABLE_MAIN_205_DT1 where mainid = TB.id) as totaldiscount, " +
										" (select discount from FORMTABLE_MAIN_205_DT1 where mainid = TB.id and cost_element = 1) as assemblediscount, " +
										" (select discount from FORMTABLE_MAIN_205_DT1 where mainid = TB.id and cost_element = 0 and Quotation_mode = 0) as thoutestdiscount, " +
										" (select discount from FORMTABLE_MAIN_205_DT1 where mainid = TB.id and cost_element = 2) as packagediscount, " +
										" (select a.NAME from OSALEAREA a LEFT JOIN OSALESCAST b on b.SALES_AREA_FK = a.ID where b.SALESMAN_FK = Createpersonnel) as salesarea, " +
										" (select FULL_NAME from MD_SD_COST_ACTUAL  a left join MD_DIVISION b on A.DIVISION_FK=B.ID where A.OWNER_FK=Createpersonnel) as businessgroup, On_demand, '' as isDeal, " +							
										" '' as failurereason, " +									
										" (select cost from FORMTABLE_MAIN_205_DT2 where mainid = TB.id and note = '加一根键合丝') as addbondingcost, " +
										" (select deal_price from FORMTABLE_MAIN_205_DT2 where mainid = TB.id and note = '加一根键合丝') as addbondingprice, " +
										" (select cost from FORMTABLE_MAIN_205_DT2 where mainid = TB.id and note = '加一个芯片') as addchipcost, " +
										" (select deal_price from FORMTABLE_MAIN_205_DT2 where mainid = TB.id and note = '加一个芯片') as addchipprice, " +
										" (select cost from FORMTABLE_MAIN_205_DT2 where mainid = TB.id and note = '金价波动100$') as goldvolatilecost, " +
										" (select deal_price from FORMTABLE_MAIN_205_DT2 where mainid = TB.id and note = '金价波动100$') as goldvolatileprice, " +
										" (select cost from FORMTABLE_MAIN_205_DT2 where mainid = TB.id and note = '铜价波动100$') as coppervolatilecost, " +
										" (select deal_price from FORMTABLE_MAIN_205_DT2 where mainid = TB.id and note = '铜价波动100$') as coppervolatileprice, " +										
										" Wire_bonding, Wire_diameter, Chip_number, artifi_thou, deprect_thou, power_thou, maintain_thou, other_thou, Advocate_material, Other_materials, " +
										" mat_pack, Custexpectprice, strikeprice, marketprice from FORMTABLE_MAIN_205 tb) A LEFT JOIN " +
										" (SELECT REQUESTID,LASTOPERATEDATE FROM WORKFLOW_REQUESTBASE WHERE REQUESTNAME LIKE '报价%' AND STATUS = '归档') B  ON A.REQUESTID = B.REQUESTID " +
										" LEFT JOIN (SELECT REQUESTID, RECEIVEDATE FROM WORKFLOW_CURRENTOPERATOR WHERE NODEID = '4881' AND ISREJECT IS NULL) C ON A.REQUESTID = C.REQUESTID " + 
										" LEFT JOIN (SELECT REQUESTID, RECEIVEDATE FROM WORKFLOW_CURRENTOPERATOR WHERE NODEID = '4882' AND ISREJECT IS NULL) D ON A.REQUESTID = D.REQUESTID) ";	            
		            String sqlWhere = sqlwhere;
		            String orderby = " id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col text=\"表单号\" column=\"process_number\" orderkey=\"process_number\"  />"+
								 "			<col text=\"创建人员\" column=\"LASTNAME\" orderkey=\"LASTNAME\"  />"+
								 "			<col text=\"填单日期\" column=\"createtime\" orderkey=\"createtime\"  />"+
								 "			<col text=\"表单状态\" column=\"State_form\" orderkey=\"State_form\"  />"+
								 "			<col text=\"报价方式\" column=\"Quotation_way\" orderkey=\"Quotation_way\"  />"+
								 "			<col text=\"客户\" column=\"CUSTID\" orderkey=\"CUSTID\"  />"+
								 "			<col text=\"外形\" column=\"shape\" orderkey=\"shape\"  />"+
								 "			<col text=\"生产类型\" column=\"product_type\" orderkey=\"product_type\"  />"+
								 "			<col text=\"贸易方式\" column=\"Tradeway\" orderkey=\"Tradeway\"  />"+
								 "			<col text=\"币别\" column=\"currency\" orderkey=\"currency\"  />"+
		                         "			<col text=\"结束日期\" column=\"endtime\" orderkey=\"endtime\"  />"+
								 "			<col text=\"汇率\" column=\"exchange_rate\" orderkey=\"exchange_rate\"  />"+
								 "			<col text=\"金价(USD)\" column=\"gold_price\" orderkey=\"gold_price\"  />"+
								 "			<col text=\"铜价(USD)\" column=\"Copper_prices\" orderkey=\"Copper_prices\"  />"+
								 "			<col text=\"测试UPH\" column=\"test_uph\" orderkey=\"test_uph\"  />"+
								 "			<col text=\"总成本\" column=\"overall_cost\" orderkey=\"overall_cost\"  />"+
								 "			<col text=\"总成交价\" column=\"total_price\" orderkey=\"total_price\"  />"+
								 "			<col text=\"整体毛利率\" column=\"overall_gross\" orderkey=\"overall_gross\"  />"+
								 "			<col text=\"封装成本\" column=\"thou_tal_cost_assy\" orderkey=\"thou_tal_cost_assy\"  />"+
								 "			<col text=\"包装成本\" column=\"pack_tal_cost_pack\" orderkey=\"pack_tal_cost_pack\"  />"+
								 "			<col text=\"千只测试成本\" column=\"test_tal_cost_thou\" orderkey=\"test_tal_cost_thou\"  />"+
								 "			<col text=\"封装成交价\" column=\"assembleprice\" orderkey=\"assembleprice\"  />"+
								 "			<col text=\"包装成交价\" column=\"packageprice\" orderkey=\"packageprice\"  />"+
								 "			<col text=\"千只测试成交价\" column=\"thoutestprice\" orderkey=\"thoutestprice\"  />"+
								 "			<col text=\"封装毛利率\" column=\"assemblegross\" orderkey=\"assemblegross\"  />"+
								 "			<col text=\"包装毛利率\" column=\"packagegross\" orderkey=\"packagegross\"  />"+
								 "			<col text=\"测试毛利率(千只)\" column=\"thoutestgross\" orderkey=\"thoutestgross\"  />"+
								 "			<col text=\"总折扣率\" column=\"totaldiscount\" orderkey=\"totaldiscount\"  />"+
								 "			<col text=\"封装折扣率\" column=\"assemblediscount\" orderkey=\"assemblediscount\"  />"+
								 "			<col text=\"测试折扣率(千只)\" column=\"thoutestdiscount\" orderkey=\"thoutestdiscount\"  />"+
								 "			<col text=\"包装折扣率\" column=\"packagediscount\" orderkey=\"packagediscount\"  />"+
								 "			<col text=\"销售区域\" column=\"salesarea\" orderkey=\"salesarea\"  />"+
								 "			<col text=\"事业群\" column=\"businessgroup\" orderkey=\"businessgroup\"  />"+
								 "			<col text=\"月需求量(K)\" column=\"On_demand\" orderkey=\"On_demand\"  />"+
								 "			<col text=\"是否成交\" column=\"isDeal\" orderkey=\"isDeal\"  />"+
								 "			<col text=\"报价失败原因\" column=\"failurereason\" orderkey=\"failurereason\"  />"+
								 "			<col text=\"精算开始时间\" column=\"actuarialstarttime\" orderkey=\"actuarialstarttime\"  />"+
								 "			<col text=\"精算结束时间\" column=\"actuarialendtime\" orderkey=\"actuarialendtime\"  />"+
								 "			<col text=\"单丝成本\" column=\"addbondingcost\" orderkey=\"addbondingcost\"  />"+
								 "			<col text=\"加一根丝价格(含税)\" column=\"addbondingprice\" orderkey=\"addbondingprice\"  />"+
								 "			<col text=\"单个芯片成本\" column=\"addchipcost\" orderkey=\"addchipcost\"  />"+
								 "			<col text=\"加一个芯片价格(含税)\" column=\"addchipprice\" orderkey=\"addchipprice\"  />"+
								 "			<col text=\"金价波动100$成本\" column=\"goldvolatilecost\" orderkey=\"goldvolatilecost\"  />"+
								 "			<col text=\"金价波动100$价格(含税)\" column=\"goldvolatileprice\" orderkey=\"goldvolatileprice\"  />"+
								 "			<col text=\"铜价波动100$成本\" column=\"coppervolatilecost\" orderkey=\"coppervolatilecost\"  />"+
								 "			<col text=\"铜价波动100$价格(含税)\" column=\"coppervolatileprice\" orderkey=\"coppervolatileprice\"  />"+
								 "			<col text=\"键合丝数\" column=\"Wire_bonding\" orderkey=\"Wire_bonding\"  />"+
								 "			<col text=\"线径\" column=\"Wire_diameter\" orderkey=\"Wire_diameter\"  />"+
								 "			<col text=\"芯片数\" column=\"Chip_number\" orderkey=\"Chip_number\"  />"+
								 "			<col text=\"千只人工\" column=\"artifi_thou\" orderkey=\"artifi_thou\"  />"+
								 "			<col text=\"千只折旧费用\" column=\"deprect_thou\" orderkey=\"deprect_thou\"  />"+
								 "			<col text=\"千只动力费用\" column=\"power_thou\" orderkey=\"power_thou\"  />"+
								 "			<col text=\"千只维修费用\" column=\"maintain_thou\" orderkey=\"maintain_thou\"  />"+
								 "			<col text=\"千只其他费用\" column=\"other_thou\" orderkey=\"other_thou\"  />"+
								 "			<col text=\"主材\" column=\"Advocate_material\" orderkey=\"Advocate_material\"  />"+
								 "			<col text=\"其他材料\" column=\"Other_materials\" orderkey=\"Other_materials\"  />"+
								 "			<col text=\"包材\" column=\"mat_pack\" orderkey=\"mat_pack\"  />"+
								 "			<col text=\"客户期望价\" column=\"Custexpectprice\" orderkey=\"Custexpectprice\"  />"+
								 "			<col text=\"现有执行价\" column=\"strikeprice\" orderkey=\"strikeprice\"  />"+
								 "			<col text=\"市场价格\" column=\"marketprice\" orderkey=\"marketprice\"  />"+
								 "		</head>"+
		                         " </table>";
		         %>
		         <wea:SplitPageTag  tableString="<%=tableString%>" isShowTopInfo="false" mode="run" />
				</td>
			</tr>
			<tr>
		    </tr>
		</TABLE>
		</FORM>
		</td>
		</tr>
		</TABLE>
	</td>
	<td ></td>
</tr>
<tr>
	<td height="10" colspan="3">
	</td>
</tr>
</table>

<script language=javascript>
//查询
function doSearch(){
	document.frmmain.submit();
}
function doDownload(){
	window.location.href='quotationRequisition.xls';
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>