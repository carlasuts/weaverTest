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
    String APPLICATION_DATE =  Util.fromScreen(request.getParameter("APPLICATION_DATE"),user.getLanguage());
  	String MAT_DESC =  Util.fromScreen(request.getParameter("MAT_DESC"),user.getLanguage());
	String NUMBERS =  Util.fromScreen(request.getParameter("NUMBERS"),user.getLanguage());
	String UNIT =  Util.fromScreen(request.getParameter("UNIT"),user.getLanguage());
  	String PRICE =  Util.fromScreen(request.getParameter("PRICE"),user.getLanguage());
  	String SUPPLIER_TO_DESCRIBE =  Util.fromScreen(request.getParameter("SUPPLIER_TO_DESCRIBE"),user.getLanguage());
	String USERS_OF_THE =  Util.fromScreen(request.getParameter("USERS_OF_THE"),user.getLanguage());
  	String WORKCODE_OF_USER =  Util.fromScreen(request.getParameter("WORKCODE_OF_USER"),user.getLanguage());
  	String OLD_USER_NAME =  Util.fromScreen(request.getParameter("OLD_USER_NAME"),user.getLanguage());
  	String OLD_USER_WORKCODE =  Util.fromScreen(request.getParameter("OLD_USER_WORKCODE"),user.getLanguage());
	String POINT_PERSON =  Util.fromScreen(request.getParameter("POINT_PERSON"),user.getLanguage());
	String FACTORY =  Util.fromScreen(request.getParameter("FACTORY"),user.getLanguage());
  	String CREATETIME =  Util.fromScreen(request.getParameter("CREATETIME"),user.getLanguage());
  	String UPDATETIME =  Util.fromScreen(request.getParameter("UPDATETIME"),user.getLanguage());


  	
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete QUERY_TOOL_CARD where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  QUERY_TOOL_CARD set MAT_DESC = '" + MAT_DESC + "',NUMBERS = '" + NUMBERS + "',UNIT = '" + UNIT +"',PRICE = '" + PRICE +"',SUPPLIER_TO_DESCRIBE = '" + SUPPLIER_TO_DESCRIBE + "', USERS_OF_THE  = '" + USERS_OF_THE + "', WORKCODE_OF_USER  = '" + WORKCODE_OF_USER + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
        	sql = "insert into QUERY_TOOL_CARD (APPLICATION_DATE,MAT_DESC,NUMBERS,UNIT,PRICE,SUPPLIER_TO_DESCRIBE,USERS_OF_THE,WORKCODE_OF_USER,POINT_PERSON,FACTORY,CREATETIME) values (to_char(sysdate,'yyyy-mm-dd'),"+        			
    				"'" + MAT_DESC + "'," +
    				"'" + NUMBERS + "'," +
    				"'" + UNIT + "'," +
    				"'" + PRICE + "'," +
    				"'" + SUPPLIER_TO_DESCRIBE + "'," +
    				"'" + USERS_OF_THE + "'," +
    				"'" + WORKCODE_OF_USER + "'," +
    				"to_char(sysdate,'yyyy-mm-dd'))"; 
    	    rs.executeSql(sql);
    }
    response.sendRedirect("tool_card_recipients.jsp");
   %>
