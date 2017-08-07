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

String cq =  Util.null2String(request.getParameter("cq1"));
String tzlx =  Util.null2String(request.getParameter("tzlx1"));
String sclx =  Util.null2String(request.getParameter("sclx1"));
String xzsb =  Util.null2String(request.getParameter("xzsb1"));
String khh =  Util.null2String(request.getParameter("khh"));
String tzbh =  Util.null2String(request.getParameter("tzbh"));
String tzbb =  Util.null2String(request.getParameter("tzbb"));
String ytzbh =  Util.null2String(request.getParameter("ytzbh"));

String result = "";
String cadgstz = "";//CAD格式图纸
String yszlsc = "";//原始资料上传
if(type.equals("1")){
	if(khh.equals("158")){
		if(sclx !=""){
			sql = "select count(*) as no from formtable_main_91 where  tzlx = '"+tzlx+"' and custid = '"+ khh +"'";
			rs.executeSql(sql);
			result +="[";
			rs.next();
			if(!"".equals(rs.getString("no")))
			{
				result += "{\"no\":\"" + rs.getString("no") + "\"},";
			}
		}
	}
	else{
		if(cq.equals("0") && !sclx.equals("")){
			sql = "select count(*) as no from formtable_main_91 where cq ='0' and tzlx = '"+tzlx+"'";
			rs.executeSql(sql);
			result +="[";
			rs.next();
			if(!"".equals(rs.getString("no")))
			{
				result += "{\"no\":\"" + rs.getString("no") + "\"},";
			}
		}
		else{
			sql = "select count(*) as no from formtable_main_91 where cq !='0' and tzlx = '"+tzlx+"'";
			rs.executeSql(sql);
			result +="[";
			rs.next();
			if(!"".equals(rs.getString("no")))
			{
				result += "{\"no\":\"" + rs.getString("no") + "\"},";
			}
		}
	}
	
	
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

if(type.equals("2")){
	sql = "select count(*) as no from formtable_main_91 where tzbh = '"+tzbh+"' and tzbb ='"+ tzbb +"' and tzlx = '"+ tzlx +"' ";
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

//升版带出cad历史附件
if(type.equals("3")){
	sql = "select * from otecdrmedef where tzbh = '"+ytzbh+"' order by tzbb desc nulls last";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("tzbh"))){
			cadgstz = rs.getString("cadgstz");
			sql = "select * from docimagefile where docid = '"+ cadgstz +"'";
			rs.executeSql(sql);
			rs.next();
			result += "{\"docid\":\"" + rs.getString("docid") + "\",\"versionid\":\"" +  rs.getString("versionid") + "\",\"imagefileid\":\"" +  rs.getString("imagefileid") + "\",\"imagefilename\":\"" +  rs.getString("imagefilename") + "\"},";
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
//升版带出原始资料历史附件
if(type.equals("4")){
	sql = "select * from otecdrmedef where tzbh = '"+ytzbh+"' order by tzbb desc nulls last";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("tzbh"))){
			yszlsc = rs.getString("yszlsc");
			sql = "select * from docimagefile where docid = '"+ yszlsc +"'";
			rs.executeSql(sql);
			rs.next();
			result += "{\"docid\":\"" + rs.getString("docid") + "\",\"versionid\":\"" +  rs.getString("versionid") + "\",\"imagefileid\":\"" +  rs.getString("imagefileid") + "\",\"imagefilename\":\"" +  rs.getString("imagefilename") + "\"},";
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

out.print(result);
%>
