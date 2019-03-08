<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSet rs = new RecordSet();
BaseBean bs = new BaseBean();
String sql = "",TOOL_CARD_ID="",TOOL_CARD_VALUE="",NUMBERS="",UNIT="",PRICE="",SUPPLIER_TO_DESCRIBE="";
String user =  Util.null2String(request.getParameter("user"));
String result = "";

	sql = "select a.id,A.MAT_DESC,A.NUMBERS,A.UNIT,A.PRICE,A.SUPPLIER_TO_DESCRIBE from QUERY_TOOL_CARD a   where A.WORKCODE_OF_USER ='" +user+"'";
	rs.executeSql(sql);
	bs.writeLog("sql:" +sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("ID"))){
			TOOL_CARD_ID = rs.getString("ID");
			TOOL_CARD_VALUE = rs.getString("MAT_DESC");
			NUMBERS = rs.getString("NUMBERS");
			UNIT = rs.getString("UNIT");
			PRICE = rs.getString("PRICE");
			SUPPLIER_TO_DESCRIBE = rs.getString("SUPPLIER_TO_DESCRIBE");
			result += "{\"TOOL_CARD_ID\":\"" + TOOL_CARD_ID+ "\",\"TOOL_CARD_VALUE\":\"" + TOOL_CARD_VALUE + "\",\"NUMBERS\":\"" + NUMBERS + "\",\"UNIT\":\"" + UNIT + "\",\"PRICE\":\"" + PRICE + "\",\"SUPPLIER_TO_DESCRIBE\":\"" + SUPPLIER_TO_DESCRIBE + "\"},";
		}
		if("".equals(rs.getString("ID"))){
			result += "{\"TOOL_CARD_ID\":\"" + TOOL_CARD_ID+ "\",\"TOOL_CARD_VALUE\":\"" + TOOL_CARD_VALUE + "\",\"NUMBERS\":\"" + NUMBERS + "\",\"UNIT\":\"" + UNIT + "\",\"PRICE\":\"" + PRICE + "\",\"SUPPLIER_TO_DESCRIBE\":\"" + SUPPLIER_TO_DESCRIBE + "\"},";
		}	
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
out.print(result);
%>
