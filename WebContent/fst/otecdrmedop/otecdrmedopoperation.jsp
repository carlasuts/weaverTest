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
    String gcname =  Util.fromScreen(request.getParameter("gcname"),user.getLanguage());
  	String tzlxname =  Util.fromScreen(request.getParameter("tzlxname"),user.getLanguage());
  	String tzshr =  Util.fromScreen(request.getParameter("tzshr"),user.getLanguage());
  	String tzpzr =  Util.fromScreen(request.getParameter("tzpzr"),user.getLanguage());
  	String shrname =  Util.fromScreen(request.getParameter("shrname"),user.getLanguage());
  	String pzrname =  Util.fromScreen(request.getParameter("pzrname"),user.getLanguage());
   	String create_time =  date;
   	int create_user_id =  userID;
   	int update_user_id =  userID;
   	String update_time =  date;
    String gcdm = "";
    String tzlx = "";
    String sql = "";
    RecordSet rs = new RecordSet();
    String id = request.getParameter("id");
    String type = request.getParameter("type");
   	
    sql = "select * from workflow_selectitem where fieldid =( select id from workflow_billfield where billid='-91' and fieldname = 'cq')   and selectname = '"+gcname+"'";
    rs.executeSql(sql);
    rs.next();
    gcdm = rs.getString("selectvalue");
    sql = "select * from workflow_selectitem where fieldid =( select id from workflow_billfield where billid='-91' and fieldname = 'tzlx')   and selectname = '"+tzlxname+"'";
    rs.executeSql(sql);
    rs.next();
    tzlx = rs.getString("selectvalue");
    
    if(type.equals("del")){
	    sql = "delete otecdrmedop where id = " + id;
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  otecdrmedop set gcname = '" + gcname + "',tzlxname = '" + tzlxname + "',tzshr = '" + tzshr + "' ,tzpzr = '" + tzpzr + "',shrname = '" + shrname + "' ,pzrname = '" + pzrname + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into otecdrmedop(gcdm,gcname,tzlx,tzlxname,tzshr,create_user,create_time,tzpzr,shrname,pzrname) values ("+
    			"'" + gcdm + "'," +
    			"'" + gcname + "'," +
				"'" + tzlx + "'," +
				"'" + tzlxname + "'," +
				"'" + tzshr + "'," +
				"'" + create_user_id + "'," +
				"'" + create_time + "'," +
				"'" + tzpzr + "'," +
				"'" + shrname + "'," +
				"'" + pzrname + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("otecdrmedop.jsp");
   %>
