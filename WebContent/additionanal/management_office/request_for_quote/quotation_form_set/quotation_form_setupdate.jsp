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
	String titlename = "报价外形设定";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String mianid = "",name = "",FULL_NAME = "",WIRE_LENGTH = "",WIRE_QTY= "",DIE_SIZE_X= "",DIE_SIZE_Y= "",EQUIPMENT_DEP_PERIOD= "",COPPER_PRICE_WAVE= "";

	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select a.id  ,a.name,B.FULL_NAME,A.WIRE_LENGTH,A.WIRE_QTY,A.DIE_SIZE_X,A.DIE_SIZE_Y,A.EQUIPMENT_DEP_PERIOD,A.COPPER_PRICE_WAVE from MD_SD_QTTN_PKG a left join MD_FACTORY b on A.FACTORY_FK = b.id where a.id ='"+id+"'");
		if(rs.next()){
			mianid = rs.getString("id");
			name = rs.getString("name");
			FULL_NAME = rs.getString("FULL_NAME");
			WIRE_LENGTH = rs.getString("WIRE_LENGTH");
			WIRE_QTY = rs.getString("WIRE_QTY");
			DIE_SIZE_X = rs.getString("DIE_SIZE_X");
			DIE_SIZE_Y = rs.getString("DIE_SIZE_Y");
			EQUIPMENT_DEP_PERIOD = rs.getString("EQUIPMENT_DEP_PERIOD");
			COPPER_PRICE_WAVE = rs.getString("COPPER_PRICE_WAVE");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='quotation_form_set.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="quotation_form_setoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">id：</td>
								<td align="left">
									<input type='text' id='mianid' name='mianid' value='<%=mianid %>' />
								</td>
							</TR>
							<TR>
								<td align="right">名称：</td>
								<td align="left">
									<input type='text' id='name' name='name' value='<%=name %>' />
								</td>
							</TR>
							<TR>
								<td align="right">工厂：</td>
								<td align="left">
									<input type='text' id='FULL_NAME' name='FULL_NAME' value='<%=FULL_NAME %>' />
								</td>
							</TR>
							<TR>
								<td align="right">单丝长度：</td>
								<td align="left">
									<input type='text' id='WIRE_LENGTH' name='WIRE_LENGTH' value='<%=WIRE_LENGTH %>' />
								</td>
							</TR>
							<TR>
								<td align="right">标准丝数：</td>
								<td align="left">
									<input type='text' id='WIRE_QTY' name='WIRE_QTY' value='<%=WIRE_QTY %>' />
								</td>
							</TR>
							<TR>
								<td align="right">芯片X：</td>
								<td align="left">
									<input type='text' id='DIE_SIZE_X' name='DIE_SIZE_X' value='<%=DIE_SIZE_X %>' />
								</td>
							</TR>
							<TR>
								<td align="right">芯片Y：</td>
								<td align="left">
									<input type='text' id='DIE_SIZE_Y' name='DIE_SIZE_Y' value='<%=DIE_SIZE_Y %>' />
								</td>
							</TR>																																			
							<TR>
								<td align="right">设备折旧年限：</td>
								<td align="left">
									<input type='text' id='EQUIPMENT_DEP_PERIOD' name='EQUIPMENT_DEP_PERIOD' value='<%=EQUIPMENT_DEP_PERIOD %>' />
								</td>
							</TR>	
							<TR>
								<td align="right">铜价波动100$：</td>
								<td align="left">
									<input type='text' id='COPPER_PRICE_WAVE' name='COPPER_PRICE_WAVE' value='<%=COPPER_PRICE_WAVE %>' />
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