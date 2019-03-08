<%@ page contentType="text/html; charset=UTF-8"%>
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
<%@ page import="weaver.file.*"%>
<%@page import="weaver.conn.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page
	import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*"%>
<%@include file="/systeminfo/init_wev8.jsp"%>
<%
	BaseBean bb = new BaseBean();
	String cust_id = Util.fromScreen(request.getParameter("cust_id"), user.getLanguage());
	String area = Util.fromScreen(request.getParameter("area"), user.getLanguage());
	String work_code = Util.fromScreen(request.getParameter("work_code"), user.getLanguage());
	String id = request.getParameter("id");
	String type = request.getParameter("type");
	String sql = "";
	RecordSet rs = new RecordSet();
	if (type.equals("del")) {
		sql = "delete osalescast where id = '" + id + "'";
		rs.executeSql(sql);
		bb.writeLog("osalescast deletesql:" + sql);
	} else if (type.equals("modi")) {
		sql = "update osalescast set name = '" + cust_id + "', sales_area_fk = '" + area + "', salesman_fk = '" + work_code +  "' where id = '" + id + "'";
		rs.executeSql(sql);
		bb.writeLog("osalescast updatesql:" + sql);
	} else if (type.equals("add")) {
		sql = "insert into osalescast(name, sales_area_fk, salesman_fk) values ('" + cust_id + "','" + area + "','" + work_code + "')";
		rs.executeSql(sql);
		bb.writeLog("osalescast insertsql:" + sql);
	}
	response.sendRedirect("quoter.jsp");
%>
