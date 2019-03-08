<%--
  Created by IntelliJ IDEA.
  User: zong.yq
  Date: 2019/1/22-0022
  Time: 10:52
  To change this template use File | Settings | File Templates.
--%>
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
    BaseBean baseBean = new BaseBean();
    String ID =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
    String NAME = Util.fromScreen(request.getParameter("name"), user.getLanguage());
    String MANUFACTURER = Util.fromScreen(request.getParameter("manufacturer"), user.getLanguage());
    String TYPE = Util.fromScreen(request.getParameter("type"), user.getLanguage());

    String type1 = request.getParameter("type1");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type1.equals("del")){
        sql = "DELETE OBASEMDOP WHERE ID = " + ID;
        rs.executeSql(sql);
    } else if (type1.equals("modi")) {
        sql = "UPDATE OBASEMDOP SET NAME = '" + NAME + "', MANUFACTURER = '" + MANUFACTURER + "', TYPE = '" + TYPE + "' WHERE ID = " + ID;
        baseBean.writeLog("update sql: " + sql);
        rs.execute(sql);
    } else {
        baseBean.writeLog("execute insert operation");
        sql  = "INSERT INTO OBASEMDOP (NAME, MANUFACTURER, TYPE) VALUES ('" + NAME + "', '" + MANUFACTURER + "', '" + TYPE + "')";
        baseBean.writeLog("insert sql: " + sql);
        rs.executeSql(sql);
    }
    response.sendRedirect("Equipment Manage.jsp");
%>
