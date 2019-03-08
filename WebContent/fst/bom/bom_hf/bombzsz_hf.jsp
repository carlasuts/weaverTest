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

String cust_id = Util.null2String(request.getParameter("cust_id"));
String pkld = Util.null2String(request.getParameter("pkld"));
String oper_grp = Util.null2String(request.getParameter("oper_grp"));
String factory = Util.null2String(request.getParameter("factory"));
String sqlwhere = " where 1 = 1 ";

if(!cust_id.equals("")){
	sqlwhere += " and cust_id like '%" + cust_id + "%'";
}

if(!pkld.equals("")){
	sqlwhere += " and pkld like '%" + pkld + "%'";
}

if(!oper_grp.equals("")){
	sqlwhere += " and oper_grp like '%" + oper_grp + "%'";
}

if(!oper_grp.equals("")){
	sqlwhere += " and factory like '%" + factory + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "BOM标准设置";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",bombzszupdate_hf.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="bombzsz_hf.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>客户名</td>
			<td class=FIELD width='15%'>
			<input type=text id='cust_id' name='cust_id' value='<%=cust_id%>'></td>
			<td NOWRAP width='5%'>PKLD</td>
			<td class=FIELD width='15%'>
			<input type=text id='pkld' name='pkld' value='<%=pkld%>'></td>
			<td NOWRAP width='5%'>工序组</td>
			<td class=FIELD width='15%'>
			<input type=text id='oper_grp' name='oper_grp' value='<%=oper_grp%>'></td>
		    <td NOWRAP width='5%'>factory</td>
			<td class=FIELD width='15%'>
			<input type=text id='oper_grp' name='factory' value='<%=factory%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='bombzsz_hf.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " id,factory,cust_id,pkld_grp,pkld,pkld_com,oper_grp,mat_type,mat_id,mat_desc,qty_1,storage_location,mustfill_flag,create_time,create_user_id,update_time,update_user_id ";
		            String fromSql  = " obomsetmat_hf ";
		            String sqlWhere = sqlwhere;
		            String orderby = " create_time " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								"			<col width=\"7%\" text=\"工厂\" column=\"factory\" orderkey=\"factory\"  />"+
								 "			<col width=\"7%\" text=\"客户名\" column=\"cust_id\" orderkey=\"cust_id\"  />"+
								 "			<col width=\"8%\" text=\"外形组\" column=\"pkld_grp\" orderkey=\"pkld_grd\"  />"+
								 "			<col width=\"12%\" text=\"外形\" column=\"pkld\" orderkey=\"pkld\"  />"+
								 "			<col width=\"7%\" text=\"外形备注\" column=\"pkld_com\" orderkey=\"pkld_com\"  />"+
								 "			<col width=\"7%\" text=\"工序组\" column=\"oper_grp\" orderkey=\"oper_grp\"  />"+
								 "			<col width=\"8%\" text=\"材料类型\" column=\"mat_type\" orderkey=\"mat_type\"  />"+
								 "			<col width=\"12%\" text=\"料号\" column=\"mat_id\" orderkey=\"mat_id\"  />"+
								 "			<col width=\"8%\" text=\"料号描述\" column=\"mat_desc\" orderkey=\"mat_desc\"  />"+
								 "			<col width=\"8%\" text=\"组件数量\" column=\"qty_1\" orderkey=\"qty_1\"  />"+
								 "			<col width=\"8%\" text=\"生产仓存地点\" column=\"storage_location\" orderkey=\"storage_location\"  />"+
								 "			<col width=\"8%\" text=\"是否必填\" column=\"mustfill_flag\" orderkey=\"mustfill_flag\"  />"+
								 "			<col width=\"8%\" text=\"创建时间\" column=\"create_time\" orderkey=\"create_time\"  />"+
								 "			<col width=\"6%\" text=\"创建人\" column=\"create_user_id\" orderkey=\"create_user_id\"  />"+
								 "			<col width=\"8%\" text=\"修改时间\" column=\"update_time\" orderkey=\"update_time\"  />"+
								 "			<col width=\"6%\" text=\"修改人\" column=\"update_user_id\" orderkey=\"update_user_id\"  />"+
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
	document.frmmain.action = "bombzszupdate_hf.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("bombzszexcel_hf.jsp");
	if(rvalue > 0){
		window.location.href = "bombzsz_hf.jsp";
	}
}
function doDownload(){
	window.location.href='bombzsz_hf.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="bombzszoperation_hf.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>