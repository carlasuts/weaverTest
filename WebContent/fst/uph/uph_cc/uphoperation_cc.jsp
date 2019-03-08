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
    String PKG_OUTLINE_FK =  Util.fromScreen(request.getParameter("PKG_OUTLINE_FK"),user.getLanguage());
  	String OPER_FK =  Util.fromScreen(request.getParameter("OPER_FK"),user.getLanguage());
  	String SINGLE_ATTACH_TIME =  Util.fromScreen(request.getParameter("SINGLE_ATTACH_TIME"),user.getLanguage());
  	String ATTACH_CHANGE_WAFER_TIME =  Util.fromScreen(request.getParameter("ATTACH_CHANGE_WAFER_TIME"),user.getLanguage());
   	String SINGLE_WIRE_BOND_TIME =  Util.fromScreen(request.getParameter("SINGLE_WIRE_BOND_TIME"),user.getLanguage());
   	String SINGLE_NO_WIRE_TIME =  Util.fromScreen(request.getParameter("SINGLE_NO_WIRE_TIME"),user.getLanguage());
   	String SINGLE_GRIND_TIME =  Util.fromScreen(request.getParameter("SINGLE_GRIND_TIME"),user.getLanguage());
   	String SCRIBE_METERS =  Util.fromScreen(request.getParameter("SCRIBE_METERS"),user.getLanguage());
   	String SCRIBE_CHANGE_WAFER_TIME =  Util.fromScreen(request.getParameter("SCRIBE_CHANGE_WAFER_TIME"),user.getLanguage());
   	String UPH_FORMULA =  Util.fromScreen(request.getParameter("UPH_FORMULA"),user.getLanguage());
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MDM_UPH_RULE_cc where id = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MDM_UPH_RULE_cc set PKG_OUTLINE_FK = '" + PKG_OUTLINE_FK + "',OPER_FK = '" + OPER_FK + "',SINGLE_ATTACH_TIME = '" + SINGLE_ATTACH_TIME + "',ATTACH_CHANGE_WAFER_TIME = '" + ATTACH_CHANGE_WAFER_TIME + "',SINGLE_WIRE_BOND_TIME = '" + SINGLE_WIRE_BOND_TIME + "',SINGLE_NO_WIRE_TIME = '" + SINGLE_NO_WIRE_TIME + "',SINGLE_GRIND_TIME = '" + SINGLE_GRIND_TIME + "',SCRIBE_METERS = '" + SCRIBE_METERS + "',SCRIBE_CHANGE_WAFER_TIME = '" + SCRIBE_CHANGE_WAFER_TIME + "',UPH_FORMULA = '" + UPH_FORMULA + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MDM_UPH_RULE_cc (id,PKG_OUTLINE_FK,OPER_FK,SINGLE_ATTACH_TIME,ATTACH_CHANGE_WAFER_TIME,SINGLE_WIRE_BOND_TIME,SINGLE_NO_WIRE_TIME,SINGLE_GRIND_TIME,SCRIBE_METERS,SCRIBE_CHANGE_WAFER_TIME,UPH_FORMULA) values (SYS_GUID()||'',"+
				"'" + PKG_OUTLINE_FK + "'," +
				"'" + OPER_FK + "'," +
				"'" + SINGLE_ATTACH_TIME + "'," +
				"'" + ATTACH_CHANGE_WAFER_TIME + "'," +
				"'" + SINGLE_WIRE_BOND_TIME + "'," +
				"'" + SINGLE_NO_WIRE_TIME + "'," +
				"'" + SINGLE_GRIND_TIME + "'," +
				"'" + SCRIBE_METERS + "'," +
				"'" + SCRIBE_CHANGE_WAFER_TIME + "'," +
				"'" + UPH_FORMULA + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("uph_cc.jsp");
   %>
