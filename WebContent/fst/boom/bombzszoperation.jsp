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
    Date d = new Date();
   	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	int userID = user.getUID();
    String factory =  Util.fromScreen(request.getParameter("factory"),user.getLanguage());
  	String cust_id =  Util.fromScreen(request.getParameter("cust_id"),user.getLanguage());
  	String pkld_grp =  Util.fromScreen(request.getParameter("pkld_grp"),user.getLanguage());
  	String pkld =  Util.fromScreen(request.getParameter("pkld"),user.getLanguage());
   	String pkld_com =  Util.fromScreen(request.getParameter("pkld_com"),user.getLanguage());
   	String oper_grp =  Util.fromScreen(request.getParameter("oper_grp"),user.getLanguage());
   	String mat_type =  Util.fromScreen(request.getParameter("mat_type"),user.getLanguage());
   	String mat_id =  Util.fromScreen(request.getParameter("mat_id"),user.getLanguage());
   	String mat_desc =  Util.fromScreen(request.getParameter("mat_desc"),user.getLanguage());
   	String qty_1 =  Util.fromScreen(request.getParameter("qty_1"),user.getLanguage());
   	String storage_location =  Util.fromScreen(request.getParameter("storage_location"),user.getLanguage());
   	String mustfill_flag =  Util.fromScreen(request.getParameter("mustfill_flag"),user.getLanguage());
   	int create_user_id =  userID;
   	String create_time =  date;
   	int update_user_id =  userID;
   	String update_time =  date;
   
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete obomsetmat where id = " + id;
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  obomsetmat set factory = '" + factory + "',cust_id = '" + cust_id + "',pkld_grp = '" + pkld_grp + "' ,pkld = '" + pkld + "',pkld_com = '" + pkld_com + "' ,oper_grp = '" + oper_grp + "',mat_type = '" + mat_type + "',mat_id = '" + mat_id + "',mat_desc = '" + mat_desc + "',qty_1 = '" + qty_1 + "',storage_location = '" + storage_location + "',mustfill_flag = '" + mustfill_flag + "',update_user_id = '" + update_user_id + "',update_time = '" + update_time + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into obomsetmat(factory,cust_id,pkld_grp,pkld,pkld_com,oper_grp,mat_type,mat_id,mat_desc,qty_1,storage_location,mustfill_flag,create_time,create_user_id) values ("+
    			"'" + factory + "'," +
    			"'" + cust_id + "'," +
				"'" + pkld_grp + "'," +
				"'" + pkld + "'," +
				"'" + pkld_com + "'," +
				"'" + oper_grp + "'," +
				"'" + mat_type + "'," +
				"'" + mat_id + "'," +
				"'" + mat_desc + "'," +
				"'" + qty_1 + "'," +
				"'" + storage_location + "'," +
				"'" + mustfill_flag + "'," +
				"'" + create_time + "'," +
				"'" +  create_user_id+ "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("bombzsz.jsp");
   %>
