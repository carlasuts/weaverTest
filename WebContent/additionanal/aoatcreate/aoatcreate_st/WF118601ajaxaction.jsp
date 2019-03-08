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
	if(!gylxdm.contains("M")){
		sql = "select id,mat_id,mat_type,mat_desc,qty_1,storage_location,mustfill_flag from obomsetmat_st where id='"+gylxdm+"'";
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
	if(gylxdm.contains("M")){
		//sql = "select MEASURE_UNIT_FK, seq,mat_id, FULL_NAME,MAT_TYPE_FK,plant_location,MTRL_GROUP_FK from BOMINFO where  seq='"+gylxdm+"'";
		sql = "select unit2 , seq, Mat_Id,mat_desc,Mat_Type, SITE_CODE,MAT_GRP from  OINVMATDEF where  seq='"+gylxdm+"'";
		rs.executeSql(sql);
		result +="[";
		while(rs.next()){
			if(!"".equals(rs.getString("seq")))
			{
				mat_desc = rs.getString("mat_desc");
				mat_desc = mat_desc.replace("\"", "%22");
				result += "{\"MEASURE_UNIT_FK\":\"" + rs.getString("unit2") + "\",\"MTRL_GROUP_FK\":\"" + rs.getString("MAT_GRP") + "\",\"mat_type\":\"" + rs.getString("Mat_Type") + "\",\"mat_id\":\"" + rs.getString("mat_id") + "\",\"storage_location\":\"" + rs.getString("SITE_CODE") + "\",\"mat_desc\":\"" + mat_desc + "\"},";
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
