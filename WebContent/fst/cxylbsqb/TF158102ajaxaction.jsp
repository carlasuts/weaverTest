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

String zjidh =  Util.null2String(request.getParameter("zjidh"));
String zjbbh =  Util.null2String(request.getParameter("zjbbh"));
String zjlist =  Util.null2String(request.getParameter("zjlist"));

String sbidh =  Util.null2String(request.getParameter("sbidh"));
String sbbbh =  Util.null2String(request.getParameter("sbbbh"));
String sblist =  Util.null2String(request.getParameter("sblist"));

String zhidh =  Util.null2String(request.getParameter("zhidh"));
String zhidbbh =  Util.null2String(request.getParameter("zhidbbh"));
String zhlist =  Util.null2String(request.getParameter("zhlist"));

String result = "";
StringBuffer sb = null;

if(type.equals("1")){
	sql = "select count(*) as no from formtable_main_110 where  xzsqidh = '"+ xzidh +"' and xzbbh = '"+ xzbbh +"'  ";
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
	sql = "select count(*) as no from formtable_main_110 where zjpmsrid = '"+ zjidh +"' and zjpmbbh = '"+ zjbbh +"'  ";
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

if(type.equals("3")){
	sql = "select count(*) as no from formtable_main_110 where  sbidh = '"+ sbidh +"' and sbidbbh = '"+ sbbbh +"' ";
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
	sql = "select count(*) as no from formtable_main_110 where   zhidh = '"+ zhidh +"' and zhidbbh = '"+ zhidbbh +"' ";
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
out.print(result);
%>
