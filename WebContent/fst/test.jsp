<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>

<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String date = "20150511104758";
String tmp = date.substring(0,4) + "-" + date.substring(4,6) + "-" + date.substring(6,8);
out.print(tmp);
%>