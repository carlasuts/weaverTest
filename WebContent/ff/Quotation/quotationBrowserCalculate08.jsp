<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%
RecordSet rs = new RecordSet();
String sql = "";
BaseBean e = new BaseBean();
e.writeLog("进入QUOTATIONBROWSERCALCULATE08");
String uuid =  Util.null2String(request.getParameter("uuid"));
String shape =  Util.null2String(request.getParameter("shape"));
String producttype =  Util.null2String(request.getParameter("producttype"));
String custid =  Util.null2String(request.getParameter("custid"));
String tradeway =  Util.null2String(request.getParameter("tradeway"));
String wirebondtype =  Util.null2String(request.getParameter("wirebondtype"));
String wirediameter =  Util.null2String(request.getParameter("wirediameter"));
String silk =  Util.null2String(request.getParameter("silk"));
String grind =  Util.null2String(request.getParameter("grind"));
String chipnumber =  Util.null2String(request.getParameter("chipnumber"));
String chipX =  Util.null2String(request.getParameter("chipX"));
String chipY =  Util.null2String(request.getParameter("chipY"));
String mat =  Util.null2String(request.getParameter("mat"));
String frametechnology =  Util.null2String(request.getParameter("frametechnology"));
String moldingcompound =  Util.null2String(request.getParameter("moldingcompound"));
String other =  Util.null2String(request.getParameter("other"));
String packageform =  Util.null2String(request.getParameter("packageform"));
String packagegrade =  Util.null2String(request.getParameter("packagegrade"));
String taping =  Util.null2String(request.getParameter("taping"));
String tester =  Util.null2String(request.getParameter("tester"));
String manipulator =  Util.null2String(request.getParameter("manipulator"));
String quotationmethod =  Util.null2String(request.getParameter("quotationmethod"));
String site =  Util.null2String(request.getParameter("site"));
String testtime =  Util.null2String(request.getParameter("testtime"));
String uphformula =  Util.null2String(request.getParameter("uphformula"));
String uph =  Util.null2String(request.getParameter("uph"));

StringBuffer sb = new StringBuffer();
if(!"".equals(shape) && !"".equals(producttype) && !"".equals(custid) && !"".equals(tradeway)){
	sql = "select ID from Offer_to_apply_middle where ID='" + uuid + "'";
	e.writeLog("sql"+sql);
	rs.executeSql(sql);
	rs.next();
	if (rs.getString("ID") != ""){
		sql = "delete from Offer_to_apply_middle where ID='" + uuid + "'";
		rs.executeSql(sql);
	}
	sql = "insert into Offer_to_apply_middle (ID, SHAPE_FAST, PRODUCT_TYPE_FAST, CUST_FAST, TRADE_WAY_FAST, WIRE_BOND_FAST, WIRE_DIAM_FAST, " +
		  "SILK_FAST, GRIND_FAST, CHIP_NUM_FAST, CHIP_X_FAST, CHIP_Y_FAST, MAT_FAST, FORM_FAST, GRADE_FAST, TAPING_FAST, FRAMEWORK_TECH_FAST, " + 
		  "ENCAPSULA_MAT_FAST, OTHER_FAST, TEST_MODELS_FAST, HANDER_FAST, TEST_QUOTATION_WAY_FAST, TEST_SITE_FOR_FAST, TEST_OF_TIME_FAST, UPH_FORMULA_FAST, UPH_FAST) " + 
		  "values ('" + uuid + "', '" + shape + "', '" + producttype + "', '" + custid + "', '" + tradeway + "', '" + wirebondtype + "', '" + wirediameter + 
		  "', '" + silk + "', '" + grind + "', '" + chipnumber + "', '" + chipX + "', '" + chipY + "', '" + mat + "', '" + packageform + "', '" + packagegrade + 
		  "', '" + taping + "', '" + frametechnology + "', '" + moldingcompound + "', '" + other + "', '" + tester + 
		  "', '" + manipulator + "', '" + quotationmethod + "', '" + site + "', '" + testtime + "', '" + uphformula + "', '" + uph +"')";
		  e.writeLog("sql"+sql);
	rs.executeSql(sql);	
}
out.print(sb);
%>