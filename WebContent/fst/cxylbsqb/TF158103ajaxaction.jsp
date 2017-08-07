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


String xzidh =  Util.null2String(request.getParameter("xzidh"));

StringBuffer sb = null;
String result = "";

if(type.equals("1")){
	sql = "select replace(wm_concat(mat_list),',',chr(10)||'<br>') as pmlist from owiptstpgm where id != '"+ xzidh +"'";
	rs.executeSql(sql);
	sb = new StringBuffer();
	if(rs.next()){
		result = rs.getString(1);
		sb.append(result);
	}
}

//未归档新建数据
if(type.equals("2")){
	sql = "select replace(wm_concat(xzdypmlist),',',chr(10)||'<br>') as pmlist from  formtable_main_110 where (xzbbh,xzsqidh) in (select xzbbh,xzsqidh from formtable_main_110 where sfxj = '0' and dqidh is null) and xzsqidh !=  '"+ xzidh +"'";
	rs.executeSql(sql);
	sb = new StringBuffer();
	if(rs.next()){
		result = rs.getString(1);
		sb.append(result);
	}
}

//未归档增加品名数据
if(type.equals("3")){
	sql = "select replace(wm_concat(zjpmdylist),',',chr(10)||'<br>') as pmlist from  formtable_main_110 where (zjpmbbh,zjpmsrid) in (select zjpmbbh,zjpmsrid from formtable_main_110 where sfzjpm = '0' and dqidh is null) and zjpmsrid !=  '"+ xzidh +"'";
	rs.executeSql(sql);
	sb = new StringBuffer();
	if(rs.next()){
		result = rs.getString(1);
		sb.append(result);
	}
}
out.print(result);
%>
