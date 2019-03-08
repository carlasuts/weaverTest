<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />



<HTML>
<HEAD><LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>

</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<!-- <script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script> -->
<%

	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "fuck you";
 	String needfav = "1";
	String needhelp = "";
%>
<%
 int userID = user.getUID();

 //String company = Util.null2String(request.getParameter("company"));
 String DEPART = Util.null2String(request.getParameter("DEPART"));
 String name = Util.null2String(request.getParameter("name"));
 String company = Util.null2String(request.getParameter("company"));
 String wokecode = Util.null2String(request.getParameter("wokecode"));
 String sqlwhere = " where 1 = 1 "; 
 //名字
 String realName="";
 String departName="";
 String companyName="";
 String sql="select lastname from HrmResource hrs where id="+name;
 String sql1="select DEPARTMENTNAME from Hrmdepartment where id="+DEPART;
 String sql2="select subcompanyname from Hrmsubcompany where id="+company;
/*  if(!company.equals("")){
 	sqlwhere += " and site =" + company;
 	} */
 
 if(!DEPART.equals("")){
	 sqlwhere +=" and DEPARTMENT = '" + DEPART + "'";
	 rs.executeSql(sql1);
	 if(rs.next()){
		 departName=rs.getString("DEPARTMENTNAME");
	 }
		
	 }
if(!company.equals("")){
 		 sqlwhere +=" and site = '" + company + "'";
 		 rs.executeSql(sql2);
 		 if(rs.next()){
 			companyName=rs.getString("subcompanyname");
 		 }
 			
 		 }
if(!wokecode.equals(""))
{
	 sqlwhere +=" and WORKCODE ="+wokecode;
}
 if(!name.equals("")){
	 sqlwhere +=" and workcode =(select hrs.loginid from HrmResource hrs where hrs.id="+name+")";
	 rs.executeSql(sql);
	 if(rs.next()){
		 realName=rs.getString("lastname");
	 }	
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
  	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",UpdateSecretaryInfo.jsp,_self} " ;
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
	<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="secretaryInfo.jsp" method=post>
	<table width=100% class=ViewForm>
	    <TR>	     
	                <td style="width:5%;text-align:right">分部:</td>
					<td style="width:10%;text-align:left">
						 
						<p><brow:browser name="company" viewType="0" hasBrowser="true" hasAdd="false"
																	  browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp'
																	  isMustInput="1"
																	  isSingle="false"
																	  hasInput="true"
																	  completeUrl="/data.jsp?type=164"
																	  isAutoComplete = "true" 
																	  width="200px"
																	  browserValue='<%=company%>'
																	  browserSpanValue='<%=companyName%>'
																	/>
						</p>
					</td>	 
					<td style="width:5%;text-align:right">部门:</td>
					<td style="width:10%;text-align:left">
						 
						<p><brow:browser name="DEPART" viewType="0" hasBrowser="true" hasAdd="false"
																	  browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp'
																	  isMustInput="1"
																	  isSingle="false"
																	  hasInput="true"
																	  completeUrl="/data.jsp?type=4"
																	  isAutoComplete = "true" 
																	  width="200px"
																	  browserValue='<%=DEPART%>'
																	  browserSpanValue='<%=departName%>'
																	/>
						</p>
					</td><td></td>	</tr><tr>
		            <td NOWRAP width='5%' style="text-align:right">工号:</td>
					<td class=FIELD width='5%'>
					<input type="text" id='wokecode' name='wokecode' value='<%=wokecode%>'>
					</td>
				    <td NOWRAP width='5%' style="text-align:right">姓名:</td>	
				    <td class=FIELD width='10%'>
				    <p><brow:browser name="name" viewType="0" hasBrowser="true" hasAdd="false"
																	  browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp'
																	  isMustInput="1"
																	  isSingle="false"
																	  hasInput="true"
																	  completeUrl="/data.jsp?type=1"
																	  isAutoComplete = "true" 
																	  width="200px"
																	  browserValue='<%=name%>'
																	  browserSpanValue='<%=realName%>'
																	/>
						</p>
					</td>
					
					<td   NOWRAP width='30%'>&nbsp;&nbsp;
				    <input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
					<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
					<input type="button" value="模板下载" onclick="javascript:window.location.href='secretaryInfo.xls';">&nbsp;&nbsp;
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
											String backfields ="id,(select subcompanyname from Hrmsubcompany hb where os.site=hb.id) company ,(select departmentname from Hrmdepartment hp where hp.id=os.department) depart,WORKCODE,LASTNAME,CREATER,CREATETIME,UPDATER,UPDATETIME";
					     		            String fromSql  = "OBASSECDOP os";
					     		            String sqlWhere = sqlwhere;
					     		            String orderby = "id" ;
					     		            String tableString = "";
					     		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
					     		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
					     		                         "		<head>"+
					     								 "			<col width=\"10%\" text=\"分部\" column=\"company\" orderkey=\"company\"  />"+
					     								 "			<col width=\"10%\" text=\"部门\" column=\"depart\" orderkey=\"depart\"  />"+
					     								 "			<col width=\"10%\" text=\"工号\" column=\"WORKCODE\" orderkey=\"WORKCODE\"  />"+
					     								"			<col width=\"10%\" text=\"姓名\" column=\"LASTNAME\" orderkey=\"LASTNAME\"  />"+
					     								"			<col width=\"10%\" text=\"创建人工号\" column=\"CREATER\" orderkey=\"CREATER\"  />"+
					     								"			<col width=\"10%\" text=\"创建时间\" column=\"CREATETIME\" orderkey=\"CREATETIME\"  />"+
					     								 "			<col width=\"10%\" text=\"更新人工号\" column=\"UPDATER\" orderkey=\"UPDATER\"  />"+
					     								 "			<col width=\"10%\" text=\"更新时间\" column=\"UPDATETIME\" orderkey=\"UPDATETIME\"  />"+
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
	document.frmmain.submit();
}
//修改
function doEdit(id){
	document.frmmain.action = "UpdateSecretaryInfo.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
// 导入
function doImportExcel(){
	var rvalue = window.showModalDialog("secretaryInfoExcel.jsp");
	if(rvalue > 0){
		window.location.href = "secretaryInfo.jsp";
	}
}
 function doDownload(){
	window.location.href='secretaryInfo.xls';
} 
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="OperationsecretaryInfo.jsp?type=del&id="+id;
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