<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSetDataSource mesrs = new RecordSetDataSource("STMESDB");
RecordSetDataSource mesrs2 = new RecordSetDataSource("STMESDB");
RecordSetDataSource mesrs3 = new RecordSetDataSource("STMESDB");
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
String result = "";
String dieMaterialDescription = "";
String chipSizeX = "";
String chipSizeY = "";
if(type.equals("1")){
	String gylxdm =  Util.null2String(request.getParameter("gylxdm"));
	sql = "select mat_grp_5 as cust_mat_id from mwipmatdef  where factory = 'DIEBANK' and mat_id='"+gylxdm+"'";
	mesrs.executeSql(sql);
	mesrs.next();
	result +="[";
	if(!"".equals(mesrs.getString("cust_mat_id"))){
	    dieMaterialDescription = mesrs.getString("cust_mat_id");
	    sql = "select chr.target_value from mspmreldef def , mspmrelchr chr  where def.factory = 'DIEBANK' and def.spec_rel_id = chr.spec_rel_id and def.mat_ver = chr.spec_rel_ver and chr.char_id = 'SP_ChipSizeX' and def.mat_id='"+gylxdm+"'";
	    mesrs2.executeSql(sql);
	    mesrs2.next();
	    chipSizeX = mesrs2.getString("target_value");
	    sql = "select chr.target_value from mspmreldef def , mspmrelchr chr  where def.factory = 'DIEBANK' and def.spec_rel_id = chr.spec_rel_id and def.mat_ver = chr.spec_rel_ver and chr.char_id = 'SP_ChipSizeY' and def.mat_id='"+gylxdm+"'";
	    mesrs3.executeSql(sql);
	    mesrs3.next();
	    chipSizeY = mesrs3.getString("target_value");
		result += "{\"die_material_description\":\"" + dieMaterialDescription + "\",\"chip_sizeX\":\"" + chipSizeX + "\",\"chip_sizeY\":\"" + chipSizeY + "\"},";
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
