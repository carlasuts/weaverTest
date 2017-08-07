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
	String titlename = "IT异常处置";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String name = "",oby = "";
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select name,oby from tb_ityc where id = " + id);
		if(rs.next()){
			name = rs.getString("name");
			oby = rs.getString("oby");
		}
	}
	String method = "";
	if (id.equals("")) {
		method = "add";
	} else {
		method = "modi";
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='ityclist.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="itycOperation.jsp" method=post>
				<input type=hidden name='method' value='<%=method %>'>
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
								<td align="right">排序：</td>
								<td align="left">
									<input type='text' id='orderby' name='orderby' value='<%=oby %>' />
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