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
	String titlename = "malay";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();	
	String no1 =  Util.fromScreen(request.getParameter("no1"),user.getLanguage());
	String sprsl = "",molga = "",lgart = "",lgtxt = "",kztxt = "",wten = "";

	RecordSet rs = new RecordSet();
	if(!no1.equals("")){
		rs.executeSql("select sprsl,molga,lgart,lgtxt,kztxt,wt_en from ZJV_HR_OAWT_BM where no1 ='"+no1+"'");
		if(rs.next()){
		    sprsl = rs.getString("sprsl");
		    molga = rs.getString("molga");
		    lgart = rs.getString("lgart");
		    lgtxt = rs.getString("lgtxt");
		    kztxt = rs.getString("kztxt");
		    wten = rs.getString("wt_en");
		}
	}
	String type = "";
	if (no1.equals("")) {
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='malay.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="malayoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='no1' value='<%=no1%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>							
							<TR>
								<td align="right">sprsl：</td>
								<td align="left">
									<input type='text' id='sprsl' name='sprsl' value='<%=sprsl%>' />
								</td>
							</TR>
							<TR>
								<td align="right">molga：</td>
								<td align="left">
									<input type='text' id='molga' name='molga' value='<%=molga%>' />
								</td>
							</TR>
							<TR>
								<td align="right">lgart：</td>
								<td align="left">
									<input type='text' id='lgart' name='lgart' value='<%=lgart%>' />
								</td>
							</TR>
							<TR>
								<td align="right">lgtxt：</td>
								<td align="left">
									<input type='text' id='lgtxt' name='lgtxt' value='<%=lgtxt%>' />
								</td>
							</TR>
							<TR>
								<td align="right">kztxt：</td>
								<td align="left">
									<input type='text' id='kztxt' name='kztxt' value='<%=kztxt%>' />
								</td>
							</TR>
							<TR>
								<td align="right">wten：</td>
								<td align="left">
									<input type='text' id='wten' name='wten' value='<%=wten%>' />
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