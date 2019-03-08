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
	String titlename = "工具卡领用";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String APPLICATION_DATE = "",MAT_DESC = "",NUMBERS= "",UNIT= "",PRICE= "",SUPPLIER_TO_DESCRIBE= "",USERS_OF_THE= "",WORKCODE_OF_USER="";
	String OLD_USER_NAME = "",OLD_USER_WORKCODE = "",POINT_PERSON= "",FACTORY= "",CREATETIME= "",UPDATETIME= "";
	
	
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select ID,APPLICATION_DATE,MAT_DESC,NUMBERS,UNIT,PRICE,SUPPLIER_TO_DESCRIBE,USERS_OF_THE,WORKCODE_OF_USER,OLD_USER_NAME,OLD_USER_WORKCODE,POINT_PERSON,FACTORY,CREATETIME,UPDATETIME from QUERY_TOOL_CARD where id ='"+id+"'");
		if(rs.next()){
			APPLICATION_DATE = rs.getString("APPLICATION_DATE");
			MAT_DESC = rs.getString("MAT_DESC");
			NUMBERS = rs.getString("NUMBERS");
			UNIT = rs.getString("UNIT");
			PRICE = rs.getString("PRICE");
			SUPPLIER_TO_DESCRIBE = rs.getString("SUPPLIER_TO_DESCRIBE");
			USERS_OF_THE = rs.getString("USERS_OF_THE");
			WORKCODE_OF_USER = rs.getString("WORKCODE_OF_USER");
			OLD_USER_NAME = rs.getString("OLD_USER_NAME");
			OLD_USER_WORKCODE = rs.getString("OLD_USER_WORKCODE");
			POINT_PERSON = rs.getString("POINT_PERSON");
			FACTORY = rs.getString("FACTORY");
			CREATETIME = rs.getString("CREATETIME");
			UPDATETIME = rs.getString("UPDATETIME");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='tool_card_recipients.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="tool_card_recipientsoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">物料描述：</td>
								<td align="left">
									<input type='text' id='MAT_DESC' name='MAT_DESC' value='<%=MAT_DESC %>' />
								</td>
							</TR>
							<TR>
								<td align="right">数量：</td>
								<td align="left">
									<input type='text' id='NUMBERS' name='NUMBERS' value='<%=NUMBERS %>' />
								</td>
							</TR>
							<TR>
								<td align="right">单位：</td>
								<td align="left">
									<input type='text' id='UNIT' name='UNIT' value='<%=UNIT %>' />
								</td>
							</TR>
							<TR>
								<td align="right">价格：</td>
								<td align="left">
									<input type='text' id='PRICE' name='PRICE' value='<%=PRICE %>' />
								</td>
							</TR>
							<TR>
								<td align="right">供应商：</td>
								<td align="left">
									<input type='text' id='SUPPLIER_TO_DESCRIBE' name='SUPPLIER_TO_DESCRIBE' value='<%=SUPPLIER_TO_DESCRIBE %>' />
								</td>
							</TR>		
							<TR>
								<td align="right">使用人：</td>
								<td align="left">
									<input type='text' id='USERS_OF_THE' name='USERS_OF_THE' value='<%=USERS_OF_THE %>' />
								</td>
							</TR>	
							<TR>
								<td align="right">使用人工号：</td>
								<td align="left">
									<input type='text' id='WORKCODE_OF_USER' name='WORKCODE_OF_USER' value='<%=WORKCODE_OF_USER %>' />
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