<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="weaver.general.Util"%>
<%
	RecordSet rs = new RecordSet();
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
int requestid = Util.getIntValue(request.getParameter("requestid"));
int resourceId = user.getUID();
String result = "";
String item_no = "";
String oper_fk= "";
String oper_desc = "";
String mat_id = "";
String mat_desc = "";
String qty_1 = "";
Stirng storage_location = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	sql = "SELECT D.ITEM_NO,c.mat_desc,c.oper_grp,c.mat_id,d.oper_fk,c.qty_1,c.storage_location,d.oper_desc FROM obomsetmat c , MD_MDM_STD_ROUTER_item d,hrmrolemembers b,MDM_OPER_MTRL_REF a WHERE a.oper_role_pk_id = b.roleid AND d.oper_fk =a.oper_fk AND c.oper_grp  = d.oper_grp AND master_fk = '"+gylxdm +"' AND b.resourceid = '"+resourceId +"' and c.mustfill_flag = 'Y' and d.oper_fk <> '0010' and d.oper_fk <> '3020' GROUP BY D.ITEM_NO,c.mat_desc,c.oper_grp,c.mat_id,d.oper_fk,c.qty_1,c.storage_location,d.oper_desc";
	rs.executeSql(sql);
	rs.next();
	result +="[";
	if(!"".equals(rs.getString("d.oper_fk"))){
		item_no = rs.getString("d.item_no");
		oper_fk = rs.getString("d.oper_fk");
		oper_desc = rs.getString("d.oper_desc");
		mat_id = rs.getString("c.mat_id");
		mat_desc = rs.getString("c.mat_desc");
		qty_1 = rs.getString("c.qty_1");
		storage_location = rs.getString("c.storage_location");
		result += "{\"mat_id\":\"" + mat_id +"\",\"oper_fk\":\"" + oper_fk + "\",\"item_no\":\"" + item_no + "\",\"oper_desc\":\"" + oper_desc + "\",\"mat_desc\":\"" + mat_desc + "\",\"qty_1\":\"" + qty_1 + "\",\"storage_location\":\"" + storage_location + "\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
