<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<%@ page import="weaver.interfaces.workflow.util.DbConn" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Connection"%>
<%
RecordSet rs = new RecordSet();
Connection conn = null;
PreparedStatement ps = null;
PreparedStatement ps1 = null;
ResultSet rs11 = null;
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
int requestid = Util.getIntValue(request.getParameter("requestid"));
String pmxl =  Util.null2String(request.getParameter("custidid"));
String plantopt =  Util.null2String(request.getParameter("plantopt"));

String pm =  Util.null2String(request.getParameter("pm"));
String zjpmsrid = Util.null2String(request.getParameter("zjpmsrid"));
String dqidbbh1 = Util.null2String(request.getParameter("dqidbbh"));

int bbhid = Util.getIntValue(request.getParameter("bbhid"))-1;
int zffjid = Util.getIntValue(request.getParameter("bbhid"));
String idh = Util.null2String(request.getParameter("idh"));

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
	//workflowseqindex表里无数据先新增
	RecordSet rs2 = new RecordSet();
	RecordSet rs3 = new RecordSet();
	String sql2 = "select count(1) as num from workflowseqindex  where FLOWID='1421' and Ruledesc = 'xzsqidh' and INDEXDESCTWO is null and Indexdesc = '"+ pmxl +"' and plantopt = '"+ plantopt +"' ";
	rs2.executeSql(sql2);
	rs2.next();
	if(rs2.getInt("num") == 0){
		sql2 = " insert into workflowseqindex (flowid , ruledesc , indexdesctwo , indexdesc ,PLANTOPT ,CURRENTID) values ('1421' ,'xzsqidh' ,null ,'"+pmxl+"','"+ plantopt +"','0' ) ";
		rs3.executeSql(sql2);
	}
	conn = DbConn.getConn("OAConn");
	ps = conn.prepareStatement(" select Currentid from workflowseqindex  where FLOWID='1421' and Ruledesc = 'xzsqidh' and INDEXDESCTWO is null and Indexdesc = '"+ pmxl +"' and plantopt = '"+ plantopt +"'  FOR UPDATE ");
	rs11 = ps.executeQuery();

	result +="[";
	rs11.next();
	if(!"".equals(rs11.getString("Currentid")))
	{
		result += "{\"no\":\"" + rs11.getString("Currentid") + "\"},";
	}
	ps1 = conn.prepareStatement(" update workflowseqindex set Currentid = '"+ (rs11.getInt("Currentid")+1) +"'  where FLOWID='1421' and Ruledesc = 'xzsqidh' and INDEXDESCTWO is null and Indexdesc = '"+ pmxl +"' and plantopt = '"+ plantopt +"'  ");
	ps1.executeUpdate();
	conn.commit();

	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
/*
if(type.equals("1")){
	//sql = "select count(*) as no from (select custid,dqidh from formtable_main_93 where custid = '"+ pmxl +"' group by custid,dqidh)";
	sql = "select count(*) as no from (select * from 	formtable_main_93  where custid = '"+ pmxl +"')";
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
*/
//新增品名  品名转换
if(type.equals("2")){
	sql = "select * from (select * from 	formtable_main_93 where dqidh = '"+zjpmsrid+"' order by To_Number(dqidbbh) desc) where rownum = 1 ";
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
	sql = "select * from formtable_main_93 where dqidh = '"+ idh +"' and dqidbbh = '"+ bbhid +"'";
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

//作废
if(type.equals("4")){
	sql = "select * from formtable_main_93 where dqidh = '"+ idh +"' and dqidbbh = '"+ zffjid +"'";
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

//判断是否退回,如果退回申请类型不可改变
if(type.equals("5")){
	sql = "select requestid,thbz,sqlx  from  formtable_main_93  where requestid = '"+ requestid +"' ";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("requestid"))){
		result += "{\"thbz\":\"" + rs.getString("thbz") + "\",\"sqlx\":\"" +  rs.getString("sqlx") + "\"},";
		}
	}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
