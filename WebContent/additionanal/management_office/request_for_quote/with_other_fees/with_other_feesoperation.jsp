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
	    sql = "delete with_other_fees where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_FRM_PKG set QTTN_PKG_FK = '" + QTTN_PKG_FK + "',FRAME_FK = '" + name + "',MAINTENANCE_COST = '" + MAINTENANCE_COST +"',LABOUR = '" + LABOUR +"',POWER = '" + POWER + "', DEPR  = '" + DEPR + "', OTHER  = '" + OTHER + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_FRM_PKG(id,QTTN_PKG_FK,FRAME_FK,LABOUR,POWER,DEPR,OTHER,MAINTENANCE_COST) values (SYS_GUID()||'',"+
				"'" + QTTN_PKG_FK + "'," +
				"'" + name + "'," +
				"'" + LABOUR + "'," +
				"'" + POWER + "'," +
				"'" + DEPR + "'," +
				"'" + OTHER + "'," +
				"'" + MAINTENANCE_COST + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("with_other_fees.jsp");
   %>
