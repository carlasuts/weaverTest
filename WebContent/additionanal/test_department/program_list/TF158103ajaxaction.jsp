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

String factory = Util.null2String(request.getParameter("factory"));
String xzidh =  Util.null2String(request.getParameter("xzidh"));

StringBuffer sb = null;
String result = "";

if(type.equals("1")){
	//sql = "select replace(wm_concat(mat_list),',',chr(10)||'<br>') as pmlist from owiptstpgm where id != '"+ xzidh +"' and delete_flag != 'Y' ";
	sql = "select  replace(mat_list,chr(13)||'<br>',' ') as pmlist from owiptstpgm where id != '"+ xzidh +"' and delete_flag != 'Y' AND Factory = Decode('"+ factory +"', '0', '1000', '1','4000','2','5000') ";
	rs.executeSql(sql);
	sb = new StringBuffer();
	while(rs.next()){
		result = rs.getString(1);
		sb.append(result).append(" ");
	}
}

//未归档新建数据
if(type.equals("2")){
	//sql = "select replace(wm_concat(xzdypmlist),',',chr(10)||'<br>') as pmlist from  formtable_main_93 where (xzbbh,xzsqidh) in (select xzbbh,xzsqidh from formtable_main_93 where sqlx = '0' and dqidh is null) and xzsqidh !=  '"+ xzidh +"'";
	sql = "select replace(xzdypmlist,chr(13)||'<br>',' ') as pmlist from  formtable_main_93 where (xzbbh,xzsqidh) in (select xzbbh,xzsqidh from formtable_main_93 where sqlx = '0' and dqidh is null) and xzsqidh !=  '"+ xzidh +"' and cq = '"+ factory +"' ";
	rs.executeSql(sql);
	sb = new StringBuffer();
	while(rs.next()){
		result = rs.getString(1);
		sb.append(result).append(" ");
	}
}

//未归档升版
if(type.equals("3")){
	//sql = "select replace(wm_concat(sbdypmlist),',',chr(10)||'<br>') as pmlist from  formtable_main_93 where (sbidbbh,sbidh) in (select sbidbbh,sbidh from formtable_main_93 where sqlx = '1' and dqidh is null) and sbidh !=  '"+ xzidh +"'";
	sql = "select replace(sbdypmlist,chr(13)||'<br>',' ') as pmlist from  formtable_main_93 where (sbidbbh,sbidh) in (select sbidbbh,sbidh from formtable_main_93 where sqlx = '1' and dqidh is null) and sbidh !=  '"+ xzidh +"' and cq = '"+ factory +"' ";
	rs.executeSql(sql);
	sb = new StringBuffer();
	while(rs.next()){
		result = rs.getString(1);
		sb.append(result).append(" ");
	}
}
out.print(sb);
%>
