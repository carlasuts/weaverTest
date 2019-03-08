<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@page import="weaver.general.BaseBean"%> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css></HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<%
BaseBean bs = new BaseBean();
int userID = user.getUID();
bs.writeLog("userID:-----------"+userID);
String sql ="select SUBCOMPANYID1  from hrmresource where id="+userID;
rs.executeSql(sql);
bs.writeLog("sql:-----------"+sql);
rs.next();
String subid= rs.getString("SUBCOMPANYID1");
bs.writeLog("subid:-----------"+subid);
String factory=" ";
if(subid.equals("1")){
	factory ="0";
}else if(subid.equals("142")){
	factory ="1";
}else if(subid.equals("101")){
	factory ="2";
}else {
	factory ="3";
}
bs.writeLog("factory:-----------"+factory);
String FAnunber = Util.null2String(request.getParameter("FAnunber"));
String filled_by = Util.null2String(request.getParameter("filled_by"));
String filled_by_name = Util.null2String(request.getParameter("filled_by_name"));

String starttime = Util.null2String(request.getParameter("starttime"));

String test_item = Util.null2String(request.getParameter("test_item"));
String reliability_failure_term = Util.null2String(request.getParameter("reliability_failure_term"));
String customer_no = Util.null2String(request.getParameter("customer_no"));
String product_name = Util.null2String(request.getParameter("product_name"));
String lot_number = Util.null2String(request.getParameter("lot_number"));
String package_type = Util.null2String(request.getParameter("package_type"));
String sample_quantity = Util.null2String(request.getParameter("sample_quantity"));
String Faresult = Util.null2String(request.getParameter("Faresult"));
String assign_test_operator = Util.null2String(request.getParameter("assign_test_operator"));

String endtime = Util.null2String(request.getParameter("endtime"));

String endtime2 = Util.null2String(request.getParameter("endtime2"));

String Famodel = Util.null2String(request.getParameter("Famodel"));
String remark = Util.null2String(request.getParameter("remark"));
String datetype = Util.null2String(request.getParameter("datetype"));

String datetype1 = Util.null2String(request.getParameter("datetype1"));

String FA_classification = Util.null2String(request.getParameter("FA_classification"));
String FA_classification_id = Util.null2String(request.getParameter("FA_classification_id"));

String reliability_number = Util.null2String(request.getParameter("reliability_number"));


String starttimeD = Util.null2String(request.getParameter("starttimeD"));
String endtimeD = Util.null2String(request.getParameter("endtimeD"));

String distributiontime = Util.null2String(request.getParameter("distributiontime"));


String sqlwhere = " where 1 = 1 and C.CURRENTNODEID >17855 and lab_factory = '"+factory+"'";


if(!FAnunber.equals("")){
	sqlwhere += " and FAnunber like '%" + FAnunber + "%'";
}

if(!filled_by.equals("")){
	sqlwhere += " and filled_by like '%" + filled_by + "%'";
}
if(!customer_no.equals("")){
	sqlwhere += " and customer_no like '%" + customer_no + "%'";
}

if(!starttime.equals("")){
	
	sqlwhere += " and request_date  >= '" + starttime + "'";
}
if(!endtime2.equals("")){
	
	sqlwhere += " and request_date  <= '" + endtime2 + " 23:59:59'";
}

if(!starttimeD.equals("")){
	sqlwhere += " and (SELECT RECEIVEDATE from workflow_currentoperator c where c.REQUESTID =a.REQUESTID and c.NODEID ='17860' )  >= '" + starttimeD + "'";
}
if(!endtimeD.equals("")){
	sqlwhere += " and (SELECT RECEIVEDATE from workflow_currentoperator c where c.REQUESTID =a.REQUESTID and c.NODEID ='17860' )  <= '" + endtimeD + " 23:59:59'";
}

if(!package_type.equals("")){
	sqlwhere += " and upper(package_type) like upper('%" + package_type + "%')";
}

if(!FA_classification.equals("")){
	sqlwhere += " and FA_classification like '%" + FA_classification + "%'";
}


if(!distributiontime.equals("")){
	sqlwhere += " and distributiontime like '%" + distributiontime + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=20;

%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "失效分析";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{导出当前页,javascript:_xtable_getExcel()(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;

	RCMenu += "{导出所有,javascript:_xtable_getAllExcel(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
	
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;

%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<tr>
	<td height="10" colspan="3"></td>
</tr>
<tr>
	<td valign="top">
		<TABLE class=Shadow>
			<tr>
				<td valign="top" >
					<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="failure_analysis.jsp" method=post>
						<input type="hidden" id="FA_classification_id" name="FA_classification_id" value="<%=FA_classification_id%>">
						<table width=100% class=ViewForm>
							<TR>
								<td NOWRAP width='10%' style="text-align:left">失效分析分类:</td>
								<td class=FIELD width='15%'>
									<select id='FA_classification'name='FA_classification'>
										<option value=""></option> 
										<option value="0">客户委托</option> 
										<option value="1">最终测试不良</option> 
										<option value="2">可靠性实验不良品</option> 
										<option value="3">单项委托</option> 
									</select>
								</td>
								<td NOWRAP width='5%' style="text-align:left" >客户号:</td>
								<td class=FIELD width='10%'>
									<input type=text id='customer_no' name='customer_no' value='<%=customer_no%>'>
								</td>
								<td NOWRAP width='5%' style="text-align:left">PKG:</td>
								<td class=FIELD width='10%'>
									<input type=text id='package_type' name='package_type' value='<%=package_type%>'>
								</td>
								<td NOWRAP width='15%' style="text-align:left">填表日期：&nbsp;&nbsp;
									<span class="wuiDateSpan" selectId="datetype" selectValue="<%=datetype%>"> 
									<input name="starttime" type="hidden"  value="<%=starttime%>"  class="wuiDateSel">
									<input name="endtime2" type="hidden"  value="<%=endtime2%>"   class="wuiDateSel">	
									</span>
								</td>
								<td NOWRAP width='15%' style="text-align:left">完成日期：&nbsp;&nbsp;
									<span class="wuiDateSpan" selectId="datetype1" selectValue="<%=datetype1%>"> 
									<input name="starttimeD" type="hidden"  value="<%=starttimeD%>"  class="wuiDateSel">
									<input name="endtimeD" type="hidden"  value="<%=endtimeD%>"   class="wuiDateSel">	
									</span>
								</td>
								<td NOWRAP width='15%'>
									<input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
									<input type="button" value="导出当前页" onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
									<input type="button" value="导出所有" onclick="javascript:_xtable_getAllExcel()">
								</td>
							</TR>
							<TR class=Spacing>
								<TD class=Line1 colspan=8>
							</TD>
							</TR>
						</table>
						<TABLE width="100%">
							<tr>
								<td valign="top">
									<%
									String backfields = " a.id,a.requestid,FAnunber,reliability_number,to_char(to_date(request_date,'yyyy-mm-dd'),'yyyy/mm/dd') as request_date,filled_by,(select lastname from hrmresource where id =filled_by) as filled_by_name,test_item,reliability_failure_term,customer_no,product_name,LOT_NUMBER,package_type,sample_quantity,Faresult,(select lastname from hrmresource where id =assign_test_operator) as assign_test_operator,Famodel,remark,(select to_char(to_date(RECEIVEDATE,'yyyy-mm-dd'),'yyyy/mm/dd') as  RECEIVEDATE from workflow_currentoperator c where c.REQUESTID =a.REQUESTID and c.NODEID ='17860') as endtime,(SELECT to_char(to_date(RECEIVEDATE,'yyyy-mm-dd'),'yyyy/mm/dd') FROM WORKFLOW_CURRENTOPERATOR WHERE nodeid IN ('17862','17871','17872') AND requestid = a.requestid and ISREJECT is null ) AS distributiontime,FA_classification ";
									String fromSql  = " formtable_main_191 a   LEFT JOIN WORKFLOW_requestbase  c on A.REQUESTID =c.requestid " ;
									String sqlWhere = sqlwhere;
									String orderby = " a.id" ;
									String tableString = "";
									tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
												 "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
												 "		<head>"+
												 "			<col width=\"10%\" text=\"编号\" column=\"FAnunber\" orderkey=\"FAnunber\"  />"+
												 "			<col width=\"10%\" text=\"委托日\" column=\"request_date\" orderkey=\"request_date\"  />"+
												 "			<col width=\"10%\" text=\"委托人\" column=\"filled_by_name\" orderkey=\"filled_by_name\"  />"+
												 "			<col width=\"10%\" text=\"RA No.\" column=\"reliability_number\" orderkey=\"reliability_number\"  />"+
												 "			<col width=\"10%\" text=\"测试不良项\" column=\"test_item\" orderkey=\"test_item\"  />"+
												 "			<col width=\"10%\" text=\"可靠性失效项目\" column=\"reliability_failure_term\" orderkey=\"reliability_failure_term\"  />"+
												 "			<col width=\"10%\" text=\"客户号\" column=\"customer_no\" orderkey=\"customer_no\"  />"+
												 "			<col width=\"10%\" text=\"品名\" column=\"product_name\" orderkey=\"product_name\"  />"+
												 "			<col width=\"10%\" text=\"组装批号\" column=\"lot_number\" orderkey=\"lot_number\"  />"+
												 "			<col width=\"10%\" text=\"PKG\" column=\"package_type\" orderkey=\"package_type\"  />"+
												 "			<col width=\"10%\" text=\"样品数\" column=\"sample_quantity\" orderkey=\"sample_quantity\"  />"+
												 "			<col width=\"10%\" text=\"失效分析结果\" column=\"Faresult\" orderkey=\"Faresult\"  />"+
												 "			<col width=\"10%\" text=\"FA人员\" column=\"assign_test_operator\" orderkey=\"assign_test_operator\"  />"+
												 "			<col width=\"10%\" text=\"分配日\" column=\"distributiontime\" orderkey=\"distributiontime\"  />"+
												 "			<col width=\"10%\" text=\"完成日\" column=\"endtime\" orderkey=\"endtime\"  />"+
												 "			<col width=\"10%\" text=\"FA失效模式\" column=\"Famodel\" orderkey=\"Famodel\"  />"+
												 "			<col width=\"10%\" text=\"备注\" column=\"remark\" orderkey=\"remark\"  />"+
												 "		</head>"+
												 "		<operates width=\"10%\">";
									tableString +=		 "		</operates>"+
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
</tr>
<tr>
	<td height="10" colspan="3">
	</td>
</tr>
</table>

<script language=javascript>
//查询
function doSearch(){
	jQuery("#FA_classification_id").val($("#FA_classification").val());
	document.frmmain.submit();
}
$("#FA_classification").attr("value",jQuery("#FA_classification_id").val());
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>