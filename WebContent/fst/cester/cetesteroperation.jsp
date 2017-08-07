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
   	String cust =  Util.fromScreen(request.getParameter("cust"),user.getLanguage());
 	String CUST_ENGR_FK =  Util.fromScreen(request.getParameter("CUST_ENGR_FK"),user.getLanguage());
 	String TPM_LEADER_FK =  Util.fromScreen(request.getParameter("TPM_LEADER_FK"),user.getLanguage());
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_CE_AUDITOR_RULE where id = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_CE_AUDITOR_RULE set cust = '" + cust + "',CUST_ENGR_FK = '" + CUST_ENGR_FK + "',TPM_LEADER_FK = '" + TPM_LEADER_FK + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_CE_AUDITOR_RULE (id,CUST,CUST_ENGR_FK,TPM_LEADER_FK) values (" +
				"SYS_GUID()||'',"+ 
				"'" + cust + "'," +
				"'" + CUST_ENGR_FK + "'," +
				"'" + TPM_LEADER_FK + "'" +
				")";
	    rs.executeSql(sql); 
    }
    response.sendRedirect("cetester.jsp");
   %>
