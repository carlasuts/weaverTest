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

String EQ_TYPE = Util.null2String(request.getParameter("EQ_TYPE"));
String PKG_TYPE = Util.null2String(request.getParameter("PKG_TYPE"));

String sqlwhere = " where 1 = 1 ";

if(!EQ_TYPE.equals("")){
	sqlwhere += " and EQ_TYPE like '%" + EQ_TYPE + "%'";
}

if(!PKG_TYPE.equals("")){
	sqlwhere += " and PKG_TYPE like '%" + PKG_TYPE + "%'";
}

int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "recipe";
String needfav ="1";
String needhelp ="";
%>
<BODY>
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
		<TABLE class=Shadow>
		<tr>
		<td valign="top" >
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="recepi.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>机器型号</td>
			<td class=FIELD width='10%'>
			<input type=text id='EQ_TYPE' name='EQ_TYPE' value='<%=EQ_TYPE%>'></td>
			<td NOWRAP width='5%'>PKG_TYPE</td>
			<td class=FIELD width='10%'>
			<input type=text id='PKG_TYPE' name='PKG_TYPE' value='<%=PKG_TYPE%>'></td>
			<td NOWRAP width='25%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='pd.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " EQ_TYPE,PKG_TYPE,RULE_NAME,RULE_VER,DESCRIPTION ";
		            String fromSql  = " RULE_CC ";
		            String sqlWhere = sqlwhere;
		            String orderby = " RULE_SEQ " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"RULE_SEQ\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"15%\" text=\"机器型号\" column=\"EQ_TYPE\" orderkey=\"EQ_TYPE\"  />"+
								 "			<col width=\"15%\" text=\"PKG\" column=\"PKG_TYPE\" orderkey=\"PKG_TYPE\"  />"+
								 "			<col width=\"10%\" text=\"规则名\" column=\"RULE_NAME\" orderkey=\"RULE_NAME\"  />"+
								 "			<col width=\"10%\" text=\"版本\" column=\"RULE_VER\" orderkey=\"RULE_VER\"  />"+
								 "			<col width=\"30%\" text=\"描述\" column=\"DESCRIPTION\" orderkey=\"DESCRIPTION\"  />"+
		                         "		</head>"+
								 "		<operates width=\"10%\">";
					tableString +=		 "    		<operate href=\"javascript:doDel()\"  text=\"删除\" target=\"_self\" index=\"0\"/>";
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
	var rvalue = window.showModalDialog("recepiexcel.jsp");
	if(rvalue > 0){
		window.location.href = "recepi.jsp";
	}
}
function doDownload(){
	window.location.href='recepi.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="recepioperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>