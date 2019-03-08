<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min.js"></script>
<%
int userID = user.getUID();

String pc = Util.null2String(request.getParameter("pc"));//PackageCode
String customer = Util.null2String(request.getParameter("customer"));//�ͻ�
String qb = Util.null2String(request.getParameter("qb"));//�ڱ�
String workcode = Util.null2String(request.getParameter("workcode"));//����
String sqlwhere = " where 1 = 1 ";
//PackageCode
if(!pc.equals("")){
	sqlwhere += " and packagecode like '%" + pc + "%'";
}
//�ͻ�
if(!customer.equals("")){
	sqlwhere += " and customer like '%" + customer + "%'";
}
//�ڱ�
if(!qb.equals("")){
	sqlwhere += " and qb like '%" + qb + "%'";
}
//����
if(!workcode.equals("")){
	sqlwhere += " and a.workcode like '%" + workcode + "%'";
}
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(16692,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{����excel,javascript:doImportExcel(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{ģ������,javascript:doDownload(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="cskf.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>PackageCode</td>
			<td class=FIELD width='15%'>
			<input type=text id='pc' name='pc' value='<%=pc%>'></td>
			<td NOWRAP width='5%'>�ͻ�</td>
			<td class=FIELD width='25%'>
			<input type=text id='customer' name='customer' value='<%=customer%>'></td>
			<td NOWRAP width='5%'>�ڱ�</td>
			<td class=FIELD width='15%'>
			<input type=text id='qb' name='qb' value='<%=qb%>'></td>
			<td NOWRAP width='5%'>����</td>
			<td class=FIELD width='15%'>
			<input type=text id='workcode' name='workcode' value='<%=workcode%>'></td>
			<td NOWRAP width='20%'><input type="button" value="����" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="����excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="ģ������" onclick="javascript:window.location.href='cskf.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " a.id,PackageCode,customer,qb,a.workcode,lastname ";
		            String fromSql  = " tb_cskf a left join hrmresource b on a.workcode = b.workcode ";
		            String sqlWhere = sqlwhere;
		            String orderby = " a.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"10%\" text=\"PackageCode\" column=\"packagecode\" orderkey=\"packagecode\"  />"+
								 "			<col width=\"10%\" text=\"�ͻ�\" column=\"customer\" orderkey=\"customer\"  />"+
								 "			<col width=\"20%\" text=\"�ڱ�\" column=\"qb\" orderkey=\"qb\"  />"+
								 "			<col width=\"25%\" text=\"����\" column=\"workcode\" orderkey=\"workcode\"  />"+
								 "			<col width=\"15%\" text=\"����\" column=\"lastname\" orderkey=\"lastname\"  />"+
		                         "		</head>"+
								 "		<operates width=\"20%\">";
					tableString +=		 "    		<operate href=\"javascript:doDel()\"  text=\"ɾ��\" target=\"_self\" index=\"0\"/>";
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
//��ѯ
function doSearch(){
	document.frmmain.submit();
}
//����
function doImportExcel(){
	var rvalue = window.showModalDialog("cskfexcel.jsp");
	if(rvalue > 0){
		window.location.href = "cskf.jsp";
	}
}
function doDownload(){
	window.location.href='cskf.xls';
}
function doDel(id){
	var isdel = confirm("���Ҫɾ����?");
	if(isdel){
		document.frmmain.action="cskfoperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
</html>