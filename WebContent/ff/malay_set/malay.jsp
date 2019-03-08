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

String lgart =Util.null2String(request.getParameter("lgart"));
String lgtxt = Util.null2String(request.getParameter("lgtxt"));
String wt_en = Util.null2String(request.getParameter("wt_en"));

String sqlwhere = " where 1 = 1 ";

if(!lgart.equals("")){
	sqlwhere += " and lgart like '%" + lgart + "%'";
}

if(!lgtxt.equals("")){
	sqlwhere += " and lgtxt '%" + lgtxt + "%'";
}

if(!wt_en.equals("")){
	sqlwhere += " and wt_en '%" + wt_en + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "malay";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",malayupdate.jsp,_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{导入excel,javascript:doImportExcel(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{模板下载,javascript:doDownload(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{导出当前页,javascript:_xtable_getExcel()(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
	RCMenu += "{导出所有,javascript:_xtable_getAllExcel(),_self} " ;
	RCMenuHeight += RCMenuHeightStep; 
	 

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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="malay.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>		
		<TR>
			<td NOWRAP width='3%'>lgart</td>
			<td class=FIELD width='7%'>
			<input type=text id='lgart' name='lgart' value='<%=lgart%>'></td>
			<td NOWRAP width='3%'>lgtxt</td>
			<td class=FIELD width='7%'>
			<input type=text id='lgtxt' name='lgtxt' value='<%=lgtxt%>'></td>
			<td NOWRAP width='3%'>wt_en</td>
			<td class=FIELD width='7%'>
			<input type=text id='wt_en' name='wt_en' value='<%=wt_en%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='malay.xls';">
			<input type="button" value="导出当前页" onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
			<input type="button" value="导出所有" onclick="javascript:_xtable_getAllExcel()"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " id,sprsl,molga,lgart,lgtxt,kztxt,wt_en ";
		            String fromSql  = " ZJV_HR_OAWT_BM ";
		            String sqlWhere = sqlwhere;
		            String orderby = " id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+								 
								 "			<col width=\"10%\" text=\"sprsl\" column=\"sprsl\" orderkey=\"sprsl\"  />"+
								 "			<col width=\"10%\" text=\"molga\" column=\"molga\" orderkey=\"molga\"  />"+
							     "			<col width=\"10%\" text=\"lgart\" column=\"lgart\" orderkey=\"lgart\"  />"+
								 "			<col width=\"10%\" text=\"lgtxt\" column=\"lgtxt\" orderkey=\"lgtxt\"  />"+
								 "			<col width=\"10%\" text=\"kztxt\" column=\"kztxt\" orderkey=\"kztxt\"  />"+
								 "			<col width=\"10%\" text=\"wt_en\" column=\"wt_en\" orderkey=\"wt_en\"  />"+
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
	document.frmmain.action = "malayupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("malayexcel.jsp");
	if(rvalue > 0){
		window.location.href = "malay.jsp";
	}
}
function doDownload(){
	window.location.href='malay.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="malayoperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>