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
	String wtfl =  Util.null2String(request.getParameter("wtfl"));
	String wtms =  Util.null2String(request.getParameter("wtms"));
	sql = "select b.id id ,B.LASTNAME , a.custid from OBASITCINF a inner join hrmresource b on a.workcode = b.workcode where a.OPTIONVALUE='"+wtfl+"' and A.OPTDESCVAL='"+wtms+"'";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("id"))){
		result += "{\"LASTNAME\":\"" + rs.getString("LASTNAME") + "\",\"custid\":\"" + rs.getString("custid") + "\"},";
	}}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
