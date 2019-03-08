<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
//带出人员信息
RecordSet rs = new RecordSet();
BaseBean e = new BaseBean();
e.writeLog("开始执行-------");
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
int requestid = Util.getIntValue(request.getParameter("requestid"));

String zjpmsrid = Util.null2String(request.getParameter("zjpmsrid"));
StringBuffer sb = null;
String result = "";

if(type.equals("1")){
	sql = "select dqpmlist from (select * from formtable_main_93 where dqidh = '"+zjpmsrid+"' order by  To_Number(dqidbbh) desc) where rownum = 1 ";
	rs.executeSql(sql);
	sb = new StringBuffer();
	if(rs.next()){
		result = rs.getString(1).replace("<br>","");
		sb.append(result);
	}
}

if(type.equals("2")){
	String roleid = Util.null2String(request.getParameter("roleid"));
	sql = "select SUBCOMPANYID1 from Hrmresource where id = '"+ roleid +"' ";
	 e.writeLog("sql"+ sql);
	rs.executeSql(sql);
	sb = new StringBuffer();
	rs.next();
	result = rs.getString(1);
	sb.append(result);
}
out.print(sb.toString());
%>
