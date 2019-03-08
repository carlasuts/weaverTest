<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css></HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
int userID = user.getUID();

String WORKCODE = Util.null2String(request.getParameter("WORKCODE"));
String starttime = Util.null2String(request.getParameter("starttime")).replace("-","");
String endtime = Util.null2String(request.getParameter("endtime")).replace("-","");
String datetype = Util.null2String(request.getParameter("datetype"));

String sqlwhere = " where 1 = 1 ";

if(!WORKCODE.equals("")){
	sqlwhere += " and WORKCODE like '%" + WORKCODE + "%'";
}

if(!starttime.equals("")){
	sqlwhere += " and CREATE_TIME  >= '" + starttime + "' ";
}
if(!endtime.equals("")){
	sqlwhere += " and CREATE_TIME  <= '" + endtime + "' ";
}

int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=100;

%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "关键用户退回履历";
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="keyuserrejhis.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
	<TR>
			<td NOWRAP width='10%'>关键用户工号</td>
			<td class=FIELD width='20%'>
			<input type=text id='WORKCODE' name='WORKCODE' value='<%=WORKCODE%>'></td>
			<td NOWRAP width='10%'>选择查询时间：&nbsp;&nbsp;
				<span class="wuiDateSpan" selectId="datetype" selectValue="<%=datetype%>"> 
				<input name="starttime" type="hidden"  value="<%=starttime%>"  class="wuiDateSel">
				<input name="endtime" type="hidden"  value="<%=endtime%>"   class="wuiDateSel">	
             	</span>
			</td>
			<td NOWRAP width='40%'>
			<input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			</td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " ID, SITE,WORKCODE, dep ,NAME,REJECTNAME,CREATE_TIME ";
		            String fromSql  = " (SELECT ID, DECODE (SITE,'1000', '崇川厂','4000', '苏通厂','合肥厂') as SITE,WORKCODE, (select DEPARTMENTNAME from Hrmdepartment where id = okj.Depart ) as dep ,NAME, \n"+ 
		            				  " (SELECT SELECTNAME \n" +  
		            				  " FROM workflow_selectitem \n" + 
		            				  " WHERE fieldid = '29761' AND SELECTVALUE =REJECTCODE) as  REJECTNAME,CREATE_TIME \n"+   
		            				  " FROM OKUSERREJHIS okj ) " ;
		            String sqlWhere = sqlwhere;
		            String orderby = " SITE,WORKCODE,CREATE_TIME" ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\"  sqlprimarykey=\"ID\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"15%\" text=\"厂区\" column=\"SITE\" orderkey=\"SITE\"  />"+
								 "			<col width=\"15%\" text=\"部门\" column=\"dep\" orderkey=\"dep\"  />"+
								 "			<col width=\"15%\" text=\"关键用户工号\" column=\"WORKCODE\" orderkey=\"WORKCODE\"  />"+
								 "			<col width=\"15%\" text=\"姓名\" column=\"NAME\" orderkey=\"NAME\"  />"+
								 "			<col width=\"15%\" text=\"退回原因\" column=\"REJECTNAME\" orderkey=\"REJECTNAME\"  />"+
								 "			<col width=\"15%\" text=\"时间\" column=\"CREATE_TIME\" orderkey=\"CREATE_TIME\"  />"+
		                         "		</head>"+
								 "		<operates width=\"10%\">";
					tableString +=		 "		</operates>"+
		                         " </table>";
		         	%>
		         <wea:SplitPageTag  tableString="<%=tableString%>" isShowTopInfo="false" mode="debug" />
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
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>