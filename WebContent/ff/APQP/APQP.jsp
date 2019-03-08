<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />

<html>
<HEAD><LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>

</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<!-- <script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script> -->
<%

	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "APQP";
 	String needfav = "1";
	String needhelp = "";
%>

<%
	String sqlwhere = "WHERE 1 = 1";
	String CUSTOMER = Util.null2String(request.getParameter("CUSTOMER"));
	String STIE = Util.null2String(request.getParameter("STIE"));
	
	if (!CUSTOMER.equals("")) {
		sqlwhere += " AND CUSTOMER LIKE '%" + CUSTOMER + "%' ";
	}
	if (!STIE.equals("")) {
		sqlwhere += " AND STIE = '" + STIE + "' ";
	}
	
	int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
	int	perpage=20;
%>

<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %> 
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
	
	<%
		RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self}";
		RCMenuHeight += RCMenuHeightStep;
		RCMenu += "{导出当前页,javascript:_xtable_getExcel(),_self}";
		RCMenuHeight += RCMenuHeightStep;
		RCMenu += "{导出所有,javascript:_xtable_getAllExcel(),_self}";
		RCMenuHeight += RCMenuHeightStep;
	%>
	
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
	
	<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
		<colgroup>
		<col width="10">
		<col width="">
		<col width="10">
		
		<tr>
			<td valign="top">
				<TABLE class=Shadow>
					<tr>
						<td valign="top">
							<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="IQIreport.jsp" method=post>
								<table width=300% class=ViewForm>
									<colgroup>
										<col width="16%">
										<col width="16%">
									<TR>
										<td NOWRAP width='5%'>厂别</td>
										<td class=FIELD width='5%'>
										<select id='SUBSECTION' name='SUBSECTION'>
											<option value=""></option>
											<option value="苏通">苏通</option>
											<option value="崇川">崇川</option>
											<option value="合肥">合肥</option>
										</select>
										</td>
										<td NOWRAP width='5%'>客户号</td>
										<td class=FIELD width='5%'>
											<input type=text id='CUSTOMERNO' name='CUSTOMERNO' value='<%=CUSTOMERNO%>'>
										</td>
										<td NOWRAP width='5%'>PKG</td>
										<td class=FIELD width='5%'>
											<input type=text id='LEADFRAME' name='LEADFRAME' value='<%=LEADFRAME%>'
										</td>
										<td NOWRAP width='25%'>
											<input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
											<input type="button" value="导出当前页" onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
											<input type="button" value="导出所有" onclick="javascript:_xtable_getAllExcel()">
										</td>
									</TR>
									<TR class=Spacing>
										<TD class=Line1 colspan=8></TD>
									</TR>
								</table>
								
								<TABLE width="300%">
									<tr>
										<td>
											<%
												String backfields = " SITE, CUSTOMER, PKG, TPMNAME, ENGMANAGERNAME, SALESNAME, PMNAME, COSTCENTERNAME, QEMANAGERNAME, PROMANAGERNAME, QAMANAGERNAME ";
												String fromsql = " OBASAPQPDOP ";
												String sqlWhere = sqlwhere;
												String orderby = " ID ";
												String tableString = "";
												tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromsql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"ID\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"厂区\" column=\"SITE\" orderkey=\"SITE\"  />"
														+ "			<col width=\"15%\" text=\"客户\" column=\"CUSTOMER\" orderkey=\"CUSTOMER\"  />"
														+ "			<col width=\"15%\" text=\"PKG\" column=\"PKG\" orderkey=\"PKG\"  />"	
														+ "			<col width=\"15%\" text=\"TPM\" column=\"TPMNAME\" orderkey=\"TPMNAME\"  />"
														+ "			<col width=\"15%\" text=\"Sales\" column=\"SALESNAME\" orderkey=\"SALESNAME\"  />"
														+ "			<col width=\"15%\" text=\"PM\" column=\"PMNAME\" orderkey=\"PMNAME\"  />"
														+ "			<col width=\"15%\" text=\"成本中心\" column=\"COSTCENTERNAME\" orderkey=\"COSTCENTERNAME\"  />"
														+ "			<col width=\"15%\" text=\"QE Manager\" column=\"QEMANAGERNAME\" orderkey=\"QEMANAGERNAME\"  />"
														+ "			<col width=\"15%\" text=\"工程总监\" column=\"ENGMANAGERNAME\" orderkey=\"ENGMANAGERNAME\"  />"
														+ "			<col width=\"15%\" text=\"生产总监\" column=\"PROMANAGERNAME\" orderkey=\"PROMANAGERNAME\"  />"
														+ "			<col width=\"15%\" text=\"质量总监\" column=\"QAMANAGERNAME\" orderkey=\"QAMANAGERNAME\"  />"														
														+ "		</head>" + "		<operates width=\"10%\">";
												tableString += "		</operates>" + " </table>";
											%> <wea:SplitPageTag tableString="<%=tableString%>"
												isShowTopInfo="false" mode="run" />
										</td>
									</tr>
								</TABLE>
							</FORM>
						</td>
					</tr>
				</TABLE>
			</td>
		</tr>
	</table>
	
	<script language=javascript>
		//查询
		function doSearch() {
			document.frmmain.submit();
		}
	</script>
</BODY>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>