<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<html><head>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css></head>
<script language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
int userID = user.getUID();

String matGrp5 = Util.null2String(request.getParameter("matGrp5"));
String marking = Util.null2String(request.getParameter("marking"));
String custData1 = Util.null2String(request.getParameter("custData1"));
String custData2 = Util.null2String(request.getParameter("custData2"));

String sqlwhere = " WHERE 1 = 1 ";

if(!matGrp5.equals("")){
	sqlwhere += " AND MAT_GRP_5 LIKE '%" + matGrp5 + "%'";
}

if(!marking.equals("")){
	sqlwhere += " AND MARKING LIKE '%" + marking + "%'";
}

if(!custData1.equals("")){
	sqlwhere += " AND CUST_DATA_1 LIKE '%" + custData1 + "%'";
}

if(!custData2.equals("")){
	sqlwhere += " AND CUST_DATA_2 LIKE '%" + custData2 + "%'";
}
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "客户品名与未定义信息对应关系";
String needfav ="1";
String needhelp ="";
%>
<body>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{导入excel,javascript:doImportExcel(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{模板下载,javascript:doDownload(),_self} " ;
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
		<table class=Shadow>
		<tr>
		<td valign="top" >
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="matgrp5.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<tr>
			<td NOWRAP width='10%'>客戶品名</td>
			<td class=FIELD width='10%'>
			<input type=text id='matGrp5' name='matGrp5' value='<%=matGrp5%>'></td>
			<td NOWRAP width='10%'>MARKING</td>
			<td class=FIELD width='10%'>
			<input type=text id='marking' name='marking' value='<%=marking%>'></td>
			<td NOWRAP width='10%'>未定义1</td>
			<td class=FIELD width='10%'>
			<input type=text id='custData1' name='custData1' value='<%=custData1%>'></td>
			<td NOWRAP width='10%'>未定义2</td>
			<td class=FIELD width='10%'>
			<input type=text id='custData2' name='custData2' value='<%=custData2%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='matGrp5.xls';"></td>
		</tr>
		<tr class=Spacing><TD class=Line1 colspan=8></TD></tr>
		</table>
		<table width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " MAT_GRP_5, MARKING, CUST_DATA_1, CUST_DATA_2 ";
		            String fromSql  = " EXTRATABLE_74 ";
		            String sqlWhere = sqlwhere;
		            String orderby = " MAT_GRP_5 " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"MAT_GRP_5\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"20%\" text=\"客户品名\" column=\"MAT_GRP_5\" orderkey=\"MAT_GRP_5\"  />"+
								 "			<col width=\"20%\" text=\"MARKING\" column=\"marking\" orderkey=\"marking\"  />"+
								 "			<col width=\"20%\" text=\"CUST_DATA_1\" column=\"CUST_DATA_1\" orderkey=\"CUST_DATA_1\"  />"+
								 "			<col width=\"20%\" text=\"CUST_DATA_2\" column=\"CUST_DATA_2\" orderkey=\"CUST_DATA_2\"  />"+
		                         "		</head>"+
								 "		<operates width=\"20%\">";
					tableString +=		 "    		<operate href=\"javascript:doDel()\"  text=\"删除\" target=\"_self\" index=\"0\"/>";
					tableString +=		 "		</operates>"+
		                         " </table>";
		         %>
		         <wea:SplitPageTag  tableString="<%=tableString%>" isShowTopInfo="false" mode="run" />
				</td>
			</tr>
			<tr>
		    </tr>
		</table>
		</form>
		</td>
		</tr>
		</table>
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
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("matgrp5excel.jsp");
	if(rvalue > 0){
		window.location.href = "matgrp5.jsp";
	}
}
function doDownload(){
	window.location.href='matgrp5.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="matgrp5operation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<script language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<script language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>