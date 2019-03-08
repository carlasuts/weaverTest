package weaver.interfaces.workflow.action.offer;

import java.math.BigDecimal;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;

public class TfmeOffer_02 {
	// 成本合计

	public void getcostofcombined(String rid, MainTableInfo maintableinfo, String workflowid) {

		int formid = BillUtil.getFormId(Integer.parseInt(workflowid));

		BaseBean baseBean = new BaseBean();
		RecordSet rs = new RecordSet();
		baseBean.writeLog("进入接口TfmeOffer02");

		String CURRENCY = "";// 币种
		String PRODUCT_TYPE = ""; // 生产类型
		String SHAPE = ""; // 外形
		String RATE = "";
		String sql = "";
		String EXCHANGE_RATE = "";

		Property[] Property = maintableinfo.getProperty();
		String id;
		for (int ss = 0; ss < Property.length; ++ss) {
			String dataDB = Property[ss].getName().toUpperCase();
			id = Util.null2String(Property[ss].getValue());

			if (dataDB.equals("CURRENCY")) {
				CURRENCY = id;
			}

			if (dataDB.equals("PRODUCT_TYPE")) {
				PRODUCT_TYPE = id;
			}
			if (dataDB.equals("SHAPE")) {
				SHAPE = id;
			}

			if (dataDB.equals("RATE")) {
				RATE = id;
			}

		}

		// baseBean.writeLog("CURRENCY: " + CURRENCY);
		// if (CURRENCY.equals("1")) {// 外销
		// 查找汇率
		// sql = "SELECT SELECTNAME FROM WORKFLOW_SELECTITEM WHERE FIELDID =
		// (SELECT ID FROM WORKFLOW_BILLFIELD WHERE BILLID = -"
		// + formid + " AND UPPER(FIELDNAME) = 'CURRENCY') AND SELECTVALUE =
		// '1'";
		// baseBean.writeLog(sql);
		// rs.execute(sql);
		// rs.next();
		// String currencyValue = rs.getString("SELECTNAME");
		// baseBean.writeLog("currencyValue: " + currencyValue);

		sql = "SELECT RATE FROM MD_SD_EXCHANGE_RATE WHERE FROM_FK = 'USD'";
		rs = new RecordSet();
		rs.execute(sql);
		rs.next();
		EXCHANGE_RATE = rs.getString("RATE");// 汇率
		baseBean.writeLog("EXCHANGE_RATE: " + EXCHANGE_RATE);
		// }

		// 更新主表汇率
		sql = "UPDATE FORMTABLE_MAIN_" + formid + " SET EXCHANGE_RATE = '" + EXCHANGE_RATE + "' WHERE REQUESTID = '"
				+ rid + "'";
		rs = new RecordSet();
		baseBean.writeLog("精算报价更新汇率：" + sql);
		rs.execute(sql);

		String TOTAL_COST_SUM = "";
		sql = "select sum(TOTAL_COST) as TOTAL_COST  from formtable_main_" + formid
				+ "_dt1 where mainid =(select  id from formtable_main_" + formid + "  where requestid ='" + rid + "') and quotation_mode = '0'";
		rs = new RecordSet();
		rs.executeSql(sql);
		baseBean.writeLog("所有" + sql);
		while (rs.next()) {
			TOTAL_COST_SUM = rs.getString("TOTAL_COST");// 44.8
		}
//		String AMOUNT_SUM = "";
//		sql = "select SUM(AMOUNT)  AS AMOUNT from  formtable_main_" + formid
//				+ "_dt3 where    mainid=(select  id from formtable_main_" + formid + "  where requestid ='" + rid
//				+ "')";
//		rs = new RecordSet();
//		rs.executeSql(sql);
//		baseBean.writeLog("建议价格" + sql);
//		while (rs.next()) {
//			AMOUNT_SUM = rs.getString("AMOUNT");// 15.11
//		}
		// overall_cost_sum 整体成本
//		BigDecimal overall_cost_sum = new BigDecimal(AMOUNT_SUM).add(new BigDecimal(TOTAL_COST_SUM));
		BigDecimal overall_cost_sum = new BigDecimal(TOTAL_COST_SUM);
		sql = "update formtable_main_" + formid + " set overall_cost ='" + overall_cost_sum + "' where requestid ='"
				+ rid + "' ";
		rs = new RecordSet();
		baseBean.writeLog("整体成本" + sql);
		rs.executeSql(sql);

		// 成本元素为测试
		String QUOTATION_MODE = "";
		sql = "select QUOTATION_MODE from  formtable_main_" + formid
				+ "_dt1 where COST_ELEMENT = 0 and mainid =(select id from formtable_main_" + formid
				+ " where requestid ='" + rid + "')";
		rs = new RecordSet();
		rs.executeSql(sql);
		baseBean.writeLog("sql报价模式: " + sql);// 报价模式
		while (rs.next()) {
			QUOTATION_MODE = rs.getString("QUOTATION_MODE");
		}

		sql = "update formtable_main_" + formid + " set Offer_category = '" + QUOTATION_MODE + "' where REQUESTID = '"
				+ rid + "'";
		rs = new RecordSet();
		baseBean.writeLog("sql报价类别: " + sql);
		rs.executeSql(sql);

		// 建议报价
		sql = "SELECT  SELECTNAME FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid = -"
				+ formid + " AND upper(fieldname) = 'PRODUCT_TYPE')  and SELECTVALUE = '" + PRODUCT_TYPE + "'";
		rs = new RecordSet();
		rs.executeSql(sql);
		baseBean.writeLog("sql生产类型： " + sql);
		while (rs.next()) {
			PRODUCT_TYPE = rs.getString("SELECTNAME");
		}

		// 外形标准毛利率
		BigDecimal GPM = new BigDecimal(0);
		sql = "select QTTN_PKG_FK, PRDC_TYPE_FK, GPM from MD_SD_QTTN_PKG_GPM where QTTN_PKG_FK = '" + SHAPE
				+ "' and PRDC_TYPE_FK = '" + PRODUCT_TYPE + "'";
		rs = new RecordSet();
		rs.executeSql(sql);
		baseBean.writeLog("sql外形标准毛利率" + sql);
		while (rs.next()) {
			GPM = (rs.getString("GPM") == "" ? new BigDecimal(0) : new BigDecimal(rs.getString("GPM")));
		}

		String TOTAL_COST = "", SUGGESTED_PRICE = "", Mid = "";
		sql = "select * from formtable_main_" + formid + "_dt1 where mainid = (select id from formtable_main_" + formid
				+ " where requestid = '" + rid + "')";
		rs = new RecordSet();
		rs.executeSql(sql);
		baseBean.writeLog("成本合计取值: " + sql);
		while (rs.next()) {
			TOTAL_COST = rs.getString("TOTAL_COST");
			Mid = rs.getString("id");
			if (CURRENCY.equals("0")) {
				baseBean.writeLog("CURRENCY" + CURRENCY);
				baseBean.writeLog("TOTAL_COST" + new BigDecimal(TOTAL_COST));// 18.76
																				// 20.35
				baseBean.writeLog("GPM" + GPM);// 0.25
				baseBean.writeLog("RATE" + new BigDecimal(RATE));//
				BigDecimal SUGGESTED_PRICE_MATH = new BigDecimal(TOTAL_COST)
						.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
						.multiply(new BigDecimal(1).add(new BigDecimal(RATE)));
				SUGGESTED_PRICE = SUGGESTED_PRICE_MATH.toString();
				baseBean.writeLog("SUGGESTED_PRICE" + SUGGESTED_PRICE);
			} else if (CURRENCY.equals("1")) {
				baseBean.writeLog("CURRENCY" + CURRENCY);
				baseBean.writeLog("TOTAL_COST" + new BigDecimal(TOTAL_COST));
				baseBean.writeLog("GPM" + GPM);// 0.25
				baseBean.writeLog("EXCHANGE_RATE" + EXCHANGE_RATE);//
				BigDecimal SUGGESTED_PRICE_MATH = new BigDecimal(TOTAL_COST)
						.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
						.divide(new BigDecimal(EXCHANGE_RATE), 4, BigDecimal.ROUND_HALF_UP);
				SUGGESTED_PRICE = SUGGESTED_PRICE_MATH.toString();
				baseBean.writeLog("SUGGESTED_PRICE" + SUGGESTED_PRICE);
			}
			baseBean.writeLog("*****成本合计更新动作*****");
			String sql1 = "UPDATE FORMTABLE_MAIN_" + formid + "_DT1 SET  SUGGESTED_PRICE ='" + SUGGESTED_PRICE
					+ "' WHERE ID = '" + Mid + "' ";
			baseBean.writeLog("更新成本合计建议价格: " + sql1);
			rs.executeSql(sql1);
		}

		BigDecimal COST = new BigDecimal(0);
		BigDecimal SUGGEST_PRICE = new BigDecimal(0);
		String Mdid = "";
		sql = "select * from  formtable_main_" + formid + "_dt2 where    mainid=(select  id from formtable_main_"
				+ formid + "  where requestid ='" + rid + "'  )";
		rs = new RecordSet();
		baseBean.writeLog("sql建议价格" + sql);
		rs.executeSql(sql);
		while (rs.next()) {
			COST = (rs.getString("COST") == null || rs.getString("COST") == "") ? new BigDecimal(0)
					: new BigDecimal(rs.getString("COST"));
			Mdid = rs.getString("id");
			if (CURRENCY.equals("0")) {
				BigDecimal SUGGESTED_PRICE_MATH = COST
						.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
						.multiply(new BigDecimal(1).add(new BigDecimal(RATE)));
				SUGGEST_PRICE = SUGGESTED_PRICE_MATH;
			} else if (CURRENCY.equals("1")) {
				BigDecimal SUGGESTED_PRICE_MATH = COST
						.divide(new BigDecimal(1).subtract(GPM), 4, BigDecimal.ROUND_HALF_UP)
						.divide(new BigDecimal(EXCHANGE_RATE), 4, BigDecimal.ROUND_HALF_UP);
				SUGGEST_PRICE = SUGGESTED_PRICE_MATH;
			}
			String sql1 = " update formtable_main_" + formid + "_dt2 set  SUGGEST_PRICE ='" + SUGGEST_PRICE
					+ "'  where    id='" + Mdid + "' ";
			baseBean.writeLog("sql建议价格" + sql1);
			rs.executeSql(sql1);
		}

	}
}
