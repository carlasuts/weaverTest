<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min.js"></script>
<%
int userID = user.getUID();

String khm = Util.null2String(request.getParameter("khm"));
String xh = Util.null2String(request.getParameter("xh"));
String tester = Util.null2String(request.getParameter("tester"));
String pkid = Util.null2String(request.getParameter("pkid"));
String workcode = Util.null2String(request.getParameter("workcode"));//工号
String sqlwhere = " where 1 = 1 ";

if(!khm.equals("")){
	sqlwhere += " and khm like '%" + khm + "%'";
}

if(!xh.equals("")){
	sqlwhere += " and xh like '%" + xh + "%'";
}

if(!tester.equals("")){
	sqlwhere += " and tester like '%" + tester + "%'";
}

if(!pkid.equals("")){
	sqlwhere += " and pkid like '%" + pkid + "%'";
}

if(!workcode.equals("")){
	sqlwhere += " and a.workcode like '%" + workcode + "%'";
}
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "良率异常";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{导入excel,javascript:doImportExcel(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{模板下载,javascript:doDownload(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="llyc.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>客户名</td>
			<td class=FIELD width='10%'>
			<input type=text id='khm' name='khm' value='<%=khm%>'></td>
			<td NOWRAP width='5%'>型号</td>
			<td class=FIELD width='10%'>
			<input type=text id='xh' name='xh' value='<%=xh%>'></td>
			<td NOWRAP width='5%'>Tester</td>
			<td class=FIELD width='10%'>
			<input type=text id='tester' name='tester' value='<%=tester%>'></td>
			<td NOWRAP width='5%'>PKLD</td>
			<td class=FIELD width='10%'>
			<input type=text id='pkid' name='pkid' value='<%=pkid%>'></td>
			<td NOWRAP width='5%'>工号</td>
			<td class=FIELD width='10%'>
			<input type=text id='workcode' name='workcode' value='<%=workcode%>'></td>
			<td NOWRAP width='25%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='llyc.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " a.id,zrr,khm,xh,tester,pkid,a.workcode,lastname ";
		            String fromSql  = " tb_llyc a left join hrmresource b on a.workcode = b.workcode ";
		            String sqlWhere = sqlwhere;
		            String orderby = " a.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"15%\" text=\"客户名\" column=\"khm\" orderkey=\"khm\"  />"+
								 "			<col width=\"15%\" text=\"型号\" column=\"xh\" orderkey=\"xh\"  />"+
								 "			<col width=\"15%\" text=\"Tester\" column=\"tester\" orderkey=\"tester\"  />"+
								 "			<col width=\"15%\" text=\"PKLD\" column=\"pkid\" orderkey=\"pkid\"  />"+
								 "			<col width=\"10%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\"  />"+
								 "			<col width=\"10%\" text=\"姓名\" column=\"lastname\" orderkey=\"lastname\"  />"+
								 "			<col width=\"10%\" text=\"责任人\" column=\"zrr\" orderkey=\"zzr\"  />"+
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
	var rvalue = window.showModalDialog("llycexcel.jsp");
	if(rvalue > 0){
		window.location.href = "llyc.jsp";
	}
}
function doDownload(){
	window.location.href='llyc.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="llycoperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
</html>