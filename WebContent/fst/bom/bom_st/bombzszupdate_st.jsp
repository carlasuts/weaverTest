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
	String titlename = "BOM标准设置";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String factory = "",cust_id = "",pkld_grp = "",pkld="",pkld_com="",oper_grp="",mat_type="",mat_id="",mat_desc="" ,qty_1="",storage_location="",mustfill_flag="";

	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select factory,cust_id,pkld_grp,pkld,pkld_com,oper_grp,mat_type,mat_id,mat_desc,qty_1,storage_location,mustfill_flag,create_user_id,create_time,update_user_id,update_time from obomsetmat_st where id ='"+id+"'");
		if(rs.next()){
			factory = rs.getString("factory");
			cust_id = rs.getString("cust_id");
			pkld_grp = rs.getString("pkld_grp");
			pkld = rs.getString("pkld");
			pkld_com = rs.getString("pkld_com");
			oper_grp = rs.getString("oper_grp");
			mat_type = rs.getString("mat_type");
			mat_id = rs.getString("mat_id");
			mat_desc = rs.getString("mat_desc");
			qty_1 = rs.getString("qty_1");
			storage_location = rs.getString("storage_location");
			mustfill_flag = rs.getString("mustfill_flag");
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='bombzsz_st.jsp',_self} ";
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
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="bombzszoperation_st.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">工厂：</td>
								<td align="left">
									<input type='text' id='factory' name='factory' value='<%=factory %>' />
								</td>
							</TR>
							<TR>
								<td align="right">客户名：</td>
								<td align="left">
									<input type='text' id='cust_id' name='cust_id' value='<%=cust_id %>' />
								</td>
							</TR>
							<TR>
								<td align="right">外形组：</td>
								<td align="left">
									<input type='text' id='pkld_grp' name='pkld_grp' value='<%=pkld_grp %>' />
								</td>
							</TR>
							<TR>
								<td align="right">外形：</td>
								<td align="left">
									<input type='text' id='pkld' name='pkld' value='<%=pkld %>' />
								</td>
							</TR>
							<TR>
								<td align="right">外形备注：</td>
								<td align="left">
									<input type='text' id='pkld_com' name='pkld_com' value='<%=pkld_com %>' />
								</td>
							</TR>
							<TR>
								<td align="right">工序组：</td>
								<td align="left">
									<input type='text' id='oper_grp' name='oper_grp' value='<%=oper_grp %>' />
								</td>
							</TR>
							<TR>
								<td align="right">材料类型：</td>
								<td align="left">
									<input type='text' id='mat_type' name='mat_type' value='<%=mat_type %>' />
								</td>
							</TR>
							<TR>
								<td align="right">料号：</td>
								<td align="left">
									<input type='text' id='mat_id' name='mat_id' value='<%=mat_id %>' />
								</td>
							</TR>
							<TR>
								<td align="right">料号描述：</td>
								<td align="left">
									<input type='text' id='mat_desc' name='mat_desc' value='<%=mat_desc %>' />
								</td>
							</TR>
							<TR>
								<td align="right">组件数量：</td>
								<td align="left">
									<input type='text' id='qty_1' name='qty_1' value='<%=qty_1 %>' />
								</td>
							</TR>
							<TR>
								<td align="right">生产仓存地点：</td>
								<td align="left">
									<input type='text' id='storage_location' name='storage_location' value='<%=storage_location %>' />
								</td>
							</TR>
							<TR>
								<td align="right">是否必填：</td>
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