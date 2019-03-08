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
	String titlename = "毛利率变动幅度核决权限";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String APPROVEL_LEVEL_FK = "",FPA_REASON = "",name = "",FULL_NAME = "",REASON= "",RATE="";

	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select a.APPROVEL_LEVEL_FK,a.FPA_REASON,a.id,a.name,B.FULL_NAME,c.name as REASON ,A.RATE from MD_SD_GPM_RANG_AR a left join  MD_APPROVEL_LEVEL b on A.APPROVEL_LEVEL_FK=B.ID left join MD_SD_QTTN_REASON c on A.FPA_REASON =c.id where a.id ='"+id+"'");
		if(rs.next()){
			APPROVEL_LEVEL_FK = rs.getString("APPROVEL_LEVEL_FK");
			FPA_REASON = rs.getString("FPA_REASON");
			name = rs.getString("name");
			FULL_NAME = rs.getString("FULL_NAME");
			REASON = rs.getString("REASON");
			RATE = rs.getString("RATE");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='gross_margin_range_nuclear_permissions.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="gross_margin_range_nuclear_permissionsoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">名称：</td>
								<td align="left">
									<input type='text' id='name' name='name' value='<%=name %>' />
								</td>
							</TR>
							<TR>
								<td align="right">核决权限：</td>
								<td align="left">
								<p>
									<brow:browser name="FULL_NAME" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.MD_SD_GPM_RANG_AR'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=APPROVEL_LEVEL_FK %>'
										  browserSpanValue='<%=FULL_NAME %>'
										/>									
								</p>										
								</td>
							</TR>
							<TR>
								<td align="right">调价原因：</td>
								<td align="left">
								<p>
									<brow:browser name="REASON" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.Due_to_reasons'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=FPA_REASON %>'
										  browserSpanValue='<%=REASON %>'
										/>
										
								</p>
								</td>
							</TR>
							<TR>
								<td align="right">系数：</td>
								<td align="left">
									<input type='text' id='RATE' name='RATE' value='<%=RATE %>' />
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