<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
int userID = user.getUID();

String custid = Util.null2String(request.getParameter("custid"));
String dqidh = Util.null2String(request.getParameter("dqidh"));
String dqidbbh = Util.null2String(request.getParameter("dqidbbh"));
String dqpmlist = Util.null2String(request.getParameter("dqpmlist"));

String sqlwhere = " where 1 = 1  ";

if(!custid.equals("")){
	sqlwhere += " and custid like '%" + custid + "%'";
}

if(!dqidh.equals("")){
	sqlwhere += " and dqidh like '%" + dqidh + "%'";
}

if(!dqpmlist.equals("")){
	sqlwhere += " and dqpmlist like '%" + dqpmlist + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "测试程序一览表";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table  width=100% height=100% border="0" cellspacing="0" cellpadding="0">
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="owiptstpgm.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>客户号</td>
			<td class=FIELD width='10%'>
			<input type=text id='custid' name='custid' value='<%=custid%>'></td>
			<td NOWRAP width='5%'>id号</td>
			<td class=FIELD width='10%'>
			<input type=text id='dqidh' name='dqidh' value='<%=dqidh%>'></td>
			<td NOWRAP width='5%'>品名</td>
			<td class=FIELD width='10%'>
			<input type=text id='dqpmlist' name='dqpmlist' value='<%=dqpmlist%>'></td>
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
		            String backfields = "id ,custid,dqidh,dqidbbh, bb,dqpmlist,gdtime";
		            String fromSql  = "(select concat(concat(concat(concat(custid,'-'),dqidh),'-'),dqidbbh)as id ,custid,dqidh,dqidbbh, max(bfbz) as bb,dqpmlist,gdtime from formtable_main_110  where  dqidh !=' ' group by concat(concat(concat(concat(custid,'-'),dqidh),'-'),dqidbbh) , custid,dqidh,dqidbbh ,dqpmlist,gdtime )";
		            String sqlWhere = sqlwhere;
		            String orderby = " id " ;
		            String sqlprimarykeys= " id ";
		            String tableString = "";
		            tableString =" <table  instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\"  sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"5%\" text=\"客户号\" column=\"custid\" orderkey=\"custid\"  />"+
								 "			<col width=\"5%\" text=\"ID号\" column=\"dqidh\" orderkey=\"dqidh\"  />"+
								 "			<col width=\"1%\" text=\"版本号\" column=\"dqidbbh\" orderkey=\"dqidbbh\"  />"+
								 "			<col width=\"30%\" text=\"品名list\" column=\"dqpmlist\" orderkey=\"dqpmlist\" />"+
								 "			<col width=\"10%\" text=\"归档时间\" column=\"gdtime\" orderkey=\"gdtime\" />"+
								 "			<col width=\"5%\" text=\"是否作废\" column=\"bb\" orderkey=\"bb\" />"+
		                         "		</head>"+
   								 "		<operates width=\"10%\">";
				    tableString +=		 "    		<operate href=\"javascript:doView()\" text=\"明细list\" target=\"_self\" index=\"0\"/>";
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


function doView(id){
	document.frmmain.action = "owiptstpgm_details.jsp?id="+id;
	document.frmmain.submit();
}


</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>