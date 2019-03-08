<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page import="weaver.general.Util,java.util.List,java.util.ArrayList"%>
<%@ page
	import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*"%>
<%@ page import="java.util.*"%>
<%@ page import="weaver.file.*"%>
<%@ page import="java.text.*"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<html>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "新建或者修改封装外形";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
    String id= Util.null2String(request.getParameter("id"));
    String name="",factory="";
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select NAME,FACTORY_FK from  MD_SD_QTTN_PKG where id='"+id+"'");
		rs.next();
		name = rs.getString("NAME");
		factory = rs.getString("FACTORY_FK");	
	}
	String type = "";
	String readOnly="";
	String hint="";
	if (id.equals("")) {
		type = "add";
		hint="（不填默认：0）";
	} else {
		type = "modi";
		readOnly="readonly='readonly'";
	}

%>
<body>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
	<%
		//保存
		RCMenu += "{" + SystemEnv.getHtmlLabelName(86, user.getLanguage()) + ",javascript:doSave(this),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		//返回
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='ShapeReport.jsp',_self} ";
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
					action="ShapeReportOperation.jsp" method=post>
					<input type=hidden name=type value='<%=type%>'>

					<table style="width: 80%" class=ListStyle>
						<tbody>
							<TR>
								<td align="right">ID：</td>
								<td align="left">
								<input type='text'	id='id' name='id' value='<%=id%>' /></td>
							</TR>
							<TR>
								<td align="right">封装外形：</td>
								<td align="left">
								<input type='text'	id='name' name='name' value='<%=name%>' /></td>
							</TR>
							<TR>
								<td align="right">厂区：</td>
								<td align="left">
								<select id='factory' name='factory' >
										<option value="0000">圆片厂</option>
										<option value="1000">一期厂</option>
										<option value="2000">二期厂</option>
										<option value="3000">三期厂</option>
										<option value="4000">合肥厂</option>
										<option value="5000">苏通厂</option>
								</select></td>
							</TR>
						</tbody>
					</table>
				</FORM>
			</td>
		</tr>

		<tr>
			<td height="10" colspan="3"></td>
		</tr>


	</table>
	<script language=javascript>
	var factory =<%=factory%>
	$("#factory").attr("value",factory);
		function doSave(obj) {
			document.frmmain.submit();
		}
	</script>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>