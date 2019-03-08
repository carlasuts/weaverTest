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
    String site =  Util.fromScreen(request.getParameter("site"),user.getLanguage());
  	String DEPART =  Util.fromScreen(request.getParameter("DEPART"),user.getLanguage());
  	String name =  Util.fromScreen(request.getParameter("name"),user.getLanguage());
  	String DEPARTCOPY =  Util.fromScreen(request.getParameter("DEPARTCOPY"),user.getLanguage());
  	String TOTAL_REJECT_QTY =  Util.fromScreen(request.getParameter("TOTAL_REJECT_QTY"),user.getLanguage());
   	String REJECTCODE1_QTY =  Util.fromScreen(request.getParameter("REJECTCODE1_QTY"),user.getLanguage());
   	String REJECTCODE2_QTY =  Util.fromScreen(request.getParameter("REJECTCODE2_QTY"),user.getLanguage());
   	String REJECTCODE3_QTY =  Util.fromScreen(request.getParameter("REJECTCODE3_QTY"),user.getLanguage());
   	String REJECTCODE4_QTY =  Util.fromScreen(request.getParameter("REJECTCODE4_QTY"),user.getLanguage());
   	String REJECTCODE5_QTY =  Util.fromScreen(request.getParameter("REJECTCODE5_QTY"),user.getLanguage());
   	String REJECTCODE6_QTY =  Util.fromScreen(request.getParameter("REJECTCODE6_QTY"),user.getLanguage());
    String create_time ="";
    String update_time ="";
   	
   	String workcode= Util.null2String(request.getParameter("workcode"));
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    
    
    
    
    if(type.equals("del")){
	    sql = "delete OKEYUSERINF where workcode = '"+workcode+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	update_time=df.format(System.currentTimeMillis());
    	String condition="";
    	if(!DEPARTCOPY.equals(DEPART)){
    		condition="',DEPART = '"+DEPART;
    	}
    	sql = "update  OKEYUSERINF set site = '" + site + condition + "',name = '" + name + "',TOTAL_REJECT_QTY = '" + TOTAL_REJECT_QTY + "',REJECTCODE1_QTY = '" + REJECTCODE1_QTY + "',REJECTCODE2_QTY = '" + REJECTCODE2_QTY + "',REJECTCODE3_QTY = '" + REJECTCODE3_QTY + "',REJECTCODE4_QTY = '" + REJECTCODE4_QTY + "',REJECTCODE5_QTY = '" + REJECTCODE5_QTY+ "',update_time = '" + update_time + "',REJECTCODE6_QTY = '" + REJECTCODE6_QTY + "' where workcode = '"+workcode+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	create_time=df.format(System.currentTimeMillis());
    	sql = "insert into OKEYUSERINF (site,workcode, DEPART,name,create_time,update_time,TOTAL_REJECT_QTY,REJECTCODE1_QTY,REJECTCODE2_QTY,REJECTCODE3_QTY,REJECTCODE4_QTY, REJECTCODE5_QTY, REJECTCODE6_QTY) values ("+
				"'" + site + "'," +
				"'" + workcode + "'," +
				"'" + DEPART + "'," +
				"'" + name + "'," +
				"'" + create_time + "'," +
				"' '," +
				"'" + TOTAL_REJECT_QTY + "'," +
				"'" + REJECTCODE1_QTY + "'," +
				"'" + REJECTCODE2_QTY + "'," +
				"'" + REJECTCODE3_QTY + "'," +
				"'" + REJECTCODE4_QTY + "'," +
				"'" + REJECTCODE5_QTY + "'," +
				"'" + REJECTCODE6_QTY + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("UserQualification.jsp");
   %>
