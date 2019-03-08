<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%
//作废
BaseBean e = new BaseBean();
e.writeLog("进入TF158102-------------------------");
RecordSet rs = new RecordSet();
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
int requestid = Util.getIntValue(request.getParameter("requestid"));
String code_desc = Util.null2String(request.getParameter("code_desc"));


String idh = Util.null2String(request.getParameter("idh"));
String idhbb = Util.null2String(request.getParameter("idhbb"));


StringBuffer sb = new StringBuffer();
String result = "";
String id_code="0";


if(type.equals("1")){
	rs.executeSql("select   CURRENTID , CURRENTID_V,CODE,id_code  from formtable_main_208 where CURRENTID ='"+idh+"'");
	JSONArray array = new JSONArray(); 
	String[] columnName =rs.getColumnName(); 
	int columnCount =columnName.length;
	 
	while (rs.next()){
		JSONObject jsonObj = new JSONObject();  
		for (int i = 0; i < columnCount; i++) {  
			String value = rs.getString(columnName[i]);  
			jsonObj.put(columnName[i], value);        
		}
		array.put(jsonObj);   
	}
	result=array.toString();
	e.writeLog("result"+result);
}

//升版带出历史附件
if(type.equals("3")){
	sql = "select * from formtable_main_208 where CURRENTID = '"+ idh +"' and CURRENTID_V = '"+ idhbb +"'";
	rs.executeSql(sql);
	while(rs.next()){
		if(!"".equals(rs.getString("CURRENTID"))){
			String LOAD_FILES = rs.getString("LOAD_FILES");
			sql = "select docid,versionid,imagefileid,imagefilename from docimagefile where docid = '"+ LOAD_FILES +"'";
			rs.executeSql(sql);
			JSONArray array = new JSONArray(); 
			String[] columnName =rs.getColumnName(); 
			int columnCount =columnName.length;
			while (rs.next()){
				JSONObject jsonObj = new JSONObject();  
				for (int i = 0; i < columnCount; i++) {  
					String value = rs.getString(columnName[i]);  
					jsonObj.put(columnName[i], value);        
				}
				array.put(jsonObj);   
			}
			result=array.toString();
			e.writeLog("result"+result);
		}
	}
}


out.print(result);
%>
