<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSet rs = new RecordSet();
String sql = "";
BaseBean bs = new BaseBean();


String shape =  Util.null2String(request.getParameter("shape"));
String producttype =  Util.null2String(request.getParameter("producttype"));
String custid =  Util.null2String(request.getParameter("custid"));
String tradeway =  Util.null2String(request.getParameter("tradeway"));
String wire_qty ="",die_size_x="",die_size_y="";

StringBuffer sb = new StringBuffer();
if(!"".equals(shape) && !"".equals(producttype) && !"".equals(custid) && !"".equals(tradeway)){

	sql = "select WIRE_QTY from MD_SD_QTTN_PKG where name = '"+shape+"'";
	bs.writeLog("sql:"+ sql);
	rs.executeSql(sql);	
	while(rs.next()){
		wire_qty = rs.getString("WIRE_QTY");
	}

	sql = "select  DIE_SIZE_X,DIE_SIZE_Y from MD_SD_QTTN_PKG where NAME =  '"+shape+"'";
	bs.writeLog("sql:"+ sql);
	rs.executeSql(sql);
	while(rs.next()){
		die_size_x = rs.getString("DIE_SIZE_X");
		die_size_y = rs.getString("DIE_SIZE_Y");
	}
}
	sb.append(wire_qty).append(" ").append(die_size_x).append(" ").append(die_size_y).append(" ");
	if(sb.length() > 0){
		sb.deleteCharAt(sb.length() - 1);
	}
out.print(sb);
%>