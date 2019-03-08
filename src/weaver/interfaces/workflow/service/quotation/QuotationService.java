/**
 * ****************************************************************************
 * System      : weaver
 * Module      : weaver.interfaces.workflow.service.quotation
 * File Name   : QuotationService.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年10月13日     peng.xu     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.service.quotation;

import weaver.interfaces.workflow.dao.quotation.QuotationBrowserDao;
import weaver.interfaces.workflow.dao.quotation.QuotationBrowserDaoImpl;
import weaver.interfaces.workflow.entity.quotation.QuotationBrowserCalculationData;
import weaver.interfaces.workflow.entity.quotation.QuotationBrowserData;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author peng.xu
 *
 */
public class QuotationService {
    public void fastQuotation(RequestInfo req, QuotationBrowserData data) {
	QuotationBrowserDao dao = new QuotationBrowserDaoImpl();
	dao.updateFastQuotaion(req, data);
    }

    public QuotationBrowserData getQuotationBrowserData(RequestInfo req) {
	QuotationBrowserDao dao = new QuotationBrowserDaoImpl();
	QuotationBrowserData data = dao.getQuotationBrowserData(req);
	return data;
    }

    public QuotationBrowserCalculationData getQuotationBrowserCalculationData(QuotationBrowserData data) {
	QuotationBrowserDao dao = new QuotationBrowserDaoImpl();
	QuotationBrowserCalculationData calculationData = dao.getQuotationBrowserCalculationData(data);
	return calculationData;
    }

    public void quotationBrowserCalculation(RequestInfo req, QuotationBrowserData data, QuotationBrowserCalculationData calculationData) {
	QuotationBrowserDao dao = new QuotationBrowserDaoImpl();
	dao.updateQuotationBrowserCalculation(req, data, calculationData);	
    }    
}
