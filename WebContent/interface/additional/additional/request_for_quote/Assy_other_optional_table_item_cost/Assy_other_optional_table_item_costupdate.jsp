<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page import="weaver.general.Util,java.util.List,java.util.ArrayList"%>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "组装其他成本项可选项";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String COST_ASSY_OTHER_FK = "",name = "",QTTN_PKG_FK = "",FULL_NAME = "",SORT= "";
	String CURRENCY_FK = "",MATERIALCOST = "",MAINTENANCE_COST = "",UC = "",LABOUR= "";
	String POWER = "",DEPR = "",OTHER = "";
	
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select a.COST_ASSY_OTHER_FK,b.name,B.QTTN_PKG_FK,A.FULL_NAME,A.SORT,A.CURRENCY_FK, MATERIALCOST ,MAINTENANCE_COST ,UC ,LABOUR ,POWER ,DEPR ,OTHER from MD_SD_COST_ASSY_OTHER_OPTION a left join  MD_SD_COST_ASSY_OTHER b on a.COST_ASSY_OTHER_FK =b.id where a.id ='"+id+"'");
		if(rs.next()){
			COST_ASSY_OTHER_FK = rs.getString("COST_ASSY_OTHER_FK");
			name = rs.getString("name");
			QTTN_PKG_FK = rs.getString("QTTN_PKG_FK");
			FULL_NAME = rs.getString("FULL_NAME");
			SORT = rs.getString("SORT");
			CURRENCY_FK = rs.getString("CURRENCY_FK");
			MATERIALCOST = rs.getString("MATERIALCOST");
			MAINTENANCE_COST = rs.getString("MAINTENANCE_COST");
			UC = rs.getString("UC");
			LABOUR = rs.getString("LABOUR");
			POWER = rs.getString("POWER");
			DEPR = rs.getString("DEPR");
			OTHER = rs.getString("OTHER");

		}
	}
	String type = "";
	if (id.equals("")) {
		type = "add";
	} else {
		type = "modi";
	}
%>
<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
	<%
		//保存
		RCMenu += "{" + SystemEnv.getHtmlLabelName(86, user.getLanguage()) + ",javascript:doSave(this),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		//返回
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='Assy_other_optional_table_item_cost.jsp',_self} ";
		RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
	<table width=100% height=100% border="0" cellspacing="0"
		cellpadding="0">
		<colgroup>
			<col width="10">
			<col width="">
			<col width="10">
		</colgroup>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
		<tr>
			<td></td>
			<td valign="top">
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="Assy_other_optional_table_item_costoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">组装其他成本项：</td>
								<td align="left">
								<p>
									<brow:browser name="QTTN_PKG_FK" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Assembly_other_costs'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=COST_ASSY_OTHER_FK %>'
										  browserSpanValue='<%=QTTN_PKG_FK %>'
										/>									
								</p>										
								</td>
							</TR>
							<TR>
								<td align="right">名称：</td>
								<td align="left">
									<input type='text' id='FULL_NAME' name='FULL_NAME' value='<%=FULL_NAME %>' />
								</td>
							</TR>
							<TR>
								<td align="right">顺序：</td>
								<td align="left">
									<input type='text' id='SORT' name='SORT' value='<%=SORT %>' />
								</td>
							</TR>
							<TR>
								<td align="right">币别：</td>
								<td align="left">
								<p>
									<brow:browser name="CURRENCY_FK" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.CURRENCY_all'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=CURRENCY_FK %>'
										  browserSpanValue='<%=CURRENCY_FK %>'
										/>									
								</p>										
								</td>
							</TR>
							<TR>
								<td align="right">材料费用：</td>
								<td align="left">
									<input type='text' id='MATERIALCOST' name='MATERIALCOST' value='<%=MATERIALCOST %>' />
								</td>
							</TR>
							<TR>
								<td align="right">维修费用：</td>
								<td align="left">
									<input type='text' id='MAINTENANCE_COST' name='MAINTENANCE_COST' value='<%=MAINTENANCE_COST %>' />
								</td>
							</TR>
							<TR>
								<td align="right">单耗：</td>
								<td align="left">
									<input type='text' id='UC' name='UC' value='<%=UC %>' />
								</td>
							</TR>
							<TR>
								<td align="right">人工费用：</td>
								<td align="left">
									<input type='text' id='LABOUR' name='LABOUR' value='<%=LABOUR %>' />
								</td>
							</TR>
							<TR>
								<td align="right">动力费用：</td>
								<td align="left">
									<input type='text' id='POWER' name='POWER' value='<%=POWER %>' />
								</td>
							</TR>
							<TR>
								<td align="right">折旧费用：</td>
								<td align="left">
									<input type='text' id='DEPR' name='DEPR' value='<%=DEPR %>' />
								</td>
							</TR>
							<TR>
								<td align="right">其他费用：</td>
								<td align="left">
									<input type='text' id='OTHER' name='OTHER' value='<%=OTHER %>' />
								</td>
							</TR>
					</TABLE>
				</FORM>
			</td>
		</tr>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
	</table>
	<script language=javascript>
		function doSave(obj) {
			document.frmmain.submit();
		}
	</script>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>