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
  	String CURRENCY_FK =  Util.fromScreen(request.getParameter("CURRENCY_FK"),user.getLanguage());
  	String PIRCE =  Util.fromScreen(request.getParameter("PIRCE"),user.getLanguage());
  	String CURRENT_PIRCE =  Util.fromScreen(request.getParameter("CURRENT_PIRCE"),user.getLanguage());
	String SORT =  Util.fromScreen(request.getParameter("SORT"),user.getLanguage());
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_SD_WIRE where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_WIRE set name = '" + name + "',CURRENCY_FK = '" + CURRENCY_FK + "',PIRCE = '" + PIRCE + "', CURRENT_PIRCE  = '" + CURRENT_PIRCE + "', SORT  = '" + SORT + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_WIRE(id,name,CURRENCY_FK,PIRCE,CURRENT_PIRCE,SORT) values (SYS_GUID()||'',"+
				"'" + name + "'," +
				"'" + CURRENCY_FK + "'," +
				"'" + PIRCE + "'," +
				"'" + CURRENT_PIRCE + "'," +
				"'" + SORT + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("wire_type_set.jsp");
   %>
