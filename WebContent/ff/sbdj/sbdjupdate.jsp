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
	String titlename = "外形测试UPH";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String fb = "",qb = "",sblb = "",sbbh = "",sbms = "",djr = "",zhdjsj = "",djpl = "",workcode = "",email = "",stopsign="";

	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select fb,qb,sblb,sbbh,sbms,djr,zhdjsj,djpl,workcode,email,stopsign  from sbdjxx where id ='"+id+"'");
		if(rs.next()){
			fb = rs.getString("fb");
			qb = rs.getString("qb");
			sblb = rs.getString("sblb");
			sbbh = rs.getString("sbbh");
			sbms = rs.getString("sbms");
			djr = rs.getString("djr");
			zhdjsj = rs.getString("zhdjsj");
			djpl = rs.getString("djpl");
			workcode = rs.getString("workcode");
			email = rs.getString("email");		
			stopsign = rs.getString("stopsign");	
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='sbdj.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="sbdjoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">分部：</td>
								<td align="left">
									<input type='text' id='fb' name='fb' value='<%=fb %>' />
								</td>
							</TR>
							<TR>
								<td align="right">期别：</td>
								<td align="left">
									<input type='text' id='qb' name='qb' value='<%=qb %>' />
								</td>
							</TR>
														<TR>
								<td align="right">设备类别：</td>
								<td align="left">
									<input type='text' id='sblb' name='sblb' value='<%=sblb %>' />
								</td>
							</TR>
							<TR>
								<td align="right">设备编号：</td>
								<td align="left">
									<input type='text' id='sbbh' name='sbbh' value='<%=sbbh %>' />
								</td>
							</TR>
														<TR>
								<td align="right">设备描述：</td>
								<td align="left">
									<input type='text' id='sbms' name='sbms' value='<%=sbms %>' />
								</td>
							</TR>
							<TR>
								<td align="right">点检人：</td>
								<td align="left">
									<input type='text' id='djr' name='djr' value='<%=djr %>' />
								</td>
							</TR>
														<TR>
								<td align="right">最后点检时间：</td>
								<td align="left">
									<input type='text' id='zhdjsj' name='zhdjsj' value='<%=zhdjsj %>' />
								</td>
							</TR>
							<TR>
								<td align="right">点检频率：</td>
								<td align="left">
									<input type='text' id='djpl' name='djpl' value='<%=djpl %>' />
								</td>
							</TR>
							</TR>
														<TR>
								<td align="right">工号：</td>
								<td align="left">
									<input type='text' id='workcode' name='workcode' value='<%=workcode %>' />
								</td>
							</TR>
							<%if(!type.equals("add")){ %>
							<TR>
								<td align="right">邮箱：</td>
								<td align="left">
									<input type='text' id='email' name='email' value='<%=email %>' />
								</td>
							</TR>
							<% }%>
							<TR>
								<td align="right">停止标志：</td>
								<td align="left">
								<select id='stopsign' name='stopsign' >
										<option value="U">使用</option>
										<option value="S">停止</option>
								</select>
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
	var stopsign ="<%=stopsign%>"
	$("#stopsign").attr("value",stopsign);
		function doSave(obj) {
			document.frmmain.submit();
		}
	</script>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>