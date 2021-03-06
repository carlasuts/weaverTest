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

String oper_fk = Util.null2String(request.getParameter("oper_fk"));
String oper_role_fk = Util.null2String(request.getParameter("oper_role_fk"));
String oper_role_pk_id = Util.null2String(request.getParameter("oper_role_pk_id"));
String mustfill_flag = Util.null2String(request.getParameter("mustfill_flag"));
String mtrl_group_fk = Util.null2String(request.getParameter("mtrl_group_fk"));
String sqlwhere = " where 1 = 1 AND SITE_OPTION = '5000' ";

if(!oper_fk.equals("")){
	sqlwhere += " and oper_fk like '%" + oper_fk + "%'";
}

if(!oper_role_fk.equals("")){
	sqlwhere += " and oper_role_fk like '%" + oper_role_fk + "%'";
}

if(!oper_role_pk_id.equals("")){
	sqlwhere += " and oper_role_pk_id like '%" + oper_role_pk_id + "%'";
}

if(!mustfill_flag.equals("")){
	sqlwhere += " and mustfill_flag like '%" + mustfill_flag + "%'";
}

if(!mtrl_group_fk.equals("")){
	sqlwhere += " and mtrl_group_fk like '%" + mtrl_group_fk + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "角色节点工序规则";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",MDM_OPER_MTRL_REFupdate_HF.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="MDM_OPER_MTRL_REF_HF.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>工序</td>
			<td class=FIELD width='15%'>
			<input type=text id='oper_fk' name='oper_fk' value='<%=oper_fk%>'></td>
			<td NOWRAP width='5%'>节点</td>
			<td class=FIELD width='15%'>
			<input type=text id='oper_role_fk' name='oper_role_fk' value='<%=oper_role_fk%>'></td>
			<td NOWRAP width='5%'>工序角色ID</td>
			<td class=FIELD width='15%'>
			<input type=text id='oper_role_pk_id' name='oper_role_pk_id' value='<%=oper_role_pk_id%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='MDM_OPER_MTRL_REF_HF.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " id,oper_fk,mtrl_group_fk,oper_role_fk,oper_role_pk_id,mustfill_flag";
		            String fromSql  = " MDM_OPER_MTRL_REF b";
		            String sqlWhere = sqlwhere;
		            String orderby = " b.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								"			<col width=\"7%\" text=\"工序\" column=\"oper_fk\" orderkey=\"oper_fk\"  />"+
								 "			<col width=\"7%\" text=\"物料组\" column=\"mtrl_group_fk\" orderkey=\"mtrl_group_fk\"  />"+
								 "			<col width=\"7%\" text=\"节点\" column=\"oper_role_fk\" orderkey=\"oper_role_fk\"  />"+
								 "			<col width=\"8%\" text=\"工序角色ID\" column=\"oper_role_pk_id\" orderkey=\"oper_role_pk_id\"  />"+
								"			<col width=\"8%\" text=\"是否必须维护\" column=\"mustfill_flag\" orderkey=\"mustfill_flag\"  />"+
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
	document.frmmain.action = "MDM_OPER_MTRL_REFupdate_HF.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("MDM_OPER_MTRL_REFexcel_HF.jsp");
	if(rvalue > 0){
		window.location.href = "MDM_OPER_MTRL_REF_HF.jsp";
	}
}
function doDownload(){
	window.location.href='MDM_OPER_MTRL_REF_HF.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="MDM_OPER_MTRL_REFoperation_HF.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>