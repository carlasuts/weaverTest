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
  	String MAT =  Util.fromScreen(request.getParameter("MAT"),user.getLanguage());
  	String GRADE =  Util.fromScreen(request.getParameter("GRADE"),user.getLanguage());
  	String MATERIAL =  Util.fromScreen(request.getParameter("MATERIAL"),user.getLanguage());
	String MAINTENANCE_COST =  Util.fromScreen(request.getParameter("MAINTENANCE_COST"),user.getLanguage());
	String LABOUR =  Util.fromScreen(request.getParameter("LABOUR"),user.getLanguage());
  	String POWER =  Util.fromScreen(request.getParameter("POWER"),user.getLanguage());
  	String DEPR =  Util.fromScreen(request.getParameter("DEPR"),user.getLanguage());
	String OTHER =  Util.fromScreen(request.getParameter("OTHER"),user.getLanguage());
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_SD_COST_PACKING where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_COST_PACKING set QTTN_PKG_FK = '" + QTTN_PKG_FK + "',PACKING_FK = '" + MAT +"',PACKING_GRADE_FK = '" + GRADE +"',MATERIAL = '" + MATERIAL +"',MAINTENANCE_COST = '" + MAINTENANCE_COST +"',LABOUR = '" + LABOUR + "',POWER = '" + POWER + "', DEPR  = '" + DEPR + "', OTHER  = '" + OTHER + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_COST_PACKING (id,QTTN_PKG_FK,PACKING_FK,PACKING_GRADE_FK,MATERIAL,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER) values (SYS_GUID()||'',"+
				"'" + QTTN_PKG_FK + "'," +
				"'" + MAT + "'," +
				"'" + GRADE + "'," +
				"'" + MATERIAL + "'," +
				"'" + MAINTENANCE_COST + "'," +
				"'" + LABOUR + "'," +
				"'" + POWER + "'," +
				"'" + DEPR + "'," +
				"'" + OTHER + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("pack_cost.jsp");
   %>
