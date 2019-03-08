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
Map<String,String>  map = new HashMap<String, String>();

baseBean.writeLog("carlasuts505");
String transCompany = Util.null2String(request.getParameter("transCompany"));
sql = "select currentid, indexdesctwo from workflowseqindex where flowid='22106' and plantopt='1000' and ruledesc='FORWARDERLONGDATE' and indexdesc = '"+ transCompany + "'";
baseBean.writeLog("货运申请节点sql: " + sql);
rs.executeSql(sql);
while(rs.next()) {
	String currentid = rs.getString("currentid");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	currentid = currentid.substring(0, 8);
	Date date = sdf.parse(currentid);
	String time = sdf.format(new Date());
	Date date1 = sdf.parse(time);
	long day = (date1.getTime() - date.getTime()) / (1000 * 60 * 60 * 24);
	map.put("day", String.valueOf(day));
	map.put("indexdesctwo", rs.getString("indexdesctwo"));
}
result = JSON.toJSONString(map);
out.print(result);
%>