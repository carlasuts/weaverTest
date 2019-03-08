<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />




<HTML>
<HEAD><LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css></HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
// int userID = user.getUID();

// String site = Util.null2String(request.getParameter("site"));
// String workcode= Util.null2String(request.getParameter("workcode"));
// String DEPART = Util.null2String(request.getParameter("DEPART"));
// String name = Util.null2String(request.getParameter("name"));
// String create_time = Util.null2String(request.getParameter("create_time"));
// String update_time = Util.null2String(request.getParameter("update_time"));
 String sqlwhere = " where 1 = 1 ";

// if(!site.equals("")){
// 	sqlwhere += " and site =" + site;
// }

// if(!workcode.equals("")){
// 	sqlwhere += " and workcode =" + workcode;
// }


// int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
 int pagenum =1;
 int	perpage=10;
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>


<%
// 	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
// 	RCMenuHeight += RCMenuHeightStep ;
// 	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",uphupdate_cc.jsp,_self} " ;
// 	RCMenuHeight += RCMenuHeightStep ;
// 	RCMenu += "{导入excel,javascript:doImportExcel(),_self} " ;
// 	RCMenuHeight += RCMenuHeightStep ;
// 	RCMenu += "{模板下载,javascript:doDownload(),_self} " ;
// 	RCMenuHeight += RCMenuHeightStep ;
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
	<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="UserQualification.jsp" method=post>
	<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
	    <TR>
			
			        <td NOWRAP width='5%'>厂区</td>
					<td class=FIELD width='10%'>
					<input type=text id='site' name='site' value='<%=site%>'></td>
					<td NOWRAP width='5%'>工号</td>
					<td class=FIELD width='10%'>
					<input type=text id='workcode' name='workcode' value='<%=workcode%>'></td>
					<td NOWRAP width='5%'>创建时间</td>
					<td class=FIELD width='10%'>
					<input type=text id='create_time' name='create_time' value='<%=create_time%>'></td>
					<td NOWRAP width='5%'>更新时间</td>
					<td class=FIELD width='10%'>
					<input type=text id='update_time' name='update_time' value='<%=update_time%>'></td>
					
					<td NOWRAP width='40%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
					<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
					<input type="button" value="模板下载" onclick="javascript:window.location.href='uph_cc.xls';"></td>
					
			
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=12></TD></TR>
	
	</table>
	
	<table width="100%">
	<tr>
	 <td valign="top">
	 
	<wea:SplitPageTag  tableInstanceId=""  tableString="<%=tableString%>"  mode="run" selectedstrs="" tableInfo="ok ,this info!"  showExpExcel=＂true＂  isShowTopInfo=”false”   isShowBottomInfo =”false” />


	 </td>
	</tr>
	<tr>
	fuck you
	</tr>
	</table>
	</FORM>
	</td>
	</tr>
	</TABLE>
</td>
<td ></td>
</tr>





<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>






<script language=javascript>
//查询
function doSearch(){
	document.frmmain.submit();
}
</script>





</BODY>

<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</HTML>