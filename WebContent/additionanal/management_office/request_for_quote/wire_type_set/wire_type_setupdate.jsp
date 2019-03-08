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
	String titlename = "键合丝种类设置";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String name = "",CURRENCY_FK = "",PIRCE = "",CURRENT_PIRCE = "",SORT= "";

	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select name,CURRENCY_FK,PIRCE,CURRENT_PIRCE,SORT FROM MD_SD_WIRE  where id ='"+id+"'");
		if(rs.next()){
			name = rs.getString("name");
			CURRENCY_FK = rs.getString("CURRENCY_FK");
			PIRCE = rs.getString("PIRCE");
			CURRENT_PIRCE = rs.getString("CURRENT_PIRCE");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='wire_type_set.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="wire_type_setoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">名称：</td>
								<td align="left">
									<input type='text' id=name name='name' value='<%=name %>' />
								</td>
							</TR>
							<TR>
								<td align="right">币别：</td>
								<td align="left">
								<p>
									<brow:browser name="CURRENCY_FK" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.currency'
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
								<td align="right">价格：</td>
								<td align="left">
									<input type='text' id='PIRCE' name='PIRCE' value='<%=PIRCE %>' />
								</td>
							</TR>
							<TR>
								<td align="right">当前价格：</td>
								<td align="left">
									<input type='text' id='CURRENT_PIRCE' name='CURRENT_PIRCE' value='<%=CURRENT_PIRCE %>' />
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