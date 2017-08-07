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

String gcname = Util.null2String(request.getParameter("gcname"));
String tzlxname = Util.null2String(request.getParameter("tzlxname"));
String tzshr = Util.null2String(request.getParameter("tzshr"));
String tzpzr = Util.null2String(request.getParameter("tzpzr"));
String sqlwhere = " where 1 = 1 ";

if(!gcname.equals("")){
	sqlwhere += " and gcname like '%" + gcname + "%'";
}

if(!tzlxname.equals("")){
	sqlwhere += " and tzlxname like '%" + tzlxname + "%'";
}

if(!tzshr.equals("")){
	sqlwhere += " and tzshr like '%" + tzshr + "%'";
}

if(!tzpzr.equals("")){
	sqlwhere += " and tzpzr like '%" + tzpzr + "%'";
}

int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "技术图纸管理";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",otecdrmedopupdate.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="otecdrmedop.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>厂区</td>
			<td class=FIELD width='15%'>
			<input type=text id='gcname' name='gcname' value='<%=gcname%>'></td>
			<td NOWRAP width='5%'>图纸类型</td>
			<td class=FIELD width='15%'>
			<input type=text id='tzlxname' name='tzlxname' value='<%=tzlxname%>'></td>
			<td NOWRAP width='5%'>图纸审核人</td>
			<td class=FIELD width='15%'>
			<input type=text id='tzshr' name='tzshr' value='<%=tzshr%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='otecdrmedop.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = "id,gcname,tzlxname,tzshr,tzpzr,shrname,pzrname";
		            String fromSql  = " otecdrmedop ";
		            String sqlWhere = sqlwhere;
		            String orderby = " id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								"			<col width=\"7%\" text=\"厂区\" column=\"gcname\" orderkey=\"gcname\"  />"+
								 "			<col width=\"7%\" text=\"图纸类型\" column=\"tzlxname\" orderkey=\"tzlxname\"  />"+
								 "			<col width=\"8%\" text=\"图纸审核人工号\" column=\"tzshr\" orderkey=\"tzshr\"  />"+
								 "			<col width=\"8%\" text=\"图纸审核人姓名\" column=\"shrname\" orderkey=\"shrname\"  />"+
								 "			<col width=\"12%\" text=\"图纸批准人工号\" column=\"tzpzr\" orderkey=\"tzpzr\"  />"+
								"			<col width=\"12%\" text=\"图纸批准人姓名\" column=\"pzrname\" orderkey=\"pzrname\"  />"+
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
	document.frmmain.action = "otecdrmedopupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("otecdrmedopexcel.jsp");
	if(rvalue > 0){
		window.location.href = "otecdrmedop.jsp";
	}
}
function doDownload(){
	window.location.href='otecdrmedop.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="otecdrmedopoperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>