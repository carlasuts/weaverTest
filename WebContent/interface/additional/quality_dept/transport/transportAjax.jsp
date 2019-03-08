<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="com.alibaba.fastjson.JSON" %>

<%
BaseBean baseBean = new BaseBean();
RecordSet rs = new RecordSet();
String sql = "";
String result = "";

Map<String,String> map = new HashMap<String, String>();
String requestid = Util.null2String(request.getParameter("requestid"));
baseBean.writeLog("requestid: " + requestid);
sql = "select mainrequestid from workflow_requestbase where requestid = '" + requestid + "'";
rs.executeSql(sql);
baseBean.writeLog("sql: " + sql);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String currentDate = sdf.format(new Date());
while(rs.next()) {
	map.put("mainrequestid", rs.getString("mainrequestid"));
	map.put("currentDate", currentDate);
}
result = JSON.toJSONString(map);
out.print(result);
%>