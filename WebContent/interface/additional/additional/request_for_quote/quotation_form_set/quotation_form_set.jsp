<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="sun.misc.BASE64Decoder" %>>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css></HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
int userID = user.getUID();

String id = Util.null2String(request.getParameter("id"));
String name = Util.null2String(request.getParameter("name"));
String FULL_NAME = Util.null2String(request.getParameter("FULL_NAME"));
String WIRE_LENGTH = Util.null2String(request.getParameter("WIRE_LENGTH"));
String WIRE_QTY = Util.null2String(request.getParameter("WIRE_QTY"));
String DIE_SIZE_X = Util.null2String(request.getParameter("DIE_SIZE_X"));
String DIE_SIZE_Y = Util.null2String(request.getParameter("DIE_SIZE_Y"));
String EQUIPMENT_DEP_PERIOD = Util.null2String(request.getParameter("EQUIPMENT_DEP_PERIOD"));
String COPPER_PRICE_WAVE = Util.null2String(request.getParameter("COPPER_PRICE_WAVE"));

String sqlwhere = " where 1 = 1 ";

if(!id.equals("")){
	sqlwhere += " and a.id like '%" + id + "%'";
}

if(!name.equals("")){
	sqlwhere += " and a.name like '%" + name + "%'";
}

if(!FULL_NAME.equals("")){
	sqlwhere += " and b.FULL_NAME like '%" + FULL_NAME + "%'";
}

if(!WIRE_LENGTH.equals("")){
	sqlwhere += " and WIRE_LENGTH like '%" + WIRE_LENGTH + "%'";
}

if(!WIRE_QTY.equals("")){
	sqlwhere += " and WIRE_QTY like '%" + WIRE_QTY + "%'";
}

if(!DIE_SIZE_X.equals("")){
	sqlwhere += " and DIE_SIZE_X like '%" + DIE_SIZE_X + "%'";
}

if(!DIE_SIZE_Y.equals("")){
	sqlwhere += " and DIE_SIZE_Y like '%" + DIE_SIZE_Y + "%'";
}

if(!EQUIPMENT_DEP_PERIOD.equals("")){
	sqlwhere += " and EQUIPMENT_DEP_PERIOD like '%" + EQUIPMENT_DEP_PERIOD + "%'";
}

if(!COPPER_PRICE_WAVE.equals("")){
	sqlwhere += " and COPPER_PRICE_WAVE like '%" + COPPER_PRICE_WAVE + "%'";
}



int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=10;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "报价外形设定";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",quotation_form_setupdate.jsp,_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{导入excel,javascript:doImportExcel(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{模板下载,javascript:doDownload(),_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="quotation_form_set.jsp" method=post>
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR>
			<td NOWRAP width='5%'>id</td>
			<td class=FIELD width='15%'>
			<input type=text id='id' name='id' value='<%=id%>'></td>
			<td NOWRAP width='5%'>名称</td>
			<td class=FIELD width='15%'>
			<input type=text id='name' name='name' value='<%=name%>'></td>
			<td NOWRAP width='5%'>工厂</td>
			<td class=FIELD width='15%'>
			<input type=text id='FULL_NAME' name='FULL_NAME' value='<%=FULL_NAME%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;
			<input type="button" value="模板下载" onclick="javascript:window.location.href='quotation_form_set.xls';"></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " a.id,a.name,B.FULL_NAME,A.WIRE_LENGTH,A.WIRE_QTY,A.DIE_SIZE_X,A.DIE_SIZE_Y,A.EQUIPMENT_DEP_PERIOD,A.COPPER_PRICE_WAVE ";
		            String fromSql  = " MD_SD_QTTN_PKG a left join MD_FACTORY b on A.FACTORY_FK = b.id";
		            String sqlWhere = sqlwhere;
		            String orderby = " a.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								"			<col width=\"15%\" text=\"id\" column=\"id\" orderkey=\"id\"  />"+
								 "			<col width=\"15%\" text=\"名称\" column=\"name\" orderkey=\"name\"  />"+
								 "			<col width=\"15%\" text=\"工厂\" column=\"FULL_NAME\" orderkey=\"FULL_NAME\"  />"+
								 "			<col width=\"10%\" text=\"单丝长度\" column=\"WIRE_LENGTH\" orderkey=\"WIRE_LENGTH\"  />"+
								"			<col width=\"10%\" text=\"标准丝数\" column=\"WIRE_QTY\" orderkey=\"WIRE_QTY\"  />"+
								"			<col width=\"10%\" text=\"芯片X\" column=\"DIE_SIZE_X\" orderkey=\"DIE_SIZE_X\"  />"+
								"			<col width=\"10%\" text=\"芯片Y\" column=\"DIE_SIZE_Y\" orderkey=\"DIE_SIZE_Y\"  />"+
								"			<col width=\"10%\" text=\"设备折旧年限\" column=\"EQUIPMENT_DEP_PERIOD\" orderkey=\"EQUIPMENT_DEP_PERIOD\"  />"+
								"			<col width=\"10%\" text=\"铜价波动100$\" column=\"COPPER_PRICE_WAVE\" orderkey=\"COPPER_PRICE_WAVE\"  />"+
		                         "		</head>"+
								 "		<operates width=\"5%\">";
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
//修改
function doEdit(id){
	document.frmmain.action = "quotation_form_setupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("quotation_form_setexcel.jsp");
	if(rvalue > 0){
		window.location.href = "quotation_form_set.jsp";
	}
}
function doDownload(){
	window.location.href='quotation_form_set.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		alert("id" +id);
		document.frmmain.action="quotation_form_setoperation.jsp?type=del&id="+id;
		alert("id++++" +id);
		document.frmmain.submit();	
	}
}
</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>