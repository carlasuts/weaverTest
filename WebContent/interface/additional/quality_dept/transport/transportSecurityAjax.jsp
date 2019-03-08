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

String date = Util.null2String(request.getParameter("date"));// 日期
String stageValue = Util.null2String(request.getParameter("stageValue"));// 期别
String entrepotType = Util.null2String(request.getParameter("entrepotType"));// 提、送货地点
Map<String,String>  map = new HashMap<String, String>();
baseBean.writeLog("date: " + date);
baseBean.writeLog("stageValue: " + stageValue);
baseBean.writeLog("entrepotType: " + entrepotType);

sql = "SELECT COUNT(DISTINCT WCO.REQUESTID) AS WFQTY FROM FORMTABLE_MAIN_215 FM, WORKFLOW_CURRENTOPERATOR WCO" +
	  " WHERE FM.REQUESTID = WCO.REQUESTID AND WCO.NODEID = '31854' AND WCO.ISREMARK = '0'" +
	  " AND WCO.ISLASTTIMES = '1' AND WCO.RECEIVEDATE = '" + date + "'" +
	  " AND FM.STAGE = '" + stageValue + "' AND FM.ENTREPOT_TYPE = '" + entrepotType +"'";

rs.executeSql(sql);
baseBean.writeLog("sql: " + sql);
while(rs.next()) {
	  map.put("WFQTY", rs.getString("WFQTY"));
}
result = JSON.toJSONString(map);
out.print(result);
%>