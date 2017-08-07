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
    String factory =  Util.fromScreen(request.getParameter("factory"),user.getLanguage());
  	String custid =  Util.fromScreen(request.getParameter("custid"),user.getLanguage());
  	String pkld =  Util.fromScreen(request.getParameter("pkld"),user.getLanguage());
  	String oper =  Util.fromScreen(request.getParameter("oper"),user.getLanguage());
   	String resg_id =  Util.fromScreen(request.getParameter("resg_id"),user.getLanguage());
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete ORASRESMFO where id =  '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  ORASRESMFO set factory = '" + factory + "',custid = '" + custid + "',pkld = '" + pkld +  "',oper = '" + oper + "',resg_id = '" + resg_id + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into ORASRESMFO(id,factory,custid,pkld,oper,resg_id) values (SYS_GUID()||'',"+
				"'" + factory + "'," +
				"'" + custid + "'," +
				"'" + pkld + "'," +
				"'" + oper + "'," +
				"'" + resg_id + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("orasresmfo.jsp");
   %>
