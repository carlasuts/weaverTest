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
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_msacal.js"></script>
<%
	BaseBean bs = new BaseBean();
	int userID = user.getUID();	
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
	String MSAeffectivedatestarttime = Util.null2String(request.getParameter("MSAeffectivedatestarttime"));
	String MSAeffectivedateendtime = Util.null2String(request.getParameter("MSAeffectivedateendtime"));
	String MSAeffectivedatetype = Util.null2String(request.getParameter("MSAeffectivedatetype"));
	String sqlwhere = " where 1 = 1 and sbszcq = '"+factory+"' ";
	
	if(!MSAeffectivedatestarttime.equals("")){
		sqlwhere += " and MSAeffectivedate >= '" + MSAeffectivedatestarttime + "' ";
	}

	if(!MSAeffectivedateendtime.equals("")){
		sqlwhere += " and MSAeffectivedate <= '" + MSAeffectivedateendtime + "' ";
	}
	
	sqlwhere += " and a.devicetype = 'MSA' ";

	int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
	int perpage = 20;
%>

<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "测量系统分析超期查询报表";
	String needfav = "1";
	String needhelp = "";
%>
<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
	<%
		RCMenu += "{" + SystemEnv.getHtmlLabelName(197, user.getLanguage()) + ",javascript:doSearch(),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		RCMenu += "{导出当前页,javascript:_xtable_getExcel(),_self} " ;
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
								action="MSA_ReportForm_OverdueQuery.jsp" method=post>								
								<table width=100% class=ViewForm>
									
									<tr>
									
										<td NOWRAP width='7%'>MSA有效日期:&nbsp;&nbsp;
											<span class="wuiDateForMsaCalSpan" selectId="datetype" selectValue="<%=MSAeffectivedatetype%>"> 
											<input name="MSAeffectivedatestarttime" id="MSAeffectivedatestarttime" type="hidden" value="<%=MSAeffectivedatestarttime%>" class="wuiDateSel">											
											<input name="MSAeffectivedateendtime" id="MSAeffectivedateendtime" type="hidden"  value="<%=MSAeffectivedateendtime%>" class="wuiDateSel">	
											</span>
										</td>
										
										
										<td NOWRAP width='93%'>
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
												
												backfields = " meteringid, (select lastname from hrmresource where id =tbr) as tbrname, tbdate, receivedate, ccdate, grdate, (select lastname from hrmresource where id =MSAzrr) as MSAzrrname, measuresite," +
												" devicename, a.deviceid as deviceid, devicemodel, measurerange, accuracy, maxallowerror, Manufacturer, ccid, MSAdate, MSAeffectivedate, remarks," +
												" (select selectname  from workflow_selectitem  where fieldid = (select id from workflow_billfield where billid = -224 and fieldname = 'usedepartment') and selectvalue = b.usedepartment) as usedepartment," +
												" (select selectname  from workflow_selectitem  where fieldid = (select id from workflow_billfield where billid = -224 and fieldname = 'managelevel') and selectvalue = b.managelevel) as managelevel," +
												" (select selectname  from workflow_selectitem  where fieldid = (select id from workflow_billfield where billid = -224 and fieldname = 'meteringtype') and selectvalue = b.meteringtype) as meteringtype," +
												" (select selectname  from workflow_selectitem  where fieldid = (select id from workflow_billfield where billid = -224 and fieldname = 'assetstype') and selectvalue = b.assetstype) as assetstype," +
												" (select selectname  from workflow_selectitem  where fieldid = (select id from workflow_billfield where billid = -224 and fieldname = 'managestate') and selectvalue = b.managestate) as managestate," +
												" ((select selectname  from workflow_selectitem  where fieldid = (select id from workflow_billfield where billid = -224 and fieldname = 'MSAinterval') and selectvalue = b.MSAinterval)||'月') as MSAinterval," +
												" (select selectname  from workflow_selectitem  where fieldid = (select id from workflow_billfield where billid = -224 and fieldname = 'MSAresult') and selectvalue = b.MSAresult) as MSAresult";
												fromSql = " device_valid_inf a left join formtable_main_224 b on (a.requestid = b.requestid) left join workflow_currentOperator c on (a.requestid=c.requestid and c.nodeid='36360') ";
												sqlWhere = sqlwhere;
												orderby = " a.id ";
												tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
												+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
												+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
												+ "\"  sqlprimarykey=\"a.deviceid\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
												+ "			<col width=\"130px\" text=\"计量编号\" column=\"meteringid\" orderkey=\"meteringid\"  />"
												+ "			<col width=\"80px\" text=\"填表人\" column=\"tbrname\" orderkey=\"tbrname\"  />"
												+ "			<col width=\"100px\" text=\"填表日期\" column=\"tbdate\" orderkey=\"tbdate\"  />"
												+ "			<col width=\"100px\" text=\"归档日期\" column=\"receivedate\" orderkey=\"receivedate\"  />"
												+ "			<col width=\"100px\" text=\"使用部门\" column=\"usedepartment\" orderkey=\"usedepartment\"  />"
												+ "			<col width=\"90px\" text=\"管理等级\" column=\"managelevel\" orderkey=\"managelevel\"  />"
												+ "			<col width=\"100px\" text=\"计量类别\" column=\"meteringtype\" orderkey=\"meteringtype\"  />"
												+ "			<col width=\"100px\" text=\"资产种类\" column=\"assetstype\" orderkey=\"assetstype\"  />"
												+ "			<col width=\"100px\" text=\"管理状态\" column=\"managestate\" orderkey=\"managestate\"  />"
												+ "			<col width=\"100px\" text=\"出厂日期\" column=\"ccdate\" orderkey=\"ccdate\"  />"
												+ "			<col width=\"100px\" text=\"购入日期\" column=\"grdate\" orderkey=\"grdate\"  />"
												+ "			<col width=\"100px\" text=\"MSA责任人\" column=\"MSAzrrname\" orderkey=\"MSAzrrname\"  />"
												+ "			<col width=\"100px\" text=\"测量地点\" column=\"measuresite\" orderkey=\"measuresite\"  />"
												+ "			<col width=\"100px\" text=\"设备名称\" column=\"devicename\" orderkey=\"devicename\"  />"
												+ "			<col width=\"100px\" text=\"设备编号\" column=\"deviceid\" orderkey=\"deviceid\"  />"
												+ "			<col width=\"100px\" text=\"设备型号\" column=\"devicemodel\" orderkey=\"devicemodel\"  />"
												+ "			<col width=\"100px\" text=\"测量范围\" column=\"measurerange\" orderkey=\"measurerange\"  />"
												+ "			<col width=\"100px\" text=\"准确度\" column=\"accuracy\" orderkey=\"accuracy\"  />"
												+ "			<col width=\"120px\" text=\"最大允许误差\" column=\"maxallowerror\" orderkey=\"maxallowerror\"  />"
												+ "			<col width=\"100px\" text=\"生产厂家\" column=\"Manufacturer\" orderkey=\"Manufacturer\"  />"
												+ "			<col width=\"120px\" text=\"出厂编号\" column=\"ccid\" orderkey=\"ccid\"  />"
												+ "			<col width=\"120px\" text=\"MSA间隔周期\" column=\"MSAinterval\" orderkey=\"MSAinterval\"  />"
												+ "			<col width=\"100px\" text=\"MSA日期\" column=\"MSAdate\" orderkey=\"MSAdate\"  />"
												+ "			<col width=\"100px\" text=\"MSA有效日期\" column=\"MSAeffectivedate\" orderkey=\"MSAeffectivedate\"  />"
												+ "			<col width=\"100px\" text=\"MSA结果\" column=\"MSAresult\" orderkey=\"MSAresult\"  />"
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
	
		function doSearch() {
			document.frmmain.submit();
		}		
		
	</script>
</body>
</html>