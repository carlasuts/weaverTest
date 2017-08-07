<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>

<%
	int userId = user.getUID();
	RecordSet rs = new RecordSet();
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String systemid =  Util.fromScreen(request.getParameter("systemid"),user.getLanguage());
	String name =  Util.fromScreen(request.getParameter("name"),user.getLanguage());
	String orderby =  Util.fromScreen(request.getParameter("orderby"),user.getLanguage());
	String method =  Util.fromScreen(request.getParameter("type"),user.getLanguage());
	String sql = "";
	if(method.equals("del")){
		sql = "delete tb_ityc1 where id = " + id;
		rs.executeSql(sql);
	}
	response.sendRedirect("ityc1list.jsp?id="+systemid);
%>