<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.BaseBean"%> 
<%@ page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="weaver.general.BaseBean" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<%
RecordSet rs = new RecordSet();
BaseBean baseBean = new BaseBean();
String sql = "";
String requestid =  Util.null2String(request.getParameter("requestid"));
String Quotation_way =  Util.null2String(request.getParameter("Quotation_way"));
String result = "";

Map<String, String> map = new HashMap<String, String>();

if(!"".equals(requestid)){
	sql = "SELECT ADV_MAT_ASSY, OTH_MAT_ASSY, MAT_COM_ASSY, ARTIFI_ASSY, POWER_ASSY, DEPRECT_ASSY, MAINTAIN_ASSY, OTHER_ASSY, THOU_TAL_COST_ASSY, TESTER_TIME, HANDER_TIME, MAT_TIME, ARTIFI_TIME, POWER_TIME, DEPRECT_TIME, MAINTAIN_TIME, OTHER_TIME, TEST_TAL_COST_TIME, TESTER_THOU, HANDER_THOU, MAT_THOU, ARTIFI_THOU, POWER_THOU, DEPRECT_THOU, MAINTAIN_THOU, OTHER_THOU, TEST_TAL_COST_THOU, FORM_PACK, GRADE_PACK, MAT_PACK, ARTIFI_PACK, POWER_PACK, DEPRECT_PACK, MAINTAIN_PACK, OTHER_PACK, PACK_TAL_COST_PACK, MAT_TOTL, ARTIF_TOTL, POWER_TOTL, DEPREC_TOTL, MAINT_TOTL, OTHER_TOTL, TOTAL_COST_TOTL, B.WIRE_BOND_FAST, B.FRAMEWORK_TECH_FAST, B.ENCAPSULA_MAT_FAST, B.MAT_FAST, WIRE_BOND_PRICE, FRAME_PRICE, MOLDING_PRICE, SLICE_PRICE, CURRENCY, B.TEST_QUOTATION_WAY_FAST, A.SHAPE, A.EXCHANGE_RATE FROM FORMTABLE_MAIN_205 A LEFT JOIN OFFER_TO_APPLY_MIDDLE B ON A.GUID = B.ID WHERE A.REQUESTID ='" + requestid + "'";
	baseBean.writeLog("sql1"+sql);
	rs.executeSql(sql);
	rs.next();
	map.put("ADV_MAT_ASSY", rs.getString("ADV_MAT_ASSY"));
	map.put("OTH_MAT_ASSY", rs.getString("OTH_MAT_ASSY"));
	map.put("MAT_COM_ASSY", rs.getString("MAT_COM_ASSY"));
	map.put("ARTIFI_ASSY", rs.getString("ARTIFI_ASSY"));
	map.put("POWER_ASSY", rs.getString("POWER_ASSY"));
	map.put("DEPRECT_ASSY", rs.getString("DEPRECT_ASSY"));
	map.put("MAINTAIN_ASSY", rs.getString("MAINTAIN_ASSY"));
	map.put("OTHER_ASSY", rs.getString("OTHER_ASSY"));
	map.put("THOU_TAL_COST_ASSY", rs.getString("THOU_TAL_COST_ASSY"));
	map.put("TESTER_TIME", rs.getString("TESTER_TIME"));
	map.put("HANDER_TIME", rs.getString("HANDER_TIME"));
	map.put("MAT_TIME", rs.getString("MAT_TIME"));
	map.put("ARTIFI_TIME", rs.getString("ARTIFI_TIME"));
	map.put("POWER_TIME", rs.getString("POWER_TIME"));
	map.put("DEPRECT_TIME", rs.getString("DEPRECT_TIME"));
	map.put("MAINTAIN_TIME", rs.getString("MAINTAIN_TIME"));
	map.put("OTHER_TIME", rs.getString("OTHER_TIME"));
	map.put("TEST_TAL_COST_TIME", rs.getString("TEST_TAL_COST_TIME"));
	map.put("TESTER_THOU", rs.getString("TESTER_THOU"));
	map.put("HANDER_THOU", rs.getString("HANDER_THOU"));
	map.put("MAT_THOU", rs.getString("MAT_THOU"));
	map.put("ARTIFI_THOU", rs.getString("ARTIFI_THOU"));
	map.put("POWER_THOU", rs.getString("POWER_THOU"));
	map.put("DEPRECT_THOU", rs.getString("DEPRECT_THOU"));
	map.put("MAINTAIN_THOU", rs.getString("MAINTAIN_THOU"));
	map.put("OTHER_THOU", rs.getString("OTHER_THOU"));
	map.put("TEST_TAL_COST_THOU", rs.getString("TEST_TAL_COST_THOU"));
	map.put("FORM_PACK", rs.getString("FORM_PACK"));
	map.put("GRADE_PACK", rs.getString("GRADE_PACK"));
	map.put("MAT_PACK", rs.getString("MAT_PACK"));
	map.put("ARTIFI_PACK", rs.getString("ARTIFI_PACK"));
	map.put("POWER_PACK", rs.getString("POWER_PACK"));
	map.put("DEPRECT_PACK", rs.getString("DEPRECT_PACK"));
	map.put("MAINTAIN_PACK", rs.getString("MAINTAIN_PACK"));
	map.put("OTHER_PACK", rs.getString("OTHER_PACK"));
	map.put("PACK_TAL_COST_PACK", rs.getString("PACK_TAL_COST_PACK"));
	map.put("MAT_TOTL", rs.getString("MAT_TOTL"));
	map.put("ARTIF_TOTL", rs.getString("ARTIF_TOTL"));
	map.put("POWER_TOTL", rs.getString("POWER_TOTL"));
	map.put("DEPREC_TOTL", rs.getString("DEPREC_TOTL"));
	map.put("MAINT_TOTL", rs.getString("MAINT_TOTL"));
	map.put("OTHER_TOTL", rs.getString("OTHER_TOTL"));
	map.put("TOTAL_COST_TOTL", rs.getString("TOTAL_COST_TOTL"));
	map.put("WIRE_BOND_FAST", rs.getString("WIRE_BOND_FAST"));
	map.put("FRAMEWORK_TECH_FAST", rs.getString("FRAMEWORK_TECH_FAST"));
	map.put("ENCAPSULA_MAT_FAST", rs.getString("ENCAPSULA_MAT_FAST"));
	map.put("MAT_FAST", rs.getString("MAT_FAST"));
	map.put("WIRE_BOND_PRICE", rs.getString("WIRE_BOND_PRICE"));
	map.put("FRAME_PRICE", rs.getString("FRAME_PRICE"));
	map.put("MOLDING_PRICE", rs.getString("MOLDING_PRICE"));
	map.put("SLICE_PRICE", rs.getString("SLICE_PRICE"));
	map.put("CURRENCY", rs.getString("CURRENCY"));
	map.put("TEST_QUOTATION_WAY_FAST", rs.getString("TEST_QUOTATION_WAY_FAST"));
	map.put("SHAPE", rs.getString("SHAPE"));
	map.put("EXCHANGE_RATE", rs.getString("EXCHANGE_RATE"));
	
	result = JSON.toJSONString(map);
}
out.print(result);
%>
