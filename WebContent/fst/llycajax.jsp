<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page
	import="weaver.general.Util,java.text.*,weaver.conn.*,java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%
	try {
		BaseBean baseBean = new BaseBean();
		String khm = request.getParameter("khm");//
		String xh = request.getParameter("xh");//
		String tester = request.getParameter("tester");//
		String pkid = request.getParameter("pkid");//
		
		RecordSet rs = new RecordSet();
		String sql = "";
		String result = "";
	
		sql = "select b.id id,lastname from TB_LLYC a inner join hrmresource b on a.workcode = b.workcode where 1 = 1 ";
		if(!khm.equals("")){
			sql += " and khm = '" + khm + "'";
		}
		if(!xh.equals("")){
			sql += " and xh = '" + xh + "'";
		}
		if(!tester.equals("")){
			sql += " and tester ='" + tester + "'";
		}
		if(!pkid.equals("")){
			sql += " and pkid = '" + pkid + "'";
		}
		rs.execute(sql);
		
		String id = "", hrm = "";
		while(rs.next()){
			id += rs.getString("id") + ",";
			hrm += rs.getString("lastname") + ",";
		}
		if(!id.equals(""))
			id = id.substring(0, id.length() - 1);
		if(!hrm.equals(""))
			hrm = hrm.substring(0, hrm.length() - 1);
		result = id + "|" + hrm;
		out.print(result);
	} 
	catch (java.lang.Exception e) {
		BaseBean baseBean = new BaseBean();
		baseBean.writeLog("start log");
		baseBean.writeLog("------------------------------------------------------------------------");
		baseBean.writeLog("/interface/ff/llycajax.jsp error:" + e.getMessage());
		baseBean.writeLog("------------------------------------------------------------------------");
		baseBean.writeLog("end log");
	}
%>
