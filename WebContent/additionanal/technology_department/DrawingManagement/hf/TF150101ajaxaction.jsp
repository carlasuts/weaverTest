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
 PreparedStatement ps = null;
 PreparedStatement ps1 = null;
 PreparedStatement ps2 = null;
 PreparedStatement ps3 = null;;
 PreparedStatement ps4 = null;
 PreparedStatement ps5 = null;
 PreparedStatement ps6 = null;
 PreparedStatement ps7 = null;
 ResultSet rs11 = null;
 ResultSet rs22 = null;
 ResultSet rs33 = null;
 ResultSet rs44 = null;
 Connection conn = null;
 Connection conn1 = null;
 Connection conn2 = null;
 Connection conn3 = null;
String sql = "";
String type =  Util.null2String(request.getParameter("type"));
int requestid = Util.getIntValue(request.getParameter("requestid"));

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
			sql = "select count(*) as no from formtable_main_167 where  tzlx = '"+tzlx+"' and custid = '"+ khh +"'";
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
	//  0试流   1考核
		if(sclx.equals("0")||sclx.equals("1")){
		//0配线图   1打印图
			if("0".equals(tzlx)){
				//workflowseqindex表里无数据先新增
				RecordSet rs2 = new RecordSet();
				RecordSet rs3 = new RecordSet();
				String sql2 = " select count(1) as num from workflowseqindex  where FLOWID='8104' and Ruledesc = 'BONDINGDIAGRAM' and INDEXDESCTWO = 'S' and Indexdesc = '"+ khh +"'  ";
				rs2.executeSql(sql2);
				rs2.next();
				if(rs2.getInt("num") == 0){
					sql2 = " insert into workflowseqindex (flowid , ruledesc , indexdesctwo , indexdesc ,PLANTOPT ,CURRENTID) values ('8104' ,'BONDINGDIAGRAM' ,'S' ,'"+khh+"','5000','0' ) ";
					rs3.executeSql(sql2);
				}
				conn = DbConn.getConn("OAConn");
				ps = conn.prepareStatement(" select Currentid from workflowseqindex  where FLOWID='8104' and Ruledesc = 'BONDINGDIAGRAM' and INDEXDESCTWO = 'S' and Indexdesc = '"+ khh +"' FOR UPDATE ");
				rs11 = ps.executeQuery();
				result +="[";
				rs11.next();
				if(!"".equals(rs11.getString("Currentid")))
				{
					result += "{\"no\":\"" + rs11.getString("Currentid") + "\"},";
				}
				ps1 = conn.prepareStatement(" update workflowseqindex set Currentid = '"+ (rs11.getInt("Currentid")+1) +"'  where FLOWID='8104' and Ruledesc = 'BONDINGDIAGRAM' and INDEXDESCTWO = 'S' and Indexdesc = '"+ khh +"'  ");
				ps1.executeUpdate();
				conn.commit();
			}
			if("1".equals(tzlx)){
				//workflowseqindex表里无数据先新增
				RecordSet rs4 = new RecordSet();
				RecordSet rs5 = new RecordSet();
				String sql3 = " select count(1) as num from workflowseqindex  where FLOWID='8104' and Ruledesc = 'MARK' and INDEXDESCTWO = 'S' and Indexdesc = '"+ khh +"'  ";
				rs4.executeSql(sql3);
				rs4.next();
				if(rs4.getInt("num") == 0){
					sql3 = " insert into workflowseqindex (flowid , ruledesc , indexdesctwo , indexdesc ,PLANTOPT ,CURRENTID) values ('8104' ,'MARK' ,'S' ,'"+khh+"','5000','0' ) ";
					rs5.executeSql(sql3);
				}
				conn1 = DbConn.getConn("OAConn");
				ps2 = conn1.prepareStatement(" select Currentid from workflowseqindex  where FLOWID='8104' and Ruledesc = 'MARK' and INDEXDESCTWO = 'S' and Indexdesc = '"+ khh +"' FOR UPDATE ");
				rs22 = ps2.executeQuery();
				result +="[";
				rs22.next();
				if(!"".equals(rs22.getString("Currentid")))
				{
					result += "{\"no\":\"" + rs22.getString("Currentid") + "\"},";
				}
				ps3 = conn1.prepareStatement(" update workflowseqindex set Currentid = '"+ (rs22.getInt("Currentid")+1) +"'  where FLOWID='8104' and Ruledesc = 'MARK' and INDEXDESCTWO = 'S' and Indexdesc = '"+ khh +"'  ");
				ps3.executeUpdate();
				conn1.commit();
			}
		}
		else{
		//0配线图   1打印图
			if("0".equals(tzlx)){
				//workflowseqindex表里无数据先新增
				RecordSet rs6 = new RecordSet();
				RecordSet rs7 = new RecordSet();
				String sql4 = " select count(1) as num from workflowseqindex  where FLOWID='8104' and Ruledesc = 'BONDINGDIAGRAM' and INDEXDESCTWO is null and Indexdesc = '"+ khh +"'  ";
				rs6.executeSql(sql4);
				rs6.next();
				if(rs6.getInt("num") == 0){
					sql4 = " insert into workflowseqindex (flowid , ruledesc , indexdesctwo , indexdesc ,PLANTOPT ,CURRENTID) values ('8104' ,'BONDINGDIAGRAM' ,'' ,'"+khh+"','5000','0' ) ";
					rs7.executeSql(sql4);
				}
				conn2 = DbConn.getConn("OAConn");
				ps4 = conn2.prepareStatement(" select Currentid from workflowseqindex  where FLOWID='8104' and Ruledesc = 'BONDINGDIAGRAM' and INDEXDESCTWO is null and Indexdesc = '"+ khh +"' FOR UPDATE ");
				rs33 = ps4.executeQuery();
				result +="[";
				rs33.next();
				if(!"".equals(rs33.getString("Currentid")))
				{
					result += "{\"no\":\"" + rs33.getString("Currentid") + "\"},";
				}
				ps5 = conn2.prepareStatement(" update workflowseqindex set Currentid = '"+ (rs33.getInt("Currentid")+1) +"'  where FLOWID='8104' and Ruledesc = 'BONDINGDIAGRAM' and INDEXDESCTWO is null and Indexdesc = '"+ khh +"'  ");
				ps5.executeUpdate();
				conn2.commit();
			}
			if("1".equals(tzlx)){
				//workflowseqindex表里无数据先新增
				RecordSet rs4 = new RecordSet();
				RecordSet rs5 = new RecordSet();
				String sql3 = " select count(1) as num from workflowseqindex  where FLOWID='8104' and Ruledesc = 'MARK' and INDEXDESCTWO is null and Indexdesc = '"+ khh +"'  ";
				rs4.executeSql(sql3);
				rs4.next();
				if(rs4.getInt("num") == 0){
					sql3 = " insert into workflowseqindex (flowid , ruledesc , indexdesctwo , indexdesc ,PLANTOPT ,CURRENTID) values ('8104' ,'MARK' ,'' ,'"+khh+"','5000','0' ) ";
					rs5.executeSql(sql3);
				}
				conn3 = DbConn.getConn("OAConn");
				ps6 = conn3.prepareStatement(" select Currentid from workflowseqindex  where FLOWID='8104' and Ruledesc = 'MARK' and INDEXDESCTWO is null and Indexdesc = '"+ khh +"' FOR UPDATE ");
				rs44 = ps6.executeQuery();
				result +="[";
				rs44.next();
				if(!"".equals(rs44.getString("Currentid")))
				{
					result += "{\"no\":\"" + rs44.getString("Currentid") + "\"},";
				}
				ps7 = conn3.prepareStatement(" update workflowseqindex set Currentid = '"+ (rs44.getInt("Currentid")+1) +"'  where FLOWID='8104' and Ruledesc = 'MARK' and INDEXDESCTWO is null and Indexdesc = '"+ khh +"'  ");
				ps7.executeUpdate();
				conn3.commit();
			}
		}
	}
	
	
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

if(type.equals("2")){
	sql = "select count(*) as no from formtable_main_167 where tzbh = '"+tzbh+"' and tzbb ='"+ tzbb +"' and tzlx = '"+ tzlx +"' and requestid != '"+ requestid +"' ";
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
	sql = "select * from otecdrmedef_hf where tzbh = '"+ytzbh+"' order by tzbb desc nulls last";
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
	sql = "select * from otecdrmedef_hf where tzbh = '"+ytzbh+"' order by tzbb desc nulls last";
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
