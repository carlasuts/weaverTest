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
String QTY= "";
String CUST_ID = "";
if(type.equals("1")){
	String fzwx =  Util.null2String(request.getParameter("fzwx"));
	String khh =  Util.null2String(request.getParameter("khh"));
	sql = "SELECT QTY FROM OSTDLOTSIZE where pkg ='"+fzwx +"' and (cust_id ='"+ khh +"' OR CUST_ID IS NULL OR CUST_ID = ' ') order by cust_id desc nulls last ";
	rs.executeSql(sql);
	rs.next();
	result +="[";
	if(!"".equals(rs.getString("QTY"))){
		QTY = rs.getString("QTY");
		CUST_ID = rs.getString("CUST_ID");
		result += "{\"QTY\":\"" + QTY +"\",\"CUST_ID\":\"" + CUST_ID + "\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
