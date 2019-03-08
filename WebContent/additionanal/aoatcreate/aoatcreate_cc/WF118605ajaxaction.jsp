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
String WORK_CENTER_FK= "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("fzwx"));
	String gxms =  Util.null2String(request.getParameter("gxms"));
	sql = "select distinct WORK_CENTER_FK from mdm_work_center_rule_cc where PKG_OUTLINE_FK ='"+gylxdm +"'  and OPER_FK ='"+gxms+"'";
	rs.executeSql(sql);
	rs.next();
	result +="[";
	if(!"".equals(rs.getString("WORK_CENTER_FK"))){
		WORK_CENTER_FK = rs.getString("WORK_CENTER_FK");
		result += "{\"WORK_CENTER_FK\":\"" + WORK_CENTER_FK +"\"},";
	}
	if("".equals(rs.getString("WORK_CENTER_FK"))){
		result += "{\"WORK_CENTER_FK\":\"" + WORK_CENTER_FK +"\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
