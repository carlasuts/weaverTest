<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="weaver.hrm.*" %>
<%
RecordSet rs = new RecordSet();
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
int requestid = Util.getIntValue(request.getParameter("requestid"));
User user = HrmUserVarify.getUser (request , response) ;
int resourceId = user.getUID();
int formid = Util.getIntValue(request.getParameter("formid"));//表单id
String result = "";
String oper = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	//sql = "select distinct oper_fk as oper from (SELECT D.ITEM_NO,c.id,c.oper_grp,c.mat_id,d.oper_fk,c.qty_1,c.storage_location,c.mustfill_flag FROM obomsetmat_cc c , MD_MDM_STD_ROUTER_item_cc d,hrmrolemembers b,MDM_OPER_MTRL_REF a WHERE a.oper_role_pk_id = b.roleid AND d.oper_fk =a.oper_fk AND c.oper_grp  = d.oper_grp AND master_fk = '"+gylxdm +"'  and c.mustfill_flag = 'Y' GROUP BY D.ITEM_NO,c.id,c.oper_grp,c.mat_id,d.oper_fk,c.qty_1,c.storage_location,c.mustfill_flag) ";
	sql = "select distinct oper_fk  from MDM_OPER_MTRL_REF a ,hrmrolemembers b,hrmroles c where  b.roleid = c.id and c.rolesmark = a.oper_role_fk and b.resourceid =  '"+ resourceId +"' and a.oper_fk in ( select operadd from formtable_main_"+Math.abs(formid)+" a,formtable_main_"+Math.abs(formid)+"_dt2 b where b.mainid = a.id and b.operadd != '0010' and a.requestid =  '"+ requestid +"')";
	rs.executeSql(sql);
	rs.next();
	result +="[";
	if(!"".equals(rs.getString("oper"))){
		oper = rs.getString("oper");
		result += "{\"oper\":\"" + oper +"\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
