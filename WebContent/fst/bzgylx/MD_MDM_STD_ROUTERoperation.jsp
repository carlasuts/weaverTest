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
   	String name =  Util.fromScreen(request.getParameter("name"),user.getLanguage());
   	String factory =  Util.fromScreen(request.getParameter("factory"),user.getLanguage());
   	String DESC =  Util.fromScreen(request.getParameter("DESC"),user.getLanguage());
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_MDM_STD_ROUTER where id = '"+id+"'";
	    rs.executeSql(sql);
	    bb.writeLog("MD_MDM_STD_ROUTER deletesql:" + sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_MDM_STD_ROUTER set name = '" + name + "',factory = '" + factory + "', \"DESC\"  = '" + DESC + "' where id = '"+id+"'";
		rs.executeSql(sql);
		bb.writeLog("MD_MDM_STD_ROUTER updatesql:" + sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_MDM_STD_ROUTER(id,name,factory,\"DESC\") values (SYS_GUID()||'',"+
				"'" + name + "'," +
				"'" + factory + "'," +
				"'" + DESC + "'" +
				")";
		rs.executeSql(sql);
		bb.writeLog("MD_MDM_STD_ROUTER insertsql:" + sql);
    }
    response.sendRedirect("MD_MDM_STD_ROUTER.jsp");
   %>
