<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>

<%
	int userId = user.getUID();
	RecordSet rs = new RecordSet();
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String name =  Util.fromScreen(request.getParameter("name"),user.getLanguage());
	String orderby =  Util.fromScreen(request.getParameter("orderby"),user.getLanguage());
	String method =  Util.fromScreen(request.getParameter("method"),user.getLanguage());
	String sql = "";
	if(method.equals("modi")){
		sql = "update  tb_ityc set name = '" + name + "',oby = " + orderby + " where id = " + id;
		rs.executeSql(sql);
	}
	else if(method.equals("add")){
		sql = "insert into tb_ityc(name,oby) values ('" + name + "'," + orderby + ")";
		rs.executeSql(sql);
	}
	else if(method.equals("del")){
		sql = "delete tb_ityc1 where systemid = " + id;
		rs.executeSql(sql);
		sql = "delete tb_ityc where id = " + id;
		rs.executeSql(sql);
	}
	response.sendRedirect("ityclist.jsp");
%>