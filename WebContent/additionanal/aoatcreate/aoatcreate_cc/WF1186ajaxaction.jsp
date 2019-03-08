<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSet rs = new RecordSet();
RecordSetDataSource mesrs = new RecordSetDataSource("mesdb");
RecordSetDataSource mesrs1 = new RecordSetDataSource("mesdb");
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
String result = "";
String oper = "";
String oper_desc = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	sql = "select * from MD_MDM_STD_ROUTER_item_cc  where master_fk='"+gylxdm+"' order by item_no";
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


//需求系统编号OA201711008 主数据申请T流程FLOW工序卡控
if(type.equals("3")){
	RecordSet rs1 = new RecordSet();
	RecordSet rs2 = new RecordSet();
	String oper1 =  Util.null2String(request.getParameter("oper1"));
	String requestid1 =  Util.null2String(request.getParameter("requestid1"));
	sql = "select Packagetype from formtable_main_144 where Requestid = '"+ requestid1 +"' ";
	rs2.executeSql(sql);
	rs2.next();
	sql = "select count(1) as no  from mdm_flow_check where oper = '"+ oper1 +"' and selectvalue = '"+ rs2.getString("Packagetype") +"' ";
	rs1.executeSql(sql);
	if(rs1.next()){
		result = rs1.getString(1);
	}
}
out.print(result);
%>
