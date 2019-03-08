<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@page import="weaver.conn.*"%>
<%@page import="weaver.general.BaseBean"%> 
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />



<HTML>
<HEAD><LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>

</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<!-- <script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script> -->
<%
    //这里是引入的jsp页面的必要参数
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "fuck you";
 	String needfav = "1";
	String needhelp = "";
	int nodeids[][]={{17880,17883},{17887,17890},{17893,17896}};
	
%>
<%
BaseBean bs = new BaseBean();
int userID = user.getUID();
bs.writeLog("userID:-----------"+userID);
String sql ="select SUBCOMPANYID1  from hrmresource where id="+userID;
rs.executeSql(sql);
bs.writeLog("sql:-----------"+sql);
rs.next();
String subid= rs.getString("SUBCOMPANYID1");
bs.writeLog("subid:-----------"+subid);
int factory=0;
if(subid.equals("1")){
	
}else if(subid.equals("121")){
	factory =1;
}else if(subid.equals("101")){
	factory =2;
}else {
}
bs.writeLog("factory:-----------"+factory);



String test_classification = Util.null2String(request.getParameter("test_classification"));
String khh = Util.null2String(request.getParameter("khh"));
String fzlx = Util.null2String(request.getParameter("fzlx"));
String starttime = Util.null2String(request.getParameter("starttime"));
String endtime = Util.null2String(request.getParameter("endtime"));//.replace("-","");
String datetype = Util.null2String(request.getParameter("datetype"));
String starttimeC = Util.null2String(request.getParameter("starttimeC"));
String endtimeC = Util.null2String(request.getParameter("endtimeC"));//.replace("-","");
String datetypeC = Util.null2String(request.getParameter("datetypeC"));
String sqlwhere = " where acceptance_date is not null"; 


 if(!test_classification.equals("")){  //实验分类
 	sqlwhere += " and test_classification =" + test_classification;
 	}else
 	{
 		sqlwhere += " and test_classification =0";
 	}
 
 if(!starttime.equals("")){     //委托日期
		sqlwhere += " and wtrq  >= '" + starttime + "'";
	}
 if(!endtime.equals("")){
		sqlwhere += " and wtrq  <= '" + endtime + " 23:59:59'";
	}
 if(!starttimeC.equals("")){     //委托日期
		sqlwhere += " and Completed_date  >= '" + starttimeC + "'";
	}
if(!endtimeC.equals("")){
		sqlwhere += " and Completed_date  <= '" + endtimeC + " 23:59:59'";
	}
 if(!khh.equals("")){
		sqlwhere += " and khh  ='" + khh + "'";
	}
 if(!fzlx.equals("")){
		sqlwhere += " and UPPER(fzlx) like '%" + fzlx.toUpperCase() + "%'";
	}


 
 //控制分页条件
 int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
 int	perpage=20;
 

%>
<BODY>
 <%@ include file="/systeminfo/TopTitle_wev8.jsp" %> 
 <%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %> 


<%
 	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
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
	<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="reliabilityExperimentOrder.jsp" method=post>
	<%  
	  String str="100%";
	  int test=0;
	  if(test_classification!=null&&!test_classification.equals("")){
		  test= Integer.valueOf(test_classification);
	  }
	 if(test==0||test==1||test==2) str="2000px";
	%>
	<table width='<%=str%>>' class=ViewForm>
	    <TR>
			        <td NOWRAP width='60px' style="text-align:right">实验分类:</td>
					<td class=FIELD width='10px'>
					<select id='test_classification'name='test_classification'>
					<option value="0">DOE实验</option> 
					<option value="1">定期监控</option> 
					<option value="2">考核实验</option> 
					<option value="3">BLR Drop Test</option> 
					<option value="4">BLR TC</option> 
					<option value="5">Shadow moire</option> 
					</select>
					</td>
					<td NOWRAP width='60px'>客户号：</td>
					<td class=FIELD width='10px'>
					<input type=text id='khh' name='khh' value='<%=khh%>'></td>
					<td NOWRAP width='60px'>PKG：</td>
					<td class=FIELD width='10px'>
					<input type=text id='fzlx' name='fzlx' value='<%=fzlx%>'></td>
					<td NOWRAP width='5%'>填表日期：&nbsp;&nbsp;
					<span class="wuiDateSpan" selectId="datetype" selectValue="<%=datetype%>"> 
					<input name="starttime" type="hidden"  value="<%=starttime%>"  class="wuiDateSel">
					<input name="endtime" type="hidden"  value="<%=endtime%>"   class="wuiDateSel">	
			        </span>
					</td>
					<td NOWRAP width='5%'>完成日期：&nbsp;&nbsp;
					<span class="wuiDateSpan" selectId="datetypeC" selectValue="<%=datetypeC%>"> 
					<input name="starttimeC" type="hidden"  value="<%=starttimeC%>"  class="wuiDateSel">
					<input name="endtimeC" type="hidden"  value="<%=endtimeC%>"   class="wuiDateSel">	
			        </span>
					</td>
					<td   NOWRAP width='20%'>&nbsp;&nbsp;
				    <input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
<!-- 					<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp; -->
<!-- 					<input type="button" value="模板下载" onclick="javascript:window.location.href='UserQualification.xls';">&nbsp;&nbsp; -->
					<input type="button" value="导出当前页" onclick="javascript:_xtable_getExcel()">&nbsp;&nbsp;
					<input type="button" value="导出所有" onclick="javascript:_xtable_getAllExcel()">
					</td>	
					<td></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=12></TD></TR>
	
	</table>
	
	<table width="<%=str%>">
	<tr>
	 <td valign="top" id="tablecontent">
  <%

  String fromSql  = "formtable_main_192 f1 Left Join (select requestid,nodeid,max(receivedate) as acceptance_date  from Workflow_Currentoperator group by requestid,nodeid) wc1 on wc1.requestid=f1.requestid and wc1.nodeid="+nodeids[factory][0]+" left join (select requestid,nodeid,max(OPERATEDATE) as Allocation_date  from Workflow_Currentoperator group by requestid,nodeid) wc2 on wc2.requestid=f1.requestid and wc2.nodeid="+nodeids[factory][1]+" Left Join (select requestid,nodeid,receivedate as Completed_date  from Workflow_Currentoperator ) wc3 on wc3.requestid=f1.requestid and wc3.nodeid=17878 ";
  String sqlWhere = sqlwhere;
  String orderby = "bgbh" ;
  String backfields="bgbh,(select lastname from Hrmresource hrs where Hrs.id=tbr)as tbr,to_char(to_date(wtrq,'yyyy-mm-dd'),'yyyy/fmmm/dd') wtrq,to_char(to_date(Allocation_date,'yyyy-mm-dd'),'yyyy/fmmm/dd') Allocation_date,f1.Cabinet_No,khh,pcs,fzlx,pm,zzph,(select SELECTNAME from workflow_selectitem where SELECTVALUE =f1.main_test_result and  fieldid =( select id from workflow_billfield where billid=-192 and fieldname ='main_test_result'))as main_test_result,(select lastname from Hrmresource hrs where Hrs.id=worker)as worker,to_char(to_date(Completed_date,'yyyy-mm-dd'),'yyyy/fmmm/dd') Completed_date";
 //to_char(to_date(Allocation_date,'yyyy-mm-dd'),'yyyy/fmmm/dd') Allocation_date,
  String tableStringFir= 
		     "			<col width=\"10%\" text=\"可靠性编号\" column=\"bgbh\" orderkey=\"bgbh\"  />"+
			 "			<col width=\"10%\" text=\"填表人\" column=\"tbr\" orderkey=\"tbr\"  />"+
			 "			<col width=\"10%\" text=\"委托日期\" column=\"wtrq\" orderkey=\"wtrq\"  />"+
     		 "			<col width=\"10%\" text=\"分配日期\" column=\"Allocation_date\" orderkey=\"Allocation_date\"  />"+
			 "			<col width=\"10%\" text=\"柜号\" column=\"Cabinet_No\" orderkey=\"Cabinet_No\"  />"+
			 "			<col width=\"10%\" text=\"客户号\" column=\"khh\" orderkey=\"khh\"  />"+
			 "			<col width=\"10%\" text=\"样品数\" column=\"pcs\" orderkey=\"pcs\"  />"+
			 "			<col width=\"10%\" text=\"PKG\" column=\"fzlx\" orderkey=\"fzlx\"  />"+
			 "			<col width=\"10%\" text=\"品名\" column=\"pm\" orderkey=\"pm\"  />"+
			 "			<col width=\"10%\" text=\"组装批号\" column=\"zzph\" orderkey=\"zzph\"  />"+
			 "			<col width=\"10%\" text=\"实验结果\" column=\"main_test_result\" orderkey=\"main_test_result\"  />"+
			 "			<col width=\"10%\" text=\"作业人\" column=\"worker\" orderkey=\"worker\"  />"+
			 "			<col width=\"10%\" text=\"存档日期\" column=\"Completed_date\" orderkey=\"Completed_date\"  />";
  //部门   完成日期
  //
  String tableStringSec="";
  String backfieldsSec="";
 
  String tableStringTr="<col width=\"10%\" text=\"备注\" column=\"bz\" orderkey=\"bz\"  />";
  String backfieldsTr=",bz";
  
  if(test==5){
		
  }
  else if(test==3||test==4){
	  backfieldsSec=",kjjb,PCB,SMT,first_fail,Ten_percent_fail,last_fail";
	  tableStringSec= 
			 //    "			<col width=\"10%\" text=\"location\" column=\"Cabinet_No\" orderkey=\"Cabinet_No\"  />"+
				 "			<col width=\"10%\" text=\"框架 / 基板\" column=\"kjjb\" orderkey=\"kjjb\"  />"+
				 "			<col width=\"10%\" text=\"PCB\" column=\"PCB\" orderkey=\"PCB\"  />"+
				 "			<col width=\"10%\" text=\"SMT\" column=\"SMT\" orderkey=\"SMT\"  />"+
				 "			<col width=\"10%\" text=\"1st Fail\" column=\"first_fail\" orderkey=\"first_fail\"  />"+
				 "			<col width=\"10%\" text=\"10% Fail\" column=\"Ten_percent_fail\" orderkey=\"Ten_percent_fail\"  />"+
				 "			<col width=\"10%\" text=\"63.2% Fail\" column=\"last_fail\" orderkey=\"last_fail\"  />";
  }
  else{
	  backfieldsSec=",khh||'-'||fzlx  as Customer_PKG,jhs,sfl,zpjhg,kjjb,zhj,ddxq,Test_item,Test_condition,"+
			  "to_char(to_date(in_date,'yyyy-mm-dd'),'yyyy/fmmm/dd') in_date,to_char(to_date(out_date,'yyyy-mm-dd'),'yyyy/fmmm/dd') out_date,to_char(to_date(Send_to_FT_date,'yyyy-mm-dd'),'yyyy/fmmm/dd') Send_to_FT_date,to_char(to_date(Receive_from_FT_date,'yyyy-mm-dd'),'yyyy/fmmm/dd') Receive_from_FT_date"+
			  ",(select SELECTNAME from workflow_selectitem where SELECTVALUE =f2.Test_result and  fieldid =( select id from workflow_billfield where billid=-192 and fieldname ='Test_result'))as Test_result,Status,FA_result,FA_failure_mode,FA_Report_No,Fail_Item,Remark";
  
	  tableStringSec= 
			     "			<col width=\"10%\" text=\"Customer-PKG\" column=\"Customer_PKG\" orderkey=\"Customer_PKG\"  />"+
			     "			<col width=\"10%\" text=\"键合丝\" column=\"jhs\" orderkey=\"jhs\"  />"+
				 "			<col width=\"10%\" text=\"塑封料/Underfill\" column=\"sfl\" orderkey=\"sfl\"  />"+
				 "			<col width=\"10%\" text=\"装片胶/焊膏\" column=\"zpjhg\" orderkey=\"zpjhg\"  />"+
				 "			<col width=\"10%\" text=\"框架 / 基板\" column=\"kjjb\" orderkey=\"kjjb\"  />"+
				 "			<col width=\"10%\" text=\"助焊剂\" column=\"zhj\" orderkey=\"zhj\"  />"+
				 "			<col width=\"10%\" text=\"电镀/焊球\" column=\"ddxq\" orderkey=\"ddxq\"  />"+
				 "			<col width=\"10%\" text=\"Test Item\" column=\"Test_item\" orderkey=\"Test_item\"  />"+
				 "			<col width=\"10%\" text=\"Test condition\" column=\"Test_condition\" orderkey=\"Test_condition\"  />"+
				 "			<col width=\"10%\" text=\"In date\" column=\"in_date\" orderkey=\"in_date\"  />"+
				 "			<col width=\"10%\" text=\"Out date\" column=\"out_date\" orderkey=\"out_date\"  />"+
				 "			<col width=\"10%\" text=\"Send to FT date\" column=\"Send_to_FT_date\" orderkey=\"Send_to_FT_date\"  />"+
				 "			<col width=\"10%\" text=\"Receive from FT date\" column=\"Receive_from_FT_date\" orderkey=\"Receive_from_FT_date\"  />"+
				 "			<col width=\"10%\" text=\"Test result\" column=\"Test_result\" orderkey=\"Test_result\"  />"+
				 "			<col width=\"10%\" text=\"Status\" column=\"Status\" orderkey=\"Status\"  />"+
				 "			<col width=\"10%\" text=\"FA result\" column=\"FA_result\" orderkey=\"FA_result\"  />"+
				 "			<col width=\"10%\" text=\"FA failure mode\" column=\"FA_failure_mode\" orderkey=\"FA_failure_mode\"  />"+
				 "			<col width=\"10%\" text=\"FA Report No\" column=\"FA_Report_No\" orderkey=\"FA_Report_No\"  />"+
				 "			<col width=\"10%\" text=\"Fail Item\" column=\"Fail_Item\" orderkey=\"Fail_Item\"  />"+
				 "			<col width=\"10%\" text=\"Remark\" column=\"Remark\" orderkey=\"Remark\"  />";
				fromSql  = fromSql+" left join formtable_main_192_dt1 f2 on f1.id=f2.mainid";
			    sqlWhere = sqlwhere+"";
			    backfields="(select SELECTNAME from workflow_selectitem where SELECTVALUE =f1.assy_location and  fieldid =( select id from workflow_billfield where billid=-192 and fieldname ='assy_location'))as cpcd,"+backfields;
			    tableStringFir="<col width=\"10%\" text=\"产品产地\" column=\"cpcd\" orderkey=\"cpcd\"  />"+tableStringFir;
			     orderby += ",f2.id asc" ;
  }
  		     		           
					     		           
					     		           
					     		            String tableString = "";
					     		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
					     		                         "		<sql backfields=\""+backfields+backfieldsSec+backfieldsTr+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"bgbh\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
					     		                         "		<head>"+
					     		                        tableStringFir+tableStringSec+tableStringTr+
					     		                         "		</head>"+
					     								 "		<operates width=\"10%\">";
// 					     					tableString +=		 "    		<operate href=\"javascript:doEdit()\"  text=\"修改\" target=\"_self\" index=\"0\"/>";
// 					     					tableString +=		 "    		<operate href=\"javascript:doDel()\"  text=\"删除\" target=\"_self\" index=\"0\"/>";
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

 $("#test_classification").attr("value",<%=test%>);
 $("#test_classification").change(function(){
	 document.frmmain.submit();
 });

</script>
</BODY>
 <style>

 </style>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</HTML>