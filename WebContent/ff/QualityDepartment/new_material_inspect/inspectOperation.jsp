<%--
  Created by IntelliJ IDEA.
  User: zong.yq
  Date: 2019/2/26-0026
  Time: 10:55
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
    String CONDITION = Util.fromScreen(request.getParameter("condition"), user.getLanguage());
    String PD = Util.fromScreen(request.getParameter("pd"), user.getLanguage());
    String ID =  Util.fromScreen(request.getParameter("id"),user.getLanguage());

    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
        sql = "DELETE OBASINSPECTDOP WHERE ID = " + ID;
        rs.executeSql(sql);
    } else if (type.equals("modi")) {
        baseBean.writeLog("execute update operation");
        sql = "UPDATE OBASINSPECTDOP SET CONDITION = '" + CONDITION + ", PD = '" + PD + "' WHERE ID = " + ID;
        baseBean.writeLog("update sql: " + sql);
        rs.executeSql(sql);
    } else {
        baseBean.writeLog("execute insert operation");
        sql  = " INSERT	INTO OBASINSPECTDOP (CONDITION, PD) VALUES ('" + CONDITION + "', '" + PD + "')";
        baseBean.writeLog("insert sql: " + sql);
        rs.executeSql(sql);
    }
    response.sendRedirect("inspect.jsp");
%>
