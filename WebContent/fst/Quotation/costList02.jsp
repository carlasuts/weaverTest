<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
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
String result = "";
String requestid =  Util.null2String(request.getParameter("requestid"));
String Quotation_way =  Util.null2String(request.getParameter("Quotation_way"));


if(!"".equals(requestid)){	
	sql = "select * from formtable_main_205_dt3 where mainid=(select id from formtable_main_205 where requestid ='"+requestid+"')";
	baseBean.writeLog("sql1"+sql);
	rs.executeSql(sql);
	List list = new ArrayList();
	List list1 = new ArrayList();
	while(rs.next()){
		Map<String, String> map = new HashMap<String, String>();
		map.put("PROJECT", rs.getString("PROJECT"));
		map.put("MODEL", rs.getString("MODEL"));
		map.put("AMOUNT", rs.getString("AMOUNT"));
		list.add(map);
	}
	
	Map<String, String> map1 = new HashMap<String, String>();
	String ADV_MAT_ASSY="";//主材
	sql = "select SUM(AMOUNT) as ADV_MAT_ASSY from  formtable_main_205_dt3 where mainid=(select  id from formtable_main_205  where requestid ='"+requestid+"')";
	baseBean.writeLog("sql2"+sql);
	rs.executeSql(sql);
	rs.next();
	BigDecimal ADV_MAT_ASSY_MATH = (rs.getString("ADV_MAT_ASSY") == "" ? new BigDecimal(0) :new BigDecimal(rs.getString("ADV_MAT_ASSY")));
	ADV_MAT_ASSY = ADV_MAT_ASSY_MATH.toString();//主材 457.36
	
	
	String  MAT_ASSY = "0", OTH_MAT_ASSY="0", MAT_COM_ASSY="0", ARTIFI_ASSY="0", POWER_ASSY="0", DEPRECT_ASSY="0", MAINTAIN_ASSY="0",OTHER_ASSY="0", THOU_TAL_COST_ASSY="0";//组装
	sql = "select * from  formtable_main_205_dt1 where mainid=(select  id from formtable_main_205  where requestid ='"+ requestid +"')  and COST_ELEMENT =1";	
	baseBean.writeLog("sql2"+sql);
	rs.executeSql(sql);
	rs.next();
	MAT_ASSY =(rs.getString("MATERIAL_COST")== "" ? "0" :rs.getString("MATERIAL_COST")); //其他材料 485.15
	baseBean.writeLog("MAT_ASSY: " + MAT_ASSY);
	ARTIFI_ASSY =(rs.getString("ARTIFICIAL_COST")== "" ? "0" :rs.getString("ARTIFICIAL_COST")); //人工费用 71.33
	POWER_ASSY =(rs.getString("POWER_COST")== "" ? "0" :rs.getString("POWER_COST")); //动力费用 19.71
	DEPRECT_ASSY =(rs.getString("DEPRECIATION_EXPENSE")== "" ? "0" :rs.getString("DEPRECIATION_EXPENSE")); //折旧费用 78.85
	MAINTAIN_ASSY =(rs.getString("MAINTENANCE_COSTS")== "" ? "0" :rs.getString("MAINTENANCE_COSTS"));//维修费用 15.77
	OTHER_ASSY =(rs.getString("OTHER_FEES")== "" ? "0" :rs.getString("OTHER_FEES"));//其他费用 7.88
	THOU_TAL_COST_ASSY = (rs.getString("TOTAL_COST") == "" ? "0" : rs.getString("TOTAL_COST"));
	BigDecimal ARTIFI_ASSY_MATH =(ARTIFI_ASSY == "" ? new BigDecimal(0) :new BigDecimal(ARTIFI_ASSY));
	BigDecimal POWER_ASSY_MATH =(POWER_ASSY == "" ? new BigDecimal(0) :new BigDecimal(POWER_ASSY));
	BigDecimal DEPRECT_ASSY_MATH = (DEPRECT_ASSY == "" ? new BigDecimal(0) :new BigDecimal(DEPRECT_ASSY));
	BigDecimal MAINTAIN_ASSY_MATH = (MAINTAIN_ASSY == "" ? new BigDecimal(0) :new BigDecimal(MAINTAIN_ASSY));
	BigDecimal OTHER_ASSY_MATH =(OTHER_ASSY == "" ? new BigDecimal(0) :new BigDecimal(OTHER_ASSY));
	BigDecimal MAT_COM_ASSY_MATH = (MAT_ASSY == "" ? new BigDecimal(0) :new BigDecimal(MAT_ASSY));// 材料合计
	baseBean.writeLog("水脏雷");
	baseBean.writeLog("MAT_COM_ASSY_MATH: " + MAT_COM_ASSY_MATH);
	baseBean.writeLog("ADV_MAT_ASSY_MATH: " + ADV_MAT_ASSY_MATH);
	OTH_MAT_ASSY = MAT_COM_ASSY_MATH.subtract(ADV_MAT_ASSY_MATH).toString();
	MAT_COM_ASSY =MAT_COM_ASSY_MATH.toString();//材料合计
	BigDecimal THOU_TAL_COST_ASSY_MATH =ARTIFI_ASSY_MATH.add(POWER_ASSY_MATH).add(DEPRECT_ASSY_MATH).add(MAINTAIN_ASSY_MATH).add(OTHER_ASSY_MATH).add(MAT_COM_ASSY_MATH);//组装总成本（数字）
	
	
	String  TESTER_THOU="", HANDER_THOU="", MAT_THOU="", ARTIFI_THOU="", POWER_THOU="", DEPRECT_THOU="0", MAINTAIN_THOU="0",  OTHER_THOU="0", TEST_TAL_COST_THOU="0";//千只
	sql = "select * from  formtable_main_205_dt1 where    mainid=(select  id from formtable_main_205  where requestid ='"+ requestid +"')  and COST_ELEMENT =0 and QUOTATION_MODE =0";
	baseBean.writeLog("sql2"+sql);
	rs.executeSql(sql);
	rs.next();
	MAT_THOU =(rs.getString("MATERIAL_COST")== "" ? "0" :rs.getString("MATERIAL_COST")); //其他材料
	ARTIFI_THOU =(rs.getString("ARTIFICIAL_COST")== "" ? "0" :rs.getString("ARTIFICIAL_COST")); //人工费用
	POWER_THOU =(rs.getString("POWER_COST")== "" ? "0" :rs.getString("POWER_COST")); //动力费用
	DEPRECT_THOU =(rs.getString("DEPRECIATION_EXPENSE")== "" ? "0" :rs.getString("DEPRECIATION_EXPENSE")); //折旧费用
	MAINTAIN_THOU =(rs.getString("MAINTENANCE_COSTS")== "" ? "0" :rs.getString("MAINTENANCE_COSTS"));//维修费用
	OTHER_THOU =(rs.getString("OTHER_FEES")== "" ? "0" :rs.getString("OTHER_FEES"));//其他费用
	TEST_TAL_COST_THOU =(rs.getString("TOTAL_COST")== "" ? "0" :rs.getString("TOTAL_COST"));//总成本
	BigDecimal MAT_THOU_MATH =(MAT_THOU == "" ? new BigDecimal(0) :new BigDecimal(MAT_THOU));
	BigDecimal TEST_TAL_COST_THOU_MATH =(TEST_TAL_COST_THOU == "" ? new BigDecimal(0) :new BigDecimal(TEST_TAL_COST_THOU));
	
	
	String  TESTER_TIME="0", HANDER_TIME="0", MAT_TIME="0", ARTIFI_TIME="0", POWER_TIME="0",DEPRECT_TIME="0", MAINTAIN_TIME="0", OTHER_TIME="0", TEST_TAL_COST_TIME="0";//小时
	sql = "select * from  formtable_main_205_dt1 where    mainid=(select  id from formtable_main_205  where requestid ='"+ requestid +"')  and COST_ELEMENT =0 and QUOTATION_MODE =1";	
	baseBean.writeLog("sql2"+sql);
	rs.executeSql(sql);
	rs.next();		
	MAT_TIME =(rs.getString("MATERIAL_COST")== "" ? "0" :rs.getString("MATERIAL_COST")); //其他材料
	ARTIFI_TIME =(rs.getString("ARTIFICIAL_COST")== "" ? "0" :rs.getString("ARTIFICIAL_COST")); //人工费用
	POWER_TIME =(rs.getString("POWER_COST")== "" ? "0" :rs.getString("POWER_COST")); //动力费用
	DEPRECT_TIME =(rs.getString("DEPRECIATION_EXPENSE")== "" ? "0" :rs.getString("DEPRECIATION_EXPENSE")); //折旧费用
	MAINTAIN_TIME =(rs.getString("MAINTENANCE_COSTS")== "" ? "0" :rs.getString("MAINTENANCE_COSTS"));//维修费用
	OTHER_TIME =(rs.getString("OTHER_FEES")== "" ? "0" :rs.getString("OTHER_FEES"));//其他费用
	TEST_TAL_COST_TIME =(rs.getString("TOTAL_COST")== "" ? "0" :rs.getString("TOTAL_COST"));//总成本
	
	
	BigDecimal MAT_TIME_MATH =(MAT_TIME == "" ? new BigDecimal(0) :new BigDecimal(MAT_TIME));
	BigDecimal TEST_TAL_COST_TIME_MATH =(TEST_TAL_COST_TIME == "" ? new BigDecimal(0) :new BigDecimal(TEST_TAL_COST_TIME));
	
	
	String  FORM_PACK="0",GRADE_PACK="0", MAT_PACK="0", ARTIFI_PACK="0", POWER_PACK="0", DEPRECT_PACK="0", MAINTAIN_PACK="0", OTHER_PACK="", PACK_TAL_COST_PACK="0";//包装
	sql = "select * from  formtable_main_205_dt1 where    mainid=(select  id from formtable_main_205  where requestid ='"+ requestid +"')  and COST_ELEMENT =2";	
	baseBean.writeLog("sql2"+sql);
	rs.executeSql(sql);
	rs.next();	
	MAT_PACK =(rs.getString("MATERIAL_COST")== "" ? "0" :rs.getString("MATERIAL_COST")); //其他材料
	ARTIFI_PACK =(rs.getString("ARTIFICIAL_COST")== "" ? "0" :rs.getString("ARTIFICIAL_COST")); //人工费用
	POWER_PACK =(rs.getString("POWER_COST")== "" ? "0" :rs.getString("POWER_COST")); //动力费用
	DEPRECT_PACK =(rs.getString("DEPRECIATION_EXPENSE")== "" ? "0" :rs.getString("DEPRECIATION_EXPENSE")); //折旧费用
	MAINTAIN_PACK =(rs.getString("MAINTENANCE_COSTS")== "" ? "0" :rs.getString("MAINTENANCE_COSTS"));//维修费用
	OTHER_PACK =(rs.getString("OTHER_FEES")== "" ? "0" :rs.getString("OTHER_FEES"));//其他费用
	PACK_TAL_COST_PACK =(rs.getString("TOTAL_COST")== "" ? "0" :rs.getString("TOTAL_COST"));//总成本
	

	BigDecimal MAT_PACK_MATH = (MAT_PACK == "" ? new BigDecimal(0) :new BigDecimal(MAT_PACK));
	BigDecimal PACK_TAL_COST_PACK_MATH =(PACK_TAL_COST_PACK == "" ? new BigDecimal(0) :new BigDecimal(PACK_TAL_COST_PACK));
	
	
	String MAT_TOTL="", ARTIF_TOTL="", POWER_TOTL="", DEPREC_TOTL="", MAINT_TOTL="", OTHER_TOTL="", TOTAL_COST_TOTL="";//合计
	sql = "select sum(ARTIFICIAL_COST) as ARTIFICIAL_COST ,sum(POWER_COST) as POWER_COST ,sum(DEPRECIATION_EXPENSE) as DEPRECIATION_EXPENSE ,sum(MAINTENANCE_COSTS) as MAINTENANCE_COSTS ,sum(OTHER_FEES) as  OTHER_FEES from  formtable_main_205_dt1 where    mainid=(select  id from formtable_main_205  where requestid ='"+ requestid +"')";
	baseBean.writeLog("sql2"+sql);
	rs.executeSql(sql);
	rs.next();
	ARTIF_TOTL =(rs.getString("ARTIFICIAL_COST")== "" ? "0" :rs.getString("ARTIFICIAL_COST")); //人工费用
	POWER_TOTL =(rs.getString("POWER_COST")== "" ? "0" :rs.getString("POWER_COST")); //动力费用
	DEPREC_TOTL =(rs.getString("DEPRECIATION_EXPENSE")== "" ? "0" :rs.getString("DEPRECIATION_EXPENSE")); //折旧费用
	MAINT_TOTL =(rs.getString("MAINTENANCE_COSTS")== "" ? "0" :rs.getString("MAINTENANCE_COSTS"));//维修费用
	OTHER_TOTL =(rs.getString("OTHER_FEES")== "" ? "0" :rs.getString("OTHER_FEES"));//其他费用

	
	BigDecimal MAT_TOTL_MATH = MAT_COM_ASSY_MATH.add(MAT_THOU_MATH).add(MAT_TIME_MATH).add(MAT_PACK_MATH);
	BigDecimal TOTAL_COST_TOTL_MATH = THOU_TAL_COST_ASSY_MATH.add(TEST_TAL_COST_THOU_MATH).add(TEST_TAL_COST_TIME_MATH).add(PACK_TAL_COST_PACK_MATH);
	MAT_TOTL =MAT_TOTL_MATH.toString();
	TOTAL_COST_TOTL =TOTAL_COST_TOTL_MATH.toString();
	
	
	String CURRENCY="", TEST_QUOTATION_WAY_FAST="", SHAPE="", EXCHANGE_RATE ="";//其他
	sql = " select  TESTER,MD_HANDLER,Pack_form,Pack_grade,CURRENCY, b.QUOTATION_MODE as TEST_QUOTATION_WAY_FAST, SHAPE, EXCHANGE_RATE  from   formtable_main_205 a  left join formtable_main_205_dt1 b on a.id=b.mainid where requestid ='"+requestid+"'";
	baseBean.writeLog("sql"+sql);
	rs.executeSql(sql);
	rs.next();
	TESTER_TIME =rs.getString("TESTER"); //测试机（小时）
	TESTER_THOU =rs.getString("TESTER"); //测试机（千只）
	HANDER_TIME =rs.getString("MD_HANDLER"); //机械手（小时）
	HANDER_THOU =rs.getString("MD_HANDLER"); //机械手（千只）
	FORM_PACK =rs.getString("Pack_form"); //包装材料
	GRADE_PACK =rs.getString("Pack_grade"); //包装等级
	CURRENCY =rs.getString("CURRENCY"); //币种
	TEST_QUOTATION_WAY_FAST =rs.getString("TEST_QUOTATION_WAY_FAST"); //测试报价方式
	SHAPE =rs.getString("SHAPE"); //品名
	EXCHANGE_RATE =rs.getString("EXCHANGE_RATE"); //汇率
	
	map1.put("TOTAL_COST_TOTL", TOTAL_COST_TOTL);
	map1.put("MAT_TOTL", MAT_TOTL);
	map1.put("ADV_MAT_ASSY", ADV_MAT_ASSY);
	map1.put("ARTIFI_ASSY", ARTIFI_ASSY);
	map1.put("POWER_ASSY", POWER_ASSY);
	map1.put("DEPRECT_ASSY", DEPRECT_ASSY);
	map1.put("MAINTAIN_ASSY", MAINTAIN_ASSY);
	map1.put("OTHER_ASSY", OTHER_ASSY);
	map1.put("THOU_TAL_COST_ASSY", THOU_TAL_COST_ASSY);
	map1.put("OTH_MAT_ASSY", OTH_MAT_ASSY);
	map1.put("MAT_COM_ASSY", MAT_COM_ASSY);
	map1.put("MAT_THOU", MAT_THOU);
	map1.put("ARTIFI_THOU", ARTIFI_THOU);
	map1.put("POWER_THOU", POWER_THOU);
	map1.put("DEPRECT_THOU", DEPRECT_THOU);
	map1.put("MAINTAIN_THOU", MAINTAIN_THOU);
	map1.put("OTHER_THOU", OTHER_THOU);
	map1.put("TEST_TAL_COST_THOU", TEST_TAL_COST_THOU);
	map1.put("MAT_TIME", MAT_TIME);
	map1.put("ARTIFI_TIME", ARTIFI_TIME);
	map1.put("POWER_TIME", POWER_TIME);
	map1.put("DEPRECT_TIME", DEPRECT_TIME);
	map1.put("MAINTAIN_TIME", MAINTAIN_TIME);
	map1.put("OTHER_TIME", OTHER_TIME);
	map1.put("TEST_TAL_COST_TIME", TEST_TAL_COST_TIME);
	map1.put("MAT_PACK", MAT_PACK);
	map1.put("ARTIFI_PACK", ARTIFI_PACK);
	map1.put("POWER_PACK", POWER_PACK);
	map1.put("DEPRECT_PACK", DEPRECT_PACK);
	map1.put("MAINTAIN_PACK", MAINTAIN_PACK);
	map1.put("OTHER_PACK", OTHER_PACK);
	map1.put("PACK_TAL_COST_PACK", PACK_TAL_COST_PACK);
	map1.put("MAINT_TOTL", MAINT_TOTL);
	map1.put("DEPREC_TOTL", DEPREC_TOTL);
	map1.put("POWER_TOTL", POWER_TOTL);
	map1.put("ARTIF_TOTL", ARTIF_TOTL);
	map1.put("OTHER_TOTL", OTHER_TOTL);
	map1.put("TESTER_TIME", TESTER_TIME);
	map1.put("TESTER_THOU", TESTER_THOU);
	map1.put("HANDER_TIME", HANDER_TIME);
	map1.put("HANDER_THOU", HANDER_THOU);
	map1.put("FORM_PACK", FORM_PACK);
	map1.put("GRADE_PACK", GRADE_PACK);
	map1.put("CURRENCY", CURRENCY);
	map1.put("TEST_QUOTATION_WAY_FAST", TEST_QUOTATION_WAY_FAST);
	map1.put("SHAPE", SHAPE);
	map1.put("EXCHANGE_RATE", EXCHANGE_RATE);
	
	list1.add(list);
	list1.add(map1);
	
	result = JSON.toJSONString(list1);

}
out.print(result);
%>
