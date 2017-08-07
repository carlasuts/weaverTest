<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSet rs = new RecordSet();
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
int requestid = Util.getIntValue(request.getParameter("requestid"));
String result = "";
String mat_desc = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	if(!gylxdm.contains("A")){
		sql = "select id,mat_id,mat_type,mat_desc,qty_1,storage_location,mustfill_flag from obomsetmat where id='"+gylxdm+"'";
		rs.executeSql(sql);
		result +="[";
		while(rs.next()){
			if(!"".equals(rs.getString("id")))
			{
				mat_desc = rs.getString("mat_desc");
				mat_desc = mat_desc.replace("\"", "%22");
				result += "{\"id\":\"" + rs.getString("id") + "\",\"mat_type\":\"" + rs.getString("mat_type") + "\",\"mat_id\":\"" + rs.getString("mat_id") + "\",\"mat_desc\":\"" + mat_desc + "\",\"qty_1\":\"" + rs.getString("qty_1") + "\",\"storage_location\":\"" + rs.getString("storage_location") + "\",\"mustfill_flag\":\"" + rs.getString("mustfill_flag") + "\"},";
			}
		}
	}
	if(gylxdm.contains("A")){
		sql = "select seq,mat_id, FULL_NAME,MAT_TYPE_FK,plant_location from BOMINFO where  seq='"+gylxdm+"'";
		rs.executeSql(sql);
		result +="[";
		while(rs.next()){
			if(!"".equals(rs.getString("seq")))
			{
				mat_desc = rs.getString("FULL_NAME");
				mat_desc = mat_desc.replace("\"", "%22");
				result += "{\"mat_type\":\"" + rs.getString("MAT_TYPE_FK") + "\",\"mat_id\":\"" + rs.getString("mat_id") + "\",\"storage_location\":\"" + rs.getString("plant_location") + "\",\"mat_desc\":\"" + mat_desc + "\"},";
			}
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
