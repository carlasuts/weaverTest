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
String pmxl =  Util.null2String(request.getParameter("custidid"));
String pm =  Util.null2String(request.getParameter("pm"));
String zjpmsrid = Util.null2String(request.getParameter("zjpmsrid"));
String dqidbbh1 = Util.null2String(request.getParameter("dqidbbh"));

String xzsqidh = "";//新增申请ID号
String xzbbh = "";//新增版本号
String dqidh = "";//当前ID号
String dqidbbh = "";//当前ID版本号
String scwj = "";//上传文件
String result = "";
String dqpmlist = "";
String pmlist = "";

StringBuffer sb = null;
//新建
if(type.equals("1")){
	sql = "select count(*) as no from formtable_main_110 where custid = '"+pmxl+"'";
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
//新增品名  品名转换
if(type.equals("2")){
	sql = "select * from (select * from formtable_main_110 where dqidh = '"+zjpmsrid+"' order by dqidbbh desc) where rownum = 1 ";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("dqidh"))){
			result += "{\"dqidh\":\"" + rs.getString("dqidh") + "\",\"dqidbbh\":\"" +  rs.getString("dqidbbh") +  "\"},";
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

//新增品名 升版 品名转换
if(type.equals("3")){
	sql = "select * from formtable_main_110 where dqidh = '"+zjpmsrid+"' order by dqidbbh desc nulls last";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("dqidh"))){
			scwj = rs.getString("scwj");
			sql = "select * from docimagefile where docid = '"+ scwj +"'";
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

//归档节点显示历史附件
if(type.equals("4")){
	sql = "select * from (select * from formtable_main_110 where dqidh = '"+zjpmsrid+"' and dqidbbh != '"+ dqidbbh1 +"' order by dqidbbh desc nulls last) where rownum = 1";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("dqidh"))){
			sql = "select * from formtable_main_110 where dqidh = '"+zjpmsrid+"' and dqidbbh = '"+ rs.getString("dqidbbh") +"' ";
			rs.executeSql(sql);
			rs.next();
			scwj = rs.getString("scwj");
			sql = "select * from docimagefile where docid = '"+ scwj +"'";
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
