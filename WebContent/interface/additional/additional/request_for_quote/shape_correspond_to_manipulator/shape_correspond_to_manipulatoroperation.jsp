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
  	String QTTN_PKG_FK =  Util.fromScreen(request.getParameter("QTTN_PKG_FK"),user.getLanguage());



  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
	String HANDLER_FK="";

		rs.executeSql("select  id from MD_HANDLER  where name ='"+name+"'");
		if(rs.next()){
			
			HANDLER_FK = rs.getString("id");
			

		}

    if(type.equals("del")){
	    sql = "delete MD_SD_QTTN_PKG_HANDLER where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_QTTN_PKG_HANDLER set HANDLER_FK = '" + HANDLER_FK + "',QTTN_PKG_FK = '" + QTTN_PKG_FK +  "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_QTTN_PKG_HANDLER(id,HANDLER_FK,QTTN_PKG_FK) values (SYS_GUID()||'',"+
				"'" + HANDLER_FK + "'," +
				"'" + QTTN_PKG_FK + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("shape_correspond_to_manipulator.jsp");
   %>
