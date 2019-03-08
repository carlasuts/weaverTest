<%@ page contentType="text/html; charset=UTF-8"%>
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
<%@ page import="weaver.file.*"%>
<%@page import="weaver.conn.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page
	import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*"%>
<%@include file="/systeminfo/init_wev8.jsp"%>
<%

    String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage()); 
  	String factory =  Util.fromScreen(request.getParameter("factory"),user.getLanguage()); //厂区
  	String name =  Util.fromScreen(request.getParameter("name"),user.getLanguage()); //封装外形

   	
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    
    
    
    
    if(type.equals("del")){
	    sql = "delete MD_SD_QTTN_PKG where id = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){

    	sql = "update  MD_SD_QTTN_PKG set id = '" + id + "',name = '" + name + "',FACTORY_FK = '" + factory+"' where id= '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_QTTN_PKG (id,name,FACTORY_FK) values ("+
				"'" + id + "'," +
				"'" + name + "'," +
				"'" + factory + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("ShapeReport.jsp");
   %>
