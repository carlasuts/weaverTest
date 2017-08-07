<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSet rs = new RecordSet();
RecordSetDataSource mesrs = new RecordSetDataSource("mesdb");
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
String result = "";
String oper = "";
String oper_desc = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	sql = "select * from MD_MDM_STD_ROUTER_item  where master_fk='"+gylxdm+"' order by item_no";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("item_no"))){
	    oper = rs.getString("oper_fk");
	    sql = "select S.OPER_DESC from mwipoprdef  s where   oper='" + oper + "'";
	    mesrs.executeSql(sql);
	    while(mesrs.next()){
	    	oper_desc = mesrs.getString("OPER_DESC");
	    }
		result += "{\"item_no\":\"" + rs.getString("item_no")+ "\",\"oper_fk\":\"" + rs.getString("oper_fk") + "\",\"oper_desc\":\"" + oper_desc + "\"},";
	}}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
