<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%
	try {
		BaseBean baseBean = new BaseBean();
		String deptid = request.getParameter("deptid");//
		
		RecordSet rs = new RecordSet();
		String sql = "";
		String result = "";
	
		sql = "select id from hrmresource where departmentid = " + deptid + " and seclevel = (select max(seclevel) from hrmresource where departmentid = " + deptid + ")";
		rs.execute(sql);
		if(rs.next()){
			result = rs.getString("id");
		}
		out.print(result);
	} 
	catch (java.lang.Exception e) {
		BaseBean baseBean = new BaseBean();
		baseBean.writeLog("start log");
		baseBean.writeLog("------------------------------------------------------------------------");
		baseBean.writeLog("/interface/ff/fst81ajax.jsp error:" + e.getMessage());
		baseBean.writeLog("------------------------------------------------------------------------");
		baseBean.writeLog("end log");
	}
%>
