<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%
//新建
BaseBean e = new BaseBean();
e.writeLog("进入TF158101-------------------------");
RecordSet rs = new RecordSet();
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
int requestid = Util.getIntValue(request.getParameter("requestid"));


String code_desc = Util.null2String(request.getParameter("code_desc"));


StringBuffer sb = new StringBuffer();

String result = "";

String id_code="0";


if(type.equals("1")){
	
	sql ="select  max(id_code) as id_code  from  formtable_main_208 where code= '"+code_desc+"'";
	
	rs.executeSql(sql);
		e.writeLog("sql"+sql);
		if(rs.next()){
			id_code = (rs.getString("id_code") == ""  ? "0" : rs.getString("id_code"));
			e.writeLog("id_code:"+rs.getString("id_code"));
			e.writeLog("id_code"+id_code);
		}
	id_code = Integer.toString((Integer.parseInt(id_code)+1));
	e.writeLog("id_code2"+id_code);
	e.writeLog("SS-------------------------" +id_code);
	String SS= StringUtils.leftPad(id_code.toString(), 4, "0");
	
	sb.append(SS).append(" ");
}

out.print(sb);
%>
