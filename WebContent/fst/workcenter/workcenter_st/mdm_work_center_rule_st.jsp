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

String CUST_FK = Util.null2String(request.getParameter("CUST_FK"));
String PKG_OUTLINE_FK = Util.null2String(request.getParameter("PKG_OUTLINE_FK"));
String OPER_FK = Util.null2String(request.getParameter("OPER_FK"));
String VEHICLE_FK = Util.null2String(request.getParameter("VEHICLE_FK"));
String WORK_CENTER_FK = Util.null2String(request.getParameter("WORK_CENTER_FK"));
String sqlwhere = " where 1 = 1 ";


if(!OPER_FK.equals("")){
	sqlwhere += " and OPER_FK like '%" + OPER_FK + "%'";
}

if(!WORK_CENTER_FK.equals("")){
	sqlwhere += " and WORK_CENTER_FK like '%" + WORK_CENTER_FK + "%'";
}
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "工作中心规则";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",mdm_work_center_rule_update_st.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="mdm_work_center_rule_st.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>工序</td>
			<td class=FIELD width='10%'>
			<input type=text id='OPER_FK' name='OPER_FK' value='<%=OPER_FK%>'></td>
			
			<td NOWRAP width='5%'>工作中心</td>
			<td class=FIELD width='10%'>
			<input type=text id='VEHICLE_FK' name='WORK_CENTER_FK' value='<%=WORK_CENTER_FK%>'></td>
			
			<td NOWRAP width='25%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='mdm_work_center_rule_st.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = "R.ID, R.CUST_FK, R.PKG_OUTLINE_FK, R.OPER_FK, R.VEHICLE_FK, R.WORK_CENTER_FK, R.DATE_CREATE, R.DATE_UPDATE, R.DATE_EFFECT, R.DATE_EXPIRE ";
		            String fromSql  = " mdm_work_center_rule_st R ";
		            String sqlWhere = sqlwhere;
		            String orderby = " R.ID " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
		                         "			<col width=\"10%\" text=\"工序\" column=\"OPER_FK\" orderkey=\"OPER_FK\"  />"+
		                         "			<col width=\"5%\" text=\"工作中心\" column=\"WORK_CENTER_FK\" orderkey=\"WORK_CENTER_FK\"  />"+
								 "			<col width=\"5%\" text=\"客户\" column=\"CUST_FK\" orderkey=\"CUST_FK\"  />"+
								 "			<col width=\"20%\" text=\"封装外形\" column=\"PKG_OUTLINE_FK\" orderkey=\"PKG_OUTLINE_FK\"  />"+
								 "			<col width=\"5%\" text=\"车载品\" column=\"VEHICLE_FK\" orderkey=\"VEHICLE_FK\"  />"+
								 "			<col width=\"10%\" text=\"填单日期\" column=\"DATE_CREATE\" orderkey=\"DATE_CREATE\"  />"+
								 "			<col width=\"10%\" text=\"修改日期\" column=\"DATE_UPDATE\" orderkey=\"DATE_UPDATE\"  />"+
								 "			<col width=\"10%\" text=\"生效日期\" column=\"DATE_EFFECT\" orderkey=\"DATE_EFFECT\"  />"+
								 "			<col width=\"10%\" text=\"失效日期\" column=\"DATE_EXPIRE\" orderkey=\"DATE_EXPIRE\"  />"+
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
	document.frmmain.action = "mdm_work_center_rule_update_st.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("mdm_work_center_rule_excel_st.jsp");
	if(rvalue > 0){
		window.location.href = "mdm_work_center_rule_st.jsp";
	}
}
function doDownload(){
	window.location.href='mdm_work_center_rule_st.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="mdm_work_center_rule_operation_st.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>