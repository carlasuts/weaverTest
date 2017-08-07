<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSetDataSource mesrs = new RecordSetDataSource("mesdb");
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
String result = "";
String operDesc = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	sql = "select  OPER_DESC from mwipoprdef where oper='"+gylxdm+"'";
	mesrs.executeSql(sql);
	mesrs.next();
	result +="[";
	if(!"".equals(mesrs.getString("OPER_DESC"))){
	    operDesc = mesrs.getString("OPER_DESC");
		result += "{\"oper_desc\":\"" + operDesc +"\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
