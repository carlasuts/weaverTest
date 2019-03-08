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
String name = Util.null2String(request.getParameter("name"));
String MATERIAL_COST = Util.null2String(request.getParameter("MATERIAL_COST"));
String MAINTENANCE_COST = Util.null2String(request.getParameter("MAINTENANCE_COST"));
String LABOUR_COST = Util.null2String(request.getParameter("LABOUR_COST"));
String POWER_COST = Util.null2String(request.getParameter("POWER_COST"));
String DEPR_COST = Util.null2String(request.getParameter("DEPR_COST"));
String OTHER_COST = Util.null2String(request.getParameter("OTHER_COST"));
String sqlwhere = " where 1 = 1 ";

if(!QTTN_PKG_FK.equals("")){
	sqlwhere += " and QTTN_PKG_FK like '%" + QTTN_PKG_FK + "%'";
}

if(!name.equals("")){
	sqlwhere += " and name like '%" + name + "%'";
}




int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "TAPPING成本设定";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",TAPPING_the_cost_of_setupdate.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="TAPPING_the_cost_of_set.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>外形</td>
			<td class=FIELD width='15%'>
			<input type=text id='QTTN_PKG_FK' name='QTTN_PKG_FK' value='<%=QTTN_PKG_FK%>'></td>
			<td NOWRAP width='5%'>Taping</td>
			<td class=FIELD width='15%'>
			<input type=text id='name' name='name' value='<%=name %>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='TAPPING_the_cost_of_set.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " A.id,A.QTTN_PKG_FK,B.name,MATERIAL_COST,MAINTENANCE_COST,LABOUR_COST,POWER_COST,DEPR_COST,OTHER_COST  ";
		            String fromSql  = " MD_SD_QTTN_PKG_TAPING a left join MD_SD_PACKING_TAPING b on A.TAPING_FK =b.id";
		            String sqlWhere = sqlwhere;
		            String orderby = " a.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								"			<col width=\"10%\" text=\"外形\" column=\"QTTN_PKG_FK\" orderkey=\"QTTN_PKG_FK\"  />"+
								 "			<col width=\"10%\" text=\"Taping\" column=\"name\" orderkey=\"name\"  />"+
								 "			<col width=\"10%\" text=\"材料费用\" column=\"MATERIAL_COST\" orderkey=\"MATERIAL_COST\"  />"+
								 "			<col width=\"10%\" text=\"人工费用\" column=\"LABOUR_COST\" orderkey=\"LABOUR_COST\"  />"+
								"			<col width=\"10%\" text=\"动力费用\" column=\"POWER_COST\" orderkey=\"POWER_COST\"  />"+
								 "			<col width=\"10%\" text=\"折旧费用\" column=\"DEPR_COST\" orderkey=\"MAINTENANCE_COST\"  />"+
								 "			<col width=\"10%\" text=\"维修费用\" column=\"MAINTENANCE_COST\" orderkey=\"MAINTENANCE_COST\"  />"+
								 "			<col width=\"10%\" text=\"其他费用\" column=\"OTHER_COST\" orderkey=\"OTHER_COST\"  />"+
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
	document.frmmain.action = "TAPPING_the_cost_of_setupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("TAPPING_the_cost_of_setexcel.jsp");
	if(rvalue > 0){
		window.location.href = "TAPPING_the_cost_of_set.jsp";
	}
}
function doDownload(){
	window.location.href='TAPPING_the_cost_of_set.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="TAPPING_the_cost_of_setoperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>