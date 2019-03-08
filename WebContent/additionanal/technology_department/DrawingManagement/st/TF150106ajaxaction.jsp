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

String tzbh =  Util.null2String(request.getParameter("tzbh"));
String cadid = Util.null2String(request.getParameter("cadgstz"));
String yszlid = Util.null2String(request.getParameter("yszlsc"));

String result = "";
if(type.equals("1")){
	sql = "select tzbh,yszlsc,cadgstz from formtable_main_91 where tzbh = '"+ tzbh +"'  and (tzbb, tzbh) in (select max(tzbb),tzbh from  otecdrmedef group by tzbh)";
	rs.executeSql(sql);
	result +="[";
	rs.next();
	if(!"".equals(rs.getString("tzbh")))
	{
		result += "{\"yszlsc\":\"" +  rs.getString("yszlsc") + "\",\"cadgstz\":\"" +  rs.getString("cadgstz") + "\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

if(type.equals("2")){
	sql = "select IMAGEFILEID from DOCIMAGEFILE where docid = '"+ cadid +"'";
	rs.executeSql(sql);
	result +="[";
	rs.next();
	if(!"".equals(rs.getString("IMAGEFILEID")))
	{
		result += "{\"IMAGEFILEID\":\"" +  rs.getString("IMAGEFILEID") +  "\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

if(type.equals("3")){
	sql = "select IMAGEFILEID from DOCIMAGEFILE where docid = '"+ yszlid +"'";
	rs.executeSql(sql);
	result +="[";
	rs.next();
	if(!"".equals(rs.getString("IMAGEFILEID")))
	{
		result += "{\"IMAGEFILEID\":\"" +  rs.getString("IMAGEFILEID") +  "\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
