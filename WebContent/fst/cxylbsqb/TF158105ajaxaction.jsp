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

String id = Util.null2String(request.getParameter("id"));
StringBuffer sb = null;
String result = "";

if(type.equals("1")){
	sql = "select  replace(mat_list,',',chr(10)||'<br>')  from owiptstpgm where  id ='"+ id +"'";
	rs.executeSql(sql);
	sb = new StringBuffer();
	if(rs.next()){
		//result = rs.getString(1);
		result = rs.getString(1).replace("<br>","");
		sb.append(result);
	}
}
if(type.equals("2")){
	sql = "select  FILEREALPATH  from owiptstpgm where  id ='"+ id +"'";
	rs.executeSql(sql);
	sb = new StringBuffer();
	if(rs.next()){
		//result = rs.getString(1);
		result = rs.getString(1);
		sb.append(result);
	}
}
out.print(sb.toString());
%>
