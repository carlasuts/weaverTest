<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSet rs = new RecordSet();
String sql = "";
String uuid =  Util.null2String(request.getParameter("uuid"));

StringBuffer sb = new StringBuffer();

if(!"".equals(uuid)){
	sql = "SELECT WIRE_BOND_FAST, WIRE_DIAM_FAST, SILK_FAST, GRIND_FAST, CHIP_NUM_FAST, CHIP_X_FAST, CHIP_Y_FAST, MAT_FAST, FORM_FAST, GRADE_FAST, TAPING_FAST, FRAMEWORK_TECH_FAST, " +
		  "ENCAPSULA_MAT_FAST, OTHER_FAST, TEST_MODELS_FAST, HANDER_FAST, TEST_QUOTATION_WAY_FAST, TEST_SITE_FOR_FAST, TEST_OF_TIME_FAST, UPH_FORMULA_FAST, UPH_FAST from Offer_to_apply_middle where ID='" + uuid + "'";	
	rs.executeSql(sql);
	rs.next();	
	sb.append(rs.getString("WIRE_BOND_FAST")).append(" ").append(rs.getString("WIRE_DIAM_FAST")).append(" ").append(rs.getString("SILK_FAST")).append(" ").append(rs.getString("GRIND_FAST")).append(" ");
	sb.append(rs.getString("CHIP_NUM_FAST")).append(" ").append(rs.getString("CHIP_X_FAST")).append(" ").append(rs.getString("CHIP_Y_FAST")).append(" ").append(rs.getString("MAT_FAST")).append(" ");
	sb.append(rs.getString("FORM_FAST")).append(" ").append(rs.getString("GRADE_FAST")).append(" ").append(rs.getString("TAPING_FAST")).append(" ").append(rs.getString("FRAMEWORK_TECH_FAST")).append(" ");
	sb.append(rs.getString("ENCAPSULA_MAT_FAST")).append(" ").append(rs.getString("OTHER_FAST")).append(" ").append(rs.getString("TEST_MODELS_FAST")).append(" ").append(rs.getString("HANDER_FAST")).append(" ");
	sb.append(rs.getString("TEST_QUOTATION_WAY_FAST")).append(" ").append(rs.getString("TEST_SITE_FOR_FAST")).append(" ").append(rs.getString("TEST_OF_TIME_FAST")).append(" ").append(rs.getString("UPH_FORMULA_FAST")).append(" ");	
	sb.append(rs.getString("UPH_FAST")).append(" ");
	if(sb.length() > 0){
		sb.deleteCharAt(sb.length() - 1);
	}
}
out.print(sb);
%>
