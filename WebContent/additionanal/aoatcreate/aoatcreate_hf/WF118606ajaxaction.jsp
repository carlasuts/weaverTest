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
String result = "";
String desc = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	sql = "select * from MD_MDM_STD_ROUTER_hf where id='"+gylxdm+"'";
	rs.executeSql(sql);
	rs.next();
	result +="[";
	if(!"".equals(rs.getString("DESC"))){
	    desc = rs.getString("DESC");
		result += "{\"desc\":\"" + desc +"\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
