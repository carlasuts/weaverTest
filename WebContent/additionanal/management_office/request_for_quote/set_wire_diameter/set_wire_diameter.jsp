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

String LENGTH = Util.null2String(request.getParameter("LENGTH"));
String UNIT_FK = Util.null2String(request.getParameter("UNIT_FK"));
String STANDARD = Util.null2String(request.getParameter("STANDARD"));
String FULL_NAME = Util.null2String(request.getParameter("FULL_NAME"));
String SORT = Util.null2String(request.getParameter("SORT"));
String sqlwhere = " where 1 = 1 ";

if(!LENGTH.equals("")){
	sqlwhere += " and LENGTH like '%" + LENGTH + "%'";
}

if(!STANDARD.equals("")){
	sqlwhere += " and STANDARD like '%" + STANDARD + "%'";
}

if(!FULL_NAME.equals("")){
	sqlwhere += " and FULL_NAME like '%" + FULL_NAME + "%'";
}



int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "线径设定";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",set_wire_diameterupdate.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="set_wire_diameter.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>长度</td>
			<td class=FIELD width='15%'>
			<input type=text id='LENGTH' name='LENGTH' value='<%=LENGTH%>'></td>
			<td NOWRAP width='5%'>标准标识</td>
			<td class=FIELD width='15%'>
			<input type=text id='STANDARD' name='STANDARD' value='<%=STANDARD%>'></td>
			<td NOWRAP width='5%'>全称</td>
			<td class=FIELD width='15%'>
			<input type=text id='FULL_NAME' name='FULL_NAME' value='<%=FULL_NAME%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='set_wire_diameter.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " id,LENGTH,UNIT_FK,STANDARD,FULL_NAME,SORT";
		            String fromSql  = " MD_SD_WIRE_DIAM b";
		            String sqlWhere = sqlwhere;
		            String orderby = " b.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								"			<col width=\"7%\" text=\"长度\" column=\"LENGTH\" orderkey=\"LENGTH\"  />"+
								 "			<col width=\"7%\" text=\"单位\" column=\"UNIT_FK\" orderkey=\"UNIT_FK\"  />"+
								 "			<col width=\"7%\" text=\"标准标识\" column=\"STANDARD\" orderkey=\"STANDARD\"  />"+
								 "			<col width=\"8%\" text=\"全称\" column=\"FULL_NAME\" orderkey=\"FULL_NAME\"  />"+
								"			<col width=\"8%\" text=\"顺序\" column=\"SORT\" orderkey=\"SORT\"  />"+
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
	document.frmmain.action = "set_wire_diameterupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("set_wire_diameterexcel.jsp");
	if(rvalue > 0){
		window.location.href = "set_wire_diameter.jsp";
	}
}
function doDownload(){
	window.location.href='set_wire_diameter.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="set_wire_diameteroperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>