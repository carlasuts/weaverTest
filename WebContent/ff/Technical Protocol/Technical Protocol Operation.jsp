<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.net.URL"%> 
<%@page import="java.net.URLConnection"%> 
<%@page import="java.net.HttpURLConnection"%> 
<%@page import="javax.servlet.http.HttpServletRequest"%> 
<%@page import="javax.servlet.http.HttpServletResponse"%> 
<%@page import="sun.misc.BASE64Decoder"%> 
<%@page import="weaver.system.*"%> 
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.net.InetAddress"%> 
<%@page import="java.net.UnknownHostException"%> 
<%@page import="weaver.conn.RecordSetDataSource"%> 
<%@page import="java.util.*"%>
<%@page import="java.text.*"%> 
<%@page import="java.math.*"%> 
<%@ page import="weaver.file.*" %>
<%@page import="weaver.conn.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@include file="/systeminfo/init_wev8.jsp" %>
<%
	BaseBean baseBean = new BaseBean();
	String ID =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
   	String FACTORY = Util.fromScreen(request.getParameter("factory"), user.getLanguage());
   	String DEPARTMENT = Util.fromScreen(request.getParameter("department"), user.getLanguage());
	String PROCESS = Util.fromScreen(request.getParameter("process"), user.getLanguage());
	String NAME = Util.fromScreen(request.getParameter("name"), user.getLanguage());
	String WORKCODE = Util.fromScreen(request.getParameter("workcode"), user.getLanguage());
	String AUDITOR = Util.fromScreen(request.getParameter("auditor"), user.getLanguage());
	String APPLIANTID = "";

	String type = request.getParameter("type");
	String sql = "";
	RecordSet rs = new RecordSet();
	if(type.equals("del")){
		sql = "DELETE OBASTPDOP WHERE ID = " + ID;
		rs.executeSql(sql);
	} else if (type.equals("modi")) {
   		baseBean.writeLog("execute update operation");
		sql = "SELECT ID FROM HRMRESOURCE WHERE WORKCODE = '" + WORKCODE + "'";
		baseBean.writeLog("Searching appliant's ID");
		rs.execute(sql);
		rs.next();
		APPLIANTID = rs.getString("ID");
		baseBean.writeLog("Appliant's ID: " + APPLIANTID);
   		sql = "UPDATE OBASTPDOP SET FACTORY = '" + FACTORY + "', DEPARTMENT = '" + DEPARTMENT + "', PROCESS = '" + PROCESS + "', NAME = '" + NAME + "', WORKCODE = '" + WORKCODE + "', AUDITOR = '" + AUDITOR + "', APPLIANTID = '" + APPLIANTID + "' WHERE ID = " + ID;
   		baseBean.writeLog("update sql: " + sql);
		rs.execute(sql);
   	} else {
   		baseBean.writeLog("execute insert operation");
   		sql  = "INSERT INTO OBASTPDOP (FACTORY, DEPARTMENT, PROCESS, NAME, WORKCODE, AUDITOR, APPLIANTID) VALUES ('" + FACTORY + "', '" + DEPARTMENT + "', '" + PROCESS + "', '" + NAME + "','" + WORKCODE + "','" + AUDITOR + "','" + APPLIANTID + "')";
   		baseBean.writeLog("insert sql: " + sql);
   		rs.executeSql(sql);
	}
   response.sendRedirect("Technical Protocol.jsp");
%>