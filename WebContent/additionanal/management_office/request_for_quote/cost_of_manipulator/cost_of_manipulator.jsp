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

String name = Util.null2String(request.getParameter("name"));
String INDEX_TIME = Util.null2String(request.getParameter("INDEX_TIME"));
String QTY_SITE_MAX = Util.null2String(request.getParameter("QTY_SITE_MAX"));
String MAINTENANCE_COST = Util.null2String(request.getParameter("MAINTENANCE_COST"));
String LABOUR = Util.null2String(request.getParameter("LABOUR"));
String POWER = Util.null2String(request.getParameter("POWER"));
String DEPR = Util.null2String(request.getParameter("DEPR"));
String OTHER = Util.null2String(request.getParameter("OTHER"));

String sqlwhere = " where 1 = 1 ";

if(!name.equals("")){
	sqlwhere += " and name like '%" + name + "%'";
}

if(!INDEX_TIME.equals("")){
	sqlwhere += " and INDEX_TIME like '%" + INDEX_TIME + "%'";
}

if(!QTY_SITE_MAX.equals("")){
	sqlwhere += " and QTY_SITE_MAX like '%" + QTY_SITE_MAX + "%'";
}




int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "机械手成本";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",cost_of_manipulatorupdate.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="cost_of_manipulator.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>机械手</td>
			<td class=FIELD width='15%'>
			<input type=text id='name' name='name' value='<%=name%>'></td>
			<td NOWRAP width='5%'>间歇时间</td>
			<td class=FIELD width='15%'>
			<input type=text id='INDEX_TIME' name='INDEX_TIME' value='<%=INDEX_TIME%>'></td>
			<td NOWRAP width='5%'>最大site数</td>
			<td class=FIELD width='15%'>
			<input type=text id='QTY_SITE_MAX' name='QTY_SITE_MAX' value='<%=QTY_SITE_MAX%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='cost_of_manipulator.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " a.id,b.name,A.INDEX_TIME,A.QTY_SITE_MAX,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER";
		            String fromSql  = " MD_SD_HANDLER_COST a left join MD_HANDLER b on A.HANDLER_FK=B.ID";
		            String sqlWhere = sqlwhere;
		            String orderby = " a.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								"			<col width=\"10%\" text=\"机械手\" column=\"name\" orderkey=\"name\"  />"+
								 "			<col width=\"10%\" text=\"间歇时间\" column=\"INDEX_TIME\" orderkey=\"INDEX_TIME\"  />"+
								 "			<col width=\"10%\" text=\"最大site数目\" column=\"QTY_SITE_MAX\" orderkey=\"QTY_SITE_MAX\"  />"+
								 "			<col width=\"10%\" text=\"人工费用\" column=\"LABOUR\" orderkey=\"LABOUR\"  />"+
								"			<col width=\"10%\" text=\"维修费用\" column=\"MAINTENANCE_COST\" orderkey=\"MAINTENANCE_COST\"  />"+
								"			<col width=\"10%\" text=\"动力费用\" column=\"POWER\" orderkey=\"POWER\"  />"+
								"			<col width=\"10%\" text=\"折旧费用\" column=\"DEPR\" orderkey=\"DEPR\"  />"+
								"			<col width=\"10%\" text=\"其他费用\" column=\"OTHER\" orderkey=\"OTHER\"  />"+
		                         "		</head>"+
								 "		<operates width=\"5%\">";
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
	document.frmmain.action = "cost_of_manipulatorupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("cost_of_manipulatorexcel.jsp");
	if(rvalue > 0){
		window.location.href = "cost_of_manipulator.jsp";
	}
}
function doDownload(){
	window.location.href='cost_of_manipulator.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="cost_of_manipulatoroperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>