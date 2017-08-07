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

String ph = Util.null2String(request.getParameter("ph"));//ph
String lotid = Util.null2String(request.getParameter("lotid"));//lotid
String sqlwhere = " where 1 = 1 ";
//����
if(!ph.equals("")){
	sqlwhere += " and ph like '%" + ph + "%'";
}
//lotid
if(!lotid.equals("")){
	sqlwhere += " and customer like '%" + lotid + "%'";
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="kkxsy.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>����</td>
			<td class=FIELD width='15%'>
			<input type=text id='ph' name='ph' value='<%=ph%>'></td>
			<td NOWRAP width='5%'>LOT ID</td>
			<td class=FIELD width='25%'>
			<input type=text id='lotid' name='lotid' value='<%=lotid%>'></td>
			<td NOWRAP width='20%'><input type="button" value="����" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="����excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="ģ������" onclick="javascript:window.location.href='kkxsy.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " id,ph,lotid,pm,fzlx,jbkj,xpcc,jhs,zhj,sfl,dd ";
		            String fromSql  = " tb_kkxsy ";
		            String sqlWhere = sqlwhere;
		            String orderby = " id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"7%\" text=\"����\" column=\"ph\" orderkey=\"ph\"  />"+
								 "			<col width=\"8%\" text=\"lot id\" column=\"lotid\" orderkey=\"lotid\"  />"+
								 "			<col width=\"10%\" text=\"Ʒ��\" column=\"pm\" orderkey=\"pm\"  />"+
								 "			<col width=\"10%\" text=\"��װ����\" column=\"fzlx\" orderkey=\"fzlx\"  />"+
								 "			<col width=\"10%\" text=\"����/���\" column=\"jbkj\" orderkey=\"jbkj\"  />"+
								 "			<col width=\"10%\" text=\"оƬ�ߴ�\" column=\"xpcc\" orderkey=\"xpcc\"  />"+
								 "			<col width=\"10%\" text=\"����˿\" column=\"jhs\" orderkey=\"jhs\"  />"+
								 "			<col width=\"10%\" text=\"������\" column=\"zhj\" orderkey=\"zhj\"  />"+
								 "			<col width=\"10%\" text=\"�ܷ���\" column=\"sfl\" orderkey=\"sfl\"  />"+
								 "			<col width=\"10%\" text=\"���\" column=\"dd\" orderkey=\"dd\"  />"+
		                         "		</head>"+
								 "		<operates width=\"5%\">";
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
	var rvalue = window.showModalDialog("kkxsyexcel.jsp");
	if(rvalue > 0){
		window.location.href = "kkxsy.jsp";
	}
}
function doDownload(){
	window.location.href='kkxsy.xls';
}
function doDel(id){
	var isdel = confirm("���Ҫɾ����?");
	if(isdel){
		document.frmmain.action="kkxsyoperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
</html>