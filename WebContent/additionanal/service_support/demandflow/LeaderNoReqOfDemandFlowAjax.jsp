<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>

<%

	RecordSet rs = new RecordSet();
	String sql = "";
	String result = "";
	String type =  Util.null2String(request.getParameter("type"));
	
	if(type.equals("1")){
		String ReqDop =  Util.null2String(request.getParameter("ReqDop"));
		sql = "SELECT COUNT(1) AS  KEYUSRNO FROM OKEYUSERINF WHERE  WORKCODE =(SELECT WORKCODE FROM HRMRESOURCE WHERE ID='"+ ReqDop +"') ";
		rs.executeSql(sql);
		rs.next();
		result = rs.getString(1);
	}
	if(type.equals("2")){
		String ReqManager =  Util.null2String(request.getParameter("ReqManager"));
		sql = "SELECT SECLEVEL FROM HRMRESOURCE WHERE ID = '"+ ReqManager +"'";
		rs.executeSql(sql);
		rs.next();
		result = rs.getString(1);
	}

	out.print(result);
%>