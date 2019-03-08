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
	String titlename = "IQI报表";
 	String needfav = "1";
	String needhelp = "";
%>

<%
	String sqlwhere = "WHERE 1 = 1";
	String CUSTOMERNO = Util.null2String(request.getParameter("CUSTOMERNO"));
	String LEADFRAME = Util.null2String(request.getParameter("LEADFRAME"));
	String STARTTIME = Util.null2String(request.getParameter("STARTTIME"));
	String ENDTIME = Util.null2String(request.getParameter("ENDTIME"));
	String SUBSECTION = Util.null2String(request.getParameter("SUBSECTION"));
	String STAGE = Util.null2String(request.getParameter("STAGE"));
	String EXECEPTIONS = Util.null2String(request.getParameter("EXECEPTIONS"));
	
	if (!CUSTOMERNO.equals("")) {
		sqlwhere += " AND CUSTOMERNO LIKE '%" + CUSTOMERNO + "%' ";
	}
	if (!LEADFRAME.equals("")) {
		sqlwhere += " AND LEADFRAME LIKE '%" + LEADFRAME + "%' ";
	}
	if(!STARTTIME.equals("")){
		sqlwhere += " AND DETECTORISSUEDATE >= '" + STARTTIME + "' ";
	}
	if(!ENDTIME.equals("")){
		sqlwhere += " AND DETECTORISSUEDATE <= '" + ENDTIME + "' ";
	}
	if(!SUBSECTION.equals("")){
		sqlwhere += " AND SUBSECTION = '" + SUBSECTION + "' ";
	}
	if(!STAGE.equals("")){
		sqlwhere += " AND STAGE = '" + STAGE + "' ";
	}
	if(!EXECEPTIONS.equals("")){
		sqlwhere += " AND EXECEPTIONS = '" + EXECEPTIONS + "' ";
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
											<option value="崇川">崇川厂</option>
											<option value="苏通">苏通厂</option>
											<option value="合肥">合肥厂</option>
										</select>
										</td>
										<td NOWRAP width='5%'>期别</td>
										<td class=FIELD width='5%'>
										<select id='STAGE' name='STAGE'>
											<option value=""></option>
											<option value="一期">一期</option>
											<option value="二期">二期</option>
											<option value="三期">三期</option>
										</select>
										</td>
										<td NOWRAP width='5%'>异常种类</td>
										<td class=FIELD width='5%'>
										<select id='EXECEPTIONS' name='EXECEPTIONS'>
											<option value=""></option>
											<option value="南通总部">南通总部</option>
											<option value="苏通厂">苏通厂</option>
											<option value="合肥厂">合肥厂</option>
											<option value="顾客异常">顾客异常</option>
											<option value="环境相关">环境相关</option>
											<option value="材料相关">材料相关</option>
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
										<td class=FIELD width='30%'>
											<span>发行日:</span>
											<span class="wuiDateSpan" selectId="datetype1" selectValue="6"> 
											<input name="STARTTIME" id="STARTTIME" type="hidden" value="<%=STARTTIME%>" class="wuiDateSel">
											</span>
											<span>-</span>
											<span class="wuiDateSpan" selectId="datetype2"  selectValue="6"> 
											<input name="ENDTIME" id="ENDTIME" type="hidden"  value="<%=ENDTIME%>" class="wuiDateSel">	
											</span>
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
												String backfields = " ID, DETECTORISSUENO, DETECTORISSUEDATE, ENGINEER, CASENAME, EXECEPTIONS, ISSUENO, DISCOVERTDATE, DISCOVERYPROCESS, OCCURREDDATE, ISSUEPROCESS, LEADFRAME, CUSTOMERNO, DEPTTOSURVEY, SURVEYDATE, ENGINEER1, PRODUCTDISOSAL, NFORMCUSTOMER, IFANSWER, SUBSECTION, DEP, STAGE, TYPE, ASSEMBLY_LOT, TIMELIMIT, ISSUEDATE, ABNORMITYREASONS, TBCOUNTERMEASURES, IMPLEMENTALTIME ";
												String fromsql = " ( SELECT FM209.ID, DETECTOR_ISSUE_NO DETECTORISSUENO, DETECTOR_ISSUE_DATE DETECTORISSUEDATE,F.LASTNAME ENGINEER, CASE_NAME CASENAME, A.SELECTNAME DEP, B.SELECTNAME STAGE, C.SELECTNAME EXECEPTIONS, ISSUE_NO ISSUENO, DISCOVERT_DATE DISCOVERTDATE, DISCOVERY_PROCESS DISCOVERYPROCESS, OCCURRED_DATE OCCURREDDATE, ISSUE_PROCESS ISSUEPROCESS, LEAD_FRAME LEADFRAME, CUSTOMER_NO CUSTOMERNO, H.NAME DEPTTOSURVEY, SURVEY_DATE SURVEYDATE, G.LASTNAME ENGINEER1, PRODUCT_DISOSAL PRODUCTDISOSAL, D.SELECTNAME NFORMCUSTOMER,E.SELECTNAME IFANSWER, CASE SUBSECTION WHEN 0 THEN '崇川' WHEN 1 THEN '苏通' ELSE '合肥' END SUBSECTION, I.TYPE, I.ASSEMBLY_LOT, TIME_LIMIT TIMELIMIT, J.ISSUEDATE, J.ABNORMITYREASONS, J.TBCOUNTERMEASURES, J.IMPLEMENTALTIME FROM FORMTABLE_MAIN_209 FM209 LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -209 AND FIELDNAME = 'dep' )) A ON A.SELECTVALUE = FM209.DEP LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -209 AND FIELDNAME = 'stage' ) ) B ON B.SELECTVALUE = FM209.STAGE LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -209 AND FIELDNAME = 'execeptions' ) ) C ON C.SELECTVALUE = FM209.EXECEPTIONS LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -209 AND FIELDNAME = 'nform_customer' ) ) D ON D.SELECTVALUE = FM209.NFORM_CUSTOMER LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -209 AND FIELDNAME = 'ifanswer' ) ) E ON E.SELECTVALUE = FM209.IFANSWER LEFT JOIN ( SELECT ID,LASTNAME FROM HRMRESOURCE ) F ON F.ID = FM209.ENGINEER LEFT JOIN ( SELECT ID,LASTNAME FROM HRMRESOURCE ) G ON G.ID = FM209.ENGINEER1 LEFT JOIN ( SELECT WR.REQUESTID, TRIM (',' FROM WR.RECEIVEDPERSONS) NAME FROM WORKFLOW_REQUESTLOG WR, (SELECT REQUESTID,MAX(LOGID) LOGID FROM WORKFLOW_REQUESTLOG WHERE NODEID = '29363' GROUP BY REQUESTID) TEMP WHERE WR.REQUESTID = TEMP.REQUESTID AND WR.LOGID = TEMP.LOGID ) H ON H.REQUESTID = FM209.REQUESTID LEFT JOIN ( SELECT MAINID, WM_CONCAT(TYPE) TYPE, WM_CONCAT(ASSEMBLY_LOT) ASSEMBLY_LOT FROM FORMTABLE_MAIN_209_DT1 GROUP BY MAINID ) I ON I.MAINID = FM209.ID LEFT JOIN ( SELECT FM208.REQUESTID REQUESTID1,MANUFACTURE_ABNORMITY_NO MANUFACTUREABNORMITYNO,ISSUE_DATE ISSUEDATE, ABNORMITY_REASONS ABNORMITYREASONS, TB_COUNTERMEASURES TBCOUNTERMEASURES, FM208DT2.IMPLEMENTALTIME IMPLEMENTALTIME FROM FORMTABLE_MAIN_208 FM208 LEFT JOIN (SELECT MAINID, MAX(IMPLEMENTALTIME) IMPLEMENTALTIME FROM FORMTABLE_MAIN_208_DT2 GROUP BY MAINID) FM208DT2  ON FM208.ID = FM208DT2.MAINID ) J ON J.MANUFACTUREABNORMITYNO = ISSUE_NO ) ";
												String sqlWhere = sqlwhere;
												String orderby = " ID ";
												String tableString = "";
												tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromsql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"ID\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"发行部NO\" column=\"DETECTORISSUENO\" orderkey=\"DETECTORISSUENO\"  />"
														+ "			<col width=\"15%\" text=\"发行日\" column=\"DETECTORISSUEDATE\" orderkey=\"DETECTORISSUEDATE\"  />"
														+ "			<col width=\"15%\" text=\"创建人\" column=\"ENGINEER\" orderkey=\"ENGINEER\"  />"
														+ "			<col width=\"15%\" text=\"件名\" column=\"CASENAME\" orderkey=\"CASENAME\"  />"
														+ "			<col width=\"15%\" text=\"发生厂别\" column=\"SUBSECTION\" orderkey=\"SUBSECTION\"  />"
														+ "			<col width=\"15%\" text=\"发生部门\" column=\"DEP\" orderkey=\"DEP\"  />"
														+ "			<col width=\"15%\" text=\"异常类别\" column=\"EXECEPTIONS\" orderkey=\"EXECEPTIONS\"  />"
														+ "			<col width=\"15%\" text=\"制造异常\" column=\"ISSUENO\" orderkey=\"ISSUENO\"  />"
														+ "			<col width=\"15%\" text=\"发现日期\" column=\"DISCOVERTDATE\" orderkey=\"DISCOVERTDATE\"  />"
														+ "			<col width=\"15%\" text=\"发现工序\" column=\"DISCOVERYPROCESS\" orderkey=\"DISCOVERYPROCESS\"  />"
														+ "			<col width=\"15%\" text=\"发生日期\" column=\"OCCURREDDATE\" orderkey=\"OCCURREDDATE\"  />"
														+ "			<col width=\"15%\" text=\"发生工序\" column=\"ISSUEPROCESS\" orderkey=\"ISSUEPROCESS\"  />"
														+ "			<col width=\"15%\" text=\"塑封体\" column=\"LEADFRAME\" orderkey=\"LEADFRAME\"  />"
														+ "			<col width=\"15%\" text=\"客户号\" column=\"CUSTOMERNO\" orderkey=\"CUSTOMERNO\"  />"
														+ "			<col width=\"15%\" text=\"型号\" column=\"TYPE\" orderkey=\"TYPE\"  />"
														+ "			<col width=\"15%\" text=\"组装批号\" column=\"ASSEMBLY_LOT\" orderkey=\"ASSEMBLY_LOT\"  />"
														+ "			<col width=\"15%\" text=\"委托调查者\" column=\"DEPTTOSURVEY\" orderkey=\"DEPTTOSURVEY\"  />"
														+ "			<col width=\"15%\" text=\"委托调查日期\" column=\"SURVEYDATE\" orderkey=\"SURVEYDATE\"  />"
														+ "			<col width=\"15%\" text=\"回答期限\" column=\"TIMELIMIT\" orderkey=\"TIMELIMIT\"  />"
														+ "			<col width=\"15%\" text=\"回答发行日\" column=\"ISSUEDATE\" orderkey=\"ISSUEDATE\"  />"
														+ "			<col width=\"15%\" text=\"对策完成时间\" column=\"IMPLEMENTALTIME\" orderkey=\"IMPLEMENTALTIME\"  />"
														+ "			<col width=\"15%\" text=\"质量担当\" column=\"ENGINEER1\" orderkey=\"ENGINEER1\"  />"
														+ "			<col width=\"15%\" text=\"产品处理日期\" column=\"PRODUCTDISOSAL\" orderkey=\"PRODUCTDISOSAL\"  />"
														+ "			<col width=\"15%\" text=\"是否通知客户\" column=\"NFORMCUSTOMER\" orderkey=\"NFORMCUSTOMER\"  />"
														+ "			<col width=\"15%\" text=\"是否要回答书\" column=\"IFANSWER\" orderkey=\"IFANSWER\"  />"
														+ "			<col width=\"15%\" text=\"发生原因\" column=\"ABNORMITYREASONS\" orderkey=\"ABNORMITYREASONS\"  />"
														+ "			<col width=\"15%\" text=\"改善对策\" column=\"TBCOUNTERMEASURES\" orderkey=\"TBCOUNTERMEASURES\"  />"
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
		
		window.onload = function(){  
			$("span:contains('发行日:')").parent().children().find("span").eq(0).empty();
			$("span:contains('-')").next().find("span").eq(0).empty();
		};
	</script>
</BODY>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>