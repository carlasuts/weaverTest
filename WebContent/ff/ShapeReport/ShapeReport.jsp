<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />


<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>

</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<!-- <script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script> -->
<%

	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "封装外形报表";
 	String needfav = "1";
	String needhelp = "";
%>
<%
int userID = user.getUID();
String name = Util.null2String(request.getParameter("name"));
String sqlwhere = " where 1 = 1 "; 
if(!name.equals("")){
 	sqlwhere += " and name ='" + name+"'";
 	}



int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;

%>

<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>


	<%
 	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
 	RCMenuHeight += RCMenuHeightStep ;
 	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",UpdateShapeReport.jsp,_self} " ;
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
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>


	<table width=100% height=100% border="0" cellspacing="0"
		cellpadding="0">
		<colgroup>
			<col width="10">
			<col width="">
			<col width="10">
		<!-- 美观  页面布局-->
		<tr>
			<td height="10" colspan="3"></td>
		</tr>



		<tr>
			<td></td>
			<td valign="top">
				<TABLE class=Shadow>
					<tr>
						<td valign="top">
							<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0"
								action="ShapeReport.jsp" method=post>
								<table width=100% class=ViewForm>
									<TR>
										<td NOWRAP width='5%' style="text-align: right">封装外形:</td>
										<td class=FIELD width='5%'>
										<input type=text id='name' name='name' value='<%=name%>'>		
										</td>


										<td NOWRAP width='30%'>&nbsp;&nbsp; <input type="button"
											value="搜索" onclick="doSearch();">&nbsp;&nbsp; <input
											type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
											<input type="button" value="模板下载"
											onclick="javascript:window.location.href='ShapeReport.xls';">&nbsp;&nbsp;
											<input type="button" value="导出当前页"
											onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
											<input type="button" value="导出所有"
											onclick="javascript:_xtable_getAllExcel()">
										</td>

									</TR>
									<TR class=Spacing>
										<TD class=Line1 colspan=3></TD>
									</TR>

								</table>

								<table width="100%">
									<tr>
										<td valign="top" id="tablecontent">
											<%
					                        String backfields = "id,name,case to_char(FACTORY_FK) when '0000' then '圆片厂' when '1000' then '一期厂' when '2000' then '二期厂' when '3000' then '三期厂' when '4000' then '合肥厂' when '5000' then '苏通厂' end as FACTORY";
					     		            String fromSql  = "MD_SD_QTTN_PKG";
					     		            String sqlWhere = sqlwhere;
					     		            String orderby = "id" ;
					     		            String tableString = "";
					     		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
					     		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
					     		                         "		<head>"+
					     								 "			<col width=\"10%\" text=\"id\" column=\"id\" orderkey=\"id\"  />"+
					     								 "			<col width=\"10%\" text=\"封装外形\" column=\"name\" orderkey=\"name\"  />"+
					     								 "			<col width=\"10%\" text=\"厂区\" column=\"FACTORY\" orderkey=\"as FACTORY\"  />"+
					     		                         "		</head>"+
					     								 "		<operates width=\"10%\">";
					     					tableString +=		 "    		<operate href=\"javascript:doEdit()\"  text=\"修改\" target=\"_self\" index=\"0\"/>";
					     					tableString +=		 "    		<operate href=\"javascript:doDel()\"  text=\"删除\" target=\"_self\" index=\"0\"/>";
					     					tableString +=		 "		</operates>"+
					     		                         " </table>";
	 %> <wea:SplitPageTag tableString="<%=tableString%>"
												isShowTopInfo="false" mode="run" />
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
			<td></td>
		</tr>




		<!-- 美观 -->
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
	document.frmmain.action = "UpdateShapeReport.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
// 导入
function doImportExcel(){
	var rvalue = window.showModalDialog("ShapeReportExcel.jsp");
	if(rvalue > 0){
		window.location.href = "ShapeReport.jsp";
	}
}
 function doDownload(){
	window.location.href='ShapeReport.xls';
} 
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="ShapeReportOperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}


</script>
</BODY>
<style>
</style>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</HTML>