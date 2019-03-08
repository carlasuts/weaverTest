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

String QTTN_PKG_FK = Util.null2String(request.getParameter("QTTN_PKG_FK"));
String MAT = Util.null2String(request.getParameter("MAT"));
String GRADE = Util.null2String(request.getParameter("GRADE"));
String MAINTENANCE_COST = Util.null2String(request.getParameter("MAINTENANCE_COST"));
String MATERIAL = Util.null2String(request.getParameter("MATERIAL"));
String LABOUR = Util.null2String(request.getParameter("LABOUR"));
String POWER = Util.null2String(request.getParameter("POWER"));
String DEPR = Util.null2String(request.getParameter("DEPR"));
String OTHER = Util.null2String(request.getParameter("OTHER"));

String sqlwhere = " where 1 = 1 ";

if(!QTTN_PKG_FK.equals("")){
	sqlwhere += " and QTTN_PKG_FK like '%" + QTTN_PKG_FK + "%'";
}

if(!MAT.equals("")){
	sqlwhere += " and MAT like '%" + MAT + "%'";
}

if(!GRADE.equals("")){
	sqlwhere += " and GRADE like '%" + GRADE + "%'";
}




int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "包装成本";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",pack_costupdate.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="pack_cost.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>外形</td>
			<td class=FIELD width='15%'>
			<input type=text id='QTTN_PKG_FK' name='QTTN_PKG_FK' value='<%=QTTN_PKG_FK%>'></td>
			<td NOWRAP width='5%'>包装材料</td>
			<td class=FIELD width='15%'>
			<input type=text id='MAT' name='MAT' value='<%=MAT%>'></td>
			<td NOWRAP width='5%'>包装档次</td>
			<td class=FIELD width='15%'>
			<input type=text id='GRADE' name='GRADE' value='<%=GRADE%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='pack_cost.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " a.id,A.QTTN_PKG_FK,b.name as MAT ,c.name as  GRADE,MATERIAL,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER";
		            String fromSql  = " MD_SD_COST_PACKING a left join MD_SD_PACKING b on A.PACKING_FK =b.id left join MD_SD_PACKING_GRADE c on A.PACKING_GRADE_FK =c.id ";
		            String sqlWhere = sqlwhere;
		            String orderby = " a.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								"			<col width=\"10%\" text=\"外形\" column=\"QTTN_PKG_FK\" orderkey=\"QTTN_PKG_FK\"  />"+
								 "			<col width=\"10%\" text=\"包装材料\" column=\"MAT\" orderkey=\"MAT\"  />"+
								 "			<col width=\"10%\" text=\"包装档次\" column=\"GRADE\" orderkey=\"GRADE\"  />"+
								 "			<col width=\"8%\" text=\"材料费用	\" column=\"MATERIAL\" orderkey=\"MATERIAL\"  />"+
								"			<col width=\"8%\" text=\"维修费用\" column=\"MAINTENANCE_COST\" orderkey=\"MAINTENANCE_COST\"  />"+
								"			<col width=\"8%\" text=\"人工费用\" column=\"LABOUR\" orderkey=\"LABOUR\"  />"+
								 "			<col width=\"8%\" text=\"动力费用\" column=\"POWER\" orderkey=\"POWER\"  />"+
								 "			<col width=\"8%\" text=\"折旧费用\" column=\"DEPR\" orderkey=\"DEPR\"  />"+
								"			<col width=\"8%\" text=\"其他费用\" column=\"OTHER\" orderkey=\"OTHER\"  />"+
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
	document.frmmain.action = "pack_costupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("pack_costexcel.jsp");
	if(rvalue > 0){
		window.location.href = "pack_cost.jsp";
	}
}
function doDownload(){
	window.location.href='pack_cost.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="pack_costoperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>