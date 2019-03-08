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
	String titlename = "设备组规则";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String factory = "",custid = "",pkld = "",oper = "",resg_id = "" ;
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select factory,custid,pkld,oper,resg_id from orasresmfo_st where id ='"+id+"'");
		if(rs.next()){
			factory = rs.getString("factory");
			custid = rs.getString("custid");
			pkld = rs.getString("pkld");
			oper = rs.getString("oper");
			resg_id = rs.getString("resg_id");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='orasresmfo_st.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="orasresmfooperation_st.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">工厂：</td>
								<td align="left">
									<input type='text' id='factory' name='factory' value='<%=factory%>' required='required'/>
								</td>
							</TR>
							<TR>
								<td align="right">客户号：</td>
								<td align="left">
									<input type='text' id='custid' name='custid' value='<%=custid%>' />
								</td>
							</TR>
							<TR>
								<td align="right">外形：</td>
								<td align="left">
									<input type='text' id='pkld' name='pkld' value='<%=pkld%>' />
								</td>
							</TR>
							<TR>
								<td align="right">工序：</td>
								<td align="left">
									<input type='text' id='oper' name='oper' value='<%=oper%>' />
								</td>
							</TR>
							<TR>
								<td align="right">设备组：</td>
								<td align="left">
									<input type='text' id='resg_id' name='resg_id' value='<%=resg_id%>' />
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