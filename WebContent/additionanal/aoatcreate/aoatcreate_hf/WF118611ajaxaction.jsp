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
String T_pmms =  Util.null2String(request.getParameter("T_pmms"));
String result = "";
if(type.equals("1")){
	String gx =  Util.null2String(request.getParameter("gx"));
	String fzwx =  Util.null2String(request.getParameter("fzwx"));
	sql = "select * from MDM_UPH_RULE_hf where pkg_outline_fk = '"+fzwx+"' and oper_fk = '"+gx+"'";
	rs.executeSql(sql);
	result +="[";
	while(rs.next()){
		if(!"".equals(rs.getString("uph_formula"))){
		result += "{\"uph_formula\":\"" + rs.getString("uph_formula") + "\",\"Single_Attach_Time\":\"" + rs.getString("Single_Attach_Time") + "\",\"Attach_Change_Wafer_Time\":\"" + rs.getString("Attach_Change_Wafer_Time") + "\",\"Single_Wire_Bond_Time\":\"" + rs.getString("Single_Wire_Bond_Time") + "\",\"Single_No_Wire_Time\":\"" + rs.getString("Single_No_Wire_Time") + "\",\"Single_Grind_Time\":\"" + rs.getString("Single_Grind_Time") + "\",\"Scribe_Meters\":\"" + rs.getString("Scribe_Meters") + "\"},";
	}}
	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}

if(type.equals("2")){
	sql = "  select * from (select  SITE AS SITE_QTY, INDEXTIME AS INDEX_TIME, TESTTIME AS TEST_TIME ,CSJ,CSLC  from FORMTABLE_MAIN_8 where trim(cpmc) = '"+T_pmms+"' Order By Id desc ) where Rownum = 1 ";
	rs.executeSql(sql);
	result +="[";
	if(rs.getCounts()>0){
		while(rs.next()){
				result += "{\"SITE_QTY\":\"" + rs.getString("SITE_QTY") + "\",\"INDEX_TIME\":\"" + rs.getString("INDEX_TIME") + "\",\"TEST_TIME\":\"" + rs.getString("TEST_TIME") + "\",\"CSJ\":\"" + rs.getString("CSJ") + "\",\"CSLC\":\"" + rs.getString("CSLC") + "\"},";
		}
	}

	if(!result.equals("[")){
		result= result.substring(0,result.length()-1);
	}
	result +="]";
}
out.print(result);
%>
