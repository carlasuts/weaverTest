<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page import="weaver.general.Util,java.util.List,java.util.ArrayList"%>
<%@ page
	import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.file.*"%>
<%@ page import="java.text.*"%>
<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "报价人员配置";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	String id = Util.fromScreen(request.getParameter("id"), user.getLanguage());
	String area = "0", cust_id = "", work_code = "";
	RecordSet rs = new RecordSet();
	if (!id.equals("")) {
		rs.executeSql("select NAME, SALES_AREA_FK, SALESMAN_FK from OSALESCAST where id ='" + id + "'");
		if (rs.next()) {
			cust_id = rs.getString("NAME");
			area = rs.getString("SALES_AREA_FK");
			work_code = rs.getString("SALESMAN_FK");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage())
				+ ",javascript:location.href='quoter.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0"
					action="quoterOperation.jsp" method=post>
					<input type=hidden name=type value='<%=type%>'> <input
						type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">客户号：</td>
								<td align="left"><input type='text' id='cust_id'
									name='cust_id' value='<%=cust_id%>' /></td>
							</TR>
							<TR>
								<td align="right">区域：</td>
								<td align="left">
									<select id='area' name='area' value='<%=area%>'>
										<option value="0">请选择</option>
										<option value="1">亚太1</option>
										<option value="2">美国</option>
										<option value="3">亚太</option>
										<option value="4">国内</option>
										<option value="5">欧洲</option>
										<option value="6">国内1</option>
										<option value="7">台韩</option>
										<option value="8">日本</option>
										<option value="9">国内2</option>
										<option value="10">亚太2</option>
										<option value="11">欧美</option>
										<option value="21">国内2</option>
									</select>
								</td>
							</TR>
							<TR>
								<td align="right">工号：</td>
								<td align="left"><input type='text' id='work_code' name='work_code'
									value='<%=work_code%>' /></td>
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
		var area = <%=area%>
	
		function doSave(obj) {
			document.frmmain.submit();
		}

		$(function () {
			$("#area").val(area);
		});
	</script>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>