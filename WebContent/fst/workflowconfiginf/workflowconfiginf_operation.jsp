<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.net.URL"%> 
<%@page import="java.net.URLConnection"%> 
<%@page import="java.net.HttpURLConnection"%> 
<%@page import="javax.servlet.http.HttpServletRequest"%> 
<%@page import="javax.servlet.http.HttpServletResponse"%>
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
<%@ page import="weaver.interfaces.workflowUtil.AESUtils" %>
<%@include file="/systeminfo/init_wev8.jsp" %>
   <%
    BaseBean bb = new BaseBean();
   	String workflowid =  Util.fromScreen(request.getParameter("workflowid"),user.getLanguage());
   	String param =  Util.fromScreen(request.getParameter("param"),user.getLanguage());
   	String paramdesc =  Util.fromScreen(request.getParameter("paramdesc"),user.getLanguage());
   	String plantopt =  Util.fromScreen(request.getParameter("plantopt"),user.getLanguage());
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    Date d = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    String date = sdf.format(d);
    int userID = user.getUID();

    if(param.equals("password")){
    //加密  
    //需要加密的明文 paramdesc    密钥 workflowid
		paramdesc = AESUtils.aesEncryp(paramdesc,workflowid);
	}

    RecordSet rs1 = new RecordSet();
    sql = " select workcode from hrmresource where id  = '"+ userID +"'" ;
    rs1.executeSql(sql);
    rs1.next();

    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete workflowconfiginf where id = '"+id+"'";
	    rs.executeSql(sql);
	    bb.writeLog("workflowconfiginf deletesql:" + sql);
    }
    else if(type.equals("modi")){
    	sql = "update  workflowconfiginf set workflowid = '" + workflowid + "',param = '" + param + "', paramdesc  = '" + paramdesc + "' , plantopt = '"+ plantopt +"' , UPDATER = '"+ rs1.getString("workcode")  +"', UPDATETIME = '"+ date +"' where id = '"+id+"'";
		rs.executeSql(sql);
		bb.writeLog("workflowconfiginf updatesql:" + sql);
    }
    else if(type.equals("add")){
    	sql = "insert into workflowconfiginf(workflowid , param, paramdesc, plantopt , CREATETIME , CREATER) values ("+
				"'" + workflowid + "'," +
				"'" + param + "'," +
				"'" + paramdesc + "'," +
				"'" + plantopt + "'," +
        "'" + date + "'," +
        "'" + rs1.getString("workcode") + "'" +
				")";
		rs.executeSql(sql);
		bb.writeLog("workflowconfiginf insertsql:" + sql);
    }
    response.sendRedirect("workflowconfiginf.jsp");
   %>
