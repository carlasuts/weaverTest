<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page import="weaver.common.xtable.*"%>
<HTML>
	<head>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
		<link rel='stylesheet' type='text/css' href='/js/extjs/resources/css/ext-all_wev8.css' />
		<link rel='stylesheet' type='text/css' href='/js/extjs/resources/css/xtheme-gray_wev8.css'/>
		<link rel='stylesheet' type='text/css' href='/css/weaver-ext_wev8.css' />
		<script type='text/javascript' src='/js/extjs/adapter/ext/ext-base_wev8.js'></script>
		<script type='text/javascript' src='/js/extjs/ext-all_wev8.js'></script>   
		<%if(user.getLanguage()==7) {%>
			<script type='text/javascript' src='/js/extjs/build/locale/ext-lang-zh_CN_gbk_wev8.js'></script>
			<script type='text/javascript' src='/js/weaver-lang-cn-gbk_wev8.js'></script>
		<%} else if(user.getLanguage()==8) {%>
			<script type='text/javascript' src='/js/extjs/build/locale/ext-lang-en_wev8.js'></script>
			<script type='text/javascript' src='/js/weaver-lang-en-gbk_wev8.js'></script>
		<%}%>
		<script type="text/javascript" src="/js/WeaverTableExt_wev8.js"></script>  
		<link rel="stylesheet" type="text/css" href="/css/weaver-ext-grid_wev8.css" />
	</head>
	<%
		String edpno = Util.fromScreen3(request.getParameter("edpno"), user.getLanguage());
		String sqlWhere = " where EDPNo = '" + edpno + "'";
	%>
	<BODY>
		<table width=100% height=100% style="margin: 0px;" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<%
					String tableString = "";
					String backfields = " requestname,t1.requestid ";
					String fromSql = " formtable_main_6 t1 join workflow_requestbase t2 on t1.requestid = t2.requestid ";
					String sqlmei = "";
					String orderby = " id ";
					//out.println("sql:"+ "select "+backfields+" from "+fromSql+ sqlWhere);

					ArrayList xTableColumnList = new ArrayList();

					TableColumn xTableColumn3 = new TableColumn();
					xTableColumn3.setColumn("requestname");
					xTableColumn3.setDataIndex("requestname");
					xTableColumn3.setHeader("相关流程");
					xTableColumn3.setLinkkey("requestid");
					xTableColumn3.setLinkvaluecolumn("requestid");
					xTableColumn3.setHref("/workflow/request/ViewRequest.jsp");
					xTableColumn3.setTarget("_fullwindow");
					xTableColumn3.setSortable(true);
					xTableColumn3.setWidth(0.016);
					xTableColumnList.add(xTableColumn3);

					TableSql xTableSql = new TableSql();
					xTableSql.setBackfields(backfields);
					xTableSql.setPageSize(5);
					xTableSql.setSqlform(fromSql);
					xTableSql.setSqlwhere(sqlWhere);
					xTableSql.setSqlprimarykey("t2.requestid");
					xTableSql.setSqlisdistinct("false");
					xTableSql.setDir(TableConst.DESC);
					xTableSql.setSort(orderby);

					Table xTable = new Table(request);

					xTable.setTableGridType(TableConst.NONE);
					xTable.setTableNeedRowNumber(true);
					xTable.setTableSql(xTableSql);
					xTable.setTableColumnList(xTableColumnList);
				%>
				<td valign="top" style="padding: 0px !important;margin: 0px !important;">
					<%=xTable.toString()%>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>