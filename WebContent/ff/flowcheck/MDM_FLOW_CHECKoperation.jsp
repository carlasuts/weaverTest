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
   	String PACKAGETYPE =  Util.fromScreen(request.getParameter("PACKAGETYPE"),user.getLanguage());
   	String OPER =  Util.fromScreen(request.getParameter("OPER"),user.getLanguage());
   	String SELECTVALUE = "";
   	if("tray盘-CHIPTRAY".equals(PACKAGETYPE)){
   		SELECTVALUE = "1";
   	}
   	if("弹匣-AMMO".equals(PACKAGETYPE)){
   		SELECTVALUE = "2";
   	}
   	if("散装-BULK".equals(PACKAGETYPE)){
   		SELECTVALUE = "3";
   	}
   	if("料条-TUBE".equals(PACKAGETYPE)){
   		SELECTVALUE = "4";
   	}
   	if("料盘-TRAY".equals(PACKAGETYPE)){
   		SELECTVALUE = "5";
   	}
   	if("载带-CARRIER".equals(PACKAGETYPE)){
   		SELECTVALUE = "6";
   	}
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    RecordSet rs1 = new RecordSet();
    if(type.equals("del")){
	    sql = "delete mdm_flow_check where id = '"+id+"'";
	    rs.executeSql(sql);
	    bb.writeLog("mdm_flow_check deletesql:" + sql);
    }
    else if(type.equals("modi")){
    	sql = "update  mdm_flow_check set packagetype = '" + PACKAGETYPE + "',oper = '" + OPER + "', selectvalue  = '" + SELECTVALUE + "' where id = '"+id+"'";
		rs.executeSql(sql);
		bb.writeLog("mdm_flow_check updatesql:" + sql);
    }
    else if(type.equals("add")){
    	sql = "select * from mdm_flow_check where packagetype = '"+ PACKAGETYPE +"' and oper = '"+ OPER +"'";
    	rs1.executeSql(sql);
    	if(!rs1.next()){
        	sql = "insert into mdm_flow_check (packagetype,oper,selectvalue) values ("+
    				"'" + PACKAGETYPE + "'," +
    				"'" + OPER + "'," +
    				"'" + SELECTVALUE + "'" +
    				")";
    		rs.executeSql(sql);
    		bb.writeLog("mdm_flow_check insertsql:" + sql);
    	}
    }
    response.sendRedirect("mdm_flow_check.jsp");
   %>
