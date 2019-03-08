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
	String roleid =  Util.null2String(request.getParameter("roleid"));
	
	sql = "select SUBCOMPANYID1 from Hrmresource where id = '"+ roleid +"' ";
	rs.executeSql(sql);
	rs.next();
	result = rs.getString(1);
	out.print(result);
%>