<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.conn.RecordSet"%>
<%@page import="weaver.general.Util"%>
<%
	//接收传入的参数
	String workCode = Util.null2String(request.getParameter("WorkCode"));
	StringBuffer sb = null;
	RecordSet rs = new RecordSet();
	BaseBean bb = new BaseBean();
	bb.writeLog("request: " + request);
	try {
		bb.writeLog("IT_AUTHORITY_CENTRALIZED_APPLICATION IS GETTING ALL_AUTHORITY NOW\r\nWorkCode:  + workCode");
		bb.writeLog("WorkCode: " + workCode);
		sb = new StringBuffer();
		String sql = null;
		sql = "SELECT AR.SYSTEM, TO_CHAR(WM_CONCAT(AR.REMARK)) AS INFO FROM AUTHORITY_RECODE AR " +  
				"WHERE AR.WORKCODE = '" + workCode + "' " + 
				"AND AR.DATE_EXPIRE > SYSDATE " +
				"GROUP BY AR.SYSTEM";
		bb.writeLog("sql: " + sql);
		rs.executeQuery(sql);
		while (rs.next()) {
			sb.append(rs.getString(1)).append(":").append(rs.getString(2)).append(";");
		}
		//去掉一个分号
		if (!"".equals(sb)) {
			sb = sb.deleteCharAt(sb.length() - 1);
		}
	} catch (Exception e) {
		bb.writeLog("IT_AUTHORITY_CENTRALIZED_APPLICATION ALL_AUTHORITY EXCEPTION:"
				+ e.getMessage());
	} finally {
		bb.writeLog("IT_AUTHORITY_CENTRALIZED_APPLICATION ALL_AUTHORITY END");
	}
	out.print(sb.toString());
%>
