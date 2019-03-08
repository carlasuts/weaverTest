<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="weaver.general.BaseBean"%> 
<%@page import="weaver.conn.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.math.BigDecimal" %>
<%
RecordSet rs = new RecordSet();
BaseBean baseBean = new BaseBean();
String sql = "";
String requestid =  Util.null2String(request.getParameter("requestid"));
String Quotation_way =  Util.null2String(request.getParameter("Quotation_way"));

StringBuffer sb = new StringBuffer();

if(!"".equals(requestid)){
	if(Quotation_way=="0"){
		sql = "SELECT Adv_mat_assy, Oth_mat_assy, Mat_com_assy, artifi_assy, power_assy, deprect_assy, maintain_assy, other_assy, thou_tal_cost_assy, tester_time, hander_time, mat_time, " +
			  "artifi_time, power_time, deprect_time, maintain_time, other_time, test_tal_cost_time, tester_thou, hander_thou, mat_thou, artifi_thou, power_thou, deprect_thou, maintain_thou, " +
			  "other_thou, test_tal_cost_thou, form_pack, grade_pack, mat_pack, artifi_pack, power_pack, deprect_pack, maintain_pack, other_pack, pack_tal_cost_pack, mat_totl, Artif_totl, " +
			  "power_totl, deprec_totl, maint_totl, other_totl, total_cost_totl, b.WIRE_BOND_FAST, b.FRAMEWORK_TECH_FAST, b.ENCAPSULA_MAT_FAST, b.MAT_FAST, wire_bond_price, frame_price, " +
			  "molding_price, slice_price, currency, b.TEST_QUOTATION_WAY_FAST, a.shape, a.exchange_rate " +
			  "from formtable_main_141 a left join Offer_to_apply_middle b on a.guid = b.ID where a.requestid ='" + requestid + "'";
		baseBean.writeLog("sql1"+sql);			  
		rs.executeSql(sql);
		rs.next();	
		sb.append(rs.getString("Adv_mat_assy")).append(" ").append(rs.getString("Oth_mat_assy")).append(" ").append(rs.getString("Mat_com_assy")).append(" ").append(rs.getString("artifi_assy")).append(" ");
		sb.append(rs.getString("power_assy")).append(" ").append(rs.getString("deprect_assy")).append(" ").append(rs.getString("maintain_assy")).append(" ").append(rs.getString("other_assy")).append(" ");
		sb.append(rs.getString("thou_tal_cost_assy")).append(" ").append(rs.getString("tester_time")).append(" ").append(rs.getString("hander_time")).append(" ").append(rs.getString("mat_time")).append(" ");
		sb.append(rs.getString("artifi_time")).append(" ").append(rs.getString("power_time")).append(" ").append(rs.getString("deprect_time")).append(" ").append(rs.getString("maintain_time")).append(" ");
		sb.append(rs.getString("other_time")).append(" ").append(rs.getString("test_tal_cost_time")).append(" ").append(rs.getString("tester_thou")).append(" ").append(rs.getString("hander_thou")).append(" ");	
		sb.append(rs.getString("mat_thou")).append(" ").append(rs.getString("artifi_thou")).append(" ").append(rs.getString("power_thou")).append(" ").append(rs.getString("deprect_thou")).append(" ");
		sb.append(rs.getString("maintain_thou")).append(" ").append(rs.getString("other_thou")).append(" ").append(rs.getString("test_tal_cost_thou")).append(" ").append(rs.getString("form_pack")).append(" ");
		sb.append(rs.getString("grade_pack")).append(" ").append(rs.getString("mat_pack")).append(" ").append(rs.getString("artifi_pack")).append(" ").append(rs.getString("power_pack")).append(" ");
		sb.append(rs.getString("deprect_pack")).append(" ").append(rs.getString("maintain_pack")).append(" ").append(rs.getString("other_pack")).append(" ").append(rs.getString("pack_tal_cost_pack")).append(" ");
		sb.append(rs.getString("mat_totl")).append(" ").append(rs.getString("Artif_totl")).append(" ").append(rs.getString("power_totl")).append(" ").append(rs.getString("deprec_totl")).append(" ");
		sb.append(rs.getString("maint_totl")).append(" ").append(rs.getString("other_totl")).append(" ").append(rs.getString("total_cost_totl")).append(" ").append(rs.getString("WIRE_BOND_FAST")).append(" ");
		sb.append(rs.getString("FRAMEWORK_TECH_FAST")).append(" ").append(rs.getString("ENCAPSULA_MAT_FAST")).append(" ").append(rs.getString("MAT_FAST")).append(" ").append(rs.getString("wire_bond_price")).append(" ");
		sb.append(rs.getString("frame_price")).append(" ").append(rs.getString("molding_price")).append(" ").append(rs.getString("slice_price")).append(" ").append(rs.getString("currency")).append(" ");
		sb.append(rs.getString("TEST_QUOTATION_WAY_FAST")).append(" ").append(rs.getString("shape")).append(" ").append(rs.getString("exchange_rate")).append(" ");
		if(sb.length() > 0){
			sb.deleteCharAt(sb.length() - 1);
		}
	}else{
		String FRAMEWORK_TECH_NAME="",FRAMEWORK_TECH_TYPE="",FRAMEWORK_TECH_PRICE="0";//框架
		String ENCAPSULA_MAT_NAME="",ENCAPSULA_MAT_TYPE="",ENCAPSULA_MAT_PRICE="0";//塑封料
		String CONDUCTIVE_ADHESIVE_NAME="",CONDUCTIVE_ADHESIVE_TYPE="",CONDUCTIVE_ADHESIVE_PRICE="0";//导电胶
		String WIRE_BOND_NAME="",WIRE_BOND_TYPE="",WIRE_BOND_PRICE="0";//键合丝
		String INSULATED_NAME="",INSULATED_TYPE="",INSULATED_PRICE="0";//绝缘胶
		String  PLATING_SOLUTION_NAME="",PLATING_SOLUTION_TYPE="",PLATING_SOLUTION_PRICE="0";//电镀液
		sql = "select * from  formtable_main_141_dt3 where    mainid=(select  id from formtable_main_141  where requestid ='"+requestid+"'  ) " ;
		baseBean.writeLog("sql1"+sql);
		rs.executeSql(sql);
		while(rs.next()){
			String PROJECT =rs.getString("PROJECT");
			String MODEL =rs.getString("MODEL");
			String AMOUNT =rs.getString("AMOUNT");
			baseBean.writeLog("PROJECT------"+PROJECT);
			baseBean.writeLog("MODEL------"+MODEL);
			baseBean.writeLog("AMOUNT------"+AMOUNT);
			if(PROJECT.contains("框架")){
				FRAMEWORK_TECH_NAME =PROJECT;
				FRAMEWORK_TECH_TYPE =MODEL;
				FRAMEWORK_TECH_PRICE =AMOUNT;
			}
			if(PROJECT.contains("导电胶")){
				CONDUCTIVE_ADHESIVE_NAME=PROJECT;
				CONDUCTIVE_ADHESIVE_TYPE =MODEL;
				CONDUCTIVE_ADHESIVE_PRICE =AMOUNT;
			}
			if(PROJECT.contains("塑封料")){
				ENCAPSULA_MAT_NAME=PROJECT;
				ENCAPSULA_MAT_TYPE =MODEL;
				ENCAPSULA_MAT_PRICE =AMOUNT;
			}
			if(PROJECT.contains("键合")){
				WIRE_BOND_NAME=PROJECT;
				WIRE_BOND_TYPE =MODEL.trim();
				WIRE_BOND_PRICE =AMOUNT;
			}
			if(PROJECT.contains("绝缘胶")){
				INSULATED_NAME=PROJECT;
				INSULATED_TYPE =MODEL;
				INSULATED_PRICE =AMOUNT;
			}
			if(PROJECT.contains("电镀液")){
				PLATING_SOLUTION_NAME=PROJECT;
				PLATING_SOLUTION_TYPE =MODEL;
				PLATING_SOLUTION_PRICE =AMOUNT;
			}
		}
		baseBean.writeLog("FRAMEWORK_TECH_NAME------"+FRAMEWORK_TECH_NAME);
		baseBean.writeLog("FRAMEWORK_TECH_TYPE------"+FRAMEWORK_TECH_TYPE);
		baseBean.writeLog("FRAMEWORK_TECH_PRICE------"+FRAMEWORK_TECH_PRICE);
		
		baseBean.writeLog("CONDUCTIVE_ADHESIVE_NAME------"+CONDUCTIVE_ADHESIVE_NAME);
		baseBean.writeLog("CONDUCTIVE_ADHESIVE_TYPE------"+CONDUCTIVE_ADHESIVE_TYPE);
		baseBean.writeLog("CONDUCTIVE_ADHESIVE_PRICE------"+CONDUCTIVE_ADHESIVE_PRICE);
		
		baseBean.writeLog("ENCAPSULA_MAT_NAME------"+ENCAPSULA_MAT_NAME);
		baseBean.writeLog("ENCAPSULA_MAT_TYPE------"+ENCAPSULA_MAT_TYPE);
		baseBean.writeLog("ENCAPSULA_MAT_PRICE------"+ENCAPSULA_MAT_PRICE);
		
		baseBean.writeLog("WIRE_BOND_NAME------"+WIRE_BOND_NAME);
		baseBean.writeLog("WIRE_BOND_TYPE------"+WIRE_BOND_TYPE);
		baseBean.writeLog("WIRE_BOND_PRICE------"+WIRE_BOND_PRICE);
		
		baseBean.writeLog("INSULATED_NAME------"+INSULATED_NAME);
		baseBean.writeLog("INSULATED_TYPE------"+INSULATED_TYPE);
		baseBean.writeLog("INSULATED_PRICE------"+INSULATED_PRICE);
		
		baseBean.writeLog("PLATING_SOLUTION_NAME------"+PLATING_SOLUTION_NAME);
		baseBean.writeLog("PLATING_SOLUTION_TYPE------"+PLATING_SOLUTION_TYPE);
		baseBean.writeLog("PLATING_SOLUTION_PRICE------"+PLATING_SOLUTION_PRICE);
		
		String ADV_MAT_ASSY="";//主材
		sql = "select SUM(AMOUNT) as ADV_MAT_ASSY from  formtable_main_141_dt3 where mainid=(select  id from formtable_main_141  where requestid ='"+requestid+"')";
		baseBean.writeLog("sql2"+sql);
		rs.executeSql(sql);
		rs.next();
		BigDecimal ADV_MAT_ASSY_MATH = (rs.getString("ADV_MAT_ASSY") == "" ? new BigDecimal(0) :new BigDecimal(rs.getString("ADV_MAT_ASSY")));
	 	ADV_MAT_ASSY =ADV_MAT_ASSY_MATH.toString();//主材
		
		
		
		String  OTH_MAT_ASSY="0", MAT_COM_ASSY="0", ARTIFI_ASSY="0", POWER_ASSY="0", DEPRECT_ASSY="0", MAINTAIN_ASSY="0",OTHER_ASSY="0", THOU_TAL_COST_ASSY="0";//组装

		sql = "select * from  formtable_main_141_dt1 where    mainid=(select  id from formtable_main_141  where requestid ='"+ requestid +"')  and COST_ELEMENT =1";	
		baseBean.writeLog("sql2"+sql);
		rs.executeSql(sql);
		rs.next();
		OTH_MAT_ASSY =(rs.getString("MATERIAL_COST")== "" ? "0" :rs.getString("MATERIAL_COST")); //其他材料
		ARTIFI_ASSY =(rs.getString("ARTIFICIAL_COST")== "" ? "0" :rs.getString("ARTIFICIAL_COST")); //人工费用
		POWER_ASSY =(rs.getString("POWER_COST")== "" ? "0" :rs.getString("POWER_COST")); //动力费用
		DEPRECT_ASSY =(rs.getString("DEPRECIATION_EXPENSE")== "" ? "0" :rs.getString("DEPRECIATION_EXPENSE")); //折旧费用
		MAINTAIN_ASSY =(rs.getString("MAINTENANCE_COSTS")== "" ? "0" :rs.getString("MAINTENANCE_COSTS"));//维修费用
		OTHER_ASSY =(rs.getString("OTHER_FEES")== "" ? "0" :rs.getString("OTHER_FEES"));//其他费用
		BigDecimal ARTIFI_ASSY_MATH =(ARTIFI_ASSY == "" ? new BigDecimal(0) :new BigDecimal(ARTIFI_ASSY));
		BigDecimal POWER_ASSY_MATH =(POWER_ASSY == "" ? new BigDecimal(0) :new BigDecimal(POWER_ASSY));
		BigDecimal DEPRECT_ASSY_MATH = (DEPRECT_ASSY == "" ? new BigDecimal(0) :new BigDecimal(DEPRECT_ASSY));
		BigDecimal MAINTAIN_ASSY_MATH = (MAINTAIN_ASSY == "" ? new BigDecimal(0) :new BigDecimal(MAINTAIN_ASSY));
		BigDecimal OTHER_ASSY_MATH =(OTHER_ASSY == "" ? new BigDecimal(0) :new BigDecimal(OTHER_ASSY));


		BigDecimal OTH_MAT_ASSY_MATH = (OTH_MAT_ASSY == "" ? new BigDecimal(0) :new BigDecimal(OTH_MAT_ASSY));
		BigDecimal MAT_COM_ASSY_MATH =OTH_MAT_ASSY_MATH.add(ADV_MAT_ASSY_MATH); //材料合计 （数字）
		MAT_COM_ASSY =MAT_COM_ASSY_MATH.toString();//材料合计
		
		BigDecimal THOU_TAL_COST_ASSY_MATH =ARTIFI_ASSY_MATH.add(POWER_ASSY_MATH).add(DEPRECT_ASSY_MATH).add(MAINTAIN_ASSY_MATH).add(OTHER_ASSY_MATH).add(MAT_COM_ASSY_MATH);//组装总成本（数字）
		THOU_TAL_COST_ASSY =THOU_TAL_COST_ASSY_MATH.toString();//组装总成本
		
		
		
		
		
		String  TESTER_THOU="", HANDER_THOU="", MAT_THOU="", ARTIFI_THOU="", POWER_THOU="", DEPRECT_THOU="0", MAINTAIN_THOU="0",  OTHER_THOU="0", TEST_TAL_COST_THOU="0";//千只
		sql = "select * from  formtable_main_141_dt1 where    mainid=(select  id from formtable_main_141  where requestid ='"+ requestid +"')  and COST_ELEMENT =0 and QUOTATION_MODE =0";	
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
		sql = "select * from  formtable_main_141_dt1 where    mainid=(select  id from formtable_main_141  where requestid ='"+ requestid +"')  and COST_ELEMENT =0 and QUOTATION_MODE =1";	
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
		sql = "select * from  formtable_main_141_dt1 where    mainid=(select  id from formtable_main_141  where requestid ='"+ requestid +"')  and COST_ELEMENT =2";	
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
		sql = "select sum(ARTIFICIAL_COST) as ARTIFICIAL_COST ,sum(POWER_COST) as POWER_COST ,sum(DEPRECIATION_EXPENSE) as DEPRECIATION_EXPENSE ,sum(MAINTENANCE_COSTS) as MAINTENANCE_COSTS ,sum(OTHER_FEES) as  OTHER_FEES from  formtable_main_141_dt1 where    mainid=(select  id from formtable_main_141  where requestid ='"+ requestid +"')";
		baseBean.writeLog("sql2"+sql);
		rs.executeSql(sql);
		rs.next();
		ARTIF_TOTL =rs.getString("ARTIFICIAL_COST"); //人工费用
		POWER_TOTL =rs.getString("POWER_COST"); //动力费用
		DEPREC_TOTL =rs.getString("DEPRECIATION_EXPENSE"); //折旧费用
		MAINT_TOTL =rs.getString("MAINTENANCE_COSTS");//维修费用
		OTHER_TOTL =rs.getString("OTHER_FEES");//其他费用
		
		BigDecimal MAT_TOTL_MATH = MAT_COM_ASSY_MATH.add(MAT_THOU_MATH).add(MAT_TIME_MATH).add(MAT_PACK_MATH);
		BigDecimal TOTAL_COST_TOTL_MATH = THOU_TAL_COST_ASSY_MATH.add(TEST_TAL_COST_THOU_MATH).add(TEST_TAL_COST_TIME_MATH).add(PACK_TAL_COST_PACK_MATH);
		MAT_TOTL =MAT_TOTL_MATH.toString();
		TOTAL_COST_TOTL =TOTAL_COST_TOTL_MATH.toString();
		
		String    CURRENCY="", TEST_QUOTATION_WAY_FAST="", SHAPE="", EXCHANGE_RATE ="";//其他
		sql = " select  TESTER,MD_HANDLER,Pack_form,Pack_grade,CURRENCY, b.QUOTATION_MODE as TEST_QUOTATION_WAY_FAST, SHAPE, EXCHANGE_RATE  from   formtable_main_141 a  left join formtable_main_141_dt1 b on a.id=b.mainid where requestid ='"+requestid+"'";
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
		
		
		
		//String FRAMEWORK_TECH_NAME,FRAMEWORK_TECH_TYPE,FRAMEWORK_TECH_PRICE;//框架
		//String ENCAPSULA_MAT_NAME,ENCAPSULA_MAT_TYPE,ENCAPSULA_MAT_PRICE;//塑封料
		//String CONDUCTIVE_ADHESIVE_NAME,CONDUCTIVE_ADHESIVE_TYPE,CONDUCTIVE_ADHESIVE_PRICE;//导电胶
		//String WIRE_BOND_NAME,WIRE_BOND_TYPE,WIRE_BOND_PRICE;//键合丝
		//String INSULATED_NAME,INSULATED_TYPE,INSULATED_PRICE;//绝缘胶
		//String PLATING_SOLUTION_NAME,PLATING_SOLUTION_TYPE,PLATING_SOLUTION_PRICE;//电镀液
		//String ADV_MAT_ASSY;//主材
		//String OTH_MAT_ASSY, MAT_COM_ASSY, ARTIFI_ASSY, POWER_ASSY, DEPRECT_ASSY, MAINTAIN_ASSY,OTHER_ASSY, THOU_TAL_COST_ASSY;//组装
		//String TESTER_THOU, HANDER_THOU, MAT_THOU, ARTIFI_THOU, POWER_THOU, DEPRECT_THOU, MAINTAIN_THOU,  OTHER_THOU, TEST_TAL_COST_THOU;//千只
		//String TESTER_TIME, HANDER_TIME, MAT_TIME, ARTIFI_TIME, POWER_TIME,DEPRECT_TIME, MAINTAIN_TIME, OTHER_TIME, TEST_TAL_COST_TIME;//小时
		//String FORM_PACK,GRADE_PACK, MAT_PACK, ARTIFI_PACK, POWER_PACK, DEPRECT_PACK, MAINTAIN_PACK, OTHER_PACK, PACK_TAL_COST_PACK;//包装
		//String MAT_TOTL, ARTIF_TOTL, POWER_TOTL, DEPREC_TOTL, MAINT_TOTL, OTHER_TOTL, TOTAL_COST_TOTL;//合计
		//String CURRENCY, TEST_QUOTATION_WAY_FAST, SHAPE, EXCHANGE_RATE ;//其他
		sb.append(ADV_MAT_ASSY).append(" ").append(OTH_MAT_ASSY).append(" ").append(MAT_COM_ASSY).append(" ").append(ARTIFI_ASSY).append(" ");
		sb.append(POWER_ASSY).append(" ").append(DEPRECT_ASSY).append(" ").append(MAINTAIN_ASSY).append(" ").append(OTHER_ASSY).append(" ");
		sb.append(THOU_TAL_COST_ASSY).append(" ").append(TESTER_TIME).append(" ").append(HANDER_TIME).append(" ").append(MAT_TIME).append(" ");
		sb.append(ARTIFI_TIME).append(" ").append(POWER_TIME).append(" ").append(DEPRECT_TIME).append(" ").append(MAINTAIN_TIME).append(" ");
		sb.append(OTHER_TIME).append(" ").append(TEST_TAL_COST_TIME).append(" ").append(TESTER_THOU).append(" ").append(HANDER_THOU).append(" ");	
		sb.append(MAT_THOU).append(" ").append(ARTIFI_THOU).append(" ").append(POWER_THOU).append(" ").append(DEPRECT_THOU).append(" ");
		sb.append(MAINTAIN_THOU).append(" ").append(OTHER_THOU).append(" ").append(TEST_TAL_COST_THOU).append(" ").append(FORM_PACK).append(" ");
		sb.append(GRADE_PACK).append(" ").append(MAT_PACK).append(" ").append(ARTIFI_PACK).append(" ").append(POWER_PACK).append(" ");
		sb.append(DEPRECT_PACK).append(" ").append(MAINTAIN_PACK).append(" ").append(OTHER_PACK).append(" ").append(PACK_TAL_COST_PACK).append(" ");
		sb.append(MAT_TOTL).append(" ").append(ARTIF_TOTL).append(" ").append(POWER_TOTL).append(" ").append(DEPREC_TOTL).append(" ");
		sb.append(MAINT_TOTL).append(" ").append(OTHER_TOTL).append(" ").append(TOTAL_COST_TOTL).append(" ").append(WIRE_BOND_TYPE).append(" ");
		sb.append(FRAMEWORK_TECH_TYPE).append(" ").append(ENCAPSULA_MAT_TYPE).append(" ").append(CONDUCTIVE_ADHESIVE_TYPE).append(" ").append(WIRE_BOND_PRICE).append(" ");
		sb.append(FRAMEWORK_TECH_PRICE).append(" ").append(ENCAPSULA_MAT_PRICE).append(" ").append(CONDUCTIVE_ADHESIVE_PRICE).append(" ").append(CURRENCY).append(" ");
		sb.append(TEST_QUOTATION_WAY_FAST).append(" ").append(SHAPE).append(" ").append(EXCHANGE_RATE).append(" ");
		if(sb.length() > 0){
			sb.deleteCharAt(sb.length() - 1);
		}
	}
}
out.print(sb);
%>
