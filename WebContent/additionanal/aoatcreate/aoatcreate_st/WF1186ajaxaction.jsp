<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSet rs = new RecordSet();
RecordSetDataSource mesrs = new RecordSetDataSource("STMESDB");
RecordSetDataSource mesrs1 = new RecordSetDataSource("STMESDB");
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
String result = "";
String oper = "";
String oper_desc = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	sql = "select * from MD_MDM_STD_ROUTER_item_st  where master_fk='"+gylxdm+"' order by item_no";
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

//656客户 根据客户品名查询打印内容要求
if(type.equals("2")){
	String khpm1 =  Util.null2String(request.getParameter("khpm1"));
	sql = "select DATA_1  from mesmgr.MGCMLAGDAT where factory = 'ASSY' and table_name = 'B@656_TOPMARK' and key_1 = '"+ khpm1 +"' ";
	mesrs1.executeSql(sql);
	if(mesrs1.next()){
		result = mesrs1.getString(1);
	}
}
out.print(result);
%>
