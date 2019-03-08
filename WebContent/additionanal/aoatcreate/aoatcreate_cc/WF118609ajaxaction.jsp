<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.hrm.*" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil"%>
<%

RecordSet rs = new RecordSet();
RecordSet rs1 = new RecordSet();
String sql = "";
String sql1 = "";
String type =  Util.null2String(request.getParameter("type"));
int requestid = Util.getIntValue(request.getParameter("requestid"));
User user = HrmUserVarify.getUser (request , response) ;
int formid = Util.getIntValue(request.getParameter("formid"));//表单id
int resourceId = user.getUID();
String result = "";
String oper = "";
String Producetype = "";
String PackageType = "";
if(Math.abs(formid) == 143){
	sql1 = "SELECT Producetype , PackageType FROM formtable_main_143 WHERE Requestid = '"+ requestid +"' " ;
	rs1.executeSql(sql1);
	rs1.next();
	Producetype = rs1.getString("Producetype");
	PackageType = rs1.getString("PackageType");
}

/*if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	sql = "select distinct oper_fk  from MDM_OPER_MTRL_REF a ,hrmrolemembers b,hrmroles c where  b.roleid = c.id and c.rolesmark = a.oper_role_fk and b.resourceid =  '"+ resourceId +"' and a.oper_fk in ( select operadd from formtable_main_"+Math.abs(formid)+" a,formtable_main_"+Math.abs(formid)+"_dt2 b where b.mainid = a.id and b.operadd != '0010' and a.requestid =  '"+ requestid +"')";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("oper_fk"))){
			oper = rs.getString("oper_fk");
			result += "{\"oper\":\"" + oper +"\"},";
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}*/

if(type.equals("1")){
	if(Producetype.equals("0") && PackageType.equals("6")){//载带-CARRIER  A流程不维护5230 5400
		sql = "select distinct oper_fk  from MDM_OPER_MTRL_REF a ,hrmrolemembers b,hrmroles c where  b.roleid = c.id and c.rolesmark = a.oper_role_fk and b.resourceid =  '"+ resourceId +"' and a.oper_fk in ( select operadd from formtable_main_"+Math.abs(formid)+" a,formtable_main_"+Math.abs(formid)+"_dt2 b where b.mainid = a.id and b.operadd != '0010' and a.requestid =  '"+ requestid +"') and a.oper_fk != '5230' and a.oper_fk != '5400' ";
	}else{
		sql = "select distinct oper_fk  from MDM_OPER_MTRL_REF a ,hrmrolemembers b,hrmroles c where  b.roleid = c.id and c.rolesmark = a.oper_role_fk and b.resourceid =  '"+ resourceId +"' and a.oper_fk in ( select operadd from formtable_main_"+Math.abs(formid)+" a,formtable_main_"+Math.abs(formid)+"_dt2 b where b.mainid = a.id and b.operadd != '0010' and a.requestid =  '"+ requestid +"')";
	}

	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("oper_fk"))){
			oper = rs.getString("oper_fk");
			result += "{\"oper\":\"" + oper +"\"},";
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
