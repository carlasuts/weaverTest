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
    String fb =  Util.fromScreen(request.getParameter("fb"),user.getLanguage());
  	String qb =  Util.fromScreen(request.getParameter("qb"),user.getLanguage());
    String sblb =  Util.fromScreen(request.getParameter("sblb"),user.getLanguage());
  	String sbbh =  Util.fromScreen(request.getParameter("sbbh"),user.getLanguage());
  	String sbms =  Util.fromScreen(request.getParameter("sbms"),user.getLanguage());
  	String djr =  Util.fromScreen(request.getParameter("djr"),user.getLanguage());
  	String zhdjsj =  Util.fromScreen(request.getParameter("zhdjsj"),user.getLanguage());
  	String djpl =  Util.fromScreen(request.getParameter("djpl"),user.getLanguage());
  	String workcode =  Util.fromScreen(request.getParameter("workcode"),user.getLanguage());
  	String email =  Util.fromScreen(request.getParameter("email"),user.getLanguage());
  	String stopsign =  Util.fromScreen(request.getParameter("stopsign"),user.getLanguage());
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete sbdjxx where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  sbdjxx set fb = '" + fb + "',qb = '" + qb + "',sblb = '" + sblb +"',sbbh = '" + sbbh +"',sbms = '" + sbms +"',djr = '" + djr +"',zhdjsj = '" + zhdjsj +"',djpl = '" + djpl + "',workcode = '" + workcode +"',email = '" + email+"',stopsign = '" + stopsign +"' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	
        sql = "select * from sbdjxx where SBBH = '" + sbbh + "' and STOPSIGN='U'"; //判断设备编号是否存在
        rs.executeSql(sql);
        if(!rs.next()){ 
    	sql = "insert into sbdjxx(FB,QB,SBLB,SBBH,SBMS,DJR,WORKCODE,ZHDJSJ,DJPL,EMAIL,STOPSIGN)  select  "+
				"'" + fb + "'," +
				"'" + qb + "'," +
				"'" + sblb + "'," +
				"'" + sbbh + "'," +
				"'" + sbms + "'," +
				"'" + djr + "'," +
				"'" + workcode + "'," +
				"'" + zhdjsj + "'," +
				"'" + djpl + "'," +
				"email," +
				"'" + stopsign + "'" +
				"  from Hrmresource where LOGINID='"+workcode+"'";
        }else{
        	sql ="select EMAIL from Hrmresource where LOGINID='"+workcode+"'";
        	rs.executeSql(sql);
        	if(rs.next())
        	 email=rs.getString("EMAIL");
        	else{
        		 bb.writeLog("sbdjxx  增加 表更新:" + sql+"----没有这个用户");
        	}
        	sql = "update  sbdjxx set fb = '" + fb + "',qb = '" + qb + "',sblb = '" + sblb  +"',sbms = '" + sbms +"',djr = '" + djr +"',zhdjsj = '" + zhdjsj +"',djpl = '" + djpl + "',workcode = '" + workcode +"',email = '" + email+"',stopsign = '" + stopsign +"'   where  SBBH = '" + sbbh + "' and STOPSIGN='U'";	
        }
		rs.executeSql(sql);
    }
    response.sendRedirect("sbdj.jsp");
   %>
