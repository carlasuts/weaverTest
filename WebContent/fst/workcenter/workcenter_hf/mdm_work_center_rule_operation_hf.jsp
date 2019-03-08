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
	Date date = new Date();
	SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	String CUST_FK =  Util.fromScreen(request.getParameter("cust_fk"),user.getLanguage());
	String PKG_OUTLINE_FK =  Util.fromScreen(request.getParameter("pkg_outline_fk"),user.getLanguage());
	String OPER_FK =  Util.fromScreen(request.getParameter("oper_fk"),user.getLanguage());
	String VEHICLE_FK =  Util.fromScreen(request.getParameter("vehicle_fk"),user.getLanguage());
	String WORK_CENTER_FK =  Util.fromScreen(request.getParameter("work_center_fk"),user.getLanguage());
	String DATE_EFFECT =  Util.fromScreen(request.getParameter("DATE_EFFECT"),user.getLanguage());
	
	String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete mdm_work_center_rule_hf where id = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  mdm_work_center_rule_hf set CUST_FK = '" + CUST_FK + "',PKG_OUTLINE_FK = '" + PKG_OUTLINE_FK + "',OPER_FK = '" + OPER_FK + "' ,VEHICLE_FK = '" + VEHICLE_FK + "',WORK_CENTER_FK = '" + WORK_CENTER_FK + "',DATE_EFFECT = TO_DATE('" + DATE_EFFECT + "','yyyy-MM-dd HH24:mi:ss') where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "Insert into MDM_WORK_CENTER_RULE_hf (ID, CUST_FK, PKG_OUTLINE_FK, OPER_FK, VEHICLE_FK, WORK_CENTER_FK, DATE_CREATE, DATE_UPDATE, DATE_EFFECT, DATE_EXPIRE) Values ( " +
				"SYS_GUID()||'',"+ 
    				"'" + CUST_FK + "'," +
    				"'" + PKG_OUTLINE_FK + "'," +
    				"'" + OPER_FK + "'," +
    				"'" + VEHICLE_FK + "'," +
					"'" + WORK_CENTER_FK + "'," +
					"TO_DATE('" + bartDateFormat.format(date) + "','yyyy-MM-dd HH24:mi:ss')," +
		    		"TO_DATE('" + bartDateFormat.format(date) + "','yyyy-MM-dd HH24:mi:ss')," +
		    		"TO_DATE('" + DATE_EFFECT + "','yyyy-MM-dd HH24:mi:ss')," +
					"TO_DATE('9999-12-31','yyyy-MM-dd HH24:mi:ss')" +
    				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("mdm_work_center_rule_hf.jsp");
   %>
