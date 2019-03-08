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
    String name =  Util.fromScreen(request.getParameter("name"),user.getLanguage());
  	String FULL_NAME =  Util.fromScreen(request.getParameter("FULL_NAME"),user.getLanguage());
  	String PIRCE =  Util.fromScreen(request.getParameter("PIRCE"),user.getLanguage());
  	String PIRCE_STEP =  Util.fromScreen(request.getParameter("PIRCE_STEP"),user.getLanguage());
	String PIRCE_DIFF =  Util.fromScreen(request.getParameter("PIRCE_DIFF"),user.getLanguage());
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_SD_WIRE_UNIT_PIRCE where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_WIRE_UNIT_PIRCE set WIRE_FK = '" + name + "',WIRE_DIAM_FK = '" + FULL_NAME + "',PIRCE = '" + PIRCE + "', PIRCE_STEP  = '" + PIRCE_STEP + "', PIRCE_DIFF  = '" + PIRCE_DIFF + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into unit_price_set(id,WIRE_FK,WIRE_DIAM_FK,PIRCE,PIRCE_STEP,PIRCE_DIFF) values (SYS_GUID()||'',"+
				"'" + name + "'," +
				"'" + FULL_NAME + "'," +
				"'" + PIRCE + "'," +
				"'" + PIRCE_STEP + "'," +
				"'" + PIRCE_DIFF + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("unit_price_set.jsp");
   %>
