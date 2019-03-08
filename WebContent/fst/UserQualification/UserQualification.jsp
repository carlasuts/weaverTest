<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />




<HTML>
<HEAD><LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>

</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%

	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "fuck you";
 	String needfav = "1";
	String needhelp = "";
%>
<%
 int userID = user.getUID();

 String site = Util.null2String(request.getParameter("site"));
 String workcode= Util.null2String(request.getParameter("workcode"));
 String DEPART = Util.null2String(request.getParameter("DEPART"));
 String name = Util.null2String(request.getParameter("name"));
 String sqlwhere = " where 1 = 1 "; 

 if(!site.equals("")){
 	sqlwhere += " and site =" + site;
 	}

 if(!workcode.equals("")){
 	sqlwhere +=" and workcode like '%" + workcode + "%'";
 }
 
 if(!DEPART.equals("")){
	 sqlwhere +=" and DEPART like '%" + DEPART + "%'";
	 }
 if(!name.equals("")){
	 sqlwhere +=" and name like '%" + name + "%'";
	 }

 
 int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
 int	perpage=10;
%>
<BODY>
 <%@ include file="/systeminfo/TopTitle_wev8.jsp" %> 
 <%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %> 


<%
 	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
 	RCMenuHeight += RCMenuHeightStep ;
 	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",UpdateUserQualification.jsp,_self} " ;
 	RCMenuHeight += RCMenuHeightStep ; 
   	RCMenu += "{导入excel,javascript:doImportExcel(),_self} " ;
 	RCMenuHeight += RCMenuHeightStep ;
 	RCMenu += "{模板下载,javascript:doDownload(),_self} " ;
 	RCMenuHeight += RCMenuHeightStep ; 
 	RCMenu += "{导出当前页,javascript:_xtable_getExcel(),_self} " ;
 	RCMenuHeight += RCMenuHeightStep;
 	RCMenu += "{导出所有,javascript:_xtable_getAllExcel(),_self} " ;
 	RCMenuHeight += RCMenuHeightStep; 
 	 

%>
 <%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %> 


<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
	<td height="10" colspan="3"></td>
</tr>



<tr>
<td ></td>
<td valign="top">
	<TABLE class=Shadow>
	<tr>
	<td valign="top" >
	<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="UserQualification.jsp" method=post>
	<table width=100% class=ViewForm>
	    <TR>
			        <td NOWRAP width='5%' style="text-align:right">厂区:</td>
					<td class=FIELD width='5%'>
					<input type=text id='site' name='site' value='<%=site%>'></td>
					
					<td NOWRAP width='5%' style="text-align:right">工号:</td>
					<td class=FIELD width='5%'>
					<input type=text id='workcode' name='workcode' value='<%=workcode%>'></td>
				    <td NOWRAP width='5%' style="text-align:right">名字:</td>	
				    <td class=FIELD width='5%'>
				    <input type=text id='name' name='name' value='<%=name%>'>
					</td>
					<td style="width:5%;text-align:right">部门:</td>
					<td style="width:10%;text-align:left">
						 
						<p><brow:browser name="DEPART" viewType="0" hasBrowser="true" hasAdd="false"
																	  browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp'
																	  isMustInput="1"
																	  isSingle="false"
																	  hasInput="true"
																	  completeUrl=""  width="200px"
																	  browserValue='<%=DEPART%>'
																	  browserSpanValue='<%=DEPART%>'
																	/>
						</p>
					</td>	
					<td   NOWRAP width='30%'>&nbsp;&nbsp;
				    <input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
					<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
					<input type="button" value="模板下载" onclick="javascript:window.location.href='UserQualification.xls';">&nbsp;&nbsp;
					<input type="button" value="导出当前页" onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
					<input type="button" value="导出所有" onclick="javascript:_xtable_getAllExcel()">
					</td>	
					
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=12></TD></TR>
	
	</table>
	
	<table width="100%">
	<tr>
	 <td valign="top" id="tablecontent">
  <%
					                        String backfields = "site,workcode,(select DEPARTMENTNAME from Hrmdepartment where id = OKEYUSERINF.DEPART ) as DEPART,name,create_time,update_time,TOTAL_REJECT_QTY,REJECTCODE1_QTY,REJECTCODE2_QTY,REJECTCODE3_QTY,REJECTCODE4_QTY, REJECTCODE5_QTY, REJECTCODE6_QTY";
					     		            String fromSql  = "OKEYUSERINF";
					     		            String sqlWhere = sqlwhere;
					     		            String orderby = "site" ;
					     		            String tableString = "";
					     		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
					     		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"workcode\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
					     		                         "		<head>"+
					     								 "			<col width=\"10%\" text=\"厂区\" column=\"site\" orderkey=\"site\"  />"+
					     								 "			<col width=\"10%\" text=\"工号\" column=\"workcode\" orderkey=\"workcode\"  />"+
					     								 "			<col width=\"10%\" text=\"部门\" column=\"DEPART\" orderkey=\"DEPART\"  />"+
					     								 "			<col width=\"10%\" text=\"名字\" column=\"name\" orderkey=\"name\"  />"+
					     								 "			<col width=\"10%\" text=\"TOTAL_REJECT_QTY\" column=\"TOTAL_REJECT_QTY\" orderkey=\"TOTAL_REJECT_QTY\"  />"+
					     								 "			<col width=\"10%\" text=\"REJECTCODE1_QTY\" column=\"REJECTCODE1_QTY\" orderkey=\"REJECTCODE1_QTY\"  />"+
					     								 "			<col width=\"10%\" text=\"REJECTCODE2_QTY\" column=\"REJECTCODE2_QTY\" orderkey=\"REJECTCODE2_QTY\"  />"+
					     								 "			<col width=\"10%\" text=\"REJECTCODE3_QTY\" column=\"REJECTCODE3_QTY\" orderkey=\"REJECTCODE3_QTY\"  />"+
					     								 "			<col width=\"10%\" text=\"REJECTCODE4_QTY\" column=\"REJECTCODE4_QTY\" orderkey=\"REJECTCODE4_QTY\"  />"+
					     								 "			<col width=\"10%\" text=\"REJECTCODE5_QTY\" column=\"REJECTCODE5_QTY\" orderkey=\"REJECTCODE5_QTY\"  />"+
					     								 "			<col width=\"10%\" text=\"REJECTCODE6_QTY\" column=\"REJECTCODE6_QTY\" orderkey=\"REJECTCODE6_QTY\"  />"+
					     								"			<col width=\"10%\" text=\"创建时间\" column=\"create_time\" orderkey=\"create_time\"  />"+
							     						"			<col width=\"10%\" text=\"更新时间\" column=\"update_time\" orderkey=\"update_time\"  />"+
					     		                         "		</head>"+
					     								 "		<operates width=\"10%\">";
					     					tableString +=		 "    		<operate href=\"javascript:doEdit()\"  text=\"修改\" target=\"_self\" index=\"0\"/>";
					     					tableString +=		 "    		<operate href=\"javascript:doDel()\"  text=\"删除\" target=\"_self\" index=\"0\"/>";
					     					tableString +=		 "		</operates>"+
					     		                         " </table>";
	 %> 
	 		          
	 <wea:SplitPageTag  tableString="<%=tableString%>" isShowTopInfo="false" mode="run" />
	 </td>
	</tr>
	<tr>
	</tr>
	</table>
	</FORM>
	</td>
	</tr>
	</TABLE>
</td>
<td ></td>
</tr>





<tr>
	<td height="10" colspan="3"></td>
</tr>
</table>






<script language=javascript>
//查询
function doSearch(){
	Console.log("hhh"+document.cookie);
	document.frmmain.submit();
}
//修改
function doEdit(workcode){
	document.frmmain.action = "UpdateUserQualification.jsp?type=modi&workcode="+workcode;
	document.frmmain.submit();
}
// 导入
function doImportExcel(){
	var rvalue = window.showModalDialog("UserQualificationExcel.jsp");
	if(rvalue > 0){
		window.location.href = "UserQualification.jsp";
	}
}
 function doDownload(){
	window.location.href='UserQualification.xls';
} 
function doDel(workcode){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="OperationUserQualification.jsp?type=del&workcode="+workcode;
		document.frmmain.submit();	
	}
}
</script>
</BODY>
 <style>
        #tablecontent table tr th{
            font-size: 1pt;
        }
         #tablecontent table tr td:nth-child(3){
            font-size: 1px;
        }
  
 </style>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</HTML>