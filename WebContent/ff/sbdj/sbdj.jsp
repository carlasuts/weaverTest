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

String fb = Util.null2String(request.getParameter("fb"));
String qb = Util.null2String(request.getParameter("qb"));
String sblb = Util.null2String(request.getParameter("sblb"));
String sbbh = Util.null2String(request.getParameter("sbbh"));
String sbms = Util.null2String(request.getParameter("sbms"));
String djr = Util.null2String(request.getParameter("djr"));
String zhdjsj = Util.null2String(request.getParameter("zhdjsj"));
String djpl = Util.null2String(request.getParameter("djpl"));
String workcode = Util.null2String(request.getParameter("workcode"));//工号
String email = Util.null2String(request.getParameter("email"));//工号
String sqlwhere = " where 1 = 1 ";

if(!fb.equals("")){
	sqlwhere += " and fb like '%" + fb + "%'";
}

if(!qb.equals("")){
	sqlwhere += " and qb like '%" + qb + "%'";
}

if(!sblb.equals("")){
	sqlwhere += " and sblb like '%" + sblb + "%'";
}

if(!sbbh.equals("")){
	sqlwhere += " and sbbh like '%" + sbbh + "%'";
}

if(!sbms.equals("")){
	sqlwhere += " and sbms like '%" + sbms + "%'";
}

if(!djr.equals("")){
	sqlwhere += " and djr like '%" + djr + "%'";
}
if(!zhdjsj.equals("")){
	sqlwhere += " and zhdjsj like '%" + zhdjsj + "%'";
}
if(!djpl.equals("")){
	sqlwhere += " and djpl like '%" + djpl + "%'";
}

if(!workcode.equals("")){
	sqlwhere += " and a.workcode like '%" + workcode + "%'";
}

if(!email.equals("")){
	sqlwhere += " and a.email like '%" + email + "%'";
}

int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "设备点检";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",sbdjupdate.jsp,_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{导入excel,javascript:doImportExcel(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{模板下载,javascript:doDownload(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
 	RCMenu += "{导出当前页,javascript:_xtable_getExcel(),_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="sbdj.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>分部</td>
			<td class=FIELD width='10%'>
			<input type=text id='fb' name='fb' value='<%=fb%>'></td>
			<td NOWRAP width='5%'>期别</td>
			<td class=FIELD width='10%'>
			<input type=text id='qb' name='qb' value='<%=qb%>'></td>
			<td NOWRAP width='5%'>设备类别</td>
			<td class=FIELD width='10%'>
			<input type=text id='sblb' name='sblb' value='<%=sblb%>'></td>
			<td NOWRAP width='5%'>设备编号</td>
			<td class=FIELD width='10%'>
			<input type=text id='sbbh' name='sbbh' value='<%=sbbh%>'></td>
			<td NOWRAP width='5%'>点检人</td>
			<td class=FIELD width='10%'>
			<input type=text id='djr' name='djr' value='<%=djr%>'></td>
			<td NOWRAP width='5%'>工号</td>
			<td class=FIELD width='10%'>
			<input type=text id='workcode' name='workcode' value='<%=workcode%>'></td>
			<td NOWRAP width='5%'>最后点检日期</td>
			<td class=FIELD width='10%'>
			<input type=text id='zhdjsj' name='zhdjsj' value='<%=zhdjsj%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='sbdj.xls';">&nbsp;&nbsp;
											<input type="button" value="导出当前页"
											onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
											<input type="button" value="导出所有"
											onclick="javascript:_xtable_getAllExcel()">
			</td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " a.id,fb,qb,sblb,sbbh,sbms,djr,zhdjsj,a.workcode,djpl,a.email,a.stopsign  ";
		            String fromSql  = " sbdjxx a left join hrmresource b on a.workcode = b.workcode ";
		            String sqlWhere = sqlwhere;
		            String orderby = " a.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
		                         "			<col width=\"10%\" text=\"分部\" column=\"fb\" orderkey=\"fb\"  />"+
								 "			<col width=\"10%\" text=\"期别\" column=\"qb\" orderkey=\"qb\"  />"+
								 "			<col width=\"10%\" text=\"设备类别\" column=\"sblb\" orderkey=\"sblb\"  />"+
								 "			<col width=\"10%\" text=\"设备编号\" column=\"sbbh\" orderkey=\"sbbh\"  />"+
								 "			<col width=\"10%\" text=\"设备描述\" column=\"sbms\" orderkey=\"sbms\"  />"+
								 "			<col width=\"15%\" text=\"点检人\" column=\"djr\" orderkey=\"djr\"  />"+
								 "			<col width=\"10%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\"  />"+
								 "			<col width=\"10%\" text=\"最后点检日期\" column=\"zhdjsj\" orderkey=\"zhdjsj\"  />"+
								 "			<col width=\"10%\" text=\"点检频率\" column=\"djpl\" orderkey=\"djpl\"  />"+
								 "			<col width=\"10%\" text=\"邮箱\" column=\"email\" orderkey=\"email\"  />"+	
								 "			<col width=\"10%\" text=\"停用标志\" column=\"stopsign\" orderkey=\"stopsign\"  />"+	
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
	<td height="10" colspan="3">停用标志：S 表示不在使用  ，U 表示还在使用
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
	document.frmmain.action = "sbdjupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("sbdjexcel.jsp");
	if(rvalue > 0){
		window.location.href = "sbdj.jsp";
	}
}
function doDownload(){
	window.location.href='sbdj.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="sbdjoperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>