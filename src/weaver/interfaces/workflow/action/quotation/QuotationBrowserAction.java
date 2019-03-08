/**
 * ****************************************************************************
 * System      : weaver
 * Module      : weaver.interfaces.workflow.action.quotation
 * File Name   : QuotationBrowserAction.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年10月12日     peng.xu     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action.quotation;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.workflow.entity.quotation.QuotationBrowserCalculationData;
import weaver.interfaces.workflow.entity.quotation.QuotationBrowserData;
import weaver.interfaces.workflow.service.quotation.QuotationService;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author peng.xu
 *
 */
public class QuotationBrowserAction implements Action {

	@Override
	public String execute(RequestInfo req) {
		BaseBean basebean = new BaseBean();
		basebean.writeLog("QuotationBrowserAction 开始执行");
		try {
			MainTableInfo mainTableInfo = req.getMainTableInfo();
			String Quotation_way = "";
			Property[] properties = mainTableInfo.getProperty();// 获取表单主字段信息
			for (int i = 0; i < properties.length; i++) {// 主表数据
				String name = properties[i].getName().toUpperCase();// 字段名
				String value = Util.null2String(properties[i].getValue());// 值
				// 申请人
				if (name.equals("QUOTATION_WAY")) {
					Quotation_way = value;
					basebean.writeLog(Quotation_way);
					basebean.writeLog(name + ":" + Quotation_way);
				}
			}

			if (Quotation_way.toString().equals("0")) {
				basebean.writeLog("***TFMEPOST开始执行***");
				QuotationService service = new QuotationService();
				basebean.writeLog("***获取数据1***");
				QuotationBrowserData data = service.getQuotationBrowserData(req);
				basebean.writeLog("***获取数据2***");
				QuotationBrowserCalculationData calculationData = service.getQuotationBrowserCalculationData(data);
				basebean.writeLog("***快速报价1***");
				service.fastQuotation(req, data);
				basebean.writeLog("***快速报价2***");
				service.quotationBrowserCalculation(req, data, calculationData);
				basebean.writeLog("QuotationBrowserAction 结束执行");
			} 
			
		} catch (Exception e) {
			basebean.writeLog("start log");
			basebean.writeLog("------------------------------------------------------------------------");
			basebean.writeLog("TFMEPOST error" + e.getMessage());
			basebean.writeLog("------------------------------------------------------------------------");
			basebean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}
