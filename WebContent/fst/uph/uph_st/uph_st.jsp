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

String PKG_OUTLINE_FK = Util.null2String(request.getParameter("PKG_OUTLINE_FK"));
String OPER_FK = Util.null2String(request.getParameter("OPER_FK"));
String sqlwhere = " where 1 = 1 ";

if(!PKG_OUTLINE_FK.equals("")){
	sqlwhere += " and PKG_OUTLINE_FK like '%" + PKG_OUTLINE_FK + "%'";
}

if(!OPER_FK.equals("")){
	sqlwhere += " and OPER_FK like '%" + OPER_FK + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "UPH规则";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",uphupdate_st.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="uph_st.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='10%'>封装外形</td>
			<td class=FIELD width='20%'>
			<input type=text id='PKG_OUTLINE_FK' name='PKG_OUTLINE_FK' value='<%=PKG_OUTLINE_FK%>'></td>
			<td NOWRAP width='10%'>工序</td>
			<td class=FIELD width='20%'>
			<input type=text id='OPER_FK' name='OPER_FK' value='<%=OPER_FK%>'></td>
			<td NOWRAP width='40%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='uph_st.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " ID,PKG_OUTLINE_FK,OPER_FK,SINGLE_ATTACH_TIME,ATTACH_CHANGE_WAFER_TIME,SINGLE_WIRE_BOND_TIME,SINGLE_NO_WIRE_TIME,SINGLE_GRIND_TIME,SCRIBE_METERS,SCRIBE_CHANGE_WAFER_TIME,UPH_FORMULA";
		            String fromSql  = " MDM_UPH_RULE_st ";
		            String sqlWhere = sqlwhere;
		            String orderby = " ID " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"ID\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"20%\" text=\"封装外形\" column=\"PKG_OUTLINE_FK\" orderkey=\"PKG_OUTLINE_FK\"  />"+
								 "			<col width=\"10%\" text=\"型号\" column=\"OPER_FK\" orderkey=\"OPER_FK\"  />"+
								 "			<col width=\"10%\" text=\"单只装片时间\" column=\"SINGLE_ATTACH_TIME\" orderkey=\"SINGLE_ATTACH_TIME\"  />"+
								 "			<col width=\"10%\" text=\"装片换圆片时间\" column=\"ATTACH_CHANGE_WAFER_TIME\" orderkey=\"ATTACH_CHANGE_WAFER_TIME\"  />"+
								 "			<col width=\"10%\" text=\"单丝键合时间\" column=\"SINGLE_WIRE_BOND_TIME\" orderkey=\"SINGLE_WIRE_BOND_TIME\"  />"+
								 "			<col width=\"10%\" text=\"单只不打线时间\" column=\"SINGLE_NO_WIRE_TIME\" orderkey=\"SINGLE_NO_WIRE_TIME\"  />"+
								 "			<col width=\"10%\" text=\"单片磨片时间\" column=\"SINGLE_GRIND_TIME\" orderkey=\"SINGLE_GRIND_TIME\"  />"+
								 "			<col width=\"10%\" text=\"划片速度\" column=\"SCRIBE_METERS\" orderkey=\"SCRIBE_METERS\"  />"+
								 "			<col width=\"10%\" text=\"划片换圆片时间\" column=\"SCRIBE_CHANGE_WAFER_TIME\" orderkey=\"SCRIBE_CHANGE_WAFER_TIME\"  />"+
								 "			<col width=\"10%\" text=\"UPH公式\" column=\"UPH_FORMULA\" orderkey=\"UPH_FORMULA\"  />"+
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
	document.frmmain.action = "uphupdate_st.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("uphexcel_st.jsp");
	if(rvalue > 0){
		window.location.href = "uph_st.jsp";
	}
}
function doDownload(){
	window.location.href='uph_st.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="uphoperation_st.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>