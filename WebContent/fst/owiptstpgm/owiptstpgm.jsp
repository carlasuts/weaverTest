<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
int userID = user.getUID();

String cust_id = Util.null2String(request.getParameter("cust_id"));
String mat_list = Util.null2String(request.getParameter("mat_list"));
String id = Util.null2String(request.getParameter("id"));
String versionid = Util.null2String(request.getParameter("versionid"));
String FILENAME = Util.null2String(request.getParameter("FILENAME"));

String sqlwhere = " where 1 = 1 ";

if(!id.equals("")){
	sqlwhere += " and id like '%" + id + "%'";
}

if(!cust_id.equals("")){
	sqlwhere += " and cust_id like '%" + cust_id + "%'";
}

if(!mat_list.equals("")){
	sqlwhere += " and mat_list like '%" + mat_list + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "测试程序一览表";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table  width=100% height=100% border="0" cellspacing="0" cellpadding="0">
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="owiptstpgm.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>客户号</td>
			<td class=FIELD width='10%'>
			<input type=text id='cust_id' name='cust_id' value='<%=cust_id%>'></td>
			<td NOWRAP width='5%'>id号</td>
			<td class=FIELD width='10%'>
			<input type=text id='id' name='id' value='<%=id%>'></td>
			<td NOWRAP width='5%'>品名</td>
			<td class=FIELD width='10%'>
			<input type=text id='mat_list' name='mat_list' value='<%=mat_list%>'></td>
			<td NOWRAP width='25%'>
			<input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			</td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = "id,cust_id,versionid,mat_list,FILEREALPATH ";
		            String fromSql  = " owiptstpgm ";
		            String sqlWhere = sqlwhere;
		            String orderby = " id " ;
		            String tableString = "";
		            tableString =" <table  instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"5%\" text=\"客户号\" column=\"cust_id\" orderkey=\"cust_id\"  />"+
								 "			<col width=\"5%\" text=\"ID号\" column=\"id\" orderkey=\"id\"  />"+
								 "			<col width=\"5%\" text=\"版本号\" column=\"versionid\" orderkey=\"versionid\"  />"+
								 "			<col width=\"15%\" text=\"品名list\" column=\"mat_list\" orderkey=\"mat_list\" />"+
		                         "		</head>"+
  								 "		<operates width=\"10%\">";
				    tableString +=		 "    		<operate href=\"javascript:doDel()\" text=\"明细list\" target=\"_self\" index=\"0\"/>";
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

function doView(id){
	alert(id);
}


function doDel(id){
	jQuery.ajax({
		url: "/interface/cxylbsqb/TF158105ajaxaction.jsp",
		data: {type: 1, id:id},
		cache: false,
		type: "post",
		dataType: "text",
		async: false,
		success: function (result) {
			result = jQuery.trim(result);
			alert(result);
			//var ary  = new Array();
			//ary = result.split("<br>");
		}
	});	
}


</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>