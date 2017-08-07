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
String result = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	sql = "select id,mat_id,mat_type,mat_desc,qty_1,storage_location from obomsetmat where id='"+gylxdm+"'";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("id"))){
		result += "{\"id\":\"" + rs.getString("id") + "\",\"mat_type\":\"" + rs.getString("mat_type") + "\",\"mat_id\":\"" + rs.getString("mat_id") + "\",\"mat_desc\":\"" + rs.getString("mat_desc") + "\",\"qty_1\":\"" + rs.getString("qty_1") + "\",\"storage_location\":\"" + rs.getString("storage_location") + "\"},";
	}}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
