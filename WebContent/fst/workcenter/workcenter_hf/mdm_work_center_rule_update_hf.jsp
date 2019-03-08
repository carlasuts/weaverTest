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
	String titlename = "工作中心规则";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String cust_fk = "",pkg_outline_fk = "",oper_fk = "" ,vehicle_fk="",work_center_fk="",DATE_EFFECT="";
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select cust_fk,pkg_outline_fk,oper_fk,vehicle_fk,work_center_fk,DATE_EFFECT from MDM_WORK_CENTER_RULE_hf where id ='"+id+"'");
		if(rs.next()){
			cust_fk = rs.getString("cust_fk");
			pkg_outline_fk = rs.getString("pkg_outline_fk");
			oper_fk = rs.getString("oper_fk");
			vehicle_fk = rs.getString("vehicle_fk");
			work_center_fk = rs.getString("work_center_fk");
			DATE_EFFECT = rs.getString("DATE_EFFECT");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='mdm_work_center_rule_hf.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="mdm_work_center_rule_operation_hf.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">客户：</td>
								<td align="left">
									<input type='text' id='cust_fk' name='cust_fk' value='<%=cust_fk %>' />
								</td>
							</TR>
							<TR>
								<td align="right">封装外形：</td>
								<td align="left">
									<input type='text' id='pkg_outline_fk' name='pkg_outline_fk' value='<%=pkg_outline_fk %>' />
								</td>
							</TR>
							<TR>
								<td align="right">工序：</td>
								<td align="left">
									<input type='text' id='oper_fk' name='oper_fk' value='<%=oper_fk %>' />
								</td>
							</TR>
							<TR>
								<td align="right">车载品：</td>
								<td align="left">
									<input type='text' id='vehicle_fk' name='vehicle_fk' value='<%=vehicle_fk %>' />
								</td>
							</TR>
							<TR>
								<td align="right">工作中心：</td>
								<td align="left">
									<input type='text' id='work_center_fk' name='work_center_fk' value='<%=work_center_fk %>' />
								</td>
							</TR>
							<TR>
								<td align="right">生效日期：</td>
								<td align="left">
									<input type='text' id='DATE_EFFECT' name='DATE_EFFECT' value='<%=DATE_EFFECT %>' />
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