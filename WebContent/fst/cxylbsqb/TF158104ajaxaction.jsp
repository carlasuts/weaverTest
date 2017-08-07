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

String zjpmsrid = Util.null2String(request.getParameter("zjpmsrid"));
StringBuffer sb = null;
String result = "";

if(type.equals("1")){
	sql = "select dqpmlist from (select * from formtable_main_110 where dqidh = '"+zjpmsrid+"' order by dqidbbh desc) where rownum = 1 ";
	rs.executeSql(sql);
	sb = new StringBuffer();
	if(rs.next()){
		result = rs.getString(1).replace("<br>","");
		sb.append(result);
	}
}
out.print(sb.toString());
%>
