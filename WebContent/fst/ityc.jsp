<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>
<%@ page import="weaver.general.Util,java.util.List,java.util.ArrayList"%>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>
<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min.js"></script>
<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "IT�쳣����";
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
	<%@ include file="/systeminfo/TopTitle.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
	<%
		//����
		RCMenu += "{" + SystemEnv.getHtmlLabelName(86, user.getLanguage()) + ",javascript:doSave(this),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		//����
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='ityclist.jsp',_self} ";
		RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu.jsp"%>
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
								<td align="right">���ƣ�</td>
								<td align="left">
									<input type='text' id='name' name='name' value='<%=name %>' />
								</td>
							</TR>
							<TR>
								<td align="right">����</td>
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
	src="/js/JSDateTime/WdatePicker.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime.js"></script>
</html>