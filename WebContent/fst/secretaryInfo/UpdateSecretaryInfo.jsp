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
<!-- <script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script> -->
<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "fuck";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
   
    String id= Util.null2String(request.getParameter("id"));    
    String site="",department="",workcode="",name="",create_time="",update_time ="";
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select site,department,workcode  from OBASSECDOP where id ='"+id+"'");
		if(rs.next()){
			site = rs.getString("site");
			department = rs.getString("department");
			workcode = rs.getString("workcode");
	
		}
	}
	String sql="";
	String userid="";
	
	String subcompanyname="";
	String departmentname="";
	 String sql1="select subcompanyname from Hrmsubcompany where id="+site;
	 String sql2="select departmentname from Hrmdepartment where id="+department;
	 
	//姓名浏览
	sql ="select id,lastname from HrmResource where workcode='"+workcode+"'";
	rs.executeSql(sql);
	if(rs.next()){
		userid = rs.getString("id");
		name = rs.getString("lastname");

	}
	rs.executeSql(sql1);
	if(rs.next()){
		subcompanyname = rs.getString("subcompanyname");

	}
	rs.executeSql(sql2);
	if(rs.next()){
		departmentname = rs.getString("departmentname");

	}
	
	String type = "";
	String readOnly="2";
	String readName="2";
	String hint="";
	if (id.equals("")) {
		type = "add";
	} else {
		type = "modi";
		readOnly="0";
		readName="1";
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
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='secretaryInfo.jsp',_self} ";
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
			<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="OperationsecretaryInfo.jsp" method=post>
				<input type=hidden name=type value='<%=type%>'>
				<input type=hidden name=id value='<%=id%>'>
				
			     <table style="width: 80%" class=ListStyle>
			     <tbody>
			     <TR>
					<td style="width:5%;text-align:right">分部:</td>
					<td style="width:10%;text-align:left">
						
						<p><brow:browser name="site" viewType="0" hasBrowser="true" hasAdd="false"
																	  browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp'
																	  isMustInput="<%=readName%>"
																	  isSingle="false"
																	  hasInput="true"
																	  completeUrl="/data.jsp?type=164"
																	  isAutoComplete = "true" 
																	  width="200px"
																	  browserValue='<%=site%>'
																	  browserSpanValue='<%=subcompanyname%>'
																	/>
						</p>
					</td>	 
				 </TR>
				 <TR>
					<td style="width:5%;text-align:right">部门:</td>
					<td style="width:10%;text-align:left">
						<p><brow:browser name="department" viewType="0" hasBrowser="true" hasAdd="false"
																	  browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp'
																	  isMustInput="<%=readName%>"
																	  isSingle="false"
																	  hasInput="true"
																	   completeUrl="/data.jsp?type=4"
																	  isAutoComplete = "true" 
																	  width="200px"
																	  browserValue='<%=department%>'
																	  browserSpanValue='<%=departmentname%>'
																	/>
						</p>
					</td>
				 </TR>
				 <TR>
					 <td NOWRAP width='5%' style="text-align:right">姓名:</td>	
				    <td class=FIELD width='10%'>
				    <p><brow:browser name="workcode" viewType="0" hasBrowser="true" hasAdd="false"
																	  browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp'
																	  isMustInput="<%=readName%>"
																	  isSingle="false"
																	  hasInput="true"
																	  completeUrl="/data.jsp?type=1"
																	  isAutoComplete = "true" 
																	  width="200px"
																	  browserValue='<%=userid%>'
																	  browserSpanValue='<%=name%>'
																	/>
						</p>
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

		function doSave(obj) {
			document.frmmain.submit();
		}
	</script>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>