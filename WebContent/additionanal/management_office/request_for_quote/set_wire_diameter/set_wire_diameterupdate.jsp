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
	String titlename = "线径设定";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String LENGTH = "",UNIT_FK = "",STANDARD = "",FULL_NAME = "",SORT= "";

	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select id,LENGTH,UNIT_FK,STANDARD,FULL_NAME,SORT from MD_SD_WIRE_DIAM where id ='"+id+"'");
		if(rs.next()){
			LENGTH = rs.getString("LENGTH");
			UNIT_FK = rs.getString("UNIT_FK");
			STANDARD = rs.getString("STANDARD");
			FULL_NAME = rs.getString("FULL_NAME");
			SORT = rs.getString("SORT");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='set_wire_diameter.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="set_wire_diameteroperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">长度：</td>
								<td align="left">
									<input type='text' id='LENGTH' name='LENGTH' value='<%=LENGTH %>' />
								</td>
							</TR>
							<TR>
								<td align="right">单位：</td>
								<td align="left">
								<p>
									<brow:browser name="UNIT_FK" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.unit'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=UNIT_FK %>'
										  browserSpanValue='<%=UNIT_FK %>'
										/>									
								</p>										
								</td>
							</TR>
							<TR>
								<td align="right">标准标识位：</td>
								<td align="left">
									<input type='text' id='STANDARD' name='STANDARD' value='<%=STANDARD %>' />
								</td>
							</TR>
							<TR>
								<td align="right">全称：</td>
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