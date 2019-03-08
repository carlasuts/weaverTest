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
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
    String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
    String site =  Util.fromScreen(request.getParameter("site"),user.getLanguage());
  	String department =  Util.fromScreen(request.getParameter("department"),user.getLanguage());
  	String workcodeId =  Util.fromScreen(request.getParameter("workcode"),user.getLanguage());
  	int userID = user.getUID();
  	
   //	TOTAL_REJECT_QTY=(TOTAL_REJECT_QTY.equals("")) || TOTAL_REJECT_QTY==null ?"0":TOTAL_REJECT_QTY;
   
    String create_time ="";
    String update_time ="";
    String workcode="";
    String lastname="";
    String userid="";
   	
    String type = request.getParameter("type");
    String sql = "";
    String sql2="select workcode,lastname from HrmResource where id='"+workcodeId+"'";
    String sql3="select workcode from HrmResource where id='"+userID+"'";
    RecordSet rs = new RecordSet();
    rs.executeSql(sql2);
    if(rs.next()){
    	workcode = rs.getString("workcode");
    	lastname = rs.getString("lastname");

	}
    rs.executeSql(sql3);
    if(rs.next()){
    	userid = rs.getString("workcode");
	}
    
    
    if(type.equals("del")){
	    sql = "delete OBASSECDOP where id = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	update_time=df.format(System.currentTimeMillis());
    	
    	sql = "update  OBASSECDOP set site = '" + site + "',department = '" + department + "',workcode = '" + workcode+"',lastname = '" + lastname + "',updater = '" + userid + "',updatetime = '" + update_time +"' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	create_time=df.format(System.currentTimeMillis());
    	sql = "insert into OBASSECDOP (site,department,workcode,lastname,creater,createtime) values ("+
				"'" + site + "'," +
				"'" + department + "'," +
				"'" + workcode + "'," +
				"'" + lastname + "'," +
				"'" + userid + "'," +
				"'" + create_time +"'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("secretaryInfo.jsp");
   %>
