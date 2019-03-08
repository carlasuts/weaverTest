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

String NAME = Util.null2String(request.getParameter("NAME"));
String TRADE_TYPE_FK = Util.null2String(request.getParameter("TRADE_TYPE_FK"));
String RATE = Util.null2String(request.getParameter("RATE"));


String sqlwhere = " where 1 = 1 ";

if(!NAME.equals("")){
	sqlwhere += " and NAME like '%" + NAME + "%'";
}

if(!TRADE_TYPE_FK.equals("")){
	sqlwhere += " and TRADE_TYPE_FK like '%" + TRADE_TYPE_FK + "%'";
}

if(!RATE.equals("")){
	sqlwhere += " and RATE like '%" + RATE + "%'";
}




int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "销售方式材料价格影响设定";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",materials_prices_setupdate.jsp,_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	//RCMenu += "{导入excel,javascript:doImportExcel(),_self} " ;
	//RCMenuHeight += RCMenuHeightStep ;
	//RCMenu += "{模板下载,javascript:doDownload(),_self} " ;
	//RCMenuHeight += RCMenuHeightStep ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="materials_prices_set.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>贸易方式</td>
			<td class=FIELD width='15%'>
			<input type=text id='TRADE_TYPE_FK' name='TRADE_TYPE_FK' value='<%=TRADE_TYPE_FK%>'></td>
			<td NOWRAP width='5%'>系数</td>
			<td class=FIELD width='15%'>
			<input type=text id='RATE' name='RATE' value='<%=RATE%>'></td>
			<td NOWRAP width='5%'>成本元素</td>
			<td class=FIELD width='15%'>
			<input type=text id='NAME' name='NAME' value='<%=NAME%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<!--<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='materials_prices_set.xls';"> -->
			</td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " A.ID,A.TRADE_TYPE_FK,A.RATE,C.NAME";
		            String fromSql  = " MD_SD_TRDTYP_MTRL_COST_RATE a left join MD_TRADE_TYPE b on A.TRADE_TYPE_FK =b.id left join MD_SD_COST_ELEMENT c on A.COST_ELEMENT_FK =C.ID";
		            String sqlWhere = sqlwhere;
		            String orderby = " a.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								"			<col width=\"15%\" text=\"贸易方式\" column=\"TRADE_TYPE_FK\" orderkey=\"TRADE_TYPE_FK\"  />"+
								 "			<col width=\"15%\" text=\"系数\" column=\"RATE\" orderkey=\"RATE\"  />"+
								 "			<col width=\"15%\" text=\"成本元素\" column=\"NAME\" orderkey=\"NAME\"  />"+
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
	document.frmmain.action = "materials_prices_setupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
/*function doImportExcel(){
	var rvalue = window.showModalDialog("materials_prices_setexcel.jsp");
	if(rvalue > 0){
		window.location.href = "materials_prices_set.jsp";
	}
}
function doDownload(){
	window.location.href='materials_prices_set.xls';
}
*/
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="materials_prices_setoperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>