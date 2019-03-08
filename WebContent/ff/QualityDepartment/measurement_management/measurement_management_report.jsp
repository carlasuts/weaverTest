<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%> 
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
	int userID = user.getUID();	
	BaseBean bs = new BaseBean();
	bs.writeLog("userID:-----------"+userID);
	String sql ="select SUBCOMPANYID1  from hrmresource where id="+userID;
	rs.executeSql(sql);
	bs.writeLog("sql:-----------"+sql);
	rs.next();
	String subid= rs.getString("SUBCOMPANYID1");
	bs.writeLog("subid:-----------"+subid);
	String factory=" ";
	if(subid.equals("1")){
		factory ="0";
	}else if(subid.equals("142")){
		factory ="1";
	}else if(subid.equals("101")){
		factory ="2";
	}else {
		factory ="3";
	}
	bs.writeLog("factory:-----------"+factory);	
	String meterstarttime = Util.null2String(request.getParameter("meterstarttime"));
	String meterendtime = Util.null2String(request.getParameter("meterendtime"));
	String metereffectivestarttime = Util.null2String(request.getParameter("metereffectivestarttime"));
	String metereffectiveendtime = Util.null2String(request.getParameter("metereffectiveendtime"));
	String tbstarttime = Util.null2String(request.getParameter("tbstarttime"));
	String tbendtime = Util.null2String(request.getParameter("tbendtime"));
	String completestarttime = Util.null2String(request.getParameter("completestarttime"));
	String completeendtime = Util.null2String(request.getParameter("completeendtime"));
	String meterdatetype = Util.null2String(request.getParameter("meterdatetype"));
	String metereffectivedatetype = Util.null2String(request.getParameter("metereffectivedatetype"));
	String tbdatetype = Util.null2String(request.getParameter("tbdatetype"));
	String completedatetype = Util.null2String(request.getParameter("completedatetype"));		
	String sqlwhere = " where 1 = 1 and sbszcq = '" + factory + "' ";
	
	if(!meterstarttime.equals("")){
		sqlwhere += " and meteringdate >= '" + meterstarttime + "' ";
	}

	if(!meterendtime.equals("")){
		sqlwhere += " and meteringdate <= '" + meterendtime + "' ";
	}
		
	if(!metereffectivestarttime.equals("")){
		sqlwhere += " and meteringeffectivedate >= '" + metereffectivestarttime + "' ";
	}

	if(!metereffectiveendtime.equals("")){
		sqlwhere += " and meteringeffectivedate <= '" + metereffectiveendtime + "' ";
	}
	
	if(!tbstarttime.equals("")){
		sqlwhere += " and tbdate >= '" + tbstarttime + "' ";
	}

	if(!tbendtime.equals("")){
		sqlwhere += " and tbdate <= '" + tbendtime + "' ";
	}
	
	if(!completestarttime.equals("")){
		sqlwhere += " and completedate >= '" + completestarttime + "' ";
	}

	if(!completeendtime.equals("")){
		sqlwhere += " and completedate <= '" + completeendtime + "' ";
	}
 
	int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
	int perpage = 20;
%>

<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "计量管理报表";
	String needfav = "1";
	String needhelp = "";
%>
<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
	<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(197, user.getLanguage()) + ",javascript:doSearch(),_self} ";
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
								action="measurement_management_report.jsp" method=post>															
								<table width=100% class=ViewForm>									
									<tr>										
										<td NOWRAP width="6%" id = "meterDate">计量日期:&nbsp;&nbsp;
											<span class="wuiDateSpan" selectId="datetype2" selectValue="<%=meterdatetype%>"> 
											<input name="meterstarttime" id="meterstarttime" type="hidden" value="<%=meterstarttime%>" class="wuiDateSel">											 
											<input name="meterendtime" id="meterendtime" type="hidden"  value="<%=meterendtime%>" class="wuiDateSel">	
											</span>
										</td>
										<td NOWRAP width="6%">计量有效日期:&nbsp;&nbsp;
											<span class="wuiDateSpan" selectId="datetype1" selectValue="<%=metereffectivedatetype%>"> 
											<input name="metereffectivestarttime" id="metereffectivestarttime" type="hidden" value="<%=metereffectivestarttime%>" class="wuiDateSel">											
											<input name="metereffectiveendtime" id="metereffectiveendtime" type="hidden"  value="<%=metereffectiveendtime%>" class="wuiDateSel">	
											</span>
										</td>
										<td NOWRAP width="6%" id = "tbDate">填表日期:&nbsp;&nbsp;
											<span class="wuiDateSpan" selectId="datetype3" selectValue="<%=tbdatetype%>"> 
											<input name="tbstarttime" id="tbstarttime" type="hidden" value="<%=tbstarttime%>" class="wuiDateSel">											
											<input name="tbendtime" id="tbendtime" type="hidden"  value="<%=tbendtime%>" class="wuiDateSel">	
											</span>
										</td>
										<td NOWRAP width="6%" id = "completeDate">完成日期:&nbsp;&nbsp;
											<span class="wuiDateSpan" selectId="datetype4" selectValue="<%=completedatetype%>"> 
											<input name="completestarttime" id="completestarttime" type="hidden" value="<%=completestarttime%>" class="wuiDateSel">											
											<input name="completeendtime" id="completeendtime" type="hidden"  value="<%=completeendtime%>" class="wuiDateSel">	
											</span>
										</td>
										<td NOWRAP width="76%">
											<input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
											<input type="button" value="导出当前页" onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
											<input type="button" value="导出所有" onclick="javascript:_xtable_getAllExcel()">
										</td>
									</tr>									
								</table>								
								<TABLE width="100%">
									<tr>
										<td valign="top">
											<%
												String tableString = "";
												String backfields = "";
												String fromSql = "";
												String sqlWhere = "";
												String orderby = "";
												
												backfields = " id, meteringid, ";
												backfields += " (select lastname from hrmresource where id = tb.tbr) as tbr, tbdate, completedate, ";												
												backfields += " (select selectname FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -223 AND fieldname = 'usedepartment') and SELECTVALUE = TB.usedepartment) as usedepartment, ";
												backfields += " (select selectname FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -223 AND fieldname = 'managelevel') and SELECTVALUE = TB.managelevel) as managelevel, ";
												backfields += " (select selectname FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -223 AND fieldname = 'meteringtype') and SELECTVALUE = TB.meteringtype) as meteringtype, ";
												backfields += " (select selectname FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -223 AND fieldname = 'assetstype') and SELECTVALUE = TB.assetstype) as assetstype, ";
												backfields += " (select selectname FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -223 AND fieldname = 'managestate') and SELECTVALUE = TB.managestate) as managestate, ";
												backfields += " ccdate, grdate, ";												
												backfields += " (select lastname from hrmresource where id = tb.deviceresponsible) as deviceresponsible, ";												
												backfields += " deviceuser, measuresite, devicename, deviceid, devicemodel, measurerange, accuracy, maxallowerror, Manufacturer, ccid, ";
												backfields += " (select selectname FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -223 AND fieldname = 'calibrationunit') and SELECTVALUE = TB.calibrationunit) as calibrationunit, ";
												backfields += " ((select selectname FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -223 AND fieldname = 'meteringintervalperiod') and SELECTVALUE = TB.meteringintervalperiod) || '月') as meteringintervalperiod, ";												
												backfields += " meteringdate, meteringeffectivedate,";
												backfields += " (select selectname FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -223 AND fieldname = 'meteringresult') and SELECTVALUE = TB.meteringresult) as meteringresult, ";
												backfields += " (select selectname FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -223 AND fieldname = 'ifneedMSA') and SELECTVALUE = TB.ifneedMSA) as ifneedMSA, ";
												backfields += " meteringcost, remarks ";
												fromSql = " (SELECT (Case wrk.currentnodeid when 35873 then (select RECEIVEDATE from WORKFLOW_CURRENTOPERATOR where NODEID = wrk.currentnodeid and REQUESTID = frm.requestid ) else '' end) as completedate, ";
												fromSql += " frm.* from FORMTABLE_MAIN_223 frm LEFT JOIN WORKFLOW_REQUESTBASE wrk on frm.requestid = wrk.requestid) tb ";
												sqlWhere = sqlwhere;
												orderby = " id ";
												tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
												+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
												+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
												+ "\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
												+ "			<col width=\"130px\" text=\"计量编号\" column=\"meteringid\" orderkey=\"meteringid\"  />"
												+ "			<col width=\"80px\" text=\"填表人\" column=\"tbr\" orderkey=\"tbr\"  />"
												+ "			<col width=\"100px\" text=\"填表日期\" column=\"tbdate\" orderkey=\"tbdate\"  />"
												+ "			<col width=\"100px\" text=\"归档日期\" column=\"completedate\" orderkey=\"completedate\"  />"
												+ "			<col width=\"100px\" text=\"使用部门\" column=\"usedepartment\" orderkey=\"usedepartment\"  />"
												+ "			<col width=\"90px\" text=\"管理等级\" column=\"managelevel\" orderkey=\"managelevel\"  />"
												+ "			<col width=\"100px\" text=\"计量类别\" column=\"meteringtype\" orderkey=\"meteringtype\"  />"
												+ "			<col width=\"100px\" text=\"资产种类\" column=\"assetstype\" orderkey=\"assetstype\"  />"
												+ "			<col width=\"100px\" text=\"管理状态\" column=\"managestate\" orderkey=\"managestate\"  />"
												+ "			<col width=\"100px\" text=\"出厂日期\" column=\"ccdate\" orderkey=\"ccdate\"  />"
												+ "			<col width=\"100px\" text=\"购入日期\" column=\"grdate\" orderkey=\"grdate\"  />"
												+ "			<col width=\"100px\" text=\"设备责任人\" column=\"deviceresponsible\" orderkey=\"deviceresponsible\"  />"
												+ "			<col width=\"100px\" text=\"设备使用人\" column=\"deviceuser\" orderkey=\"deviceuser\"  />"
												+ "			<col width=\"100px\" text=\"测量地点\" column=\"measuresite\" orderkey=\"measuresite\"  />"
												+ "			<col width=\"100px\" text=\"设备名称\" column=\"devicename\" orderkey=\"devicename\"  />"
												+ "			<col width=\"100px\" text=\"设备编号\" column=\"deviceid\" orderkey=\"deviceid\"  />"
												+ "			<col width=\"100px\" text=\"设备型号\" column=\"devicemodel\" orderkey=\"devicemodel\"  />"
												+ "			<col width=\"100px\" text=\"测量范围\" column=\"measurerange\" orderkey=\"measurerange\"  />"
												+ "			<col width=\"100px\" text=\"准确度\" column=\"accuracy\" orderkey=\"accuracy\"  />"
												+ "			<col width=\"120px\" text=\"最大允许误差\" column=\"maxallowerror\" orderkey=\"maxallowerror\"  />"
												+ "			<col width=\"100px\" text=\"生产厂家\" column=\"Manufacturer\" orderkey=\"Manufacturer\"  />"
												+ "			<col width=\"120px\" text=\"出厂编号\" column=\"ccid\" orderkey=\"ccid\"  />"
												+ "			<col width=\"150px\" text=\"校准单位\" column=\"calibrationunit\" orderkey=\"calibrationunit\"  />"
												+ "			<col width=\"100px\" text=\"计量间隔周期\" column=\"meteringintervalperiod\" orderkey=\"meteringintervalperiod\"  />"
												+ "			<col width=\"100px\" text=\"计量日期\" column=\"meteringdate\" orderkey=\"meteringdate\"  />"
												+ "			<col width=\"100px\" text=\"计量有效日期\" column=\"meteringeffectivedate\" orderkey=\"meteringeffectivedate\"  />"
												+ "			<col width=\"100px\" text=\"计量结果\" column=\"meteringresult\" orderkey=\"meteringresult\"  />"
												+ "			<col width=\"100px\" text=\"是否需要MSA\" column=\"ifneedMSA\" orderkey=\"ifneedMSA\"  />"
												+ "			<col width=\"100px\" text=\"计量费用(元)\" column=\"meteringcost\" orderkey=\"meteringcost\"  />"
												+ "			<col width=\"100px\" text=\"备注\" column=\"remarks\" orderkey=\"remarks\"  />"
												+ "		</head>" + "		<operates width=\"10%\">";
											tableString += "		</operates>" + " </table>";													
											%> <wea:SplitPageTag tableString="<%=tableString%>" isShowTopInfo="false" mode="run" />
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
	</script>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>