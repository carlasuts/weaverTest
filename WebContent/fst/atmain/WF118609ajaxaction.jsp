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
String result = "";
String oper = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	sql = "select distinct oper_fk  from MDM_OPER_MTRL_REF a ,hrmrolemembers b,hrmroles c where  b.roleid = c.id and c.rolesmark = a.oper_role_fk and b.resourceid =  '"+ resourceId +"' and a.oper_fk in ( select operadd from formtable_main_78 a,formtable_main_78_dt2 b where b.mainid = a.id and a.requestid =  '"+ requestid +"')";
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
