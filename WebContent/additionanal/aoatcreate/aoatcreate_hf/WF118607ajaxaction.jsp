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
String resg_id= "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("fzwx"));
	String gxms =  Util.null2String(request.getParameter("gx"));
	String khh =  Util.null2String(request.getParameter("khh"));
	sql = "select resg_id from orasresmfo_hf where pkld ='"+gylxdm +"'  and OPER ='"+gxms+"' and (custid = '"+ khh +"' or custid is null or custid = ' ') order by custid desc nulls last";
	rs.executeSql(sql);
	rs.next();
	result +="[";
	if(!"".equals(rs.getString("resg_id"))){
		resg_id = rs.getString("resg_id");
		result += "{\"resg_id\":\"" + resg_id +"\"},";
	}
	if("".equals(rs.getString("resg_id"))){
		result += "{\"resg_id\":\"" + resg_id +"\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
