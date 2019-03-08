<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>

<%
	int userId = user.getUID();
	RecordSet rs = new RecordSet();
	String id = request.getParameter("id");
   	String name =  Util.fromScreen(request.getParameter("name"),user.getLanguage());
   	String factory =  Util.fromScreen(request.getParameter("factory"),user.getLanguage());
   	String DESC =  Util.fromScreen(request.getParameter("DESC"),user.getLanguage());
    String type = request.getParameter("type");
	String sql = "";
	if(type.equals("modi")){
    	sql = "update  MD_MDM_STD_ROUTER_cc set name = '" + name + "',factory = '" + factory + "', \"DESC\"  = '" + DESC + "' where id = '"+id+"'";
		rs.executeSql(sql);
	}
	else if(type.equals("add")){
    	sql = "insert into MD_MDM_STD_ROUTER_cc(id,name,factory,\"DESC\") values (SYS_GUID()||'',"+
				"'" + name + "'," +
				"'" + factory + "'," +
				"'" + DESC + "'" +
				")";
		rs.executeSql(sql);
	}
	else if(type.equals("del")){
		sql = "delete MD_MDM_STD_ROUTER_item_cc where master_fk  = '"+id+"'";
		rs.executeSql(sql);
		sql = "delete md_mdm_std_router_cc where id  = '"+id+"'";
		rs.executeSql(sql);
	}
	response.sendRedirect("gylxmslist_cc.jsp");
%>