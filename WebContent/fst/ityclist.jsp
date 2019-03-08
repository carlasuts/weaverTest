<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.Util" %>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css></HEAD>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min.js"></script>
<%
int userId = user.getUID();

String mc = Util.null2String(request.getParameter("mc"));//����
String sqlwhere = " where 1 = 1 ";
//�ͻ�
if(!mc.equals("")){
	sqlwhere += " and name like '%"+mc+"%'";
}
int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "IT�쳣����";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",ityc.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="ityclist.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='15%'>���</td>
			<td class=FIELD width='35%'>
			<input type=text id='mc' name='mc' value='<%=mc%>'></td>
			</td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " id,name,oby ";
		            String fromSql  = " tb_ityc ";
		            String sqlWhere = sqlwhere;
		            String orderby = " oby asc " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"10%\" text=\"ID\" column=\"id\" orderkey=\"id\"  />"+
								 "			<col width=\"50%\" text=\"����\" column=\"name\" orderkey=\"name\"  />"+
								 "			<col width=\"20%\" text=\"����\" column=\"oby\" orderkey=\"oby\"  />"+
		                         "		</head>"+
								 "		<operates width=\"20%\">";
					tableString +=		 "    		<operate href=\"javascript:doView()\"  text=\"����\" target=\"_self\" index=\"0\"/>";
					tableString +=		 "    		<operate href=\"javascript:doEdit()\"  text=\"�޸�\" target=\"_self\" index=\"0\"/>";
					tableString +=		 "    		<operate href=\"javascript:doDel()\"  text=\"ɾ��\" target=\"_self\" index=\"0\"/>";
					tableString +=		 "		</operates>"+
		                                     "</table>";
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
function doEdit(id){
	document.frmmain.action = "ityc.jsp?id="+id;
	document.frmmain.submit();
}
//��ϸ
function doView(id){
	document.frmmain.action = "ityc1list.jsp?id="+id;
	document.frmmain.submit();
}
//ɾ��
function doDel(id){
	if(confirm("ɾ�������Ҳ�ᱻɾ�������Ҫɾ����")){
		document.frmmain.action = "itycOperation.jsp?method=del&id="+id;
		document.frmmain.submit();
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
</html>