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

String CUST_ENGR_FK = Util.null2String(request.getParameter("CUST_ENGR_FK"));
String TPM_LEADER_FK = Util.null2String(request.getParameter("TPM_LEADER_FK"));
String cust = Util.null2String(request.getParameter("cust"));
//String pkid = Util.null2String(request.getParameter("pkid"));
//String workcode = Util.null2String(request.getParameter("workcode"));//工号
String sqlwhere = " where 1 = 1 ";

if(!cust.equals("")){
	sqlwhere += " and cust like '%" + cust + "%'";
}

if(!CUST_ENGR_FK.equals("")){
	sqlwhere += " and CUST_ENGR_FK like '%" + CUST_ENGR_FK + "%'";
}

if(!TPM_LEADER_FK.equals("")){
	sqlwhere += " and TPM_LEADER_FK like '%" + TPM_LEADER_FK + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "客户工程师规则";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",cetesterupdate.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="cetester.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>客户名</td>
			<td class=FIELD width='10%'>
			<input type=text id='cust' name='cust' value='<%=cust%>'></td>
			<td NOWRAP width='5%'>客户负责人</td>
			<td class=FIELD width='10%'>
			<input type=text id='CUST_ENGR_FK' name='CUST_ENGR_FK' value='<%=CUST_ENGR_FK%>'></td>
			<td NOWRAP width='5%'>TPMLeader</td>
			<td class=FIELD width='10%'>
			<input type=text id='TPM_LEADER_FK' name='TPM_LEADER_FK' value='<%=TPM_LEADER_FK%>'></td>
			<td NOWRAP width='25%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='cetester.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = "id, cust ,(select lastname from  hrmresource  where WORKCODE =b.CUST_ENGR_FK) as CUST_ENGR_FK ,(select lastname from  hrmresource  where WORKCODE =b.TPM_LEADER_FK) as TPM_LEADER_FK ";
		            String fromSql  = " MD_CE_AUDITOR_RULE b ";
		            String sqlWhere = sqlwhere;
		            String orderby = " b.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"b.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"15%\" text=\"客户名\" column=\"cust\" orderkey=\"cust\"  />"+
								 "			<col width=\"15%\" text=\"客户负责人\" column=\"CUST_ENGR_FK\" orderkey=\"CUST_ENGR_FK\"  />"+
								 "			<col width=\"15%\" text=\"TPMLeader\" column=\"TPM_LEADER_FK\" orderkey=\"TPM_LEADER_FK\"  />"+
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
	document.frmmain.action = "cetesterupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("cetesterexcel.jsp");
	if(rvalue > 0){
		window.location.href = "cetester.jsp";
	}
}
function doDownload(){
	window.location.href='cetester.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="cetesteroperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>