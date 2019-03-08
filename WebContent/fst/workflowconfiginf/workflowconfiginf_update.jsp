<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page import="weaver.general.Util,java.util.List,java.util.ArrayList"%>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>
<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "流程配置信息";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String workflowid = "",param = "",paramdesc = "",plantopt = "" ;
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select workflowid , param, paramdesc, plantopt from workflowconfiginf where id ='"+id+"'");
		if(rs.next()){
			workflowid = rs.getString("workflowid");
			param = rs.getString("param");
			paramdesc = rs.getString("paramdesc");
			plantopt = rs.getString("plantopt");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='workflowconfiginf.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="workflowconfiginf_operation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">流程ID：</td>
								<td align="left">
									<input type='text' id='workflowid' name='workflowid' value='<%=workflowid %>' />
								</td>
							</TR>
							<TR>
								<td align="right">厂区：</td>
								<td align="left">
									<input type='text' id='plantopt' name='plantopt' value='<%=plantopt %>' />
								</td>
							</TR>
							<TR>
								<td align="right">参数：</td>
								<td align="left">
									<input type='text' id='param' name='param' value='<%=param %>' />
								</td>
							</TR>
							<TR>
								<td align="right">参数描述：</td>
								<td align="left">
									<input type='text' id='paramdesc' name='paramdesc' value='<%=paramdesc %>' />
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