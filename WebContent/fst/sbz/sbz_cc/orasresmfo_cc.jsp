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

String factory = Util.null2String(request.getParameter("factory"));
String custId = Util.null2String(request.getParameter("custId"));
String pkld = Util.null2String(request.getParameter("pkld"));
String oper = Util.null2String(request.getParameter("oper"));
String sqlwhere = " where 1 = 1 ";

if(!factory.equals("")){
	sqlwhere += " and FACTORY like '%" + factory + "%'";
}

if(!custId.equals("")){
	sqlwhere += " and CUSTID like '%" + custId + "%'";
}

if(!pkld.equals("")){
	sqlwhere += " and PKLD like '%" + pkld + "%'";
}

if(!oper.equals("")){
	sqlwhere += " and OPER like '%" + oper + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "设备组规则";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",orasresmfoupdate_cc.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="orasresmfo_cc.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>工厂</td>
			<td class=FIELD width='10%'>
			<input type=text id='factory' name='factory' value='<%=factory%>'></td>
			<td NOWRAP width='5%'>客户号</td>
			<td class=FIELD width='10%'>
			<input type=text id='custId' name='custId' value='<%=custId%>'></td>
			<td NOWRAP width='5%'>外形</td>
			<td class=FIELD width='10%'>
			<input type=text id='pkld' name='pkld' value='<%=pkld%>'></td>
			<td NOWRAP width='5%'>工序</td>
			<td class=FIELD width='10%'>
			<input type=text id='oper' name='oper' value='<%=oper%>'></td>
			<td NOWRAP width='25%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='orasresmfo_cc.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " id ,factory ,custid ,pkld ,oper ,resg_id ";
		            String fromSql  = " orasresmfo_cc b ";
		            String sqlWhere = sqlwhere;
		            String orderby = " b.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"b.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"15%\" text=\"工厂\" column=\"factory\" orderkey=\"factory\"  />"+
								 "			<col width=\"15%\" text=\"客户号\" column=\"custid\" orderkey=\"custid\"  />"+
								 "			<col width=\"15%\" text=\"外形\" column=\"pkld\" orderkey=\"pkld\"  />"+
								 "			<col width=\"15%\" text=\"工序\" column=\"oper\" orderkey=\"oper\"  />"+
								 "			<col width=\"15%\" text=\"设备组\" column=\"resg_id\" orderkey=\"resg_id\"  />"+
		                         "		</head>"+
								 "		<operates width=\"10%\">";
					tableString +=		 "    		<operate href=\"javascript:doEdit()\"  text=\"修改\" target=\"_self\" index=\"0\"/>";
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
//修改
function doEdit(id){
	document.frmmain.action = "orasresmfoupdate_cc.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("orasresmfoexcel_cc.jsp");
	if(rvalue > 0){
		window.location.href = "orasresmfo_cc.jsp";
	}
}
function doDownload(){
	window.location.href='orasresmfo_cc.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="orasresmfooperation_cc.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>