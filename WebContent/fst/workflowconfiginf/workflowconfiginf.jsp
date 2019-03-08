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

String workflowid = Util.null2String(request.getParameter("workflowid"));
String plantopt = Util.null2String(request.getParameter("plantopt"));
String paramdesc = Util.null2String(request.getParameter("paramdesc"));
String param = Util.null2String(request.getParameter("param"));

String sqlwhere = " where 1 = 1 ";

if(!workflowid.equals("")){
	sqlwhere += " and workflowid like '%" + workflowid + "%'";
}

if(!plantopt.equals("")){
	sqlwhere += " and plantopt like '%" + plantopt + "%'";
}
if(!paramdesc.equals("")){
	sqlwhere += " and paramdesc like '%" + paramdesc + "%'";
}

if(!param.equals("")){
	sqlwhere += " and param like '%" + param + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "流程配置信息";
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
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",workflowconfiginf_update.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="workflowconfiginf.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>流程ID</td>
			<td class=FIELD width='10%'>
			<input type=text id=workflowid name='workflowid' value='<%=workflowid%>'></td>
			<td NOWRAP width='5%'>工厂</td>
			<td class=FIELD width='10%'>
			<input type=text id='plantopt' name='plantopt' value='<%=plantopt%>'></td>
			<td NOWRAP width='5%'>参数</td>
			<td class=FIELD width='10%'>
			<input type=text id=param name='param' value='<%=param%>'></td>
			<td NOWRAP width='5%'>参数描述</td>
			<td class=FIELD width='10%'>
			<input type=text id='paramdesc' name='paramdesc' value='<%=paramdesc%>'></td>
			<td NOWRAP width='25%'>
			<input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			</td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = "id, workflowid , param, paramdesc, plantopt ,CREATER,CREATETIME,UPDATER,UPDATETIME ";
		            String fromSql  = " workflowconfiginf ";
		            String sqlWhere = sqlwhere;
		            String orderby = " id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"15%\" text=\"流程ID\" column=\"workflowid\" orderkey=\"workflowid\"  />"+
								 "			<col width=\"15%\" text=\"厂区\" column=\"plantopt\" orderkey=\"plantopt\"  />"+
								 "			<col width=\"15%\" text=\"参数\" column=\"param\" orderkey=\"param\"  />"+
								 "			<col width=\"15%\" text=\"参数描述\" column=\"paramdesc\" orderkey=\"paramdesc\"  />"+
								 "			<col width=\"15%\" text=\"创建人\" column=\"CREATER\" orderkey=\"CREATER\"  />"+
								 "			<col width=\"15%\" text=\"创建时间\" column=\"CREATETIME\" orderkey=\"CREATETIME\"  />"+
								 "			<col width=\"15%\" text=\"更新人\" column=\"UPDATER\" orderkey=\"UPDATER\"  />"+
								 "			<col width=\"15%\" text=\"更新时间\" column=\"UPDATETIME\" orderkey=\"UPDATETIME\"  />"+
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
	document.frmmain.action = "workflowconfiginf_update.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="workflowconfiginf_operation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>