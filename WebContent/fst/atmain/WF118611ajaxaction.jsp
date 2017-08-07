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
	String gx =  Util.null2String(request.getParameter("gx"));
	String fzwx =  Util.null2String(request.getParameter("fzwx"));
	sql = "select * from MDM_UPH_RULE where pkg_outline_fk = '"+fzwx+"' and oper_fk = '"+gx+"'";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("uph_formula"))){
		result += "{\"uph_formula\":\"" + rs.getString("uph_formula") + "\",\"Single_Attach_Time\":\"" + rs.getString("Single_Attach_Time") + "\",\"Attach_Change_Wafer_Time\":\"" + rs.getString("Attach_Change_Wafer_Time") + "\",\"Single_Wire_Bond_Time\":\"" + rs.getString("Single_Wire_Bond_Time") + "\",\"Single_No_Wire_Time\":\"" + rs.getString("Single_No_Wire_Time") + "\",\"Single_Grind_Time\":\"" + rs.getString("Single_Grind_Time") + "\",\"Scribe_Meters\":\"" + rs.getString("Scribe_Meters") + "\"},";
	}}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
