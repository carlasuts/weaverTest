package weaver.interfaces.workflow.action.offer;

import java.math.BigDecimal;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;;

public class TfmeOffer_01 {
	// 成本合计

	public void getcostofcombined(String rid, MainTableInfo maintableinfo, String workflowid) {

		int formid = BillUtil.getFormId(Integer.parseInt(workflowid));

		BaseBean bs = new BaseBean();
		RecordSet rs = new RecordSet();
		bs.writeLog("进入接口TfmeOffer");

		String CURRENCY = "";// 币种

		String TRADEWAY_SELECTVALUE = "";
		String TRADEWAY = ""; // 贸易方式
		String PRODUCT_TYPE_SELECTVALUE = "";
		String PRODUCT_TYPE = ""; // 生产类型
		String SHAPE = ""; // 外形
		String FACTORY = "";// 工厂
		String SHAPE_FAST = "";// 外形(快速)
		String PRODUCT_TYPE_FAST = "";// 生产类型(快速)
		String CUST_FAST = "";// 客户(快速)
		String TRADE_WAY_FAST = "";// 贸易方式(快速)
		String WIRE_BOND_FAST = "";// 键合丝类别(快速)
		String WIRE_DIAM_FAST = "";// 线径(快速)
		String SILK_FAST = "";// 丝数(快速)
		String GRIND_FAST = ""; // 磨片(快速)
		String CHIP_NUM_FAST = "";// 芯片个数(快速)
		String CHIP_X_FAST = "";// 芯片X(快速)
		String CHIP_Y_FAST = "";// 芯片Y(快速)
		String MAT_FAST = "";// 装片材料(快速)
		String FORM_FAST = "";// 包装形式(快速)
		String GRADE_FAST = "";// 包装档次(快速)
		String TAPING_FAST = "";// (单独)TAPING(快速)
		String FRAMEWORK_TECH_FAST = "";// 框架工艺(快速)
		String ENCAPSULA_MAT_FAST = "";// 塑封料(快速)
		String OTHER_FAST = "";// 其他(快速)
		String TEST_MODELS_FAST = "";// 测试机型号(快速)
		String HANDER_FAST = "";// 机械手(快速)
		String TEST_QUOTATION_WAY_FAST = "";// 测试报价方式(快速)
		String TEST_SITE_FOR_FAST = "";// 测试site数(快速)
		String TEST_OF_TIME_FAST = "";// 测试时间(ms)(快速)
		String UPH_FORMULA_FAST = "";// UPH公式(快速)
		String UPH_FAST = "";// UPH(快速)

		String sql = "";

		Property[] Property = maintableinfo.getProperty();
		String id;
		bs.writeLog("Property" + Property);
		for (int ss = 0; ss < Property.length; ++ss) {
			String dataDB = Property[ss].getName().toUpperCase();
			id = Util.null2String(Property[ss].getValue());

			if (dataDB.equals("TRADEWAY")) {
				TRADEWAY_SELECTVALUE = id;
			}
			if (dataDB.equals("CURRENCY")) {
				CURRENCY = id;
			}

			if (dataDB.equals("PRODUCT_TYPE")) {
				PRODUCT_TYPE_SELECTVALUE = id;
			}
			if (dataDB.equals("SHAPE")) {
				SHAPE = id;
			}
			if (dataDB.equals("PRODUCT_TYPE_FAST")) {
				PRODUCT_TYPE_FAST = id;
			}

			if (dataDB.equals("FACTORY")) {
				FACTORY = id;
			}
			if (dataDB.equals("SHAPE_FAST")) {
				SHAPE_FAST = id;
			}

			if (dataDB.equals("CUST_FAST")) {
				CUST_FAST = id;
			}

			if (dataDB.equals("TRADE_WAY_FAST")) {
				TRADE_WAY_FAST = id;
			}
			if (dataDB.equals("WIRE_BOND_FAST")) {
				WIRE_BOND_FAST = id;
			}
			if (dataDB.equals("WIRE_DIAM_FAST")) {
				WIRE_DIAM_FAST = id;
			}
			if (dataDB.equals("SILK_FAST")) {
				SILK_FAST = id;
			}
			if (dataDB.equals("GRIND_FAST")) {
				GRIND_FAST = id;
			}
			if (dataDB.equals("CHIP_NUM_FAST")) {
				CHIP_NUM_FAST = id;
			}
			if (dataDB.equals("CHIP_X_FAST")) {
				CHIP_X_FAST = id;
			}
			if (dataDB.equals("CHIP_Y_FAST")) {
				CHIP_Y_FAST = id;
			}
			if (dataDB.equals("MAT_FAST")) {
				MAT_FAST = id;
			}
			if (dataDB.equals("FORM_FAST")) {
				FORM_FAST = id;
			}
			if (dataDB.equals("GRADE_FAST")) {
				GRADE_FAST = id;
			}
			if (dataDB.equals("TAPING_FAST")) {
				TAPING_FAST = id;
			}
			if (dataDB.equals("FRAMEWORK_TECH_FAST")) {
				FRAMEWORK_TECH_FAST = id;
			}
			if (dataDB.equals("ENCAPSULA_MAT_FAST")) {
				ENCAPSULA_MAT_FAST = id;
			}
			if (dataDB.equals("TEST_MODELS_FAST")) {
				TEST_MODELS_FAST = id;
			}
			if (dataDB.equals("OTHER_FAST")) {
				OTHER_FAST = id;
			}
			if (dataDB.equals("HANDER_FAST")) {
				HANDER_FAST = id;
			}
			if (dataDB.equals("TEST_QUOTATION_WAY_FAST")) {
				TEST_QUOTATION_WAY_FAST = id;
			}
			if (dataDB.equals("TEST_SITE_FOR_FAST")) {
				TEST_SITE_FOR_FAST = id;
			}
			if (dataDB.equals("TEST_OF_TIME_FAST")) {
				TEST_OF_TIME_FAST = id;
			}
			if (dataDB.equals("UPH_FORMULA_FAST")) {
				UPH_FORMULA_FAST = id;
			}
			if (dataDB.equals("UPH_FAST")) {
				UPH_FAST = id;
			}

		}

		// 获取贸易方式全名
		sql = "select SELECTNAME from workflow_selectitem where selectvalue = " + TRADEWAY_SELECTVALUE
				+ " and fieldid =( select id from workflow_billfield where billid=-" + formid
				+ " and fieldname ='Tradeway')";
		rs.execute(sql);
		rs.next();
		TRADEWAY = rs.getString("SELECTNAME");

		// 获取生产类型全名 PRODUCT_TYPE_SELECTVALUE
		sql = "select SELECTNAME from workflow_selectitem where selectvalue = " + PRODUCT_TYPE_SELECTVALUE
				+ " and fieldid =( select id from workflow_billfield where billid=-" + formid
				+ " and fieldname ='product_type')";
		rs.execute(sql);
		rs.next();
		PRODUCT_TYPE = rs.getString("SELECTNAME");

		bs.writeLog("TRADEWAY_SELECTVALUE:" + TRADEWAY_SELECTVALUE);
		bs.writeLog("TRADEWAY:" + TRADEWAY);
		bs.writeLog("PRODUCT_TYPE_SELECTVALUE:" + PRODUCT_TYPE_SELECTVALUE);
		bs.writeLog("PRODUCT_TYPE:" + PRODUCT_TYPE);
		bs.writeLog("SHAPE:" + SHAPE);
		bs.writeLog("FACTORY:" + FACTORY);
		bs.writeLog("SHAPE_FAST:" + SHAPE_FAST);
		bs.writeLog("PRODUCT_TYPE_FAST:" + PRODUCT_TYPE_FAST);
		bs.writeLog("CUST_FAST:" + CUST_FAST);
		bs.writeLog("TRADE_WAY_FAST:" + TRADE_WAY_FAST);
		bs.writeLog("WIRE_BOND_FAST:" + WIRE_BOND_FAST);
		bs.writeLog("WIRE_DIAM_FAST:" + WIRE_DIAM_FAST);
		bs.writeLog("SILK_FAST:" + SILK_FAST);
		bs.writeLog("GRIND_FAST:" + GRIND_FAST);
		bs.writeLog("CHIP_NUM_FAST:" + CHIP_NUM_FAST);
		bs.writeLog("CHIP_X_FAST:" + CHIP_X_FAST);
		bs.writeLog("CHIP_Y_FAST:" + CHIP_Y_FAST);
		bs.writeLog("MAT_FAST:" + MAT_FAST);
		bs.writeLog("FORM_FAST:" + FORM_FAST);
		bs.writeLog("GRADE_FAST:" + GRADE_FAST);
		bs.writeLog("TAPING_FAST:" + TAPING_FAST);
		bs.writeLog("FRAMEWORK_TECH_FAST:" + FRAMEWORK_TECH_FAST);
		bs.writeLog("ENCAPSULA_MAT_FAST:" + ENCAPSULA_MAT_FAST);
		bs.writeLog("OTHER_FAST:" + OTHER_FAST);
		bs.writeLog("TEST_MODELS_FAST:" + TEST_MODELS_FAST);
		bs.writeLog("HANDER_FAST:" + HANDER_FAST);
		bs.writeLog("TEST_QUOTATION_WAY_FAST:" + TEST_QUOTATION_WAY_FAST);
		bs.writeLog("TEST_SITE_FOR_FAST:" + TEST_SITE_FOR_FAST);
		bs.writeLog("TEST_OF_TIME_FAST:" + TEST_OF_TIME_FAST);
		bs.writeLog("UPH_FORMULA_FAST:" + UPH_FORMULA_FAST);
		bs.writeLog("UPH_FAST:" + UPH_FAST);
		bs.writeLog("CURRENCY:" + CURRENCY);

		String mainid = "";
		sql = "select ID from formtable_main_" + formid + "  where requestid =" + rid;
		bs.writeLog("11111111111111");
		rs.executeSql(sql);
		while (rs.next()) {
			mainid = rs.getString("ID");
		}

		BigDecimal CHIP_X_A = new BigDecimal(CHIP_X_FAST);
		BigDecimal CHIP_Y_B = new BigDecimal(CHIP_Y_FAST);

		BigDecimal chipnumber_no = new BigDecimal(CHIP_NUM_FAST);
		sql = "select  NAME,DIE_SIZE_X,DIE_SIZE_Y  from MD_SD_QTTN_PKG where name = '" + SHAPE + "'";
		BigDecimal CHIP_X_C = new BigDecimal(0);
		BigDecimal CHIP_Y_D = new BigDecimal(0);
		rs.executeSql(sql);
		while (rs.next()) {
			CHIP_X_C = (rs.getString("DIE_SIZE_X") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("DIE_SIZE_X")));
			CHIP_Y_D = (rs.getString("DIE_SIZE_Y") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("DIE_SIZE_Y")));
		}
		// 规则
		BigDecimal base_grind = (CHIP_X_A.multiply(CHIP_Y_B)).divide(CHIP_X_C.multiply(CHIP_Y_D), 4,
				BigDecimal.ROUND_HALF_UP);// 磨片
		BigDecimal base_scrib = (CHIP_X_A.add(CHIP_Y_B)).divide(CHIP_X_C.add(CHIP_Y_D), 4, BigDecimal.ROUND_HALF_UP);// 划片
		BigDecimal base_Load = (CHIP_X_A.multiply(CHIP_Y_B)).divide(CHIP_X_C.multiply(CHIP_Y_D), 4,
				BigDecimal.ROUND_HALF_UP);// 装片
		bs.writeLog("base_grind" + base_grind + "  base_scrib" + base_scrib + "   base_Load" + base_Load);
		// 划片标准成本
		BigDecimal scrib_1 = new BigDecimal(0);
		BigDecimal scrib_2 = new BigDecimal(0);
		BigDecimal scrib_3 = new BigDecimal(0);
		BigDecimal scrib_4 = new BigDecimal(0);
		BigDecimal scrib_5 = new BigDecimal(0);
		BigDecimal scrib_6 = new BigDecimal(0);
		BigDecimal scrib_7 = new BigDecimal(0);

		sql = "SELECT  a.QTTN_PKG_FK,C.FULL_NAME,b.name,MATERIAL,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,(MATERIAL+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) AS TOTAL FROM MD_SD_COST_DIE a left join MD_SD_MOUNTING_MTRL_SPEC b on A.MTRL_SPEC=B.ID left join MD_SD_COST_DIE_CAT c on A.COST_DIE_CAT_FK =C.ID   where QTTN_PKG_FK = '"
				+ SHAPE + "' AND C.FULL_NAME ='划片' ";
		rs.executeSql(sql);
		bs.writeLog("sql划片标准成本" + sql);
		while (rs.next()) {
			scrib_1 = (rs.getString("MATERIAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIAL")));
			scrib_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MAINTENANCE_COST")));
			scrib_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
			scrib_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
			scrib_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
			scrib_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
			scrib_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));
			bs.writeLog(" 划片标准 材料  scrib_1： " + scrib_1);
			bs.writeLog(" 划片标准 维修  scrib_2： " + scrib_2);
			bs.writeLog(" 划片标准 人工  scrib_3： " + scrib_3);
			bs.writeLog(" 划片标准 动力  scrib_4： " + scrib_4);
			bs.writeLog(" 划片标准 折旧  scrib_5： " + scrib_5);
			bs.writeLog(" 划片标准 其他  scrib_6： " + scrib_6);
			bs.writeLog(" 划片标准 total  scrib_7： " + scrib_7);
		}
		// 划片实际成本
		BigDecimal scrib_actual_1 = new BigDecimal(0);
		BigDecimal scrib_actual_2 = new BigDecimal(0);
		BigDecimal scrib_actual_3 = new BigDecimal(0);
		BigDecimal scrib_actual_4 = new BigDecimal(0);
		BigDecimal scrib_actual_5 = new BigDecimal(0);
		BigDecimal scrib_actual_6 = new BigDecimal(0);
		BigDecimal scrib_actual_7 = new BigDecimal(0);

		if (!PRODUCT_TYPE.equals("TO")) {
			scrib_actual_1 = scrib_1.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_2 = scrib_2.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_3 = scrib_3.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_4 = scrib_4.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_5 = scrib_5.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_6 = scrib_6.multiply(base_scrib).multiply(chipnumber_no);
			scrib_actual_7 = scrib_7.multiply(base_scrib).multiply(chipnumber_no);
		}

		bs.writeLog(" 划片实际 材料  scrib_actual_1： " + scrib_actual_1);
		bs.writeLog(" 划片实际 维修  scrib_actual_2： " + scrib_actual_2);
		bs.writeLog(" 划片实际 人工  scrib_actual_3： " + scrib_actual_3);
		bs.writeLog(" 划片实际 动力  scrib_actual_4： " + scrib_actual_4);
		bs.writeLog(" 划片实际 折旧  scrib_actual_5： " + scrib_actual_5);
		bs.writeLog(" 划片实际 其他  scrib_actual_6： " + scrib_actual_6);
		bs.writeLog(" 划片实际 total  scrib_actual_7： " + scrib_actual_7);

		// 磨片标准成本
		BigDecimal grind_1 = new BigDecimal(0);
		BigDecimal grind_2 = new BigDecimal(0);
		BigDecimal grind_3 = new BigDecimal(0);
		BigDecimal grind_4 = new BigDecimal(0);
		BigDecimal grind_5 = new BigDecimal(0);
		BigDecimal grind_6 = new BigDecimal(0);
		BigDecimal grind_7 = new BigDecimal(0);
		// 磨片实际成本
		BigDecimal grind_actual_1 = new BigDecimal(0);
		BigDecimal grind_actual_2 = new BigDecimal(0);
		BigDecimal grind_actual_3 = new BigDecimal(0);
		BigDecimal grind_actual_4 = new BigDecimal(0);
		BigDecimal grind_actual_5 = new BigDecimal(0);
		BigDecimal grind_actual_6 = new BigDecimal(0);
		BigDecimal grind_actual_7 = new BigDecimal(0);

		bs.writeLog(GRIND_FAST);
		if (Integer.parseInt(GRIND_FAST) == 0) {
			sql = "SELECT  a.QTTN_PKG_FK,C.FULL_NAME,b.name,MATERIAL,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,(MATERIAL+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) AS TOTAL FROM MD_SD_COST_DIE a left join MD_SD_MOUNTING_MTRL_SPEC b on A.MTRL_SPEC=B.ID left join MD_SD_COST_DIE_CAT c on A.COST_DIE_CAT_FK =C.ID   where QTTN_PKG_FK = '"
					+ SHAPE + "' AND C.FULL_NAME ='磨片' ";
			rs.executeSql(sql);
			bs.writeLog("sql磨片标准成本" + sql);
			while (rs.next()) {
				grind_1 = (rs.getString("MATERIAL") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("MATERIAL")));
				grind_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("MAINTENANCE_COST")));
				grind_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
				grind_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
				grind_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				grind_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
				grind_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));

				bs.writeLog(" 磨片标准 材料  grind_1： " + grind_1);
				bs.writeLog(" 磨片标准 维修  grind_2： " + grind_2);
				bs.writeLog(" 磨片标准 人工  grind_3： " + grind_3);
				bs.writeLog(" 磨片标准 动力  grind_4： " + grind_4);
				bs.writeLog(" 磨片标准 折旧  grind_5： " + grind_5);
				bs.writeLog(" 磨片标准 其他  grind_6： " + grind_6);
				bs.writeLog(" 磨片标准 total  grind_7： " + grind_7);
			}
			if (!PRODUCT_TYPE.equals("TO")) {
				grind_actual_1 = grind_1.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_2 = grind_2.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_3 = grind_3.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_4 = grind_4.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_5 = grind_5.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_6 = grind_6.multiply(base_grind).multiply(chipnumber_no);
				grind_actual_7 = grind_7.multiply(base_grind).multiply(chipnumber_no);
			}
		}

		bs.writeLog(" 磨片实际 材料  grind_actual_1： " + grind_actual_1);
		bs.writeLog(" 磨片实际 维修  grind_actual_2： " + grind_actual_2);
		bs.writeLog(" 磨片实际 人工  grind_actual_3： " + grind_actual_3);
		bs.writeLog(" 磨片实际 动力  grind_actual_4： " + grind_actual_4);
		bs.writeLog(" 磨片实际 折旧  grind_actual_5： " + grind_actual_5);
		bs.writeLog(" 磨片实际 其他  grind_actual_6： " + grind_actual_6);
		bs.writeLog(" 磨片实际 total  grind_actual_7： " + grind_actual_7);

		// 装片标准成本
		BigDecimal Load_1 = new BigDecimal(0);
		BigDecimal Load_2 = new BigDecimal(0);
		BigDecimal Load_3 = new BigDecimal(0);
		BigDecimal Load_4 = new BigDecimal(0);
		BigDecimal Load_5 = new BigDecimal(0);
		BigDecimal Load_6 = new BigDecimal(0);
		BigDecimal Load_7 = new BigDecimal(0);

		sql = "SELECT  a.QTTN_PKG_FK,C.FULL_NAME,b.name,MATERIAL,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,(MATERIAL+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) AS TOTAL FROM MD_SD_COST_DIE a left join MD_SD_MOUNTING_MTRL_SPEC b on A.MTRL_SPEC=B.ID left join MD_SD_COST_DIE_CAT c on A.COST_DIE_CAT_FK =C.ID   where QTTN_PKG_FK = '"
				+ SHAPE + "' AND C.FULL_NAME ='装片' and replace(b.name,' ','') ='" + MAT_FAST + "'";
		bs.writeLog("sql装片标准成本" + sql);
		rs.executeSql(sql);
		while (rs.next()) {
			Load_1 = (rs.getString("MATERIAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("MATERIAL")));
			Load_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MAINTENANCE_COST")));
			Load_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
			Load_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
			Load_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
			Load_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
			Load_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));

			bs.writeLog(" 装片标准成本 材料  Load_1： " + Load_1);
			bs.writeLog(" 装片标准成本 维修  Load_2： " + Load_2);
			bs.writeLog(" 装片标准成本 人工  Load_3： " + Load_3);
			bs.writeLog(" 装片标准成本 动力  Load_4： " + Load_4);
			bs.writeLog(" 装片标准成本 折旧  Load_5： " + Load_5);
			bs.writeLog(" 装片标准成本 其他  Load_6： " + Load_6);
			bs.writeLog(" 装片标准成本 total  Load_7： " + Load_7);
		}
		// 装片实际成本
		BigDecimal Load_actual_1 = new BigDecimal(0);
		BigDecimal Load_actual_2 = new BigDecimal(0);
		BigDecimal Load_actual_3 = new BigDecimal(0);
		BigDecimal Load_actual_4 = new BigDecimal(0);
		BigDecimal Load_actual_5 = new BigDecimal(0);
		BigDecimal Load_actual_6 = new BigDecimal(0);
		BigDecimal Load_actual_7 = new BigDecimal(0);

		if (!PRODUCT_TYPE.equals("TO")) {
			Load_actual_1 = Load_1.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_2 = Load_2.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_3 = Load_3.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_4 = Load_4.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_5 = Load_5.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_6 = Load_6.multiply(base_Load).multiply(chipnumber_no);
			Load_actual_7 = Load_7.multiply(base_Load).multiply(chipnumber_no);
		}

		bs.writeLog(" 装片实际成本 材料  Load_actual_1： " + Load_actual_1);
		bs.writeLog(" 装片实际成本 维修  Load_actual_2： " + Load_actual_2);
		bs.writeLog(" 装片实际成本 人工  Load_actual_3： " + Load_actual_3);
		bs.writeLog(" 装片实际成本 动力  Load_actual_4： " + Load_actual_4);
		bs.writeLog(" 装片实际成本 折旧  Load_actual_5： " + Load_actual_5);
		bs.writeLog(" 装片实际成本 其他  Load_actual_6： " + Load_actual_6);
		bs.writeLog(" 装片实际成本 total  Load_actual_7： " + Load_actual_7);

		// 芯片实际成本

		// 装片其他费用
		BigDecimal Load_other_2 = new BigDecimal(0);
		BigDecimal Load_other_3 = new BigDecimal(0);
		BigDecimal Load_other_4 = new BigDecimal(0);
		BigDecimal Load_other_5 = new BigDecimal(0);
		BigDecimal Load_other_6 = new BigDecimal(0);
		BigDecimal Load_other_7 = new BigDecimal(0);

		sql = "select a.QTTN_PKG_FK,b.name,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,(MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) AS TOTAL  from MD_SD_FRM_PKG a left join MD_SD_FRAME b on A.FRAME_FK = b.id where QTTN_PKG_FK ='"
				+ SHAPE + "'";
		bs.writeLog("sql装片其他费用" + sql);
		rs.executeSql(sql);
		while (rs.next()) {
			Load_other_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MAINTENANCE_COST")));
			Load_other_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
			Load_other_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
			Load_other_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
			Load_other_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
			Load_other_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));

			bs.writeLog(" 装片其他标准 维修  Load_other_2： " + Load_other_2);
			bs.writeLog(" 装片其他标准 人工  Load_other_3： " + Load_other_3);
			bs.writeLog(" 装片其他标准 动力  Load_other_4： " + Load_other_4);
			bs.writeLog(" 装片其他标准 折旧  Load_other_5： " + Load_other_5);
			bs.writeLog(" 装片其他标准 其他  Load_other_6： " + Load_other_6);
			bs.writeLog(" 装片其他标准 total  Load_other_7： " + Load_other_7);
		}
		BigDecimal Load_other_true_2 = new BigDecimal(0);
		BigDecimal Load_other_true_3 = new BigDecimal(0);
		BigDecimal Load_other_true_4 = new BigDecimal(0);
		BigDecimal Load_other_true_5 = new BigDecimal(0);
		BigDecimal Load_other_true_6 = new BigDecimal(0);
		BigDecimal Load_other_true_7 = new BigDecimal(0);

		if (!PRODUCT_TYPE.equals("TO")) {
			Load_other_true_2 = Load_other_2.multiply(chipnumber_no);
			Load_other_true_3 = Load_other_3.multiply(chipnumber_no);
			Load_other_true_4 = Load_other_4.multiply(chipnumber_no);
			Load_other_true_5 = Load_other_5.multiply(chipnumber_no);
			Load_other_true_6 = Load_other_6.multiply(chipnumber_no);
			Load_other_true_7 = Load_other_7.multiply(chipnumber_no);
		}

		bs.writeLog(" 装片其他实际 维修  Load_other_true_2： " + Load_other_true_2);
		bs.writeLog(" 装片其他实际 人工  Load_other_true_3： " + Load_other_true_3);
		bs.writeLog(" 装片其他实际 动力  Load_other_true_4： " + Load_other_true_4);
		bs.writeLog(" 装片其他实际 折旧  Load_other_true_5： " + Load_other_true_5);
		bs.writeLog(" 装片其他实际 其他  Load_other_true_6： " + Load_other_true_6);
		bs.writeLog(" 装片其他实际 total  Load_other_true_7： " + Load_other_true_7);

		// 成本1 = 装片+磨片+划片
		BigDecimal cost_of_one = scrib_actual_7.add(grind_actual_7).add(Load_actual_7);

		bs.writeLog(" 成本1   cost_of_one" + cost_of_one);

		// 成本2 = 装片其他费用
		BigDecimal cost_of_two = Load_other_true_7;

		bs.writeLog(" 成本2   cost_of_two" + cost_of_two);

		// 键合费用
		// 单价设定
		BigDecimal current_price_bonding = new BigDecimal(0);
		BigDecimal price_step_bonding = new BigDecimal(0);
		BigDecimal price_diff_bonding = new BigDecimal(0);

		sql = "select A.PIRCE,a.PIRCE_STEP,a.PIRCE_DIFF from MD_SD_WIRE_UNIT_PIRCE a left join md_sd_wire b on A.WIRE_FK=B.ID left join MD_SD_WIRE_DIAM c on A.WIRE_DIAM_FK =c.id where b.name ='"
				+ WIRE_BOND_FAST + "'  and c.full_name = '" + WIRE_DIAM_FAST + "UM'";
		rs.executeSql(sql);
		bs.writeLog("sql键合费用单价设定" + sql);
		while (rs.next()) {
			current_price_bonding = (rs.getString("PIRCE") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("PIRCE")));// 单价当前价格
			price_step_bonding = (rs.getString("PIRCE_STEP") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("PIRCE_STEP")));// 步长
			price_diff_bonding = (rs.getString("PIRCE_DIFF") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("PIRCE_DIFF")));// 价差

			bs.writeLog(" 单价当前价格   current_price_bonding： " + current_price_bonding);
			bs.writeLog(" 步长   price_step_bonding： " + price_step_bonding);
			bs.writeLog(" 价差   price_diff_bonding： " + price_diff_bonding);
		}
		//// 键合丝种类设置 取值
		BigDecimal current_price_category = new BigDecimal(0);
		BigDecimal price_category = new BigDecimal(0);

		sql = "SELECT name,PIRCE,CURRENT_PIRCE FROM MD_SD_WIRE  where name = '" + WIRE_BOND_FAST + "'";
		rs.executeSql(sql);
		bs.writeLog("sql键合丝种类设置" + sql);
		while (rs.next()) {
			current_price_category = (rs.getString("CURRENT_PIRCE") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("CURRENT_PIRCE")));// 类别当前价格
			price_category = (rs.getString("PIRCE") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("PIRCE")));// 类别价格

			bs.writeLog(" 类别当前价格   current_price_category : " + current_price_category);
			bs.writeLog(" 类别价格   price_category : " + price_category);
		}
		// 外形键丝设定 取值 单丝长度 标准丝数
		BigDecimal wire_length = new BigDecimal(0);
		BigDecimal wire_qty = new BigDecimal(0);

		sql = "select  ID,name,WIRE_LENGTH,WIRE_QTY from MD_SD_QTTN_PKG where id='" + SHAPE + "'";
		bs.writeLog("sql外形键丝设定   取值 单丝长度 标准丝数" + sql);
		rs.executeSql(sql);
		while (rs.next()) {
			wire_length = (rs.getString("WIRE_LENGTH") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("WIRE_LENGTH")));// 单丝长度
			wire_qty = (rs.getString("WIRE_QTY") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("WIRE_QTY")));// 标准丝数

			bs.writeLog(" 单丝长度   wire_length : " + wire_length);
			bs.writeLog("标准丝数 wire_qty :" + wire_qty);
		}
		// 键合材料成本
		BigDecimal silk_standard = new BigDecimal(SILK_FAST);// 丝数

		bs.writeLog("丝数 silk_standard :" + silk_standard);

		BigDecimal bonding_mat_cost = new BigDecimal(0);
		if (!PRODUCT_TYPE.equals("TO")) {
			bonding_mat_cost = current_price_bonding
					.add((current_price_category.subtract(price_category))
							.divide(price_step_bonding, 4, BigDecimal.ROUND_HALF_UP).multiply(price_diff_bonding))
					.multiply(wire_length).multiply(silk_standard);
		}

		bs.writeLog("键合材料成本 bonding_mat_cost :" + bonding_mat_cost);

		// 键合标准工费
		BigDecimal bonded_labour_fee_1 = new BigDecimal(0);
		BigDecimal bonded_labour_fee_2 = new BigDecimal(0);
		BigDecimal bonded_labour_fee_3 = new BigDecimal(0);
		BigDecimal bonded_labour_fee_4 = new BigDecimal(0);
		BigDecimal bonded_labour_fee_5 = new BigDecimal(0);
		BigDecimal bonded_labour_fee_6 = new BigDecimal(0);
		BigDecimal bonded_labour_fee_7 = new BigDecimal(0);

		sql = "select b.name,a.QTTN_PKG_FK,MTRL_COST,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER,(MTRL_COST+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_COST_WIRE a left join md_sd_wire b on A.WIRE_FK =B.ID where QTTN_PKG_FK ='"
				+ SHAPE + "' and name='" + WIRE_BOND_FAST + "'";
		bs.writeLog("sql键合标准工费" + sql);
		rs.executeSql(sql);
		while (rs.next()) {

			bonded_labour_fee_1 = (rs.getString("MTRL_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MTRL_COST")));
			bonded_labour_fee_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MAINTENANCE_COST")));
			bonded_labour_fee_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("LABOUR")));
			bonded_labour_fee_4 = (rs.getString("POWER") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("POWER")));
			bonded_labour_fee_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("DEPR")));
			bonded_labour_fee_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("OTHER")));
			bonded_labour_fee_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("TOTAL")));

			bs.writeLog(" 键合标准工费 材料  bonded_labour_fee_1 : " + bonded_labour_fee_1);
			bs.writeLog(" 键合标准工费 维修  bonded_labour_fee_2 : " + bonded_labour_fee_2);
			bs.writeLog(" 键合标准工费 人工  bonded_labour_fee_3 : " + bonded_labour_fee_3);
			bs.writeLog(" 键合标准工费 动力  bonded_labour_fee_4 : " + bonded_labour_fee_4);
			bs.writeLog(" 键合标准工费 折旧  bonded_labour_fee_5 : " + bonded_labour_fee_5);
			bs.writeLog(" 键合标准工费 其他  bonded_labour_fee_6 : " + bonded_labour_fee_6);
			bs.writeLog(" 键合标准工费 total  bonded_labour_fee_7 : " + bonded_labour_fee_7);

		}
		// 键合实际工费

		BigDecimal bonded_labour_true_1 = new BigDecimal(0);
		BigDecimal bonded_labour_true_2 = new BigDecimal(0);
		BigDecimal bonded_labour_true_3 = new BigDecimal(0);
		BigDecimal bonded_labour_true_4 = new BigDecimal(0);
		BigDecimal bonded_labour_true_5 = new BigDecimal(0);
		BigDecimal bonded_labour_true_6 = new BigDecimal(0);
		BigDecimal bonded_labour_true_7 = new BigDecimal(0);

		if (!PRODUCT_TYPE.equals("TO")) {
			bonded_labour_true_1 = bonded_labour_fee_1.divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
					.multiply(silk_standard);
			bonded_labour_true_2 = bonded_labour_fee_2.divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
					.multiply(silk_standard);
			bonded_labour_true_3 = bonded_labour_fee_3.divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
					.multiply(silk_standard);
			bonded_labour_true_4 = bonded_labour_fee_4.divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
					.multiply(silk_standard);
			bonded_labour_true_5 = bonded_labour_fee_5.divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
					.multiply(silk_standard);
			bonded_labour_true_6 = bonded_labour_fee_6.divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
					.multiply(silk_standard);
			bonded_labour_true_7 = bonded_labour_fee_7.divide(wire_qty, 4, BigDecimal.ROUND_HALF_UP)
					.multiply(silk_standard);
		}

		bs.writeLog(" 键合实际工费 材料  bonded_labour_true_1 : " + bonded_labour_true_1);
		bs.writeLog(" 键合实际工费 维修  bonded_labour_true_2 : " + bonded_labour_true_2);
		bs.writeLog(" 键合标准工费 人工  bonded_labour_true_3 : " + bonded_labour_true_3);
		bs.writeLog(" 键合标准工费 动力  bonded_labour_true_4 : " + bonded_labour_true_4);
		bs.writeLog(" 键合标准工费 折旧  bonded_labour_true_5 : " + bonded_labour_true_5);
		bs.writeLog(" 键合标准工费 其他  bonded_labour_true_6 : " + bonded_labour_true_6);
		bs.writeLog(" 键合标准工费 total  bonded_labour_true_7 : " + bonded_labour_true_7);

		// 键合成本
		BigDecimal bonding_cost = bonding_mat_cost.add(bonded_labour_true_7);

		bs.writeLog(" 键合成本 total  bonding_cost " + bonding_cost);

		// 销售方式材料价格影响系数
		sql = "select b.FULL_NAME,A.RATE,C.NAME from MD_SD_TRDTYP_MTRL_COST_RATE a left join MD_TRADE_TYPE b on A.TRADE_TYPE_FK =b.id left join MD_SD_COST_ELEMENT c on A.COST_ELEMENT_FK =C.ID  where  b.FULL_NAME = '"
				+ TRADEWAY + "'";
		BigDecimal rate_emat = new BigDecimal(1);// 塑封料 系数
		BigDecimal rate_ftech = new BigDecimal(1);// 框架工艺 系数
		rs.executeSql(sql);
		while (rs.next()) {
			String NAME = rs.getString("NAME");
			if (NAME.equals("塑封料")) {
				rate_emat = (rs.getString("RATE") == "" ? new BigDecimal(1) : new BigDecimal(rs.getString("RATE")));
			} else if (NAME.equals("框架工艺")) {
				rate_ftech = (rs.getString("RATE") == "" ? new BigDecimal(1) : new BigDecimal(rs.getString("RATE")));
			}

			bs.writeLog("sql NAME" + NAME);
			bs.writeLog("sql框架工艺系数: " + rate_emat);
			bs.writeLog("sql框架工艺系数: " + rate_ftech);
		}

		// 组装其他费用
		// 框架工艺
		BigDecimal frametechnology_fees_1 = new BigDecimal(0);
		BigDecimal frametechnology_fees_2 = new BigDecimal(0);
		BigDecimal frametechnology_fees_3 = new BigDecimal(0);
		BigDecimal frametechnology_fees_4 = new BigDecimal(0);
		BigDecimal frametechnology_fees_5 = new BigDecimal(0);
		BigDecimal frametechnology_fees_6 = new BigDecimal(0);
		BigDecimal frametechnology_fees_7 = new BigDecimal(0);

		sql = "select b.name,B.QTTN_PKG_FK,A.FULL_NAME,A.NAME,A.SORT,A.CURRENCY_FK, MATERIALCOST,MAINTENANCE_COST,UC,LABOUR,POWER,DEPR,OTHER,(MATERIALCOST+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_COST_ASSY_OTHER_OPTION a left join  MD_SD_COST_ASSY_OTHER b on a.COST_ASSY_OTHER_FK =b.id where QTTN_PKG_FK ='"
				+ SHAPE + "'  and replace(replace(a.full_name,('||'),''),' ','') ='" + FRAMEWORK_TECH_FAST + "'";
		bs.writeLog("sql框架工艺" + sql);
		rs.executeSql(sql);
		while (rs.next()) {
			frametechnology_fees_1 = (rs.getString("MATERIALCOST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MATERIALCOST")));
			frametechnology_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MAINTENANCE_COST")));
			frametechnology_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("LABOUR")));
			frametechnology_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("POWER")));
			frametechnology_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("DEPR")));
			frametechnology_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("OTHER")));
			frametechnology_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("TOTAL")));

			bs.writeLog(" 框架工艺 材料  frametechnology_fees_1 : " + frametechnology_fees_1);
			bs.writeLog(" 框架工艺 维修  frametechnology_fees_2 : " + frametechnology_fees_2);
			bs.writeLog(" 框架工艺 人工  frametechnology_fees_3 : " + frametechnology_fees_3);
			bs.writeLog(" 框架工艺 动力  frametechnology_fees_4 : " + frametechnology_fees_4);
			bs.writeLog(" 框架工艺 折旧  frametechnology_fees_5 : " + frametechnology_fees_5);
			bs.writeLog(" 框架工艺 其他  frametechnology_fees_6 : " + frametechnology_fees_6);
			bs.writeLog(" 框架工艺 total  frametechnology_fees_7 : " + frametechnology_fees_7);
		}
		BigDecimal frametechnology_ftech_true = new BigDecimal(0);

		if (!PRODUCT_TYPE.equals("TO")) {
			frametechnology_ftech_true = frametechnology_fees_1.multiply(rate_ftech);
		}

		bs.writeLog(" 框架工艺 材料 实际 frametechnology_ftech_true : " + frametechnology_ftech_true);

		BigDecimal frametechnology_fees_total = frametechnology_ftech_true.add(frametechnology_fees_2)
				.add(frametechnology_fees_3).add(frametechnology_fees_4).add(frametechnology_fees_5)
				.add(frametechnology_fees_6);

		bs.writeLog(" 框架工艺 总体  frametechnology_fees_total : " + frametechnology_fees_total);

		// 塑封料
		BigDecimal moldingcompound_fees_1 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_2 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_3 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_4 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_5 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_6 = new BigDecimal(0);
		BigDecimal moldingcompound_fees_7 = new BigDecimal(0);

		sql = "select b.name,B.QTTN_PKG_FK,A.FULL_NAME,A.NAME,A.SORT,A.CURRENCY_FK, MATERIALCOST,MAINTENANCE_COST,UC,LABOUR,POWER,DEPR,OTHER,(MATERIALCOST+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_COST_ASSY_OTHER_OPTION a left join  MD_SD_COST_ASSY_OTHER b on a.COST_ASSY_OTHER_FK =b.id where QTTN_PKG_FK ='"
				+ SHAPE + "'  and a.FULL_NAME ='" + ENCAPSULA_MAT_FAST + "'";
		rs.executeSql(sql);
		bs.writeLog("sql塑封料" + sql);
		while (rs.next()) {
			moldingcompound_fees_1 = (rs.getString("MATERIALCOST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MATERIALCOST")));
			moldingcompound_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MAINTENANCE_COST")));
			moldingcompound_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("LABOUR")));
			moldingcompound_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("POWER")));
			moldingcompound_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("DEPR")));
			moldingcompound_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("OTHER")));
			moldingcompound_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("TOTAL")));

			bs.writeLog(" 塑封料 材料  moldingcompound_fees_1 : " + moldingcompound_fees_1);
			bs.writeLog(" 塑封料 维修  moldingcompound_fees_2 : " + moldingcompound_fees_2);
			bs.writeLog(" 塑封料 人工  moldingcompound_fees_3 : " + moldingcompound_fees_3);
			bs.writeLog(" 塑封料 动力  moldingcompound_fees_4 : " + moldingcompound_fees_4);
			bs.writeLog(" 塑封料 折旧  moldingcompound_fees_5 : " + moldingcompound_fees_5);
			bs.writeLog(" 塑封料 其他  moldingcompound_fees_6 : " + moldingcompound_fees_6);
			bs.writeLog(" 塑封料 total  moldingcompound_fees_7 : " + moldingcompound_fees_7);

		}
		BigDecimal moldingcompound_mat_true = new BigDecimal(0);

		if (!PRODUCT_TYPE.equals("TO")) {
			moldingcompound_mat_true = moldingcompound_fees_1.multiply(rate_emat);
		}

		bs.writeLog(" 塑封料 材料 实际 moldingcompound_mat_true : " + moldingcompound_mat_true);

		BigDecimal moldingcompound_fees_total = moldingcompound_mat_true.add(moldingcompound_fees_2)
				.add(moldingcompound_fees_3).add(moldingcompound_fees_4).add(moldingcompound_fees_5)
				.add(moldingcompound_fees_6);

		bs.writeLog(" 塑封料 材料 实际 moldingcompound_mat_true : " + moldingcompound_mat_true);

		// 其他
		BigDecimal other_fees_1 = new BigDecimal(0);
		BigDecimal other_fees_2 = new BigDecimal(0);
		BigDecimal other_fees_3 = new BigDecimal(0);
		BigDecimal other_fees_4 = new BigDecimal(0);
		BigDecimal other_fees_5 = new BigDecimal(0);
		BigDecimal other_fees_6 = new BigDecimal(0);
		BigDecimal other_fees_7 = new BigDecimal(0);

		if (!PRODUCT_TYPE.equals("TO")) {
			sql = "select b.name,B.QTTN_PKG_FK,A.FULL_NAME,A.NAME,A.SORT,A.CURRENCY_FK, MATERIALCOST,MAINTENANCE_COST,UC,LABOUR,POWER,DEPR,OTHER,(MATERIALCOST+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_COST_ASSY_OTHER_OPTION a left join  MD_SD_COST_ASSY_OTHER b on a.COST_ASSY_OTHER_FK =b.id where QTTN_PKG_FK ='"
					+ SHAPE + "'  and a.NAME ='" + OTHER_FAST + "'";
			bs.writeLog("sql其他" + sql);
			rs.executeSql(sql);
			while (rs.next()) {
				other_fees_1 = (rs.getString("MATERIALCOST") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("MATERIALCOST")));
				other_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("MAINTENANCE_COST")));
				other_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("LABOUR")));
				other_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("POWER")));
				other_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				other_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("OTHER")));
				other_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("TOTAL")));
			}
		}
		bs.writeLog(" 其他 材料  other_fees_1 : " + other_fees_1);
		bs.writeLog(" 其他 维修  other_fees_2 : " + other_fees_2);
		bs.writeLog(" 其他 人工  other_fees_3 : " + other_fees_3);
		bs.writeLog(" 其他 动力  other_fees_4 : " + other_fees_4);
		bs.writeLog(" 其他 折旧  other_fees_5 : " + other_fees_5);
		bs.writeLog(" 其他 其他  other_fees_6 : " + other_fees_6);
		bs.writeLog(" 其他 total  other_fees_7 : " + other_fees_7);

		// 打印
		BigDecimal print_fees_1 = new BigDecimal(0);
		BigDecimal print_fees_2 = new BigDecimal(0);
		BigDecimal print_fees_3 = new BigDecimal(0);
		BigDecimal print_fees_4 = new BigDecimal(0);
		BigDecimal print_fees_5 = new BigDecimal(0);
		BigDecimal print_fees_6 = new BigDecimal(0);
		BigDecimal print_fees_7 = new BigDecimal(0);

		if (!PRODUCT_TYPE.equals("TO")) {
			sql = "select b.name,B.QTTN_PKG_FK,A.FULL_NAME,A.NAME,A.SORT,A.CURRENCY_FK, MATERIALCOST,MAINTENANCE_COST,UC,LABOUR,POWER,DEPR,OTHER,(MATERIALCOST+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_COST_ASSY_OTHER_OPTION a left join  MD_SD_COST_ASSY_OTHER b on a.COST_ASSY_OTHER_FK =b.id where QTTN_PKG_FK ='"
					+ SHAPE + "'  and a.NAME ='打印'";
			bs.writeLog("sql打印" + sql);
			rs.executeSql(sql);
			while (rs.next()) {
				print_fees_1 = (rs.getString("MATERIALCOST") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("MATERIALCOST")));
				print_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("MAINTENANCE_COST")));
				print_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("LABOUR")));
				print_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("POWER")));
				print_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
				print_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("OTHER")));
				print_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0)
						: new BigDecimal(rs.getString("TOTAL")));
			}
		}
		bs.writeLog(" 打印 材料  print_fees_1 : " + print_fees_1);
		bs.writeLog(" 打印 维修  print_fees_2 : " + print_fees_2);
		bs.writeLog(" 打印 人工  print_fees_3 : " + print_fees_3);
		bs.writeLog(" 打印 动力  print_fees_4 : " + print_fees_4);
		bs.writeLog(" 打印 折旧  print_fees_5 : " + print_fees_5);
		bs.writeLog(" 打印 其他  print_fees_6 : " + print_fees_6);
		bs.writeLog(" 打印 total  print_fees_7 : " + print_fees_7);

		// 组装 各项金额
		// 主材
		BigDecimal assembly_adv_mat = bonding_mat_cost.add(frametechnology_ftech_true).add(moldingcompound_mat_true)
				.add(Load_actual_1);
		// 材料合计
		BigDecimal assembly_mat_cost = scrib_actual_1.add(grind_actual_1).add(Load_actual_1).add(bonding_mat_cost)
				.add(bonded_labour_true_1).add(frametechnology_ftech_true).add(moldingcompound_mat_true)
				.add(other_fees_1);
		// 其他材料
		BigDecimal assembly_oth_mat = assembly_mat_cost.subtract(assembly_adv_mat);
		// 组装维修费用
		BigDecimal assembly_maintenance_cost = scrib_actual_2.add(grind_actual_2).add(Load_actual_2)
				.add(Load_other_true_2).add(bonded_labour_true_2).add(frametechnology_fees_2)
				.add(moldingcompound_fees_2).add(other_fees_2).add(print_fees_2);
		// 组装人工费用
		BigDecimal assembly_labour_cost = scrib_actual_3.add(grind_actual_3).add(Load_actual_3).add(Load_other_true_3)
				.add(bonded_labour_true_3).add(frametechnology_fees_3).add(moldingcompound_fees_3).add(other_fees_3)
				.add(print_fees_3);
		// 组装动力费用
		BigDecimal assembly_power_cost = scrib_actual_4.add(grind_actual_4).add(Load_actual_4).add(Load_other_true_4)
				.add(bonded_labour_true_4).add(frametechnology_fees_4).add(moldingcompound_fees_4).add(other_fees_4)
				.add(print_fees_4);
		// 组装折旧费用
		BigDecimal assembly_depr_cost = scrib_actual_5.add(grind_actual_5).add(Load_actual_5).add(Load_other_true_5)
				.add(bonded_labour_true_5).add(frametechnology_fees_5).add(moldingcompound_fees_5).add(other_fees_5)
				.add(print_fees_5);
		// 组装其他费用
		BigDecimal assembly_other_cost = scrib_actual_6.add(grind_actual_6).add(Load_actual_6).add(Load_other_true_6)
				.add(bonded_labour_true_6).add(frametechnology_fees_6).add(moldingcompound_fees_6).add(other_fees_6)
				.add(print_fees_6);
		// 组装总成本
		BigDecimal assembly_total_cost2 = scrib_actual_7.add(grind_actual_7).add(Load_actual_7).add(Load_other_true_7)
				.add(bonding_mat_cost).add(bonded_labour_true_7).add(frametechnology_fees_total)
				.add(moldingcompound_fees_total).add(other_fees_7).add(print_fees_7);
		// 组装总成本 (算法二)
		BigDecimal assembly_total_cost = assembly_mat_cost.add(assembly_maintenance_cost).add(assembly_labour_cost)
				.add(assembly_power_cost).add(assembly_depr_cost).add(assembly_other_cost);

		bs.writeLog(" 组装     主材 assembly_adv_mat ：" + assembly_adv_mat);
		bs.writeLog(" 其他     材料 assembly_oth_mat ：" + assembly_oth_mat);
		bs.writeLog(" 组装总 材料  assembly_mat_cost : " + assembly_mat_cost);
		bs.writeLog(" 组装总 维修  assembly_maintenance_cost : " + assembly_maintenance_cost);
		bs.writeLog(" 组装总 人工  assembly_labour_cost : " + assembly_labour_cost);
		bs.writeLog(" 组装总 动力  assembly_power_cost : " + assembly_power_cost);
		bs.writeLog(" 组装总 折旧  assembly_depr_cost : " + assembly_depr_cost);
		bs.writeLog(" 组装总 其他  assembly_other_cost : " + assembly_other_cost);
		bs.writeLog(" 组装总 total  assembly_total_cost : " + assembly_total_cost);
		bs.writeLog(" 组装总 total  assembly_total_cost2 : " + assembly_total_cost2);

		// sql ="update formtable_main_141 set Adv_mat_assy
		// ='"+assembly_adv_mat+"',Oth_mat_assy='"+assembly_oth_mat+"',Mat_com_assy='"+assembly_mat_cost+"',artifi_assy='"+assembly_labour_cost+"',power_assy='"+assembly_power_cost+"',deprect_assy='"+assembly_depr_cost+"',maintain_assy='"+assembly_maintenance_cost+"',other_assy='"+assembly_other_cost+"',thou_tal_cost_assy
		// ='"+assembly_total_cost+"' where requestid ='"+rid+"'";
		// rs.executeSql(sql);
		// bs.writeLog("更新组装成本"+sql);
		// 测试费用
		// 测试机 费用
		BigDecimal testing_machine_cost_2 = new BigDecimal(0);
		BigDecimal testing_machine_cost_3 = new BigDecimal(0);
		BigDecimal testing_machine_cost_4 = new BigDecimal(0);
		BigDecimal testing_machine_cost_5 = new BigDecimal(0);
		BigDecimal testing_machine_cost_6 = new BigDecimal(0);
		BigDecimal testing_machine_cost_7 = new BigDecimal(0);

		sql = "select MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER ,(MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER) as TOTAL from MD_SD_TESTER_COST a left join MD_TESTER b on A.TESTER_FK =B.ID where b.name ='"
				+ TEST_MODELS_FAST + "'";
		rs.executeSql(sql);
		bs.writeLog("sql测试机 费用" + sql);
		while (rs.next()) {

			testing_machine_cost_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MAINTENANCE_COST")));
			testing_machine_cost_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("LABOUR")));
			testing_machine_cost_4 = (rs.getString("POWER") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("POWER")));
			testing_machine_cost_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("DEPR")));
			testing_machine_cost_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("OTHER")));
			testing_machine_cost_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("TOTAL")));

			bs.writeLog(" 测试机 维修  testing_machine_cost_2 : " + testing_machine_cost_2);
			bs.writeLog(" 测试机 人工  testing_machine_cost_3 : " + testing_machine_cost_3);
			bs.writeLog(" 测试机 动力  testing_machine_cost_4 : " + testing_machine_cost_4);
			bs.writeLog(" 测试机 折旧  testing_machine_cost_5 : " + testing_machine_cost_5);
			bs.writeLog(" 测试机 其他  testing_machine_cost_6 : " + testing_machine_cost_6);
			bs.writeLog(" 测试机 total  testing_machine_cost_7 : " + testing_machine_cost_7);

		}

		// 机械手 费用
		BigDecimal hander_machine_cost_2 = new BigDecimal(0);
		BigDecimal hander_machine_cost_3 = new BigDecimal(0);
		BigDecimal hander_machine_cost_4 = new BigDecimal(0);
		BigDecimal hander_machine_cost_5 = new BigDecimal(0);
		BigDecimal hander_machine_cost_6 = new BigDecimal(0);
		BigDecimal hander_machine_cost_7 = new BigDecimal(0);
		BigDecimal index_time = new BigDecimal(0);

		sql = "select A.INDEX_TIME,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER ,(MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER)  as TOTAL  from MD_SD_HANDLER_COST a left join MD_HANDLER b on A.HANDLER_FK=B.ID where b.name ='"
				+ HANDER_FAST + "'";
		rs.executeSql(sql);
		bs.writeLog("sql机械手 费用" + sql);
		while (rs.next()) {

			hander_machine_cost_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MAINTENANCE_COST")));
			hander_machine_cost_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("LABOUR")));
			hander_machine_cost_4 = (rs.getString("POWER") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("POWER")));
			hander_machine_cost_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("DEPR")));
			hander_machine_cost_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("OTHER")));
			hander_machine_cost_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("TOTAL")));
			index_time = (rs.getString("INDEX_TIME") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("INDEX_TIME")));

			bs.writeLog(" 机械手 维修  hander_machine_cost_2 : " + hander_machine_cost_2);
			bs.writeLog(" 机械手 人工  hander_machine_cost_3 : " + hander_machine_cost_3);
			bs.writeLog(" 机械手 动力  hander_machine_cost_4 : " + hander_machine_cost_4);
			bs.writeLog(" 机械手 折旧  hander_machine_cost_5 : " + hander_machine_cost_5);
			bs.writeLog(" 机械手 其他  hander_machine_cost_6 : " + hander_machine_cost_6);
			bs.writeLog(" 机械手 total  hander_machine_cost_7 : " + hander_machine_cost_7);
			bs.writeLog(" 间歇时间   index_time : " + index_time);
		}

		BigDecimal test_mat_cost = new BigDecimal(0);
		BigDecimal test_maintenance_cost = new BigDecimal(0);
		BigDecimal test_labour_cost = new BigDecimal(0);
		BigDecimal test_power_cost = new BigDecimal(0);
		BigDecimal test_depr_cost = new BigDecimal(0);
		BigDecimal test_other_cost = new BigDecimal(0);
		BigDecimal test_total_cost = new BigDecimal(0);
		BigDecimal test_total_cost2 = new BigDecimal(0);
		BigDecimal test_uph = new BigDecimal(0);

		// 测试小时
		if (TEST_QUOTATION_WAY_FAST.equals("1")) {
			test_mat_cost = new BigDecimal(0);
			test_maintenance_cost = testing_machine_cost_2.add(hander_machine_cost_2);
			test_labour_cost = testing_machine_cost_3.add(hander_machine_cost_3);
			test_power_cost = testing_machine_cost_4.add(hander_machine_cost_4);
			test_depr_cost = testing_machine_cost_5.add(hander_machine_cost_5);
			test_other_cost = testing_machine_cost_6.add(hander_machine_cost_6);
			test_total_cost = testing_machine_cost_7.add(hander_machine_cost_7);

			bs.writeLog(" 测试小时成本 维修  test_maintenance_cost : " + test_maintenance_cost);
			bs.writeLog(" 测试小时成本 人工  test_labour_cost : " + test_labour_cost);
			bs.writeLog(" 测试小时成本 动力  test_power_cost : " + test_power_cost);
			bs.writeLog(" 测试小时成本 折旧  test_depr_cost : " + test_depr_cost);
			bs.writeLog(" 测试小时成本 其他  test_other_cost : " + test_other_cost);
			bs.writeLog(" 测试小时成本 total  test_total_cost : " + test_total_cost);
			// sql ="update formtable_main_141 set
			// tester_time='"+TEST_MODELS_FAST+"',
			// hander_time='"+HANDER_FAST+"',
			// mat_time='"+test_mat_cost+"',artifi_time='"+test_labour_cost+"',
			// power_time='"+test_power_cost+"',
			// deprect_time='"+test_depr_cost+"',
			// maintain_time='"+test_maintenance_cost+"',
			// other_time='"+test_other_cost+"', test_tal_cost_time,
			// ='"+test_total_cost+"' where requestid ='"+rid+"'";
			// rs.executeSql(sql);
			// bs.writeLog("更新测试小时成本"+sql);

		} else if (TEST_QUOTATION_WAY_FAST.equals("0")) {
			// 测试千只
			test_uph = new BigDecimal(UPH_FAST);
			test_mat_cost = new BigDecimal(0);
			test_maintenance_cost = testing_machine_cost_2.add(hander_machine_cost_2)
					.divide(test_uph, 7, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1000));
			test_labour_cost = testing_machine_cost_3.add(hander_machine_cost_3)
					.divide(test_uph, 7, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1000));
			test_power_cost = testing_machine_cost_4.add(hander_machine_cost_4)
					.divide(test_uph, 7, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1000));
			test_depr_cost = testing_machine_cost_5.add(hander_machine_cost_5)
					.divide(test_uph, 7, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1000));
			test_other_cost = testing_machine_cost_6.add(hander_machine_cost_6)
					.divide(test_uph, 7, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1000));
			test_total_cost2 = testing_machine_cost_7.add(hander_machine_cost_7)
					.divide(test_uph, 7, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(1000));
			test_total_cost = test_mat_cost.add(test_maintenance_cost).add(test_labour_cost).add(test_power_cost)
					.add(test_depr_cost).add(test_other_cost);

			bs.writeLog(" 测试千只成本 维修  test_maintenance_cost : " + test_maintenance_cost);
			bs.writeLog(" 测试千只成本 人工  test_labour_cost : " + test_labour_cost);
			bs.writeLog(" 测试千只成本 动力  test_power_cost : " + test_power_cost);
			bs.writeLog(" 测试千只成本 折旧  test_depr_cost : " + test_depr_cost);
			bs.writeLog(" 测试千只成本 其他  test_other_cost : " + test_other_cost);
			bs.writeLog(" 测试千只成本 total  test_total_cost : " + test_total_cost);
			bs.writeLog(" 测试千只成本 total2  test_total_cost2 : " + test_total_cost2);

			// sql ="update formtable_main_141 set
			// tester_thou='"+TEST_MODELS_FAST+"',
			// hander_thou='"+HANDER_FAST+"',
			// mat_thou='"+test_mat_cost+"',artifi_thou='"+test_labour_cost+"',
			// power_thou='"+test_power_cost+"',
			// deprect_thou='"+test_depr_cost+"',
			// maintain_thou='"+test_maintenance_cost+"',
			// other_thou='"+test_other_cost+"', test_tal_cost_thou,
			// ='"+test_total_cost+"' where requestid ='"+rid+"'";
			// rs.executeSql(sql);
			// bs.writeLog("更新测试千只成本"+sql);

		}

		// 包装成本
		// 包装成本=成本3+成本4
		// 成本3=根据外形、包装材料、包装档次，将对应的所有费用相加
		// 成本4=根据是否需要TAPING，把对应的所有费用相加

		// 成本3
		BigDecimal pack_fees_1 = new BigDecimal(0);
		BigDecimal pack_fees_2 = new BigDecimal(0);
		BigDecimal pack_fees_3 = new BigDecimal(0);
		BigDecimal pack_fees_4 = new BigDecimal(0);
		BigDecimal pack_fees_5 = new BigDecimal(0);
		BigDecimal pack_fees_6 = new BigDecimal(0);
		BigDecimal pack_fees_7 = new BigDecimal(0);

		sql = "select MATERIAL,MAINTENANCE_COST ,LABOUR,POWER,DEPR,OTHER,(MATERIAL+MAINTENANCE_COST+LABOUR+POWER+DEPR+OTHER)  as TOTAL from MD_SD_COST_PACKING a left join MD_SD_PACKING b on A.PACKING_FK =b.id left join MD_SD_PACKING_GRADE c on A.PACKING_GRADE_FK =c.id where A.QTTN_PKG_FK ='"
				+ SHAPE + "' and b.name='" + FORM_FAST + "' and c.name='" + GRADE_FAST + "'";
		rs.executeSql(sql);
		bs.writeLog("sql成本3" + sql);
		while (rs.next()) {

			pack_fees_1 = (rs.getString("MATERIAL") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MATERIAL")));
			pack_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MAINTENANCE_COST")));
			pack_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("LABOUR")));
			pack_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
			pack_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
			pack_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
			pack_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));

			bs.writeLog(" 包装成本 材料  pack_fees_1 : " + pack_fees_1);
			bs.writeLog(" 包装成本 维修  pack_fees_2 : " + pack_fees_2);
			bs.writeLog(" 包装成本 人工  pack_fees_3 : " + pack_fees_3);
			bs.writeLog(" 包装成本 动力  pack_fees_4 : " + pack_fees_4);
			bs.writeLog(" 包装成本 折旧  pack_fees_5 : " + pack_fees_5);
			bs.writeLog(" 包装成本 其他  pack_fees_6 : " + pack_fees_6);
			bs.writeLog(" 包装成本 total  pack_fees_7 : " + pack_fees_7);

		}
		for (int i = 0; i < rs.getCounts(); i++) {

		}
		// 成本3合计
		BigDecimal cost_of_three = pack_fees_7;
		bs.writeLog("成本3   合计   cost_of_three :" + cost_of_three);

		// 成本4
		BigDecimal tapping_fees_1 = new BigDecimal(0);
		BigDecimal tapping_fees_2 = new BigDecimal(0);
		BigDecimal tapping_fees_3 = new BigDecimal(0);
		BigDecimal tapping_fees_4 = new BigDecimal(0);
		BigDecimal tapping_fees_5 = new BigDecimal(0);
		BigDecimal tapping_fees_6 = new BigDecimal(0);
		BigDecimal tapping_fees_7 = new BigDecimal(0);

		sql = "select MATERIAL_COST,MAINTENANCE_COST,LABOUR_COST,POWER_COST,DEPR_COST,OTHER_COST, (MATERIAL_COST+MAINTENANCE_COST+LABOUR_COST+POWER_COST+DEPR_COST+OTHER_COST)  as total from MD_SD_QTTN_PKG_TAPING a left join MD_SD_PACKING_TAPING b on A.TAPING_FK =b.id where  A.QTTN_PKG_FK ='"
				+ SHAPE + "' and B.NAME ='" + TAPING_FAST + "'";
		rs.executeSql(sql);
		bs.writeLog("sql成本4" + sql);
		while (rs.next()) {
			tapping_fees_1 = (rs.getString("MATERIAL") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MATERIAL")));// 正式环境中此值为null
			tapping_fees_2 = (rs.getString("MAINTENANCE_COST") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("MAINTENANCE_COST")));
			tapping_fees_3 = (rs.getString("LABOUR") == "" ? new BigDecimal(0)
					: new BigDecimal(rs.getString("LABOUR")));
			tapping_fees_4 = (rs.getString("POWER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("POWER")));
			tapping_fees_5 = (rs.getString("DEPR") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("DEPR")));
			tapping_fees_6 = (rs.getString("OTHER") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("OTHER")));
			tapping_fees_7 = (rs.getString("TOTAL") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("TOTAL")));// 正式环境中此值为null

			bs.writeLog(" TAPPING 材料  tapping_fees_1 : " + tapping_fees_1);
			bs.writeLog(" TAPPING 维修  tapping_fees_2 : " + tapping_fees_2);
			bs.writeLog(" TAPPING 人工  tapping_fees_3 : " + tapping_fees_3);
			bs.writeLog(" TAPPING 动力  tapping_fees_4 : " + tapping_fees_4);
			bs.writeLog(" TAPPING 折旧  tapping_fees_5 : " + tapping_fees_5);
			bs.writeLog(" TAPPING 其他  tapping_fees_6 : " + tapping_fees_6);
			bs.writeLog(" TAPPING total  tapping_fees_7 : " + tapping_fees_7);
		}
		// 成本4
		BigDecimal cost_of_four = pack_fees_7;

		bs.writeLog(" 成本4   合计   cost_of_four : " + cost_of_four);
		// 包装成本
		BigDecimal pack_mat_cost = pack_fees_1.add(tapping_fees_1);
		BigDecimal pack_maintenance_cost = pack_fees_2.add(tapping_fees_2);
		BigDecimal pack_labour_cost = pack_fees_3.add(tapping_fees_3);
		BigDecimal pack_power_cost = pack_fees_4.add(tapping_fees_4);
		BigDecimal pack_depr_cost = pack_fees_5.add(tapping_fees_5);
		BigDecimal pack_other_cost = pack_fees_6.add(tapping_fees_6);
		BigDecimal pack_total_cost = pack_fees_7.add(tapping_fees_7);

		bs.writeLog(" 包装成本 材料  pack_mat_cost : " + pack_mat_cost);
		bs.writeLog(" 包装成本 维修  pack_maintenance_cost : " + pack_maintenance_cost);
		bs.writeLog(" 包装成本 人工  pack_labour_cost : " + pack_labour_cost);
		bs.writeLog(" 包装成本 动力  pack_power_cost : " + pack_power_cost);
		bs.writeLog(" 包装成本 折旧  pack_depr_cost : " + pack_depr_cost);
		bs.writeLog(" 包装成本 其他  pack_other_cost : " + pack_other_cost);
		bs.writeLog(" 包装成本 total  pack_total_cost : " + pack_total_cost);

		// sql ="update formtable_main_141 set form_pack='"+FORM_FAST+"',
		// grade_pack='"+GRADE_FAST+"',
		// mat_pack='"+pack_mat_cost+"',artifi_pack='"+pack_labour_cost+"',
		// power_pack='"+pack_power_cost+"', deprect_pack='"+pack_depr_cost+"',
		// maintain_pack='"+pack_maintenance_cost+"',
		// other_pack='"+pack_other_cost+"', pack_tal_cost_pack,
		// ='"+pack_total_cost+"' where requestid ='"+rid+"'";
		// rs.executeSql(sql);
		// bs.writeLog("更新包装成本"+sql);

		// 外形标准毛利率
		BigDecimal GPM = new BigDecimal(0);
		sql = "select QTTN_PKG_FK,PRDC_TYPE_FK,GPM from MD_SD_QTTN_PKG_GPM where QTTN_PKG_FK ='" + SHAPE
				+ "' and PRDC_TYPE_FK ='" + PRODUCT_TYPE + "'";
		rs.executeSql(sql);
		bs.writeLog("sql外形标准毛利率" + sql);
		while (rs.next()) {

			GPM = (rs.getString("GPM") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("GPM")));

			bs.writeLog(" 外形标准毛利率   GPM : " + GPM);
		}
		// 贸易方式税点设定
		BigDecimal rate = new BigDecimal(0);
		sql = "select name,full_name,RATE from MD_TRADE_TYPE  where  full_name ='" + TRADEWAY + "'";
		rs.executeSql(sql);
		bs.writeLog("sql贸易方式税点设定" + sql);
		while (rs.next()) {

			rate = (rs.getString("RATE") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("RATE")));
			bs.writeLog(" 贸易方式税点   rate : " + rate);
		}
		// 汇率
		BigDecimal exchange_rate = new BigDecimal(0);
		sql = "select FROM_FK,TO_FK,RATE from MD_SD_EXCHANGE_RATE where FROM_FK ='USD' ";
		rs.executeSql(sql);
		bs.writeLog("sql汇率" + sql);
		while (rs.next()) {

			exchange_rate = (rs.getString("RATE") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("RATE")));
			bs.writeLog(" 汇率   exchange_rate : " + exchange_rate);
		}

		BigDecimal assy_advice = new BigDecimal(0);
		BigDecimal test_advice = new BigDecimal(0);
		BigDecimal pack_advice = new BigDecimal(0);
		BigDecimal advice_chip_cose = new BigDecimal(0);
		BigDecimal advice_wire_cost = new BigDecimal(0);

		if (CURRENCY.equals("0")) {
			assy_advice = assembly_total_cost.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
					.multiply(new BigDecimal(1).add(rate));
			test_advice = test_total_cost.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
					.multiply(new BigDecimal(1).add(rate));
			pack_advice = pack_total_cost.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
					.multiply(new BigDecimal(1).add(rate));
			bs.writeLog(" 组装建议   assy_advice : " + assy_advice);
			bs.writeLog(" 测试建议   test_advice : " + test_advice);
			bs.writeLog(" 包装建议   pack_advice : " + pack_advice);

			advice_chip_cose = cost_of_one.add(cost_of_two)
					.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
					.multiply(new BigDecimal(1).add(rate)).divide(chipnumber_no, 4, BigDecimal.ROUND_HALF_UP);
			advice_wire_cost = bonding_cost.divide(silk_standard, 4, BigDecimal.ROUND_HALF_UP)
					.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
					.multiply(new BigDecimal(1).add(rate));
			bs.writeLog("加一个芯片  advice_chip_cose:" + advice_chip_cose);
			bs.writeLog("加一根丝  advice_wire_cost:" + advice_wire_cost);

		} else if (CURRENCY.equals("1")) {

			assy_advice = assembly_total_cost.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
					.divide(exchange_rate, 4, BigDecimal.ROUND_HALF_UP);
			test_advice = test_total_cost.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
					.divide(exchange_rate, 4, BigDecimal.ROUND_HALF_UP);
			pack_advice = pack_total_cost.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
					.divide(exchange_rate, 4, BigDecimal.ROUND_HALF_UP);

			bs.writeLog(" 组装建议   assy_advice : " + assy_advice);
			bs.writeLog(" 测试建议   test_advice : " + test_advice);
			bs.writeLog(" 包装建议   pack_advice : " + pack_advice);

			advice_chip_cose = cost_of_one.add(cost_of_two)
					.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP).divide(exchange_rate)
					.divide(chipnumber_no, 4, BigDecimal.ROUND_HALF_UP);
			advice_wire_cost = bonding_cost.divide(silk_standard, 4, BigDecimal.ROUND_HALF_UP)
					.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP).divide(exchange_rate);
			bs.writeLog("加一个芯片  advice_chip_cose:" + advice_chip_cose);
			bs.writeLog("加一根丝  advice_wire_cost:" + advice_wire_cost);
		}
		bs.writeLog("建议价格组装  assy_advice:" + assy_advice);
		bs.writeLog("建议价格测试  test_advice:" + test_advice);
		bs.writeLog("建议价格包装  pack_advice:" + pack_advice);

		sql = "DELETE FROM FORMTABLE_MAIN" + formid + "DT1 WHERE MAINID = '" + mainid + "'";
		rs = new RecordSet();
		rs.execute(sql);

		sql = "DELETE FROM FORMTABLE_MAIN" + formid + "DT2 WHERE MAINID = '" + mainid + "'";
		rs = new RecordSet();
		rs.execute(sql);

		sql = "insert into formtable_main_" + formid
				+ "_dt1 (MAINID,cost_element,Quotation_mode,total_cost,Suggested_price,deal_price,gross_margin,discount) values ("
				+ "'" + mainid + "', '1', '0', '" + assembly_total_cost + "'," + "'" + assy_advice + "'," + "'"
				+ assy_advice + "'," + "'" + GPM + "'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);

		sql = "insert into formtable_main_" + formid
				+ "_dt1 (MAINID,cost_element,Quotation_mode,total_cost,Suggested_price,deal_price,gross_margin,discount) values ("
				+ "'" + mainid + "', '0', '" + TEST_QUOTATION_WAY_FAST + "', " + "'" + test_total_cost + "'," + "'"
				+ test_advice + "'," + "'" + test_advice + "'," + "'" + GPM + "'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);

		sql = "insert into formtable_main_" + formid
				+ "_dt1 (MAINID,cost_element,Quotation_mode,total_cost,Suggested_price,deal_price,gross_margin,discount) values ("
				+ "'" + mainid + "', '2', '0', '" + pack_total_cost + "'," + "'" + pack_advice + "'," + "'"
				+ pack_advice + "'," + "'" + GPM + "'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);

		sql = "insert into formtable_main_" + formid
				+ "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS,SUGGEST_PRICE,DEAL_PRICE) values (" + "'" + mainid + "',"
				+ "'金价波动100$'," + "'0'," + "'0'," + "'0.00'," + "'0.00'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);

		sql = "insert into formtable_main_" + formid
				+ "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS,SUGGEST_PRICE,DEAL_PRICE) values (" + "'" + mainid + "',"
				+ "'加一个芯片'," + "'0'," + "'0'," + "'" + advice_chip_cose + "'," + "'" + advice_chip_cose + "'" + ")";
		rs.executeSql(sql);

		sql = "insert into formtable_main_" + formid
				+ "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS,SUGGEST_PRICE,DEAL_PRICE) values (" + "'" + mainid + "',"
				+ "'铜价波动100$'," + "'0'," + "'0'," + "'0.00'," + "'0.00'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);

		sql = "insert into formtable_main_" + formid
				+ "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS,SUGGEST_PRICE,DEAL_PRICE) values (" + "'" + mainid + "',"
				+ "'加一根键合丝'," + "'0'," + "'0'," + "'" + advice_wire_cost + "'," + "'" + advice_wire_cost + "'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);

		sql = "SELECT SUM(TOTAL_COST) AS TOTAL_COST FROM FORMTABLE_MAIN_" + formid
				+ "_DT1 WHERE MAINID =(SELECT ID FROM FORMTABLE_MAIN_" + formid + " WHERE REQUESTID ='" + rid + "')";
		rs = new RecordSet();
		rs.execute(sql);
		rs.next();
		String overall_cost = "";
		overall_cost = rs.getString("TOTAL_COST");
		sql = "UPDATE FORMTABLE_MAIN_" + formid + " SET OVERALL_COST = '" + overall_cost + "' WHERE REQUESTID = '" + rid
				+ "'";
		rs.execute(sql);

	}
}
