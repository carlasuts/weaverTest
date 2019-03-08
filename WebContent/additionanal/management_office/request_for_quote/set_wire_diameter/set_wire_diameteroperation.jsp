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
    String LENGTH =  Util.fromScreen(request.getParameter("LENGTH"),user.getLanguage());
  	String UNIT_FK =  Util.fromScreen(request.getParameter("UNIT_FK"),user.getLanguage());
  	String STANDARD =  Util.fromScreen(request.getParameter("STANDARD"),user.getLanguage());
  	String FULL_NAME =  Util.fromScreen(request.getParameter("FULL_NAME"),user.getLanguage());
	String SORT =  Util.fromScreen(request.getParameter("SORT"),user.getLanguage());
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_SD_WIRE_DIAM where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_WIRE_DIAM set LENGTH = '" + LENGTH + "',UNIT_FK = '" + UNIT_FK + "',STANDARD = '" + STANDARD + "', FULL_NAME  = '" + FULL_NAME + "', SORT  = '" + SORT + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_WIRE_DIAM(id,LENGTH,UNIT_FK,STANDARD,FULL_NAME,SORT) values (SYS_GUID()||'',"+
				"'" + LENGTH + "'," +
				"'" + UNIT_FK + "'," +
				"'" + STANDARD + "'," +
				"'" + FULL_NAME + "'," +
				"'" + SORT + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("set_wire_diameter.jsp");
   %>
