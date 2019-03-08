<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@page import="weaver.general.BaseBean"%> 
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
	String test_classification = Util.null2String(request.getParameter("test_classification"));
	String sbbh = Util.null2String(request.getParameter("sbbh"));
	String gx = Util.null2String(request.getParameter("gx"));
	String djz = Util.null2String(request.getParameter("djz"));
	String pd = Util.null2String(request.getParameter("re"));
	String result = Util.null2String(request.getParameter("re"));
	String djjg = Util.null2String(request.getParameter("re"));
	String pdjg = Util.null2String(request.getParameter("re"));
	String starttime = Util.null2String(request.getParameter("starttime"));
	String endtime = Util.null2String(request.getParameter("endtime"));
	String stat = Util.null2String(request.getParameter("stat"));
	String zhdjsj = Util.null2String(request.getParameter("zhdjsj"));
	String djpl = Util.null2String(request.getParameter("djpl"));
	String sqlwhere = " where 1 = 1 ";

	if (!sbbh.equals("")) {
		sqlwhere += " and sbbh like '%" + sbbh + "%'";
	}

	if (!gx.equals("")) {
		sqlwhere += " and gx like '%" + gx + "%'";
	}
	
	if (!djz.equals("")) {
		sqlwhere += " and djz like '%" + djz + "%'";
	}
	
	if(!starttime.equals("")){
		sqlwhere += " and djrq >= '" + starttime + "' ";
	}

	if(!endtime.equals("")){
		sqlwhere += " and djrq <= '" + endtime + "' ";
	}
	
	if (test_classification!=null&&!test_classification.equals("")){
		int t = Integer.valueOf(test_classification);
		if (t == 0 || t == 1 || t == 2) {
			if (!pd.equals("")) {
				sqlwhere += " and pd = '" + pd + "'";
			}
		} else if (t == 3) {
			if (!result.equals("")){
				sqlwhere += " and result = '" + result + "'";
			}
		} else if (t == 4) {
			if (!djjg.equals("")){
				sqlwhere += " and djjg = '" + djjg + "'";
			}
		} else {
			if (!pdjg.equals("")){
				sqlwhere += " and pdjg = '" + pdjg + "'";
			}
		}
	}
	
	if (!stat.equals("")) {
		int status = Integer.valueOf(stat);
		if (status == 0) {
			sqlwhere += " and zhdjsj >= to_char((sysdate - djpl),'yyyy-mm-dd')";
		} else if (status == 1) {
			sqlwhere += " and zhdjsj < to_char((sysdate - djpl),'yyyy-mm-dd')";
		}
	}

 
	int pagenum = Util.getIntValue(request.getParameter("pagenum"), 1);
	int perpage = 20;
%>

<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "工作台点检报表";
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
								action="point_inspection.jsp" method=post>
								<%
									int test = 0;
									if(test_classification!=null&&!test_classification.equals("")){
										test= Integer.valueOf(test_classification);
									}								
								%>
								<table width=100% class=ViewForm>
									<colgroup>
										<col width="16%">
										<col width="16%">
									<TR>
										<td NOWRAP width='5%'>点检设备:</td>
										<td class=FIELD width='10%'>
										<select id='test_classification'name='test_classification'>
											<option value="0">工作台</option> 
											<option value="1">货架</option> 
											<option value="2">推车</option>
											<option value="3">离子风扇</option>
											<option value="4">防静电接地线/桩接地电阻</option>
											<option value="5">静电源&产品静电压</option>
											<option value="6">656-离子风扇</option>
										</select>
										</td>
										<td NOWRAP width='5%'>编号</td>
										<td class=FIELD width='10%'><input type=text id='sbbh'
											name='sbbh' value='<%=sbbh%>'></td>
										<td NOWRAP width='5%'>工序</td>
										<td class=FIELD width='10%'><input type=text id='gx'
											name='gx' value='<%=gx%>'></td>
										<td NOWRAP width='5%'>点检者</td>
										<td class=FIELD width='10%'><input type=text id='djz'
											name='djz' value='<%=djz%>'></td>
										</TR>
										
										<TR>
										<td class=FIELD width='20%'>
											<span>选择查询时间:</span>
											<span class="wuiDateSpan" selectId="datetype1" selectValue="6"> 
											<input name="starttime" id="starttime" type="hidden" value="<%=starttime%>" class="wuiDateSel">
											</span>
											<span>-</span>
											<span class="wuiDateSpan" selectId="datetype2"  selectValue="6"> 
											<input name="endtime" id="endtime" type="hidden"  value="<%=endtime%>" class="wuiDateSel">	
											</span>
										</td>
										<td NOWRAP width='5%'>判定结果</td>
										<td class=FIELD width='10%'>
										<select id='re' name='re'>
											<option value=""></option>
											<option value="OK">OK</option>
											<option value="NG">NG</option>
										</select>
										</td><td NOWRAP width='5%'>点检状态</td>
										<td class=FIELD width='10%'>
										<select id='stat' name='stat'>
											<option value=""></option>
											<option value="0">已点检</option>
											<option value="1">未点检</option>
										</select>
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
								<TABLE width="100%">
									<tr>
										<td valign="top">
											<%
												String tableString = "";
												String backfields = "";
												String fromSql = "";
												String sqlWhere = "";
												String orderby = "";
												if (test == 0) {
													backfields = " gx, xm, c.fb as fb, c.qb as qb, sbbh as bh, ywtd, jddzz, ddddzz, sfcldz, jdlxdzz, pd, wtcz, djdd, djrq, djz, djpl, zhdjsj ";
													fromSql = " ( select b.id, gx, case xm when 0 then '工作台' end as xm, case fb when 0 then '崇川' when 1 then '合肥' when 2 then '苏通' end as fb, case qb when 0 then 'A1' when 1 then 'T1' when 2 then 'A2' when 3 then 'T2' when 4 then 'A3' when 5 then 'T3' when 6 then '技术中心' when 7 then '动力部' when 8 then '合肥' when 9 then '苏通' when 10 then '2.5期' end as qb, gzt as bh, case ywtd when 0 then 'Y' when 1 then 'N' end as ywtd, jddzz, ddddzz, case sfcldz when 0 then 'Y' when 1 then 'N' end as sfcldz, jdlxdzz, case pd when 0 then 'OK' when 1 then 'NG' end as pd, wtcz, djdd, djrq, djz from formtable_main_173_dt1 a, ( select fm173.id, fm173.gztgx as gx, fm173.xm, fm173.fb, fm173.qb, fm173.wtcz, fm173.djdd, fm173.djrq, hrm.lastname as djz from formtable_main_173 fm173 left join hrmresource hrm on fm173.djz = hrm. id ) b where a .mainid = b. id) c left join sbdjxx on c.bh = sbdjxx.id ";
													sqlWhere = sqlwhere;
													orderby = " c.id ";
													tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"c.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"测试工序\" column=\"gx\" orderkey=\"gx\"  />"
														+ "			<col width=\"15%\" text=\"测试项目\" column=\"xm\" orderkey=\"xm\"  />"
														+ "			<col width=\"15%\" text=\"分部\" column=\"fb\" orderkey=\"fb\"  />"
														+ "			<col width=\"15%\" text=\"期别\" column=\"qb\" orderkey=\"qb\"  />"
														+ "			<col width=\"15%\" text=\"工作台编号\" column=\"bh\" orderkey=\"bh\"  />"
														+ "			<col width=\"15%\" text=\"有无台垫\" column=\"ywtd\" orderkey=\"ywtd\"  />"
														+ "			<col width=\"15%\" text=\"接地电阻值\" column=\"jddzz\" orderkey=\"jddzz\"  />"
														+ "			<col width=\"15%\" text=\"点对点电阻值\" column=\"ddddzz\" orderkey=\"ddddzz\"  />"
														+ "			<col width=\"15%\" text=\"是否有接地线\" column=\"sfcldz\" orderkey=\"sfcldz\"  />"
														+ "			<col width=\"15%\" text=\"接地连线电阻值\" column=\"jdlxdzz\" orderkey=\"jdlxdzz\"  />"
														+ "			<col width=\"15%\" text=\"判定\" column=\"pd\" orderkey=\"pd\"  />"
														+ "			<col width=\"15%\" text=\"问题处置\" column=\"wtcz\" orderkey=\"wtcz\"  />"
														+ "			<col width=\"15%\" text=\"点检地点\" column=\"djdd\" orderkey=\"djdd\"  />"
														+ "			<col width=\"15%\" text=\"点检日期\" column=\"djrq\" orderkey=\"djrq\"  />"
														+ "			<col width=\"15%\" text=\"点检者\" column=\"djz\" orderkey=\"djz\"  />"
														+ "		</head>" + "		<operates width=\"10%\">";
													tableString += "		</operates>" + " </table>";
												} else if (test == 1) {
													backfields = " gx, xm, c.fb as fb, c.qb as qb, sbbh as bh, ywtd, jddzz, ddddzz, sfcldz, jdlxdzz, pd, wtcz, djdd, djrq, djz, djpl, zhdjsj ";
													fromSql = " ( select b.id, gx, case xm when 1 then '货架' end as xm, case fb when 0 then '崇川' when 1 then '合肥' when 2 then '苏通' end as fb, case qb when 0 then 'A1' when 1 then 'T1' when 2 then 'A2' when 3 then 'T2' when 4 then 'A3' when 5 then 'T3' when 6 then '技术中心' when 7 then '动力部' when 8 then '合肥' when 9 then '苏通' when 10 then '2.5期' end as qb, hj as bh, case ywtd when 0 then 'Y' when 1 then 'N' end as ywtd, jddzz, ddddzz, case sfcldz when 0 then 'Y' when 1 then 'N' end as sfcldz, jdlxdzz, case pd when 0 then 'OK' when 1 then 'NG' end as pd, wtcz, djdd, djrq, djz from formtable_main_174_dt2 a, ( select fm174.id, fm174.hjgx as gx, fm174.xm, fm174.fb, fm174.qb, fm174.wtcz, fm174.djdd, fm174.djrq, hrm.lastname as djz from formtable_main_174 fm174 left join hrmresource hrm on fm174.djz = hrm. id ) b where b. id = a .mainid) c left join sbdjxx on c.bh = sbdjxx.id ";
													sqlWhere = sqlwhere;
													orderby = " c.id ";
													tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"c.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"测试工序\" column=\"gx\" orderkey=\"gx\"  />"
														+ "			<col width=\"15%\" text=\"测试项目\" column=\"xm\" orderkey=\"xm\"  />"
														+ "			<col width=\"15%\" text=\"分部\" column=\"fb\" orderkey=\"fb\"  />"
														+ "			<col width=\"15%\" text=\"期别\" column=\"qb\" orderkey=\"qb\"  />"
														+ "			<col width=\"15%\" text=\"货架编号\" column=\"bh\" orderkey=\"bh\"  />"
														+ "			<col width=\"15%\" text=\"有无台垫\" column=\"ywtd\" orderkey=\"ywtd\"  />"
														+ "			<col width=\"15%\" text=\"接地电阻值\" column=\"jddzz\" orderkey=\"jddzz\"  />"
														+ "			<col width=\"15%\" text=\"点对点电阻值\" column=\"ddddzz\" orderkey=\"ddddzz\"  />"
														+ "			<col width=\"15%\" text=\"是否有接地线\" column=\"sfcldz\" orderkey=\"sfcldz\"  />"
														+ "			<col width=\"15%\" text=\"接地连线电阻值\" column=\"jdlxdzz\" orderkey=\"jdlxdzz\"  />"
														+ "			<col width=\"15%\" text=\"判定\" column=\"pd\" orderkey=\"pd\"  />"
														+ "			<col width=\"15%\" text=\"问题处置\" column=\"wtcz\" orderkey=\"wtcz\"  />"
														+ "			<col width=\"15%\" text=\"点检地点\" column=\"djdd\" orderkey=\"djdd\"  />"
														+ "			<col width=\"15%\" text=\"点检日期\" column=\"djrq\" orderkey=\"djrq\"  />"
														+ "			<col width=\"15%\" text=\"点检者 \" column=\"djz\" orderkey=\"djz\"  />"
														+ "		</head>" + "		<operates width=\"10%\">";
													tableString += "		</operates>" + " </table>";
												} else if (test == 2) {
													backfields = " gx, xm, c.qb as qb, c.fb as fb, sbbh as bh, ywtd, jddzz, ddddzz, jdlddlqj, pd, wtcz, djdd, djrq, djz, djpl, zhdjsj ";
													fromSql = " ( select b.id, gx, case xm when 2 then '推车' end as xm, case fb when 0 then '崇川' when 1 then '合肥' when 2 then '苏通' end as fb, case qb when 0 then 'A1' when 1 then 'T1' when 2 then 'A2' when 3 then 'T2' when 4 then 'A3' when 5 then 'T3' when 6 then '技术中心' when 7 then '动力部' when 8 then '合肥' when 9 then '苏通' when 10 then '2.5期' end as qb, tc as bh, case ywtd when 0 then 'Y' when 1 then 'N' end as ywtd, jddzz, ddddzz, case jdlddlqj when 0 then 'Y' when 1 then 'N' end as jdlddlqj, case pd when 0 then 'OK' when 1 then 'NG' end as pd, wtcz, djdd, djrq, djz from formtable_main_179_dt3 a, ( select fm179.id, fm179.tcgx as gx, fm179.xm, fm179.fb, fm179.qb, fm179.wtcz, fm179.djdd, fm179.djrq, hrm.lastname as djz from formtable_main_179 fm179 left join hrmresource hrm on fm179.djz = hrm. id ) b where b. id = a .mainid ) c left join sbdjxx on c.bh = sbdjxx. id ";
													sqlWhere = sqlwhere;
													orderby = " c.id ";
													tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"c.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"测试工序\" column=\"gx\" orderkey=\"gx\"  />"
														+ "			<col width=\"15%\" text=\"测试项目\" column=\"xm\" orderkey=\"xm\"  />"
														+ "			<col width=\"15%\" text=\"分部\" column=\"fb\" orderkey=\"fb\"  />"
														+ "			<col width=\"15%\" text=\"期别\" column=\"qb\" orderkey=\"qb\"  />"
														+ "			<col width=\"15%\" text=\"推车编号\" column=\"bh\" orderkey=\"bh\"  />"
														+ "			<col width=\"15%\" text=\"有无台垫\" column=\"ywtd\" orderkey=\"ywtd\"  />"
														+ "			<col width=\"15%\" text=\"接地电阻值\" column=\"jddzz\" orderkey=\"jddzz\"  />"
														+ "			<col width=\"15%\" text=\"点对点电阻值\" column=\"ddddzz\" orderkey=\"ddddzz\"  />"
														+ "			<col width=\"15%\" text=\"接地链/导电轮清洁\" column=\"jdlddlqj\" orderkey=\"jdlddlqj\"  />"
														+ "			<col width=\"15%\" text=\"判定\" column=\"pd\" orderkey=\"pd\"  />"
														+ "			<col width=\"15%\" text=\"问题处置\" column=\"wtcz\" orderkey=\"wtcz\"  />"
														+ "			<col width=\"15%\" text=\"点检地点\" column=\"djdd\" orderkey=\"djdd\"  />"
														+ "			<col width=\"15%\" text=\"点检日期\" column=\"djrq\" orderkey=\"djrq\"  />"
														+ "			<col width=\"15%\" text=\"点检者 \" column=\"djz\" orderkey=\"djz\"  />"
														+ "		</head>" + "		<operates width=\"10%\">";
													tableString += "		</operates>" + " </table>";
												} else if (test == 3) {
													backfields = " gx, xm, e.fb as fb, e.qb as qb, jh, sbbh as bh, process, xh, jhdjrq, sjdjrq, selectname as measure_distance, clean_adjust, ywzw, fspd, pdjcsfwh, plus_1, plus_2, plus_3, minus_1, minus_2, minus_3, balanced_voltages, result, wtcz, djdd, djrq, djz ";
													fromSql = " ( select c.id, gx, xm, fb, qb, jh, lzfs, process, xh, jhdjrq, sjdjrq, selectname, clean_adjust, ywzw, fspd, pdjcsfwh, plus_1, plus_2, plus_3, minus_1, minus_2, minus_3, balanced_voltages, result, wtcz, djdd, djrq, djz from ( select b.id, gx, xm, case fb when 0 then '崇川' when 1 then '合肥' when 2 then '苏通' end as fb, case qb when 0 then 'A1' when 1 then 'T1' when 2 then 'A2' when 3 then 'T2' when 4 then 'A3' when 5 then 'T3' when 6 then '技术中心' when 7 then '动力部' when 8 then '合肥' when 9 then '苏通' when 10 then '2.5期' end as qb, jh, lzfs, process, xh, jhdjrq, sjdjrq, measure_distance, case clean_adjust when 0 then 'pm前' when 1 then 'pm后' end as clean_adjust, case ywzw when 1 then 'OK' when 0 then 'NG' end as ywzw, case fspd when 0 then 'OK' when 1 then 'NG' end as fspd, case pdjcsfwh when 0 then 'OK' when 1 then 'NG' end as pdjcsfwh, plus_1, plus_2, plus_3, minus_1, minus_2, minus_3, balanced_voltages, case result when 0 then 'OK' when 1 then 'NG' end as result, wtcz, djdd, djrq, djz from formtable_main_177_dt4 a, ( select fm177.id, fm177.csgx as gx, fm177.xm, fm177.fb, fm177.qb, fm177.wtcz, fm177.djdd, fm177.djrq, hrm.lastname as djz from formtable_main_177 fm177 left join hrmresource hrm on fm177.djz = hrm. id ) b where a .mainid = b. id ) c left join ( select selectname, selectvalue from workflow_selectitem where fieldid = ( select id from workflow_billfield where billid =- 89 and fieldname = 'measure_distance' ) ) d on d .selectvalue = c.measure_distance ) e left join sbdjxx on e .lzfs = sbdjxx. id ";
													sqlWhere = sqlwhere;
													orderby = " e.id ";
													tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"e.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"测试工序\" column=\"gx\" orderkey=\"gx\"  />"
														+ "			<col width=\"15%\" text=\"测试项目\" column=\"xm\" orderkey=\"xm\"  />"
														+ "			<col width=\"15%\" text=\"分部\" column=\"fb\" orderkey=\"fb\"  />"
														+ "			<col width=\"15%\" text=\"期别\" column=\"qb\" orderkey=\"qb\"  />"
														+ "			<col width=\"15%\" text=\"机号\" column=\"jh\" orderkey=\"jh\"  />"
														+ "			<col width=\"15%\" text=\"编号\" column=\"bh\" orderkey=\"bh\"  />"
														+ "			<col width=\"15%\" text=\"安装工序\" column=\"process\" orderkey=\"process\"  />"
														+ "			<col width=\"15%\" text=\"型号\" column=\"xh\" orderkey=\"xh\"  />"
														+ "			<col width=\"15%\" text=\"计划点检日期\" column=\"jhdjrq\" orderkey=\"jhdjrq\"  />"
														+ "			<col width=\"15%\" text=\"实际点检日期\" column=\"sjdjrq\" orderkey=\"sjdjrq\"  />"
														+ "			<col width=\"15%\" text=\"测量距离\" column=\"measure_distance\" orderkey=\"measure_distance\"  />"
														+ "			<col width=\"15%\" text=\"清洁调试\" column=\"clean_adjust\" orderkey=\"clean_adjust\"  />"
														+ "			<col width=\"15%\" text=\"电极、风扇、栅格、机身是否脏\" column=\"ywzw\" orderkey=\"ywzw\"  />"
														+ "			<col width=\"15%\" text=\"风扇转动\" column=\"fspd\" orderkey=\"fspd\"  />"
														+ "			<col width=\"15%\" text=\"飘带点检\" column=\"pdjcsfwh\" orderkey=\"pdjcsfwh\"  />"
														+ "			<col width=\"15%\" text=\"+1000V→+100V_1\" column=\"plus_1\" orderkey=\"plus_1\"  />"
														+ "			<col width=\"15%\" text=\"+1000V→+100V_2\" column=\"plus_2\" orderkey=\"plus_2\"  />"
														+ "			<col width=\"15%\" text=\"+1000V→+100V_3\" column=\"plus_3\" orderkey=\"plus_3\"  />"
														+ "			<col width=\"15%\" text=\"-1000V→-100V_1\" column=\"minus_1\" orderkey=\"minus_1\"  />"
														+ "			<col width=\"15%\" text=\"-1000V→-100V_2\" column=\"minus_2\" orderkey=\"minus_2\"  />"
														+ "			<col width=\"15%\" text=\"-1000V→-100V_3\" column=\"minus_3\" orderkey=\"minus_3\"  />"
														+ "			<col width=\"15%\" text=\"平衡电压\" column=\"balanced_voltages\" orderkey=\"balanced_voltages\"  />"
														+ "			<col width=\"15%\" text=\"测量结果\" column=\"result\" orderkey=\"result\"  />"
														+ "			<col width=\"15%\" text=\"问题处置\" column=\"wtcz\" orderkey=\"wtcz\"  />"
														+ "			<col width=\"15%\" text=\"点检地点\" column=\"djdd\" orderkey=\"djdd\"  />"
														+ "			<col width=\"15%\" text=\"点检日期\" column=\"djrq\" orderkey=\"djrq\"  />"
														+ "			<col width=\"15%\" text=\"点检人\" column=\"djz\" orderkey=\"djz\"  />"
														+ "		</head>" + "		<operates width=\"10%\">";
													tableString += "		</operates>" + " </table>";
												} else if (test == 4) {
													backfields = " xm, fb, qb, djdd, djrq, lastname as djz, djjg, wtcz ";
													fromSql = " ( select id, case xm when 5 then '防静电接地线/桩接地电阻' end as xm, case fb when 0 then '崇川' when 1 then '合肥' when 2 then '苏通' end as fb, case qb when 0 then 'A1' when 1 then 'T1' when 2 then 'A2' when 3 then 'T2' when 4 then 'A3' when 5 then 'T3' when 6 then '技术中心' when 7 then '动力部' when 8 then '合肥' when 9 then '苏通' when 10 then '2.5期' end as qb, djdd, djrq, djz, djjg, wtcz from formtable_main_175 where xm = 5 ) a left join hrmresource hrm on a .djz = hrm. id";
													sqlWhere = sqlwhere;
													orderby = " a.id ";
													tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"点检项目\" column=\"xm\" orderkey=\"xm\"  />"
														+ "			<col width=\"15%\" text=\"分部\" column=\"fb\" orderkey=\"fb\"  />"
														+ "			<col width=\"15%\" text=\"期别\" column=\"qb\" orderkey=\"qb\"  />"
														+ "			<col width=\"15%\" text=\"点检地点\" column=\"djdd\" orderkey=\"djdd\"  />"
														+ "			<col width=\"15%\" text=\"点检日期\" column=\"djrq\" orderkey=\"djrq\"  />"
														+ "			<col width=\"15%\" text=\"点检者\" column=\"djz\" orderkey=\"djz\"  />"
														+ "			<col width=\"15%\" text=\"点检结果\" column=\"djjg\" orderkey=\"djjg\"  />"
														+ "			<col width=\"15%\" text=\"问题处理\" column=\"wtcz\" orderkey=\"wtcz\"  />"
														+ "		</head>" + "		<operates width=\"10%\">";
													tableString += "		</operates>" + " </table>";
												} else if (test == 5) {
													backfields = " gx, xm, e.fb as fb, e.qb as qb, bmjd, sbbh as csgx, jdycp, clz, jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz, zhdjsj, djpl ";
													fromSql = " ( select x.id, gx, y.selectname as xm, fb, qb, bmjd, jdcp, jdycp, clz, jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz from ( select c.id, gx, xm, fb, qb, bmjd, jdcp, jdycp, clz, jl, selectname as bzpd, case pdjg when 0 then 'OK' when 1 then 'NG' end as pdjg, bz, wtcz, djdd, djrq, djz from ( select a.id, csgx as gx, xm, fb, qb, bmjd, jdcp, a .jdycp as jdycp, clz, case jl when 0 then '1cm' when 1 then '2.5cm' when 2 then '30cm' end as jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz from formtable_main_176_dt6 a, ( select fm176.id, csgx, xm, case fb when 0 then '崇川' when 1 then '合肥' when 2 then '苏通' end as fb, case qb when 0 then 'A1' when 1 then 'T1' when 2 then 'A2' when 3 then 'T2' when 4 then 'A3' when 5 then 'T3' when 6 then '技术中心' when 7 then '动力部' when 8 then '合肥' when 9 then '苏通' when 10 then '2.5期' end as qb, jdycp, wtcz, djdd, djrq, lastname as djz from formtable_main_176 fm176, hrmresource hrm where fm176.djz = hrm.id ) b where a.mainid = b.id ) c left join ( select * from workflow_selectitem where fieldid = ( select id from workflow_billfield where billid =-176 and fieldname = 'bzpd' ) ) d on d .selectvalue = c.bzpd ) x left join ( select * from workflow_selectitem where fieldid = ( select id from workflow_billfield where billid =-176 and fieldname = 'xm' ) ) y on y.selectvalue = x.xm ) e left join sbdjxx on e.jdcp = sbdjxx. id ";
													sqlWhere = sqlwhere;
													orderby = " e.id ";
													tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"e.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														
														+ "			<col width=\"15%\" text=\"测试工序\" column=\"gx\" orderkey=\"gx\"  />"
														+ "			<col width=\"15%\" text=\"测试项目\" column=\"xm\" orderkey=\"xm\"  />"
														+ "			<col width=\"15%\" text=\"分部\" column=\"fb\" orderkey=\"fb\"  />"
														+ "			<col width=\"15%\" text=\"期别\" column=\"qb\" orderkey=\"qb\"  />"
														+ "			<col width=\"15%\" text=\"部门\" column=\"bmjd\" orderkey=\"bmjd\"  />"
														+ "			<col width=\"15%\" text=\"工序\" column=\"csgx\" orderkey=\"csgx\"  />"
														+ "			<col width=\"15%\" text=\"静电源/产品\" column=\"jdycp\" orderkey=\"jdycp\"  />"
														+ "			<col width=\"15%\" text=\"测量值\" column=\"clz\" orderkey=\"clz\"  />"
														+ "			<col width=\"15%\" text=\"距离\" column=\"jl\" orderkey=\"jl\"  />"
														+ "			<col width=\"15%\" text=\"标准\" column=\"bzpd\" orderkey=\"bzpd\"  />"
														+ "			<col width=\"15%\" text=\"判定结果\" column=\"pdjg\" orderkey=\"pdjg\"  />"
														+ "			<col width=\"15%\" text=\"备注\" column=\"bz\" orderkey=\"bz\"  />"
														+ "			<col width=\"15%\" text=\"问题处置\" column=\"wtcz\" orderkey=\"wtcz\"  />"
														+ "			<col width=\"15%\" text=\"点检地点\" column=\"djdd\" orderkey=\"djdd\"  />"
														+ "			<col width=\"15%\" text=\"点检日期\" column=\"djrq\" orderkey=\"djrq\"  />"
														+ "			<col width=\"15%\" text=\"点检者\" column=\"djz\" orderkey=\"djz\"  />"
														+ "		</head>" + "		<operates width=\"10%\">";
													tableString += "		</operates>" + " </table>";
												} else {
													backfields = " gx, xm, e.fb as fb, e.qb as qb, jh, sbbh as bh, process, xh, jhdjrq, sjdjrq, selectname as measure_distance, clean_adjust, ywzw, fspd, pdjcsfwh, plus_1, plus_2, plus_3, minus_1, minus_2, minus_3, balanced_voltages, result, wtcz, djdd, djrq, djz ";
													fromSql = " ( select c.id, gx, xm, fb, qb, jh, lzfs, process, xh, jhdjrq, sjdjrq, selectname, clean_adjust, ywzw, fspd, pdjcsfwh, plus_1, plus_2, plus_3, minus_1, minus_2, minus_3, balanced_voltages, result, wtcz, djdd, djrq, djz from ( select b.id, gx, xm, case fb when 0 then '崇川' when 1 then '合肥' when 2 then '苏通' end as fb, case qb when 0 then 'A1' when 1 then 'T1' when 2 then 'A2' when 3 then 'T2' when 4 then 'A3' when 5 then 'T3' when 6 then '技术中心' when 7 then '动力部' when 8 then '合肥' when 9 then '苏通' when 10 then '2.5期' end as qb, jh, lzfs, process, xh, jhdjrq, sjdjrq, measure_distance, case clean_adjust when 0 then 'pm前' when 1 then 'pm后' end as clean_adjust, case ywzw when 1 then 'OK' when 0 then 'NG' end as ywzw, case fspd when 0 then 'OK' when 1 then 'NG' end as fspd, case pdjcsfwh when 0 then 'OK' when 1 then 'NG' end as pdjcsfwh, plus_1, plus_2, plus_3, minus_1, minus_2, minus_3, balanced_voltages, case result when 0 then 'OK' when 1 then 'NG' end as result, wtcz, djdd, djrq, djz from formtable_main_180_dt4 a, ( select fm180.id, fm180.csgx as gx, fm180.xm, fm180.fb, fm180.qb, fm180.wtcz, fm180.djdd, fm180.djrq, hrm.lastname as djz from formtable_main_180 fm180 left join hrmresource hrm on fm180.djz = hrm. id ) b where a .mainid = b. id ) c left join ( select selectname, selectvalue from workflow_selectitem where fieldid = ( select id from workflow_billfield where billid =- 89 and fieldname = 'measure_distance' ) ) d on d .selectvalue = c.measure_distance ) e left join sbdjxx on e .lzfs = sbdjxx. id ";
													sqlWhere = sqlwhere;
													orderby = " e.id ";
													tableString = " <table instanceid=\"contract\" tabletype=\"none\" pagesize=\"" + perpage + "\" >"
														+ "		<sql backfields=\"" + backfields + "\" sqlform=\"" + fromSql + "\" sqlwhere=\""
														+ Util.toHtmlForSplitPage(sqlWhere) + "\" sqlorderby=\"" + orderby
														+ "\"  sqlprimarykey=\"e.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>" + "		<head>"
														+ "			<col width=\"15%\" text=\"测试工序\" column=\"gx\" orderkey=\"gx\"  />"
														+ "			<col width=\"15%\" text=\"测试项目\" column=\"xm\" orderkey=\"xm\"  />"
														+ "			<col width=\"15%\" text=\"分部\" column=\"fb\" orderkey=\"fb\"  />"
														+ "			<col width=\"15%\" text=\"期别\" column=\"qb\" orderkey=\"qb\"  />"
														+ "			<col width=\"15%\" text=\"机号\" column=\"jh\" orderkey=\"jh\"  />"
														+ "			<col width=\"15%\" text=\"编号\" column=\"bh\" orderkey=\"bh\"  />"
														+ "			<col width=\"15%\" text=\"安装工序\" column=\"process\" orderkey=\"process\"  />"
														+ "			<col width=\"15%\" text=\"型号\" column=\"xh\" orderkey=\"xh\"  />"
														+ "			<col width=\"15%\" text=\"计划点检日期\" column=\"jhdjrq\" orderkey=\"jhdjrq\"  />"
														+ "			<col width=\"15%\" text=\"实际点检日期\" column=\"sjdjrq\" orderkey=\"sjdjrq\"  />"
														+ "			<col width=\"15%\" text=\"测量距离\" column=\"measure_distance\" orderkey=\"measure_distance\"  />"
														+ "			<col width=\"15%\" text=\"清洁调试\" column=\"clean_adjust\" orderkey=\"clean_adjust\"  />"
														+ "			<col width=\"15%\" text=\"电极、风扇、栅格、机身是否脏\" column=\"ywzw\" orderkey=\"ywzw\"  />"
														+ "			<col width=\"15%\" text=\"风扇转动\" column=\"fspd\" orderkey=\"fspd\"  />"
														+ "			<col width=\"15%\" text=\"飘带点检\" column=\"pdjcsfwh\" orderkey=\"pdjcsfwh\"  />"
														+ "			<col width=\"15%\" text=\"+1000V→+50V_1\" column=\"plus_1\" orderkey=\"plus_1\"  />"
														+ "			<col width=\"15%\" text=\"+1000V→+50V_2\" column=\"plus_2\" orderkey=\"plus_2\"  />"
														+ "			<col width=\"15%\" text=\"+1000V→+50V_3\" column=\"plus_3\" orderkey=\"plus_3\"  />"
														+ "			<col width=\"15%\" text=\"-1000V→-50_1\" column=\"minus_1\" orderkey=\"minus_1\"  />"
														+ "			<col width=\"15%\" text=\"-1000V→-50V_2\" column=\"minus_2\" orderkey=\"minus_2\"  />"
														+ "			<col width=\"15%\" text=\"-1000V→-50V_3\" column=\"minus_3\" orderkey=\"minus_3\"  />"
														+ "			<col width=\"15%\" text=\"平衡电压\" column=\"balanced_voltages\" orderkey=\"balanced_voltages\"  />"
														+ "			<col width=\"15%\" text=\"测量结果\" column=\"result\" orderkey=\"result\"  />"
														+ "			<col width=\"15%\" text=\"问题处置\" column=\"wtcz\" orderkey=\"wtcz\"  />"
														+ "			<col width=\"15%\" text=\"点检地点\" column=\"djdd\" orderkey=\"djdd\"  />"
														+ "			<col width=\"15%\" text=\"点检日期\" column=\"djrq\" orderkey=\"djrq\"  />"
														+ "			<col width=\"15%\" text=\"点检人\" column=\"djz\" orderkey=\"djz\"  />"
														+ "		</head>" + "		<operates width=\"10%\">";
													tableString += "		</operates>" + " </table>";
												}
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
		
		$("#test_classification").attr("value",<%=test%>);
		$("#test_classification").change(function(){
			document.frmmain.submit();
		});
		
		
		
		window.onload = function(){  
			$("span:contains('选择查询时间:')").parent().children().find("span").eq(0).empty();
			$("span:contains('-')").next().find("span").eq(0).empty();
		};
	</script>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>