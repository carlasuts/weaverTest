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
	String titlename = "外形标准毛利率";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String GPM = "",QTTN_PKG_FK = "",PRDC_TYPE_FK = "";

	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select QTTN_PKG_FK,PRDC_TYPE_FK,GPM from MD_SD_QTTN_PKG_GPM where id ='"+id+"'");
		if(rs.next()){
			QTTN_PKG_FK = rs.getString("QTTN_PKG_FK");
			PRDC_TYPE_FK = rs.getString("PRDC_TYPE_FK");
			GPM = rs.getString("GPM");

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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='gross_margin_appearance_standards.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="gross_margin_appearance_standardsoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">外形：</td>
								<td align="left">
								<p>
									<brow:browser name="QTTN_PKG_FK" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.cont_config'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=QTTN_PKG_FK %>'
										  browserSpanValue='<%=QTTN_PKG_FK %>'
										/>									
								</p>										
								</td>
							</TR>
							<TR>
								<td align="right">生产类型：</td>
								<td align="left">
								<p>
									<brow:browser name="PRDC_TYPE_FK" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.product_type'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=PRDC_TYPE_FK %>'
										  browserSpanValue='<%=PRDC_TYPE_FK %>'
										/>
										
								</p>
								</td>
							</TR>
							<TR>
								<td align="right">毛利率：</td>
								<td align="left">
									<input type='text' id='GPM' name='GPM' value='<%=GPM %>' />
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