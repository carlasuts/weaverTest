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
	String titlename = "UPH规则";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String PKG_OUTLINE_FK = "",OPER_FK = "",SINGLE_ATTACH_TIME = "",ATTACH_CHANGE_WAFER_TIME="",SINGLE_WIRE_BOND_TIME="",SINGLE_NO_WIRE_TIME="",SINGLE_GRIND_TIME="",SCRIBE_METERS="",SCRIBE_CHANGE_WAFER_TIME="",UPH_FORMULA="" ;
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select PKG_OUTLINE_FK,OPER_FK,SINGLE_ATTACH_TIME,ATTACH_CHANGE_WAFER_TIME,SINGLE_WIRE_BOND_TIME,SINGLE_NO_WIRE_TIME,SINGLE_GRIND_TIME,SCRIBE_METERS,SCRIBE_CHANGE_WAFER_TIME,UPH_FORMULA from MDM_UPH_RULE_hf where id ='"+id+"'");
		if(rs.next()){
			PKG_OUTLINE_FK = rs.getString("PKG_OUTLINE_FK");
			OPER_FK = rs.getString("OPER_FK");
			SINGLE_ATTACH_TIME = rs.getString("SINGLE_ATTACH_TIME");
			ATTACH_CHANGE_WAFER_TIME = rs.getString("ATTACH_CHANGE_WAFER_TIME");
			SINGLE_WIRE_BOND_TIME = rs.getString("SINGLE_WIRE_BOND_TIME");
			SINGLE_NO_WIRE_TIME = rs.getString("SINGLE_NO_WIRE_TIME");
			SINGLE_GRIND_TIME = rs.getString("SINGLE_GRIND_TIME");
			SCRIBE_METERS = rs.getString("SCRIBE_METERS");
			SCRIBE_CHANGE_WAFER_TIME = rs.getString("SCRIBE_CHANGE_WAFER_TIME");
			UPH_FORMULA = rs.getString("UPH_FORMULA");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='uph_hf.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="uphoperation_hf.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">封装外形：</td>
								<td align="left">
									<input type='text' id='PKG_OUTLINE_FK' name='PKG_OUTLINE_FK' value='<%=PKG_OUTLINE_FK %>' />
								</td>
							</TR>
							<TR>
								<td align="right">型号：</td>
								<td align="left">
									<input type='text' id='OPER_FK' name='OPER_FK' value='<%=OPER_FK %>' />
								</td>
							</TR>
							<TR>
								<td align="right">单只装片时间：</td>
								<td align="left">
									<input type='text' id='SINGLE_ATTACH_TIME' name='SINGLE_ATTACH_TIME' value='<%=SINGLE_ATTACH_TIME %>' />
								</td>
							</TR>
							<TR>
								<td align="right">装片换圆片时间：</td>
								<td align="left">
									<input type='text' id='ATTACH_CHANGE_WAFER_TIME' name='ATTACH_CHANGE_WAFER_TIME' value='<%=ATTACH_CHANGE_WAFER_TIME %>' />
								</td>
							</TR>
							<TR>
								<td align="right">单丝键合时间：</td>
								<td align="left">
									<input type='text' id='SINGLE_WIRE_BOND_TIME' name='SINGLE_WIRE_BOND_TIME' value='<%=SINGLE_WIRE_BOND_TIME %>' />
								</td>
							</TR>
							<TR>
								<td align="right">单只不打线时间：</td>
								<td align="left">
									<input type='text' id='SINGLE_NO_WIRE_TIME' name='SINGLE_NO_WIRE_TIME' value='<%=SINGLE_NO_WIRE_TIME %>' />
								</td>
							</TR>
							<TR>
								<td align="right">单片磨片时间：</td>
								<td align="left">
									<input type='text' id='SINGLE_GRIND_TIME' name='SINGLE_GRIND_TIME' value='<%=SINGLE_GRIND_TIME %>' />
								</td>
							</TR>
							<TR>
								<td align="right">划片速度：</td>
								<td align="left">
									<input type='text' id='SCRIBE_METERS' name='SCRIBE_METERS' value='<%=SCRIBE_METERS %>' />
								</td>
							</TR>
							<TR>
								<td align="right">划片换圆片时间：</td>
								<td align="left">
									<input type='text' id='SCRIBE_CHANGE_WAFER_TIME' name='SCRIBE_CHANGE_WAFER_TIME' value='<%=SCRIBE_CHANGE_WAFER_TIME %>' />
								</td>
							</TR>
							<TR>
								<td align="right">UPH公式：</td>
								<td align="left">
									<input type='text' id='UPH_FORMULA' name='UPH_FORMULA' value='<%=UPH_FORMULA %>' />
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