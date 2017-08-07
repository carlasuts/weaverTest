<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSet rs = new RecordSet();
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
int requestid = Util.getIntValue(request.getParameter("requestid"));

String gysdh =  Util.null2String(request.getParameter("gysdh"));
String PKG =  Util.null2String(request.getParameter("fzwx"));

String result = "";
if(type.equals("1")){
	sql = "select count(*) as no from formtable_main_91 where tzlx = '2' and gysdh ='"+gysdh+"' and PKG = '"+PKG+"'";
	rs.executeSql(sql);
	result +="[";
	rs.next();
	if(!"".equals(rs.getString("no")))
	{
		result += "{\"no\":\"" + rs.getString("no") + "\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
