<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.general.BaseBean"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
int userID = user.getUID();

String custid = Util.null2String(request.getParameter("custid"));
String tzlxname = Util.null2String(request.getParameter("tzlxname"));
String tzbh = Util.null2String(request.getParameter("tzbh"));
String tzbb = Util.null2String(request.getParameter("tzbb"));
String pkg = Util.null2String(request.getParameter("pkg"));
String pkld = Util.null2String(request.getParameter("pkld"));
String custmat = Util.null2String(request.getParameter("custmat"));
String matdesc = Util.null2String(request.getParameter("matdesc"));

String gcname_id = Util.null2String(request.getParameter("gcname_id"));
String tzlxname_id = Util.null2String(request.getParameter("tzlxname_id"));

String sqlwhere = " where 1 = 1 and (tzbb, tzbh) in (select max(To_Number(tzbb)),tzbh from  otecdrmedef_hf group by tzbh) and WORLFLOWCLOSE = 'Y'  ";

if(!custid.equals("")){
	sqlwhere += " and custid like '%" + custid + "%'";
}


if(!tzlxname.equals("")){
	sqlwhere += " and tzlxname like '%" + tzlxname + "%'";
}

if(!tzbh.equals("")){
	sqlwhere += " and tzbh like '%" + tzbh + "%'";
}

if(!tzbb.equals("")){
	sqlwhere += " and tzbb like '%" + tzbb + "%'";
}
if(!custmat.equals("")){
	sqlwhere += " and custmat like '%" + custmat + "%'";
}

if(!pkld.equals("")){
	sqlwhere += " and pkld like '%" + pkld + "%'";
}

if(!matdesc.equals("")){
	sqlwhere += " and matdesc like '%" + matdesc + "%'";
}


int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "技术图纸查询";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
<table  width=100% height=100% border="0" cellspacing="0" cellpadding="0">
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="otecdrmedef_done.jsp" method=post>
		<input type="hidden" id="gcname_id" name="gcname_id" value="<%=gcname_id%>">	
		<input type="hidden" id="tzlxname_id" name="tzlxname_id" value="<%=tzlxname_id%>">	
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>图纸类型</td>
			<td class=FIELD width='10%'>
			<select name="tzlxname" id='tzlxname'>  
				<option value=""></option>  
				<option value="配线图">配线图</option>  
				<option value="打印图">打印图</option>  
				<option value="引线框图">引线框图</option>  
				<option value="制造图">制造图</option>  
				<option value="产品图">产品图</option>  
				<option value="辅助材料图">辅助材料图</option>  
				<option value="基板图">基板图</option>  
			</select> </td>
			<td NOWRAP width='5%'>图纸编号</td>
			<td class=FIELD width='10%'>
			<input type=text id='tzbh' name='tzbh' value='<%=tzbh%>'></td>
			<td NOWRAP width='5%'>图纸版本</td>
			<td class=FIELD width='10%'>
			<input type=text id='tzbb' name='tzbb' value='<%=tzbb%>'></td>
		</TR> 
		<TR>
			<td NOWRAP width='5%'>客户号</td>
			<td class=FIELD width='10%'>
			<input type=text id='custid' name='custid' value='<%=custid%>'></td>
			<td NOWRAP width='5%'>客户品名</td>
			<td class=FIELD width='10%'>
			<input type=text id='custmat' name='custmat' value='<%=custmat%>'></td> 
			<td NOWRAP width='5%'>品名描述</td>
			<td class=FIELD width='10%'>
			<input type=text id='matdesc' name='matdesc' value='<%=matdesc%>'></td>
 			<td NOWRAP width='5%'>封装外形</td>
			<td class=FIELD width='10%'>
			<input type=text id='pkld' name='pkld' value='<%=pkld%>'></td>
			<td NOWRAP width='5%'>
			<input type="button" value="搜索" onclick="doSearch();">
			</td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=6></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = "custmat,custid,TZLXNAME,tzbh,tzbb,pkg,pkld,CREATE_TIME,matdesc ";
		            String fromSql  = " otecdrmedef_hf ";
		            String sqlWhere = sqlwhere;
		            String orderby = " tzbh " ;
		            String tableString = "";
		            tableString =" <table  instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\"  sqlprimarykey=\"tzbh\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								 "			<col width=\"5%\" text=\"图纸类型\" column=\"tzlxname\" orderkey=\"tzlxname\"  />"+
								 "			<col width=\"15%\" text=\"图纸编号\" column=\"tzbh\" orderkey=\"tzbh\" />"+
								 "			<col width=\"5%\" text=\"图纸版本\" column=\"tzbb\" orderkey=\"tzbb\" />"+
								 "			<col width=\"5%\" text=\"客户号\" column=\"custid\" orderkey=\"custid\"  />"+
								 "			<col width=\"5%\" text=\"客户品名\" column=\"custmat\" orderkey=\"custmat\"  />"+
								 "			<col width=\"5%\" text=\"品名描述\" column=\"matdesc\" orderkey=\"matdesc\"  />"+
								 "			<col width=\"5%\" text=\"封装外形\" column=\"pkld\" orderkey=\"pkld\"  />"+
								 "			<col width=\"15%\" text=\"封装大类\" column=\"pkg\" orderkey=\"pkg\" />"+
								 "			<col width=\"10%\" text=\"创建时间\" column=\"CREATE_TIME\" orderkey=\"CREATE_TIME\" />"+
		                         "		</head>"+
   								 "		<operates width=\"10%\">";
   				    tableString +=		 "    		<operate href=\"javascript:doView()\" text=\"明细list\" target=\"_self\" index=\"0\"/>";
/* 				    tableString +=		 "    		<operate href=\"javascript:doCad()\" text=\"CAD图纸\" target=\"_self\" index=\"0\"/>";
				    tableString +=		 "    		<operate href=\"javascript:doYszl()\"  text=\"原始资料\" target=\"_self\" index=\"0\"/>"; */
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
	jQuery("#gcname_id").val($("#gcname").find("option:selected").text());
	jQuery("#tzlxname_id").val($("#tzlxname").find("option:selected").text());
	document.frmmain.submit();
}

function doView(id){
	document.frmmain.action = "otecdrmedef_done_details.jsp?id="+id;
	document.frmmain.submit();
}

$("#gcname").attr("value",jQuery("#gcname_id").val());
$("#tzlxname").attr("value",jQuery("#tzlxname_id").val());

</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>