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
	String titlename = "FLOW工序卡控";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String PACKAGETYPE_id = Util.null2String(request.getParameter("PACKAGETYPE_id"));
	String PACKAGETYPE = "",OPER = "" ;
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select packagetype,oper from MDM_FLOW_CHECK where id ='"+id+"'");
		if(rs.next()){
			PACKAGETYPE = rs.getString("packagetype");
			OPER = rs.getString("oper");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='MDM_FLOW_CHECK.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="MDM_FLOW_CHECKoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
				<input type="hidden" id="PACKAGETYPE_id" name="PACKAGETYPE_id" value="<%=PACKAGETYPE%>">
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">包装方式：</td>
								<td align="left">
									<select name="PACKAGETYPE" id='PACKAGETYPE'> 
										<option value="" ></option>  
										<option value="tray盘-CHIPTRAY" >tray盘-CHIPTRAY</option>  
										<option value="弹匣-AMMO" >弹匣-AMMO</option> 
										<option value="散装-BULK" >散装-BULK</option>  
										<option value="料条-TUBE" >料条-TUBE</option>  
										<option value="料盘-TRAY" >料盘-TRAY</option> 
										<option value="载带-CARRIER" >载带-CARRIER</option>  
							    	</select>
								</td>
							</TR>
							<TR>
								<td align="right">工序：</td>
								<td align="left">
									<input type='text' id='OPER' name='OPER' value='<%=OPER %>' />
								</td>
							</TR>
						</TBODY>
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
	src="/js/JSDateTime/WdatePicker_wev8.js">
</script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>


<script language=javascript>
$(document).ready(function(){
	$("#PACKAGETYPE").attr("value",jQuery("#PACKAGETYPE_id").val());	
});
</script>





</html>