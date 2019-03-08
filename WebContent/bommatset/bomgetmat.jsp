<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.text.*" %>
<%
BaseBean bs = new BaseBean();
bs.writeLog("aaaaaaaa:-----------");
RecordSetDataSource mesrs1 = new RecordSetDataSource("mesdb"); 
RecordSetDataSource mesrs2 = new RecordSetDataSource("STMESDB"); 
RecordSetDataSource mesrs3 = new RecordSetDataSource("HFMESDB"); 
String sql = "";



String mat_short_desc =  Util.null2String(request.getParameter("mat_short_desc"));
String factory =  Util.null2String(request.getParameter("factory"));

String MAT_TEST ="",MAT_ASSY="";
bs.writeLog("mat_short_desc:"+ mat_short_desc);
bs.writeLog("factory:"+ factory);
StringBuffer sb = new StringBuffer();
if(!"".equals(mat_short_desc)){

	sql = "select MAT_ID from  mwipmatdef  where factory ='ASSY' AND MAT_SHORT_DESC ='"+ mat_short_desc + "'";
	bs.writeLog("sql:"+ sql);
	if(factory.equals("0")){
		mesrs1.executeSql(sql);	
		while(mesrs1.next()){
			MAT_ASSY = mesrs1.getString("MAT_ID");
		}
	}else if(factory.equals("1")){
		mesrs2.executeSql(sql);	
		while(mesrs2.next()){
			MAT_ASSY = mesrs2.getString("MAT_ID");
		}
	}else if(factory.equals("2")){
		mesrs3.executeSql(sql);	
		while(mesrs3.next()){
			MAT_ASSY = mesrs3.getString("MAT_ID");
		}
	}
	bs.writeLog("MAT_ASSY" +MAT_ASSY);
	sql = "select MAT_ID from  mwipmatdef  where factory ='TEST' AND MAT_SHORT_DESC ='"+ mat_short_desc + "'";
	bs.writeLog("sql:"+ sql);
	if(factory.equals("0")){
		mesrs1.executeSql(sql);	
		while(mesrs1.next()){
		MAT_TEST = (mesrs1.getString("MAT_ID") == "" ? " " : mesrs1.getString("MAT_ID"));
	}
	}else if(factory.equals("1")){
		mesrs2.executeSql(sql);	
		while(mesrs2.next()){
			MAT_TEST = (mesrs2.getString("MAT_ID") == "" ? " " : mesrs2.getString("MAT_ID"));
		}
	}else if(factory.equals("2")){
		mesrs3.executeSql(sql);	
		while(mesrs3.next()){
			MAT_TEST = (mesrs3.getString("MAT_ID") == "" ? " " : mesrs3.getString("MAT_ID"));
		}
	}
	
	
	bs.writeLog("MAT_TEST" +MAT_TEST);
}
	sb.append(MAT_ASSY).append(" ").append(MAT_TEST).append(" ");
	if(sb.length() > 0){
		sb.deleteCharAt(sb.length() - 1);
	}
	
out.print(sb);
%>