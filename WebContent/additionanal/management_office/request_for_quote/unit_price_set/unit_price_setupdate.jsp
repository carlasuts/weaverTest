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
	String titlename = "单价设定";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String WIRE_FK = "",WIRE_DIAM_FK = "",name = "",FULL_NAME = "",PIRCE= "",PIRCE_STEP= "",PIRCE_DIFF= "";
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select a.id,a.WIRE_FK,a.WIRE_DIAM_FK,b.name,c.FULL_NAME,A.PIRCE,a.PIRCE_STEP,a.PIRCE_DIFF from MD_SD_WIRE_UNIT_PIRCE a left join md_sd_wire b on A.WIRE_FK=B.ID left join MD_SD_WIRE_DIAM c on A.WIRE_DIAM_FK =c.id where a.id ='"+id+"'");
		if(rs.next()){
			WIRE_FK = rs.getString("WIRE_FK");
			WIRE_DIAM_FK = rs.getString("WIRE_DIAM_FK");
			name = rs.getString("name");
			FULL_NAME = rs.getString("FULL_NAME");
			PIRCE = rs.getString("PIRCE");
			PIRCE_STEP = rs.getString("PIRCE_STEP");
			PIRCE_DIFF = rs.getString("PIRCE_DIFF");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='unit_price_set.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="unit_price_setoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">键合丝：</td>
								<td align="left">
								<p>
									<brow:browser name="name" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.bondingwire_type'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=WIRE_FK %>'
										  browserSpanValue='<%=name %>'
										/>									
								</p>										
								</td>
							</TR>
							<TR>
								<td align="right">线径：</td>
								<td align="left">
								<p>
									<brow:browser name="FULL_NAME" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Wire_diameter'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=WIRE_DIAM_FK %>'
										  browserSpanValue='<%=FULL_NAME %>'
										/>									
								</p>										
								</td>
							</TR>
							<TR>
								<td align="right">当前价格：</td>
								<td align="left">
									<input type='text' id='PIRCE' name='PIRCE' value='<%=PIRCE %>' />
								</td>
							</TR>
							<TR>
								<td align="right">步长：</td>
								<td align="left">
									<input type='text' id='PIRCE_STEP' name='PIRCE_STEP' value='<%=PIRCE_STEP %>' />
								</td>
							</TR>
							<TR>
								<td align="right">价差：</td>
								<td align="left">
									<input type='text' id='PIRCE_DIFF' name='PIRCE_DIFF' value='<%=PIRCE_DIFF %>' />
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