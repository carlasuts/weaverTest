<%@ page contentType="text/html;charset=GBK" language="java"%>
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
<%@page import="weaver.file.LogMan"%> 
<%@page import="weaver.conn.*"%>
<%@page import="weaver.general.BaseBean"%>
   <%
    String id = request.getParameter("rule_seq");
    String type = request.getParameter("pkg_type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete rule_cc where rule_seq = " + id;
	    rs.executeSql(sql);
	    response.sendRedirect("recepi.jsp");
    }
   %>