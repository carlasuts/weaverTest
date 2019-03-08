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
	String TESTER_FK ="";
  	String QTTN_PKG_FK =  Util.fromScreen(request.getParameter("QTTN_PKG_FK"),user.getLanguage());
	BaseBean e = new BaseBean();
  	e.writeLog("TESTER_FK:"+TESTER_FK);
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
	

		rs.executeSql("select  id from MD_TESTER  where name ='"+name+"'");
		if(rs.next()){
			
			TESTER_FK = rs.getString("id");
			
			e.writeLog("TESTER_FK:"+TESTER_FK);
		}

	
	
    if(type.equals("del")){
	    sql = "delete MD_SD_QTTN_PKG_TESTER where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_QTTN_PKG_TESTER set TESTER_FK = '" + TESTER_FK + "',QTTN_PKG_FK = '" + QTTN_PKG_FK +  "' where id = '"+id+"'";
		rs.executeSql(sql);
		e.writeLog("sql update:"+sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_QTTN_PKG_TESTER(id,TESTER_FK,QTTN_PKG_FK) values (SYS_GUID()||'',"+
				"'" + TESTER_FK + "'," +
				"'" + QTTN_PKG_FK + "'" +
				")";
		rs.executeSql(sql);
		e.writeLog("sql insert :"+sql);
    }
    response.sendRedirect("shape_correspond_to_the_test_machine.jsp");
   %>
