<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css></HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>

<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
<%
int userID = user.getUID();
String starttime = Util.null2String(request.getParameter("starttime"));
String endtime = Util.null2String(request.getParameter("endtime"));
String amStart = Util.null2String(request.getParameter("amStart"));
String pmEnd = Util.null2String(request.getParameter("pmEnd"));
String datetype = Util.null2String(request.getParameter("datetype"));

String timeStart = starttime + amStart;
String timeEnd = endtime + pmEnd;

String sqlwhere = " where 1 = 1 ";

if(!starttime.equals("")&&!amStart.equals("")){
	sqlwhere += " and time >= '" + timeStart.replace("-","").replace(":","") + "' ";
}

if(!endtime.equals("")&&!pmEnd.equals("")){
	sqlwhere += " and time <= '" + timeEnd.replace("-","").replace(":","") + "' ";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=100;

%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "新品导入list合肥";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{导出当前页,javascript:_xtable_getExcel()(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;

	RCMenu += "{导出所有,javascript:_xtable_getAllExcel(),_self} " ;
	RCMenuHeight += RCMenuHeightStep;
	
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;

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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="NewProductIntroductionList_hf.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'></td>
			<td class=FIELD width='10%'>
				<span>选择查询时间:</span>
				<span class="wuiDateSpan" selectId="datetype1" selectValue="6"> 
				<input name="starttime"  type="hidden" value="<%=starttime%>"  class="wuiDateSel">
             	</span>
	            <INPUT type="hidden" id="amStart" name="amStart" value='<%=amStart%>'>
				<button type="button" class="Clock" ;" onclick="onShowTime1(amStartSpan,amStart)"></BUTTON>
	            <SPAN class="spanW" id="amStartSpan">
	             	<%if("".equals(amStart)){%>
	             	<%}else{out.print(amStart);}%>
	            </SPAN>
             	<span>-</span>
             	<span class="wuiDateSpan" selectId="datetype2"  selectValue="6"> 
				<input name="endtime" type="hidden"  value="<%=endtime%>"   class="wuiDateSel">	
             	</span>
				<INPUT type="hidden" id="pmEnd" name="pmEnd" value='<%=pmEnd%>'>
             	<button type="button" class="Clock" ;" onclick="onShowTime1(pmEndSpan,pmEnd)"></BUTTON>
              	<SPAN class="spanW" id="pmEndSpan">
              		<%if("".equals(pmEnd)){%>
              		<%}else{out.print(pmEnd);}%>
              	</SPAN>
			</td>
			<td NOWRAP width='25%'>
			<input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导出当前页" onclick="_xtable_getExcel()();">&nbsp;&nbsp;
			<input type="button" value="导出所有" onclick="_xtable_getAllExcel();">&nbsp;&nbsp;
			</td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " requestid , '合肥厂'as cq,Customer,type,Packageoutline,Customermtrldescription,Productmaterialcode,time ";
		            String fromSql  = " (select fm.requestid, cq,Customer,Decode(Producetype,'0','AT','1','AO') as type,Packageoutline,Customermtrldescription,Productmaterialcode,  \n" + 
		            				  " (replace(LASTOPERATEDATE,'-')||replace( LASTOPERATETIME,':')) as time  \n" + 
		            				  " from  formtable_main_149 fm ,Workflow_Requestbase wr \n" + 	
		            				  " where   fm.Requestid = Wr.Requestid  and wr.CURRENTNODETYPE = '3' and wr.workflowid = '3608'  \n" + 	
		            				  " Union all \n" + 	
		            				  " select fm.requestid, cq,Customer,Decode(Producetype,'0','AT','1','AO') as type,Packageoutline,Customermtrldescription, Productmaterialcode,  \n" + 
		            				  " (replace(LASTOPERATEDATE,'-')||replace( LASTOPERATETIME,':')) as time  \n" + 
		            				  " from  formtable_main_148 fm ,Workflow_Requestbase wr where  Fm.Requestid = Wr.Requestid and wr.CURRENTNODETYPE = '3'   \n" +       
		            				  " and wr.workflowid =  '3607' ) ";
		            String sqlWhere = sqlwhere;
		            String orderby = " time  " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\"  sqlprimarykey=\"requestid\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"15%\" text=\"厂区\" column=\"cq\" orderkey=\"cq\"  />"+
								 "			<col width=\"15%\" text=\"客户号\" column=\"Customer\" orderkey=\"Customer\"  />"+
								 "			<col width=\"15%\" text=\"生产类型\" column=\"type\" orderkey=\"type\"  />"+
								 "			<col width=\"15%\" text=\"封装外形\" column=\"Packageoutline\" orderkey=\"Packageoutline\"  />"+
								 "			<col width=\"15%\" text=\"品名描述\" column=\"Customermtrldescription\" orderkey=\"Customermtrldescription\"  />"+
								 "			<col width=\"15%\" text=\"产品料号\" column=\"Productmaterialcode\" orderkey=\"Productmaterialcode\"  />"+
								 "			<col width=\"15%\" text=\"导入时间\" column=\"time\" orderkey=\"time\"  />"+
		                         "		</head>"+
								 "		<operates width=\"10%\">";
					tableString +=		 "		</operates>"+
		                         " </table>";
		         	%>
		         <wea:SplitPageTag  tableString="<%=tableString%>" isShowTopInfo="false" mode="run" />
				</td>
			</tr>
			<tr>
		    </tr>
		</TABLE>
		</FORM>
		</td>
		</tr>
		</TABLE>
	</td>
	<td ></td>
</tr>
<tr>
	<td height="10" colspan="3">
	</td>
</tr>
</table>

<script language=javascript>
//查询
function doSearch(){
	document.frmmain.submit();
}

function onShowTime1(spanname,inputname){
	var dads  = document.getElementById("meizzDateLayer2").style;
	setLastSelectTime(inputname);
	var th = spanname;
	var ttop  = spanname.offsetTop; 
	var thei  = spanname.clientHeight;
	var tleft = spanname.offsetLeft; 
	var ttyp  = spanname.type;       
	while (spanname = spanname.offsetParent){
		ttop += spanname.offsetTop; 
		tleft += spanname.offsetLeft;
	}
	dads.top  = ((ttyp == "image") ? ttop + thei : ttop + thei + 22)+"px";
	dads.left = tleft+"px";
	outObject = th;
	outValue = inputname;
	outButton = (arguments.length == 1) ? null : th;
	dads.display = '';
	outType = 0;
	bShow = true;
}

window.onload = function(){  
	$("span:contains('选择查询时间:')").parent().children().find("span").eq(0).empty();
	$("span:contains('-')").next().find("span").eq(0).empty();
};
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>