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
	String titlename = "Technical Protocol";
 	String needfav = "1";
	String needhelp = "";
%>

<%
	String sqlwhere = "WHERE 1 = 1";
	String FACTORY = Util.null2String(request.getParameter("FACTORY"));
	String NAME = Util.null2String(request.getParameter("NAME"));
	
	if (!FACTORY.equals("")) {
		sqlwhere += " AND FACTORY = '" + FACTORY + "' ";
	}
	if (!NAME.equals("")) {
		sqlwhere += " AND NAME LIKE '%" + NAME + "%' ";
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
	   	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",Technical Protocol Update.jsp,_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{导入excel,javascript:doImportExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		RCMenu += "{导出当前页,javascript:_xtable_getExcel(),_self}";
		RCMenuHeight += RCMenuHeightStep;
		RCMenu += "{导出所有,javascript:_xtable_getAllExcel(),_self}";
		RCMenuHeight += RCMenuHeightStep;
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
			<td valign="top">
				<TABLE class=Shadow>
					<tr>
						<td valign="top">
							<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="Technical Protocol.jsp" method=post>
								<table width=300% class=ViewForm>
									<colgroup>
										<col width="16%">
										<col width="16%">
									<TR>
										<td NOWRAP width='5%'>厂区</td>
										<td class=FIELD width='5%'>
										<select id='FACTORY' name='FACTORY'>
											<option value=""></option>
											<option value="崇川厂">崇川厂</option>
											<option value="苏通厂">苏通厂</option>
											<option value="合肥厂">合肥厂</option>
											<option value="圆片厂">圆片厂</option>
										</select>
										</td>
										<td NOWRAP width='5%'>申请人</td>
										<td class=FIELD width='5%'>
											<input type=text id='NAME' name='NAME' value='<%=NAME%>'>
										</td>
										<td NOWRAP width='25%'>
											<input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
											<input type="button" value="导出当前页" onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
											<input type="button" value="导出所有" onclick="javascript:_xtable_getAllExcel()">
                                            <input type="button" value="模板下载" onclick="javascript:window.location.href='tech.xls';"></td>
										</td>
									</TR>
									<TR class=Spacing>
										<TD class=Line1 colspan=8></TD>
									</TR>
								</table>
								
								<TABLE width="100%">
									<tr>
										<td>
											<%
												String backfields = " ID, FACTORY, DEPARTMENT, PROCESS, NAME, WORKCODE, AUDITOR ";
												String fromsql = " ( SELECT TP.ID, A.SELECTNAME FACTORY, TP.DEPARTMENT, TP.PROCESS, TP.NAME, TP.WORKCODE, (SELECT LISTAGG(HRM.LASTNAME, ',') WITHIN GROUP(ORDER BY HRM.ID) FROM HRMRESOURCE HRM WHERE INSTR(',' || TP.AUDITOR || ',', ',' || HRM.ID || ',') > 0) AUDITOR FROM OBASTPDOP TP LEFT JOIN (SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = (SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -267 AND FIELDNAME = 'factory')) A ON TP.FACTORY = A.SELECTVALUE ) ";
												String sqlWhere = sqlwhere;
												String orderby = " ID ";
												String tableString = "";
												tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromsql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"ID\" sqlsortway=\"asc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"申请厂区\" column=\"FACTORY\" orderkey=\"FACTORY\"  />"
														+ "			<col width=\"15%\" text=\"申请部门\" column=\"DEPARTMENT\" orderkey=\"DEPARTMENT\"  />"
														+ "			<col width=\"15%\" text=\"工序\" column=\"PROCESS\" orderkey=\"PROCESS\"  />"	
														+ "			<col width=\"15%\" text=\"申请人\" column=\"NAME\" orderkey=\"NAME\"  />"
														+ "			<col width=\"15%\" text=\"审核(工程部长/设备部长)\" column=\"AUDITOR\" orderkey=\"AUDITOR\"  />"
														+ "		</head>" + "		<operates width=\"10%\">";
												tableString +=		 "    		<operate href=\"javascript:doEdit()\"  text=\"修改\" target=\"_self\" index=\"0\"/>";								 
												tableString +=		 "    		<operate href=\"javascript:doDel()\"  text=\"删除\" target=\"_self\" index=\"0\"/>";
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
		//修改
		function doEdit(id){
			document.frmmain.action = "Technical Protocol Update.jsp?type=modi&id="+id;
			document.frmmain.submit();
		}
		// 删除
		function doDel(id){
			var isdel = confirm("真的要删除吗?");
			if(isdel){
				document.frmmain.action="Technical Protocol Operation.jsp?type=del&id="+id;
				document.frmmain.submit();	
			}
		}
		// 导入
		function doImportExcel(){
			var rvalue = window.showModalDialog("Technical Protocol Excel.jsp");
			if(rvalue > 0){
				window.location.href = "Technical Protocol.jsp";
			}
		}
        function doDownload(){
            window.location.href='tech.xls';
        }
	</script>
</BODY>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>