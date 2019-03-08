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
	String name = Util.fromScreen(request.getParameter("name"), user.getLanguage());
	String work_code = Util.fromScreen(request.getParameter("work_code"), user.getLanguage());
	String id = request.getParameter("id");
	String type = request.getParameter("type");
	String sql = "";
	RecordSet rs = new RecordSet();
	if (type.equals("del")) {
		sql = "delete oinrwcedop_cc where id = '" + id + "'";
		rs.executeSql(sql);
		bb.writeLog("oinrwcedop_cc deletesql:" + sql);
	} else if (type.equals("modi")) {
		sql = "update oinrwcedop_cc set cust_id = '" + cust_id + "',name = '" + name + "', work_code = '" + work_code +  "' where id = '" + id + "'";
		rs.executeSql(sql);
		bb.writeLog("oinrwcedop_cc updatesql:" + sql);
	} else if (type.equals("add")) {
		sql = "insert into oinrwcedop_cc(cust_id, name, work_code) values ('" + cust_id + "','" + name + "','" + work_code + "')";
		rs.executeSql(sql);
		bb.writeLog("oinrwcedop_cc insertsql:" + sql);
	}
	response.sendRedirect("oinrwcedop.jsp");
%>
