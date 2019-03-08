<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page import="weaver.general.Util,java.util.List,java.util.ArrayList"%>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<html>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "fuck";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
    String workcode= Util.null2String(request.getParameter("workcode"));
    String site="",DEPART="",name="",create_time="",update_time ="",TOTAL_REJECT_QTY="", REJECTCODE1_QTY="",REJECTCODE2_QTY="" ,REJECTCODE3_QTY="",REJECTCODE4_QTY="",REJECTCODE5_QTY="",REJECTCODE6_QTY="";
	//String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	//String PKG_OUTLINE_FK = "",OPER_FK = "",SINGLE_ATTACH_TIME = "",ATTACH_CHANGE_WAFER_TIME="",SINGLE_WIRE_BOND_TIME="",SINGLE_NO_WIRE_TIME="",SINGLE_GRIND_TIME="",SCRIBE_METERS="",SCRIBE_CHANGE_WAFER_TIME="",UPH_FORMULA="" ;
	RecordSet rs = new RecordSet();
	if(!workcode.equals("")){
		rs.executeSql("select site,workcode,(select DEPARTMENTNAME from Hrmdepartment where id = OKEYUSERINF.DEPART ) as DEPART,name,create_time,update_time,TOTAL_REJECT_QTY,REJECTCODE1_QTY,REJECTCODE2_QTY,REJECTCODE3_QTY,REJECTCODE4_QTY, REJECTCODE5_QTY, REJECTCODE6_QTY from OKEYUSERINF where workcode ='"+workcode+"'");
		//rs.executeSql("select PKG_OUTLINE_FK,OPER_FK,SINGLE_ATTACH_TIME,ATTACH_CHANGE_WAFER_TIME,SINGLE_WIRE_BOND_TIME,SINGLE_NO_WIRE_TIME,SINGLE_GRIND_TIME,SCRIBE_METERS,SCRIBE_CHANGE_WAFER_TIME,UPH_FORMULA from MDM_UPH_RULE_cc where id ='"+id+"'");
		if(rs.next()){
			site = rs.getString("site");
			DEPART = rs.getString("DEPART");
			name = rs.getString("name");
			create_time = rs.getString("create_time");
			update_time = rs.getString("update_time");
			TOTAL_REJECT_QTY = rs.getString("TOTAL_REJECT_QTY");
			REJECTCODE1_QTY = rs.getString("REJECTCODE1_QTY");
			REJECTCODE2_QTY = rs.getString("REJECTCODE2_QTY");
			REJECTCODE3_QTY = rs.getString("REJECTCODE3_QTY");
			REJECTCODE4_QTY = rs.getString("REJECTCODE4_QTY");
			REJECTCODE5_QTY = rs.getString("REJECTCODE5_QTY");
			REJECTCODE6_QTY = rs.getString("REJECTCODE6_QTY");
		}
	}
	String type = "";
	String readOnly="";
	String hint="";
	if (workcode.equals("")) {
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='UserQualification.jsp',_self} ";
		RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
	<table width=100% height=100% border="0" cellspacing="0"	cellpadding="0">
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
			<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="OperationUserQualification.jsp" method=post>
				<input type=hidden name=type value='<%=type%>'>
				
			     <table style="width: 80%" class=ListStyle>
			     <tbody>
			     <TR>
					<td align="right">工厂：</td>
					<td align="left">
						<input type="hidden" id='site_id' name='site_id'  value='<%=site%>' />
					<select id='site'name='site'>
					<option value="1000">崇川厂</option>
					<option value="4000">苏通厂</option>
					<option value="5000">合肥厂</option>
                                        <option value="6100">SUZ</option>
					<option value="6200">PNG</option>
					</select>
					</td>
				 </TR>
				 <TR>
					<td align="right">部门：</td>
					<td align="left" >
					    <input type=hidden name='DEPARTCOPY' value='<%=DEPART%>'>
						<p><brow:browser name="DEPART" viewType="0" hasBrowser="true" hasAdd="false"
																	  browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp'
																	  isMustInput="2"
																	  isSingle="false"
																	  hasInput="true"
																	  completeUrl=""  width="200px"
																	  browserValue='<%=DEPART%>'
																	  browserSpanValue='<%=DEPART%>'
																	/>
						</p>
					</td>
				 </TR>
				  <TR>
					<td align="right">工号：</td>
					<td align="left">
					    <input type="hidden" id='workcodeup' name='workcodeup'  value='<%=workcode%>' />
						<input type='text' id='workcode' name='workcode'  value='<%=workcode%>' />
					</td>
				 </TR>
				 <TR>
					<td align="right">名字：</td>
					<td align="left">
						<input type='text' id='name' name='name'   value='<%=name%>' />
					</td>
				 </TR>
				 <TR>
					<td align="right">TOTAL_REJECT_QTY：</td>
					<td align="left">
						<input type='text' id='TOTAL_REJECT_QTY' name='TOTAL_REJECT_QTY' <%=readOnly%> value='<%=TOTAL_REJECT_QTY%>' /><%=hint%>
					</td>
				 </TR>
				 <TR>
					<td align="right">REJECTCODE1_QTY：</td>
					<td align="left">
						<input type='text' id='REJECTCODE1_QTY' name='REJECTCODE1_QTY'  <%=readOnly%> value='<%=REJECTCODE1_QTY%>' /><%=hint%>
					</td>
				 </TR>
				 <TR>
					<td align="right">REJECTCODE2_QTY：</td>
					<td align="left">
						<input type='text' id='REJECTCODE2_QTY' name='REJECTCODE2_QTY'  <%=readOnly%> value='<%=REJECTCODE2_QTY%>' /><%=hint%>
					</td>
				 </TR>
				 <TR>
					<td align="right">REJECTCODE3_QTY：</td>
					<td align="left">
						<input type='text' id='REJECTCODE3_QTY' name='REJECTCODE3_QTY'  <%=readOnly%> value='<%=REJECTCODE3_QTY%>' /><%=hint%>
					</td>
				 </TR>
				 <TR>
					<td align="right">REJECTCODE4_QTY：</td>
					<td align="left">
						<input type='text' id='REJECTCODE4_QTY' name='REJECTCODE4_QTY'  <%=readOnly%> value='<%=REJECTCODE4_QTY%>' /><%=hint%>
					</td>
				 </TR>
				 <TR>
					<td align="right">REJECTCODE5_QTY：</td>
					<td align="left">
						<input type='text' id='REJECTCODE5_QTY' name='REJECTCODE5_QTY'  <%=readOnly%> value='<%=REJECTCODE5_QTY%>' /><%=hint%>
					</td>
				 </TR>
				 <TR>
					<td align="right">REJECTCODE6_QTY：</td>
					<td align="left">
						<input type='text' id='REJECTCODE6_QTY' name='REJECTCODE6_QTY'  <%=readOnly%> value='<%=REJECTCODE6_QTY%>' /><%=hint%>
					</td>
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
	if(jQuery("#site_id").val()!=""){
		$("#site").attr("value",jQuery("#site_id").val());
	}
		function doSave(obj) {
			document.frmmain.submit();
		}
	</script>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>