<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
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
	String name = Util.null2String(request.getParameter("name"));
	String work_code = Util.null2String(request.getParameter("work_code"));
	String sqlwhere = " where 1 = 1 ";

	if (!cust_id.equals("")) {
		sqlwhere += " and CUST_ID like '%" + cust_id + "%'";
	}

	if (!name.equals("")) {
		sqlwhere += " and NAME like '%" + name + "%'";
	}
	
	if (!work_code.equals("")) {
		sqlwhere += " and WORK_CODE like '%" + work_code + "%'";
	}

	int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
	int perpage = 20;
%>

<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "客户CP负责人员配置";
	String needfav = "1";
	String needhelp = "";
%>
<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
	<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(197, user.getLanguage()) + ",javascript:doSearch(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		RCMenu += "{" + SystemEnv.getHtmlLabelName(82, user.getLanguage()) + ",oinrwcpdopupdate.jsp,_self} ";
		RCMenuHeight += RCMenuHeightStep;
		RCMenu += "{导入excel,javascript:doImportExcel(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		RCMenu += "{模板下载,javascript:doDownload(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		RCMenu += "{导出当前页,javascript:_xtable_getExcel()(),_self} " ;
		RCMenuHeight += RCMenuHeightStep;
		RCMenu += "{导出所有,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
	<table width=100% height=100% border="0" cellspacing="0"
		cellpadding="0">
		<colgroup>
			<col width="10">
			<col width="">
			<col width="10">
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
		<tr>
			<td></td>
			<td valign="top">
				<TABLE class=Shadow>
					<tr>
						<td valign="top">
							<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0"
								action="oinrwcpdop.jsp" method=post>
								<table width=100% class=ViewForm>
									<colgroup>
										<col width="16%">
										<col width="16%">
									<TR>
										<td NOWRAP width='5%'>客户号</td>
										<td class=FIELD width='10%'><input type=text id='cust_id'
											name='cust_id' value='<%=cust_id%>'></td>
										<td NOWRAP width='5%'>知会人</td>
										<td class=FIELD width='10%'><input type=text id='name'
											name='name' value='<%=name%>'></td>
										<td NOWRAP width='5%'>工号</td>
										<td class=FIELD width='10%'><input type=text id='work_code'
											name='work_code' value='<%=work_code%>'></td>
										<td NOWRAP width='25%'><input type="button" value="搜索"
											onclick="doSearch();">&nbsp;&nbsp; <input
											type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
											<input type="button" value="模板下载"
											onclick="javascript:window.location.href='oinrwcpdop.xls';">&nbsp;&nbsp;
											<input type="button" value="新建人员" onclick="doInsert()">&nbsp;&nbsp;
											<input type="button" value="导出当前页" onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
											<input type="button" value="导出所有" onclick="javascript:_xtable_getAllExcel()">
										</td>
									</TR>
									<TR class=Spacing>
										<TD class=Line1 colspan=8></TD>
									</TR>
								</table>
								<TABLE width="100%">
									<tr>
										<td valign="top">
											<%
												String backfields = "id, cust_id, name, work_code";
												String fromSql = " oinrwcpdop_hf b ";
												String sqlWhere = sqlwhere;
												String orderby = " b.id ";
												String tableString = "";
												tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"b.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"客户号\" column=\"cust_id\" orderkey=\"cust_id\"  />"
														+ "			<col width=\"15%\" text=\"知会人\" column=\"name\" orderkey=\"name\"  />" 
														+ "			<col width=\"15%\" text=\"工号\" column=\"work_code\" orderkey=\"work_code\"  />"
														+ "		</head>"
														+ "		<operates width=\"10%\">";
												tableString += "    		<operate href=\"javascript:doEdit()\"  text=\"修改\" target=\"_self\" index=\"0\"/>";
												tableString += "    		<operate href=\"javascript:doDel()\"  text=\"删除\" target=\"_self\" index=\"0\"/>";
												tableString += "		</operates>" + " </table>";
											%> <wea:SplitPageTag tableString="<%=tableString%>"
												isShowTopInfo="false" mode="run" />
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
			<td></td>
		</tr>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
	</table>

	<script language=javascript>
		//查询
		function doSearch() {
			document.frmmain.submit();
		}
		//修改
		function doEdit(id) {
			document.frmmain.action = "oinrwcpdopupdate.jsp?type=modi&id=" + id;
			document.frmmain.submit();
		}
		//导入
		function doImportExcel() {
			var rvalue = window.showModalDialog("oinrwcpdopexcel.jsp");
			if (rvalue > 0) {
				window.location.href = "oinrwcpdop.jsp";
			}
		}
		function doDownload() {
			window.location.href = 'oinrwcpdop.xls';
		}
		function doDel(id) {
			var isdel = confirm("真的要删除吗?");
			if (isdel) {
				document.frmmain.action = "oinrwcpdopoperation.jsp?type=del&id="
						+ id;
				document.frmmain.submit();
			}
		}
		// 新增
		function doInsert() {
			document.frmmain.action = "oinrwcpdopupdate.jsp?type=ins";
			document.frmmain.submit();
		}
	</script>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>