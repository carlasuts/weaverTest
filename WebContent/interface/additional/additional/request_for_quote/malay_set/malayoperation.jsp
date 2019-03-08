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
   	int userID = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	String date = sdf.format(d); 
    String no1 =  Util.fromScreen(request.getParameter("no1"),user.getLanguage());
  	String sprsl =  Util.fromScreen(request.getParameter("sprsl"),user.getLanguage());
  	String molga =  Util.fromScreen(request.getParameter("molga"),user.getLanguage());
  	String lgart =  Util.fromScreen(request.getParameter("lgart"),user.getLanguage());
  	String lgtxt =  Util.fromScreen(request.getParameter("lgtxt"),user.getLanguage());
  	String kztxt =  Util.fromScreen(request.getParameter("kztxt"),user.getLanguage());
  	String wten =  Util.fromScreen(request.getParameter("wten"),user.getLanguage());
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete ZJV_HR_OAWT_BM where no1  = '"+no1+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  ZJV_HR_OAWT_BM set sprsl = '" + sprsl + "',molga = '" + molga + "',lgart = '" + lgart + "',lgtxt = '" + lgtxt  + "',kztxt = '" + kztxt  + "',wt_en = '" + wten + "' where no1 = '"+no1+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into ZJV_HR_OAWT_BM(NO1, SPRSL, MOLGA, LGART, LGTXT,KZTXT, WT_EN) values ("+
				"'" + no1 + "'," +
				"'" + sprsl + "'," +
				"'" + molga + "'," +
				"'" + lgart + "'," +
				"'" + lgtxt + "'," +
				"'" + kztxt + "'," +
			    "'" + wten + "'" +	
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("malay.jsp");
   %>
