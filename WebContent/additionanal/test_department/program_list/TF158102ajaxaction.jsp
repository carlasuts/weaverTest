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

String pmxl =  Util.null2String(request.getParameter("pmxl"));
String xzidh =  Util.null2String(request.getParameter("xzidh"));
String xzbbh =  Util.null2String(request.getParameter("xzbbh"));
String xzlist =  Util.null2String(request.getParameter("xzlist"));

String sbidh =  Util.null2String(request.getParameter("sbidh"));
String sbbbh =  Util.null2String(request.getParameter("sbbbh"));
String sblist =  Util.null2String(request.getParameter("sblist"));


String result = "";
StringBuffer sb = null;

if(type.equals("1")){
	sql = "select count(*) as no from formtable_main_93 where  xzsqidh = '"+ xzidh +"' and xzbbh = '"+ xzbbh +"'";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("no"))){
		result += "{\"no\":\"" + rs.getString("no")+ "\"},";
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

if(type.equals("2")){
	sql = "select sqr from formtable_main_93 where  xzsqidh = '"+ xzidh +"' and xzbbh = '"+ xzbbh +"'";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("sqr"))){
		result += "{\"sqr\":\"" + rs.getString("sqr")+ "\"},";
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

if(type.equals("3")){
	sql = "select count(*) as no from formtable_main_93 where  sbidh = '"+ sbidh +"' and sbidbbh = '"+ sbbbh +"' ";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("no"))){
		result += "{\"no\":\"" + rs.getString("no")+ "\"},";
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

if(type.equals("4")){
	sql = "select sqr from formtable_main_93 where  sbidh = '"+ sbidh +"' and sbidbbh = '"+ sbbbh +"' ";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("sqr"))){
		result += "{\"sqr\":\"" + rs.getString("sqr")+ "\"},";
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

out.print(result);
%>
