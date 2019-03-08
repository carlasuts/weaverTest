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
	String titlename = "顾客投诉回答报告";
 	String needfav = "1";
	String needhelp = "";
%>

<%
	String sqlwhere = "WHERE 1 = 1";
	String CARNO = Util.null2String(request.getParameter("CARNO"));
	String DMR = Util.null2String(request.getParameter("DMR"));
	String STARTTIME = Util.null2String(request.getParameter("STARTTIME"));
	String ENDTIME = Util.null2String(request.getParameter("ENDTIME"));
	
	if (!CARNO.equals("")) {
		sqlwhere += " AND CARNO LIKE '%" + CARNO + "%' ";
	}
	if (!DMR.equals("")) {
		sqlwhere += " AND DMR LIKE '%" + DMR + "%' ";
	}
	if(!STARTTIME.equals("")){
		sqlwhere += " AND RECEIVEDATE >= '" + STARTTIME + "' ";
	}
	if(!ENDTIME.equals("")){
		sqlwhere += " AND RECEIVEDATE <= '" + ENDTIME + "' ";
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
			<td height="10" colspan="3"></td>
		</tr>
		
		<tr>
			<td ></td>
			<td valign="top">
				<TABLE class=Shadow>
					<tr>
						<td valign="top">
							<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="CustomerComplaints.jsp" method=post>
								<table width=100% class=ViewForm>
									<colgroup>
										<col width="16%">
										<col width="16%">
									<TR>
										<td NOWRAP width='5%'>客户号</td>
										<td class=FIELD width='10%'>
											<input type=text id='DMR' name='DMR' value='<%=DMR%>'>
										</td>
										<td NOWRAP width='5%'>编号</td>
										<td class=FIELD width='10%'>
											<input type=text id='CARNO' name='CARNO' value='<%=CARNO%>'
										</td>
										<td class=FIELD width='30%'>
											<span>接受日期:</span>
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
										<td valign="top">
											<%
												String backfields = " ID, REQUESTID, ISTRUE, MONTH, WEEK, CARNO, DMR, DEFECTCLASSIFICATION, PARTNAME, ASSYLOT, PKG, DEFECTQTY, QTYIN, DEFECTRATE, RECEIVEDATE, DEPARTMENT, RESPONSIBLEPROCESS, MFGDATE, CUSTOMERREQUIRED8DREPLIED, RESPONSEREPLYDATE, REPLYDATE, HOUR3D, HOUR8D, NAME, CAUSEANDCORRECTIVE, CAPA, REASONDISTINGUISH, REPEAT, EXCURSION, LOWTECH, POINTOFDETECTION, SCHEDULEDDATE, ACTUALDATE ";
												String fromSql = " ( SELECT ID, FM171.REQUESTID, CARNO, DMR, DEFECTCLASSIFICATION, PARTNAME, ASSYLOT, PKG, DEFECTQTY, QTYIN, DEFECTRATE, RESPONSIBLEPROCESS, MFGDATE, CUSTOMERREQUIRED8DREPLIED, SCHEDULEDDATE, ACTUALDATE, CAPA, CAUSEANDCORRECTIVE, A.SELECTNAME AS REASONDISTINGUISH, B.SELECTNAME AS REPEAT, C.SELECTNAME AS EXCURSION, D.SELECTNAME AS LOWTECH, E.SELECTNAME AS POINTOFDETECTION, F.SELECTNAME AS ISTRUE, G.RECEIVEDATE AS RECEIVEDATE, H.RECEIVEDATE AS RESPONSEREPLYDATE, H.OPERATEDATE AS REPLYDATE, I.MONTH MONTH, I.WEEK WEEK, J.NAME, K.DEPARTMENT, L.HOURS AS HOUR3D, M.HOURS AS HOUR8D FROM FORMTABLE_MAIN_171 FM171 LEFT JOIN ( SELECT MAINID, REPLACE(WM_CONCAT(CAPA), ',', ';') AS CAPA FROM (SELECT MAINID, (CAPA || ' ' || OWNER || ' ' || DUEDATE) AS CAPA FROM FORMTABLE_MAIN_171_DT2) GROUP BY MAINID ) FM171DT2 ON FM171.ID = FM171DT2.MAINID LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -171 AND FIELDNAME = 'ReasonDistinguish' )) A ON FM171.REASONDISTINGUISH = A.SELECTVALUE LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -171 AND FIELDNAME = 'Repeat' )) B ON FM171.REPEAT = B.SELECTVALUE LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -171 AND FIELDNAME = 'Excursion' )) C ON FM171.EXCURSION = C.SELECTVALUE LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -171 AND FIELDNAME = 'LowTech' )) D ON FM171.LOWTECH = D.SELECTVALUE LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -171 AND FIELDNAME = 'PointofDetection' )) E ON FM171.POINTOFDETECTION = E.SELECTVALUE LEFT JOIN ( SELECT SELECTNAME, SELECTVALUE FROM WORKFLOW_SELECTITEM WHERE FIELDID = ( SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -171 AND FIELDNAME = 'istrue' )) F ON FM171.POINTOFDETECTION = F.SELECTVALUE LEFT JOIN ( SELECT REQUESTID, MAX(RECEIVEDATE) RECEIVEDATE FROM WORKFLOW_CURRENTOPERATOR WHERE NODEID = '12853' GROUP BY REQUESTID ) G ON FM171.REQUESTID = G.REQUESTID LEFT JOIN ( SELECT REQUESTID, MAX(RECEIVEDATE) RECEIVEDATE, MAX(OPERATEDATE) OPERATEDATE FROM WORKFLOW_CURRENTOPERATOR WHERE NODEID = '12857' GROUP BY REQUESTID ) H ON FM171.REQUESTID = H.REQUESTID LEFT JOIN ( SELECT REQUESTID, SUBSTR(MAX(RECEIVEDATE), 6, 2) AS MONTH, SUBSTR(MAX(RECEIVEDATE), 3, 2) || (TO_CHAR(TO_DATE(MAX(RECEIVEDATE),'YYYY-MM-DD'),'iw')) AS WEEK FROM WORKFLOW_CURRENTOPERATOR WHERE NODEID = '12853' GROUP BY REQUESTID ) I ON FM171.REQUESTID = I.REQUESTID LEFT JOIN ( SELECT TEMP1.REQUESTID, HRM.LASTNAME NAME FROM (SELECT WR.REQUESTID, WR.USERID FROM WORKFLOW_CURRENTOPERATOR WR, (SELECT REQUESTID, MAX(GROUPID) GROUPID FROM WORKFLOW_CURRENTOPERATOR WHERE NODEID = 12853 GROUP BY REQUESTID) TEMP WHERE NODEID = 12853 AND WR.REQUESTID = TEMP.REQUESTID AND WR.GROUPID = TEMP.GROUPID) TEMP1 LEFT JOIN (SELECT ID, LASTNAME FROM HRMRESOURCE) HRM ON TEMP1.USERID = HRM. ID ) J ON FM171.REQUESTID = J.REQUESTID LEFT JOIN ( SELECT REQUESTID, (SELECT WM_CONCAT (DEPARTMENTMARK) FROM HRMDEPARTMENT WHERE ID IN (SELECT DISTINCT DEPARTMENTID FROM HRMRESOURCE WHERE ID IN (SELECT USERID FROM WORKFLOW_CURRENTOPERATOR WHERE REQUESTID = FM171.REQUESTID AND NODEID = 4181 AND ISREMARK IN (0, 2)))) DEPARTMENT FROM FORMTABLE_MAIN_171 FM171) K ON K.REQUESTID = FM171.REQUESTID LEFT JOIN ( WITH TEMP AS (SELECT REQUESTID, MAX (OPERATEDATE) || ' ' || MAX (OPERATETIME) AS ENDTIME  FROM WORKFLOW_CURRENTOPERATOR WHERE NODEID = 12856 GROUP BY REQUESTID), TEMP1 AS (SELECT REQUESTID, MAX (RECEIVEDATE) || ' ' || MAX (RECEIVETIME) AS STARTTIME  FROM WORKFLOW_CURRENTOPERATOR WHERE NODEID = 12853 GROUP BY REQUESTID) SELECT TEMP.REQUESTID, ROUND(TO_NUMBER(TO_DATE(TEMP.ENDTIME, 'YYYY-MM-DD HH24-MI-SS') - TO_DATE(TEMP1.STARTTIME, 'YYYY-MM-DD HH24-MI-SS'))*24, 2) AS HOURS FROM TEMP, TEMP1 WHERE TEMP.REQUESTID = TEMP1.REQUESTID) L ON FM171.REQUESTID = L.REQUESTID LEFT JOIN ( WITH TEMP AS (SELECT REQUESTID, MAX (RECEIVEDATE) || ' ' || MAX (RECEIVETIME) AS ENDTIME  FROM WORKFLOW_CURRENTOPERATOR WHERE NODEID = 12859 GROUP BY REQUESTID), TEMP1 AS (SELECT REQUESTID, MAX (RECEIVEDATE) || ' ' || MAX (RECEIVETIME) AS STARTTIME  FROM WORKFLOW_CURRENTOPERATOR WHERE NODEID = 12853 GROUP BY REQUESTID) SELECT TEMP.REQUESTID, ROUND(TO_NUMBER(TO_DATE(TEMP.ENDTIME, 'YYYY-MM-DD HH24-MI-SS') - TO_DATE(TEMP1.STARTTIME, 'YYYY-MM-DD HH24-MI-SS')), 2) AS HOURS FROM TEMP, TEMP1 WHERE TEMP.REQUESTID = TEMP1.REQUESTID ) M ON M.REQUESTID = FM171.REQUESTID ) ";
												String sqlWhere = sqlwhere;
												String orderby = " ID ";
												String tableString = "";
												tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"ID\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"Valid\\invalid\" column=\"ISTRUE\" orderkey=\"ISTRUE\"  />"
														+ "			<col width=\"15%\" text=\"月份\" column=\"MONTH\" orderkey=\"MONTH\"  />"
														+ "			<col width=\"15%\" text=\"周次\" column=\"WEEK\" orderkey=\"WEEK\"  />"
														+ "			<col width=\"15%\" text=\"编号\" column=\"CARNO\" orderkey=\"CARNO\"  />"
														+ "			<col width=\"15%\" text=\"客户号\" column=\"DMR\" orderkey=\"DMR\"  />"
														+ "			<col width=\"15%\" text=\"异常内容\" column=\"DEFECTCLASSIFICATION\" orderkey=\"DEFECTCLASSIFICATION\"  />"
														+ "			<col width=\"15%\" text=\"品名\" column=\"PARTNAME\" orderkey=\"PARTNAME\"  />"
														+ "			<col width=\"15%\" text=\"批号\" column=\"ASSYLOT\" orderkey=\"ASSYLOT\"  />"
														+ "			<col width=\"15%\" text=\"PKG\" column=\"PKG\" orderkey=\"PKG\"  />"
														+ "			<col width=\"15%\" text=\"不良数\" column=\"DEFECTQTY\" orderkey=\"DEFECTQTY\"  />"
														+ "			<col width=\"15%\" text=\"客户投入数\" column=\"QTYIN\" orderkey=\"QTYIN\"  />"
														+ "			<col width=\"15%\" text=\"不良率\" column=\"DEFECTRATE\" orderkey=\"DEFECTRATE\"  />"
														+ "			<col width=\"15%\" text=\"接受日期\" column=\"RECEIVEDATE\" orderkey=\"RECEIVEDATE\"  />"
														+ "			<col width=\"15%\" text=\"责任部门\" column=\"DEPARTMENT\" orderkey=\"DEPARTMENT\"  />"
														+ "			<col width=\"15%\" text=\"责任工序\" column=\"RESPONSIBLEPROCESS\" orderkey=\"RESPONSIBLEPROCESS\"  />"
														+ "			<col width=\"15%\" text=\"制造日期\" column=\"MFGDATE\" orderkey=\"MFGDATE\"  />"
														+ "			<col width=\"15%\" text=\"客户要求回复时间\" column=\"CUSTOMERREQUIRED8DREPLIED\" orderkey=\"CUSTOMERREQUIRED8DREPLIED\"  />"
														+ "			<col width=\"15%\" text=\"责任部门回复日期\" column=\"RESPONSEREPLYDATE\" orderkey=\"RESPONSEREPLYDATE\"  />"
														+ "			<col width=\"15%\" text=\"回复日期\" column=\"REPLYDATE\" orderkey=\"REPLYDATE\"  />"
														+ "			<col width=\"15%\" text=\"3D(hour)\" column=\"HOUR3D\" orderkey=\"HOUR3D\"  />"
														+ "			<col width=\"15%\" text=\"8D回复周期(day)\" column=\"HOUR8D\" orderkey=\"HOUR8D\"  />"
														+ "			<col width=\"15%\" text=\"处理责任人\" column=\"NAME\" orderkey=\"NAME\"  />"
														+ "			<col width=\"15%\" text=\"原因\" column=\"CAUSEANDCORRECTIVE\" orderkey=\"CAUSEANDCORRECTIVE\"  />"
														+ "			<col width=\"15%\" text=\"对策\" column=\"CAPA\" orderkey=\"CAPA\"  />"
														+ "			<col width=\"15%\" text=\"原因区分\" column=\"REASONDISTINGUISH\" orderkey=\"REASONDISTINGUISH\"  />"
														+ "			<col width=\"15%\" text=\"Repeat\" column=\"REPEAT\" orderkey=\"REPEAT\"  />"
														+ "			<col width=\"15%\" text=\"Excursion\" column=\"EXCURSION\" orderkey=\"EXCURSION\"  />"
														+ "			<col width=\"15%\" text=\"Low tech\" column=\"LOWTECH\" orderkey=\"LOWTECH\"  />"
														+ "			<col width=\"15%\" text=\"投诉场合\" column=\"POINTOFDETECTION\" orderkey=\"POINTOFDETECTION\"  />"
														+ "			<col width=\"15%\" text=\"效果确认预定日\" column=\"SCHEDULEDDATE\" orderkey=\"SCHEDULEDDATE\"  />"
														+ "			<col width=\"15%\" text=\"效果确认日\" column=\"ACTUALDATE\" orderkey=\"ACTUALDATE\"  />"
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
		
		window.onload = function(){  
			$("span:contains('接受日期:')").parent().children().find("span").eq(0).empty();
			$("span:contains('-')").next().find("span").eq(0).empty();
		};
	</script>
</BODY>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>