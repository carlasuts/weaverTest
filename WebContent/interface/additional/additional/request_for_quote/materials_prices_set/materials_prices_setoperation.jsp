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
    String NAME =  Util.fromScreen(request.getParameter("NAME"),user.getLanguage());
  	String RATE =  Util.fromScreen(request.getParameter("RATE"),user.getLanguage());
	String RATRADE_TYPE_FKTE =  Util.fromScreen(request.getParameter("TRADE_TYPE_FK"),user.getLanguage());
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_SD_TRDTYP_MTRL_COST_RATE where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_TRDTYP_MTRL_COST_RATE set RATE = '" + RATE + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_TRDTYP_MTRL_COST_RATE(TRADE_TYPE_FK,RATE) values ("+
				"'" + TRADE_TYPE_FK + "'," +
				"'" + RATE + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("materials_prices_set.jsp");
   %>
