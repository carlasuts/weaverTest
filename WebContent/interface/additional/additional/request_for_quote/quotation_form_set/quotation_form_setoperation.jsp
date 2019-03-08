<%@ page language="java" contentType="text/html; charset=utf-8"  %>
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
     bb.writeLog("MD_SD_QTTN_PKG++++++++++"); 
    
    String mainid =  Util.fromScreen(request.getParameter("mianid"),user.getLanguage());
  	String name =  Util.fromScreen(request.getParameter("name"),user.getLanguage());
  	String FULL_NAME =  Util.fromScreen(request.getParameter("FULL_NAME"),user.getLanguage());
  	String WIRE_LENGTH =  Util.fromScreen(request.getParameter("WIRE_LENGTH"),user.getLanguage());
	String WIRE_QTY =  Util.fromScreen(request.getParameter("WIRE_QTY"),user.getLanguage());
	String DIE_SIZE_X =  Util.fromScreen(request.getParameter("DIE_SIZE_X"),user.getLanguage());
  	String DIE_SIZE_Y =  Util.fromScreen(request.getParameter("DIE_SIZE_Y"),user.getLanguage());
  	String EQUIPMENT_DEP_PERIOD =  Util.fromScreen(request.getParameter("EQUIPMENT_DEP_PERIOD"),user.getLanguage());
	String COPPER_PRICE_WAVE =  Util.fromScreen(request.getParameter("COPPER_PRICE_WAVE"),user.getLanguage());
	String FACTORY_FK = "";

	if (FULL_NAME.equals("圆片厂")){
		FACTORY_FK = "0000";
	}else if (FULL_NAME.equals("一期厂")){
		FACTORY_FK = "1000";
	}else if (FULL_NAME.equals("二期厂")){
		FACTORY_FK = "2000";
	}else if (FULL_NAME.equals("三期厂")){
		FACTORY_FK = "3000";
	}else if (FULL_NAME.equals("合肥厂")){
		FACTORY_FK = "4000";
	}else if (FULL_NAME.equals("苏通厂")){
		FACTORY_FK = "5000";
	}
    String id = request.getParameter("id");
    String type = request.getParameter("type");
   
    bb.writeLog("MD_SD_QTTN_PKG : id:" + id + ",type " + type +" MAINID" + mainid ); 
   
    String sql = "";
    RecordSet rs = new RecordSet();

    if(type.equals("del")){
	    sql = "delete MD_SD_QTTN_PKG where id  = '"+id+"'";
	     bb.writeLog("MD_SD_QTTN_PKG:" + sql);
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_QTTN_PKG set id = '" + id + "',name = '" + name + "',FACTORY_FK = '" + FACTORY_FK +"',WIRE_LENGTH = '" + WIRE_LENGTH +"',WIRE_QTY = '" + WIRE_QTY +"',DIE_SIZE_X = '" + DIE_SIZE_X +"',DIE_SIZE_Y = '" + DIE_SIZE_Y + "', EQUIPMENT_DEP_PERIOD  = '" + EQUIPMENT_DEP_PERIOD + "', COPPER_PRICE_WAVE  = '" + COPPER_PRICE_WAVE + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_QTTN_PKG(id,name,FACTORY_FK,WIRE_LENGTH,WIRE_QTY,DIE_SIZE_X,DIE_SIZE_Y,EQUIPMENT_DEP_PERIOD,COPPER_PRICE_WAVE) values ("+
				"'" + mainid + "'," +
				"'" + name + "'," +
				"'" + FACTORY_FK + "'," +
				"'" + WIRE_LENGTH + "'," +
				"'" + WIRE_QTY + "'," +
				"'" + DIE_SIZE_X + "'," +
				"'" + DIE_SIZE_Y + "'," +
				"'" + EQUIPMENT_DEP_PERIOD + "'," +
				"'" + COPPER_PRICE_WAVE + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("quotation_form_set.jsp");
   %>
