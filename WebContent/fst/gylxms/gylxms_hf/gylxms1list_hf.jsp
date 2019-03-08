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
	
	String id1 =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String master_fk = Util.null2String(request.getParameter("master_fk"));//
	String item_no = Util.null2String(request.getParameter("item_no"));//项目号
	String oper_fk = Util.null2String(request.getParameter("oper_fk"));//工序
	String factory = Util.null2String(request.getParameter("factory"));//
	String sqlwhere = " where master_fk = '"+id1+"'";

	//
	if(!item_no.equals("")){
		sqlwhere += " and item_no like '%" + item_no + "%'";
	}
	//
	if(!oper_fk.equals("")){
		sqlwhere += " and oper_fk like '%" + oper_fk + "%'";
	}
	//
	if(!factory.equals("")){
		sqlwhere += " and factory like '%" + factory + "%'";
	}
	int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
	int	perpage=100;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "标准工艺路线";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",gylxmsupdate_hf.jsp?id="+id1+",_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="gylxms1list_hf.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>工序</td>
			<td class=FIELD width='25%'>
			<input type=text id='oper_fk' name='oper_fk' value='<%=oper_fk%>'></td>
			<td NOWRAP width='5%'>工厂</td>
			<td class=FIELD width='15%'>
			<input type=text id='factory' name='factory' value='<%=factory%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='gylxms_hf.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = "id, item_no,oper_fk,factory";
		            String fromSql  = " MD_MDM_STD_ROUTER_item_hf ";
		            String sqlWhere = sqlwhere;
		            String orderby = " item_no " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"15%\" text=\"项目号\" column=\"item_no\" orderkey=\"item_no\"  />"+
								 "			<col width=\"15%\" text=\"工序\" column=\"oper_fk\" orderkey=\"oper_fk\"  />"+
								 "			<col width=\"15%\" text=\"工厂\" column=\"factory\" orderkey=\"factory\"  />"+
		                         "		</head>"+
								 "		<operates width=\"20%\">";
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
	var rvalue = window.showModalDialog("gylxmsexcel_hf.jsp?");
	if(rvalue > 0){
		window.location.href = "gylxms1list_hf.jsp";
	}
}

function doDownload(){
	window.location.href='gylxms_hf.xls';
}

function doDel(a){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="gylxms1Operation_hf.jsp?type=del&a='"+a+"'";
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>