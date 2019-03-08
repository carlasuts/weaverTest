<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css></HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
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
String factory=" ";
if(subid.equals("1")){
	factory ="0";
}else if(subid.equals("142")){
	factory ="1";
}else if(subid.equals("101")){
	factory ="2";
}else {
	factory ="3";
}
bs.writeLog("factory:-----------"+factory);
String APPLICATION_DATE =Util.null2String(request.getParameter("APPLICATION_DATE"));
String MAT_DESC = Util.null2String(request.getParameter("MAT_DESC"));
String NUMBERS = Util.null2String(request.getParameter("NUMBERS"));
String UNIT = Util.null2String(request.getParameter("UNIT"));
String PRICE = Util.null2String(request.getParameter("PRICE"));
String SUPPLIER_TO_DESCRIBE = Util.null2String(request.getParameter("SUPPLIER_TO_DESCRIBE"));
String USERS_OF_THE = Util.null2String(request.getParameter("USERS_OF_THE"));
String WORKCODE_OF_USER = Util.null2String(request.getParameter("WORKCODE_OF_USER"));
String OLD_USER_NAME = Util.null2String(request.getParameter("OLD_USER_NAME"));
String OLD_USER_WORKCODE = Util.null2String(request.getParameter("OLD_USER_WORKCODE"));
String POINT_PERSON = Util.null2String(request.getParameter("POINT_PERSON"));
String gcname = Util.null2String(request.getParameter("gcname"));
String PROCESS_NUMBER = Util.null2String(request.getParameter("PROCESS_NUMBER"));
String gcname_id = Util.null2String(request.getParameter("gcname_id"));
String isfirst = Util.null2String(request.getParameter("isfirst"));

String sqlwhere = " where 1 = 1  ";
/*String sqlwhere = " where 1 = 1  and FACTORY like '%" + gcname_id + "%'";*/

if(!MAT_DESC.equals("")){
	sqlwhere += " and MAT_DESC like '%" + MAT_DESC + "%'";
}

if(!USERS_OF_THE.equals("")){
	sqlwhere += " and USERS_OF_THE like '%" + USERS_OF_THE + "%'";
}

if(!WORKCODE_OF_USER.equals("")){
	sqlwhere += " and WORKCODE_OF_USER like '%" + WORKCODE_OF_USER + "%'";
}

if(!OLD_USER_NAME.equals("")){
	sqlwhere += " and OLD_USER_NAME like '%" + OLD_USER_NAME + "%'";
}

if(!OLD_USER_WORKCODE.equals("")){
	sqlwhere += " and OLD_USER_WORKCODE like '%" + OLD_USER_WORKCODE + "%'";
}


if(!POINT_PERSON.equals("")){
	sqlwhere += " and POINT_PERSON like '%" + POINT_PERSON + "%'";
}


if(!gcname_id.equals("")){
	sqlwhere += " and FACTORY like '%" + gcname_id + "%'";
}


if(!PROCESS_NUMBER.equals("")){
	sqlwhere += " and PROCESS_NUMBER like '%" + PROCESS_NUMBER + "%'";
}





int pagenum = Util.getIntValue(request.getParameter("pagenum"),1);
int	perpage=30;
%>

<%
String imagefilename = "/images/hdMaintenance.gif";
String titlename = "工具卡领用";
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:doSearch(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",tool_card_recipientsupdate.jsp,_self} " ;
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
		<FORM id=weaver NAME=frmmain STYLE="margin-bottom:0" action="tool_card_recipients.jsp" method=post>
		<input type="hidden" id="gcname_id" name="gcname_id" value="<%=gcname_id%>">
		<input type="hidden" id="isfirst" name="isfirst" value="<%=isfirst%>">
		<table width=100% class=ViewForm>
		<colgroup>
		<col width="16%">
		<col width="16%">
		<TR> 			
			<td NOWRAP width='5%'>厂区</td>
			<td class=FIELD width='10%'>
			<select name="gcname" id='gcname' > 
				<option value=""></option>  
				<option value="崇川" >崇川</option>  
				<option value="苏通" >苏通</option> 
				<option value="合肥" >合肥</option>  
	    	</select></td>
			<td NOWRAP width='5%'>物料描述</td>
			<td class=FIELD width='15%'>
			<input type=text id='MAT_DESC' name='MAT_DESC' value='<%=MAT_DESC%>'></td>
			<td NOWRAP width='5%'>使用人</td>
			<td class=FIELD width='15%'>
			<input type=text id='USERS_OF_THE' name='USERS_OF_THE' value='<%=USERS_OF_THE%>'></td>
			<td NOWRAP width='5%'>使用人工号</td>
			<td class=FIELD width='15%'>
			<input type=text id='WORKCODE_OF_USER' name='WORKCODE_OF_USER' value='<%=WORKCODE_OF_USER%>'></td>
			<td NOWRAP width='5%'>领料人</td>
			<td class=FIELD width='15%'>
			<input type=text id='POINT_PERSON' name='POINT_PERSON' value='<%=POINT_PERSON%>'></td>
			<td NOWRAP width='5%'>流程编号</td>
			<td class=FIELD width='15%'>
			<input type=text id='PROCESS_NUMBER' name='PROCESS_NUMBER' value='<%=PROCESS_NUMBER%>'></td>
			<td NOWRAP width='20%'><input type="button" value="搜索" onclick="doSearch();">&nbsp;&nbsp;
			<!--<input type="button" value="导入excel" onclick="doImportExcel();">&nbsp;&nbsp;-->
			<!--<input type="button" value="模板下载" onclick="javascript:window.location.href='tool_card_recipients.xls';">--></td>
		</TR>
		<TR class=Spacing><TD class=Line1 colspan=8></TD></TR>
		</table>
		<TABLE width="100%">
			<tr>
				<td valign="top">
		        	<%
		            String backfields = " a.ID,APPLICATION_DATE,MAT_DESC,NUMBERS,UNIT,PRICE,SUPPLIER_TO_DESCRIBE,USERS_OF_THE,WORKCODE_OF_USER,OLD_USER_NAME,OLD_USER_WORKCODE,POINT_PERSON,FACTORY,CREATETIME,UPDATETIME,PROCESS_NUMBER ";
		            String fromSql  = " QUERY_TOOL_CARD a   ";
		            String sqlWhere = sqlwhere;
		            String orderby = " a.id " ;
		            String tableString = "";
		            tableString =" <table instanceid=\"contract\" tabletype=\"none\" pagesize=\""+perpage+"\" >"+
		                         "		<sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\" sqlorderby=\""+orderby+"\" sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
		                         "		<head>"+
								"			<col width=\"5%\" text=\"厂区\" column=\"FACTORY\" orderkey=\"FACTORY\"  />"+
								 "			<col width=\"10%\" text=\"物料描述\" column=\"MAT_DESC\" orderkey=\"MAT_DESC\"  />"+
								"			<col width=\"5%\" text=\"数量\" column=\"NUMBERS\" orderkey=\"NUMBERS\"  />"+
								 "			<col width=\"5%\" text=\"单位\" column=\"UNIT\" orderkey=\"UNIT\"  />"+
								 "			<col width=\"5%\" text=\"价格\" column=\"PRICE\" orderkey=\"PRICE\"  />"+
								 "			<col width=\"10%\" text=\"供应商\" column=\"SUPPLIER_TO_DESCRIBE\" orderkey=\"SUPPLIER_TO_DESCRIBE\"  />"+
								"			<col width=\"5%\" text=\"使用人\" column=\"USERS_OF_THE\" orderkey=\"USERS_OF_THE\"  />"+
								"			<col width=\"5%\" text=\"使用人工号\" column=\"WORKCODE_OF_USER\" orderkey=\"WORKCODE_OF_USER\"  />"+
								"			<col width=\"5%\" text=\"原持有人\" column=\"OLD_USER_NAME\" orderkey=\"OLD_USER_NAME\"  />"+
								"			<col width=\"5%\" text=\"原持有人工号\" column=\"OLD_USER_WORKCODE\" orderkey=\"OLD_USER_WORKCODE\"  />"+
								"			<col width=\"5%\" text=\"领料人\" column=\"POINT_PERSON\" orderkey=\"POINT_PERSON\"  />"+
								"			<col width=\"5%\" text=\"创建时间\" column=\"CREATETIME\" orderkey=\"CREATETIME\"  />"+	
								"			<col width=\"5%\" text=\"更新时间\" column=\"UPDATETIME\" orderkey=\"UPDATETIME\"  />"+	
								"			<col width=\"5%\" text=\"流程编号\" column=\"PROCESS_NUMBER\" orderkey=\"PROCESS_NUMBER\"  />"+									
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
var userID =<%=userID%>
var factory =<%=factory%>


function doSearch(){
	//jQuery("#gcname_id").val($("#gcname").val());
	jQuery("#gcname_id").val($("#gcname").find("option:selected").text());
	document.frmmain.submit();
}


jQuery(function () {
	if(factory==1 || factory==2){
		if(factory==1  && jQuery("#isfirst").val()=='') {
			$("#gcname").val("苏通");
			jQuery("#gcname_id").val($("#gcname").val());
			$("#gcname").attr("value",jQuery("#gcname_id").val());
			jQuery("#isfirst").val('1');
			document.frmmain.submit();
		} else if (factory==2 && jQuery("#isfirst").val()==''){
			$("#gcname").val("合肥");
			jQuery("#gcname_id").val($("#gcname").val());
			$("#gcname").attr("value",jQuery("#gcname_id").val());
			jQuery("#isfirst").val('1');
			document.frmmain.submit();
		}
		jQuery(gcname).attr("disabled", "disabled");
	}
});


 $("#gcname").change(function(){
 	jQuery("#gcname_id").val($("#gcname").find("option:selected").text());
	document.frmmain.submit();
 });
 
 $("#gcname").attr("value",jQuery("#gcname_id").val());
//修改
function doEdit(id){
	document.frmmain.action = "tool_card_recipientsupdate.jsp?type=modi&id="+id;
	document.frmmain.submit();
}
//导入
function doImportExcel(){
	var rvalue = window.showModalDialog("tool_card_recipientsexcel.jsp");
	if(rvalue > 0){
		window.location.href = "tool_card_recipients.jsp";
	}
}
function doDownload(){
	window.location.href='tool_card_recipients.xls';
}
function doDel(id){
	var isdel = confirm("真的要删除吗?");
	if(isdel){
		document.frmmain.action="tool_card_recipientsoperation.jsp?type=del&id="+id;
		document.frmmain.submit();	
	}
}

</script>
</body>
<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>