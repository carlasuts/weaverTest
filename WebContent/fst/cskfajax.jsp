<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page
	import="weaver.general.Util,java.text.*,weaver.conn.*,java.util.*"%>
<%@page import="weaver.general.BaseBean"%>
<%
	try {
		BaseBean baseBean = new BaseBean();
		String fzxx = request.getParameter("fzxx");//封装形式
		String khdm = request.getParameter("khdm");//顾客代码
		
		RecordSet rs = new RecordSet();
		String sql = "";
		String result = "";
		int z = 0;
		sql = "select b.id id from TB_CSKF a inner join hrmresource b on a.workcode = b.workcode where packagecode = '" + fzxx + "' and customer = '" + khdm + "'";
		rs.execute(sql);
		while(rs.next()){
			result += rs.getString("id") + ",";
			z++;
		}
		if(z == 0){
			sql = "select b.id id from TB_CSKF a inner join hrmresource b on a.workcode = b.workcode where packagecode = '" + fzxx + "' and customer = 'ALL'";
			rs.execute(sql);
			while(rs.next()){
				result += rs.getString("id") + ",";
			}
		}
		if(result.length() > 0)
			result = result.substring(0, result.length() - 1);
		out.print(result);
	} 
	catch (java.lang.Exception e) {
		BaseBean baseBean = new BaseBean();
		baseBean.writeLog("start log");
		baseBean.writeLog("------------------------------------------------------------------------");
		baseBean.writeLog("/interface/ff/cskfajax.jsp error:" + e.getMessage());
		baseBean.writeLog("------------------------------------------------------------------------");
		baseBean.writeLog("end log");
	}
%>
