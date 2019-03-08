<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSetDataSource mesrs = new RecordSetDataSource("HFMESDB");
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
String result = "";
String count = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm")).trim();
	String khpm =  Util.null2String(request.getParameter("khpm"));
	sql = "select count(*) as no from mwipmatdef where mat_short_desc = '"+gylxdm+"' and Delete_Flag  != 'Y' AND Factory = 'ASSY' ";
	mesrs.executeSql(sql);
	mesrs.next();
	result +="[";
	if(!"".equals(mesrs.getString("no"))){
	    count = mesrs.getString("no");
		result += "{\"no\":\"" + count +"\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
