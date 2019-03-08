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
	String titlename = "角色节点工序规则";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String oper_fk = "",mtrl_group_fk = "",oper_role_fk = "",oper_role_pk_id = "",mustfill_flag= "";

	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select oper_fk,mtrl_group_fk,oper_role_fk,oper_role_pk_id ,mustfill_flag from MDM_OPER_MTRL_REF where id ='"+id+"' and SITE_OPTION = '1000' ");
		if(rs.next()){
			oper_fk = rs.getString("oper_fk");
			oper_role_fk = rs.getString("oper_role_fk");
			oper_role_pk_id = rs.getString("oper_role_pk_id");
			mustfill_flag = rs.getString("mustfill_flag");
			mtrl_group_fk = rs.getString("mtrl_group_fk");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='MDM_OPER_MTRL_REF_CC.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="MDM_OPER_MTRL_REFoperation_CC.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">工序：</td>
								<td align="left">
									<input type='text' id='oper_fk' name='oper_fk' value='<%=oper_fk %>' />
								</td>
							</TR>
							<TR>
								<td align="right">物料组：</td>
								<td align="left">
									<input type='text' id='mtrl_group_fk' name='mtrl_group_fk' value='<%=mtrl_group_fk %>' />
								</td>
							</TR>
							<TR>
								<td align="right">节点：</td>
								<td align="left">
									<input type='text' id='oper_role_fk' name='oper_role_fk' value='<%=oper_role_fk %>' />
								</td>
							</TR>
							<TR>
								<td align="right">工序角色ID：</td>
								<td align="left">
									<input type='text' id='oper_role_pk_id' name='oper_role_pk_id' value='<%=oper_role_pk_id %>' />
								</td>
							</TR>
							<TR>
								<td align="right">是否必须维护：</td>
								<td align="left">
									<input type='text' id='mustfill_flag' name='mustfill_flag' value='<%=mustfill_flag %>' />
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