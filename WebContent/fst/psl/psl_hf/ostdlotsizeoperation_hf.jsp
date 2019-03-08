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
    BaseBean bb = new BaseBean();
   	String pkg =  Util.fromScreen(request.getParameter("pkg"),user.getLanguage());
   	String cust_id =  Util.fromScreen(request.getParameter("cust_id"),user.getLanguage());
   	String qty =  Util.fromScreen(request.getParameter("qty"),user.getLanguage());
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete ostdlotsize_hf where id = '"+id+"'";
	    rs.executeSql(sql);
	    bb.writeLog("ostdlotsize_hf deletesql:" + sql);
    }
    else if(type.equals("modi")){
    	sql = "update  ostdlotsize_hf set pkg = '" + pkg + "',cust_id = '" + cust_id + "',qty = '" + qty + "' where id = '"+id+"'";
		rs.executeSql(sql);
		bb.writeLog("ostdlotsize_hf updatesql:" + sql);
    }
    else if(type.equals("add")){
    	sql = "insert into ostdlotsize_hf (id,pkg,cust_id,qty) values (SYS_GUID()||'',"+
				"'" + pkg + "'," +
				"'" + cust_id + "'," +
				"'" + qty + "'" +
				")";
		rs.executeSql(sql);
		bb.writeLog("ostdlotsize_hf insertsql:" + sql);
    }
    response.sendRedirect("ostdlotsize_hf.jsp");
   %>
