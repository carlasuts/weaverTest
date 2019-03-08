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
	RecordSet rs = new RecordSet();
	String id = request.getParameter("a");
	String item_no =  Util.fromScreen(request.getParameter("item_no"),user.getLanguage());
   	String oper_fk =  Util.fromScreen(request.getParameter("oper_fk"),user.getLanguage());
   	String factory =  Util.fromScreen(request.getParameter("factory"),user.getLanguage());
   	String master_fk =  Util.fromScreen(request.getParameter("master_fk"),user.getLanguage());
   	String type =  Util.fromScreen(request.getParameter("type"),user.getLanguage());
	String sql = "";
	if(id!= null){
		sql = "select master_fk from MD_MDM_STD_ROUTER_item_cc where id = "  + id;
		bb.writeLog(sql);
		rs.executeSql(sql);
		rs.next();
		master_fk = rs.getString("master_fk");
	}
	if(type.equals("del")){
		sql = "delete MD_MDM_STD_ROUTER_item_cc where id  = " + id;
		rs.executeSql(sql);
	}
	 else if(type.equals("add")){
	    	sql = "insert into MD_MDM_STD_ROUTER_item_cc(id,master_fk,item_no,oper_fk,factory) values (SYS_GUID()||'',"+
					"'" + master_fk + "'," +
					"'" + item_no + "'," +
					"'" + oper_fk + "'," +
					"'" + factory + "'" +
					")";
			rs.executeSql(sql);
	    }
	response.sendRedirect("gylxms1list_cc.jsp?id="+master_fk);
%>