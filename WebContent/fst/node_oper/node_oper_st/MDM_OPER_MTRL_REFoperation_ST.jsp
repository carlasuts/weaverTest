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
    String oper_fk =  Util.fromScreen(request.getParameter("oper_fk"),user.getLanguage());
  	String oper_role_fk =  Util.fromScreen(request.getParameter("oper_role_fk"),user.getLanguage());
  	String oper_role_pk_id =  Util.fromScreen(request.getParameter("oper_role_pk_id"),user.getLanguage());
  	String mustfill_flag =  Util.fromScreen(request.getParameter("mustfill_flag"),user.getLanguage());
	String mtrl_group_fk =  Util.fromScreen(request.getParameter("mtrl_group_fk"),user.getLanguage());
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MDM_OPER_MTRL_REF where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MDM_OPER_MTRL_REF set oper_fk = '" + oper_fk + "',mtrl_group_fk = '" + mtrl_group_fk + "',oper_role_fk = '" + oper_role_fk + "', oper_role_pk_id  = '" + oper_role_pk_id + "', mustfill_flag  = '" + mustfill_flag + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MDM_OPER_MTRL_REF(id,oper_fk,mtrl_group_fk,oper_role_fk,oper_role_pk_id,mustfill_flag,SITE_OPTION) values (SYS_GUID()||'',"+
				"'" + oper_fk + "'," +
				"'" + mtrl_group_fk + "'," +
				"'" + oper_role_fk + "'," +
				"'" + oper_role_pk_id + "'," +
				"'" + mustfill_flag + "', '4000' " +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("MDM_OPER_MTRL_REF_ST.jsp");
   %>
