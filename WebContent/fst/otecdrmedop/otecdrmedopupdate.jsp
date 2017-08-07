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
	String titlename = "技术图纸管理";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String gcname = "",tzlxname = "",tzshr = "",tzpzr="",shrname = "",pzrname="";

	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select gcname,tzlxname,tzshr,tzpzr,shrname,pzrname from otecdrmedop where id ='"+id+"'");
		if(rs.next()){
			gcname = rs.getString("gcname");
			tzlxname = rs.getString("tzlxname");
			tzshr = rs.getString("tzshr");
			tzpzr = rs.getString("tzpzr");
			shrname = rs.getString("shrname");
			pzrname = rs.getString("pzrname");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='otecdrmedop.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="otecdrmedopoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">厂区：</td>
								<td align="left">
									<input type='text' id='gcname' name='gcname' value='<%=gcname %>' />
								</td>
							</TR>
							<TR>
								<td align="right">图纸类型：</td>
								<td align="left">
									<input type='text' id='tzlxname' name='tzlxname' value='<%=tzlxname %>' />
								</td>
							</TR>
							<TR>
								<td align="right">图纸审核人工号：</td>
								<td align="left">
									<input type='text' id='tzshr' name='tzshr' value='<%=tzshr %>' />
								</td>
							</TR>
							<TR>
								<td align="right">图纸审核人姓名：</td>
								<td align="left">
									<input type='text' id='shrname' name='shrname' value='<%=shrname %>' />
								</td>
							</TR>
							<TR>
								<td align="right">图纸批准人工号：</td>
								<td align="left">
									<input type='text' id='tzpzr' name='tzpzr' value='<%=tzpzr %>' />
								</td>
							</TR>
							<TR>
								<td align="right">图纸批准人姓名：</td>
								<td align="left">
									<input type='text' id='pzrname' name='pzrname' value='<%=pzrname %>' />
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