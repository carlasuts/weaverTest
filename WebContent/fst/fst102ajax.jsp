<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%
	try {
		BaseBean baseBean = new BaseBean();
		String id = request.getParameter("id");//
		
		RecordSet rs = new RecordSet();
		String sql = "";
		String result = "";
	
		sql = "select managerid from hrmresource where id = " + id;
		rs.execute(sql);
		if(rs.next()){
			result = rs.getString("managerid");
		}
		out.print(result);
	} 
	catch (java.lang.Exception e) {
		BaseBean baseBean = new BaseBean();
		baseBean.writeLog("start log");
		baseBean.writeLog("------------------------------------------------------------------------");
		baseBean.writeLog("/interface/ff/fst102ajax.jsp error:" + e.getMessage());
		baseBean.writeLog("------------------------------------------------------------------------");
		baseBean.writeLog("end log");
	}
%>
