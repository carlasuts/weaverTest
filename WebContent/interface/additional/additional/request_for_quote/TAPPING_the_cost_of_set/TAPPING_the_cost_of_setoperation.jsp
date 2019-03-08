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
    String QTTN_PKG_FK =  Util.fromScreen(request.getParameter("QTTN_PKG_FK"),user.getLanguage());
  	String name =  Util.fromScreen(request.getParameter("name"),user.getLanguage());
  	String MATERIAL_COST =  Util.fromScreen(request.getParameter("MATERIAL_COST"),user.getLanguage());
  	String LABOUR_COST =  Util.fromScreen(request.getParameter("LABOUR_COST"),user.getLanguage());
	String POWER_COST =  Util.fromScreen(request.getParameter("POWER_COST"),user.getLanguage());
	String DEPR_COST =  Util.fromScreen(request.getParameter("DEPR_COST"),user.getLanguage());
  	String MAINTENANCE_COST =  Util.fromScreen(request.getParameter("MAINTENANCE_COST"),user.getLanguage());
	String OTHER_COST =  Util.fromScreen(request.getParameter("OTHER_COST"),user.getLanguage());
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_SD_QTTN_PKG_TAPING where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_QTTN_PKG_TAPING set QTTN_PKG_FK = '" + QTTN_PKG_FK + "',TAPING_FK = '" + name +  "',MATERIAL_COST = '" + MATERIAL_COST + "',LABOUR_COST = '" + LABOUR_COST + "',POWER_COST = '" + POWER_COST +"',DEPR_COST = '" + DEPR_COST + "', MAINTENANCE_COST  = '" + MAINTENANCE_COST + "', OTHER_COST  = '" + OTHER_COST + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_QTTN_PKG_TAPING(id,QTTN_PKG_FK,TAPING_FK,MATERIAL_COST,LABOUR_COST,POWER_COST,DEPR_COST,MAINTENANCE_COST,OTHER_COST) values (SYS_GUID()||'',"+
				"'" + QTTN_PKG_FK + "'," +
				"'" + name + "'," +
				"'" + MATERIAL_COST + "'," +
				"'" + LABOUR_COST + "'," +
				"'" + POWER_COST + "'," +
				"'" + DEPR_COST + "'," +
				"'" + MAINTENANCE_COST + "'," +
				"'" + OTHER_COST + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("TAPPING_the_cost_of_set.jsp");
   %>
