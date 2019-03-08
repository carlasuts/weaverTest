/**
 * ****************************************************************************
 * System      : weaver
 * Module      : weaver.interfaces.workflow.dao.quotation
 * File Name   : QuotationBrowserDao.java
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
package weaver.interfaces.workflow.dao.quotation;

import weaver.interfaces.workflow.entity.quotation.QuotationBrowserCalculationData;
import weaver.interfaces.workflow.entity.quotation.QuotationBrowserData;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author peng.xu
 *
 */
public interface QuotationBrowserDao {
    public QuotationBrowserData getQuotationBrowserData(RequestInfo request);

    public QuotationBrowserCalculationData getQuotationBrowserCalculationData(QuotationBrowserData data);

    public void updateFastQuotaion(RequestInfo request, QuotationBrowserData data);

    public void updateQuotationBrowserCalculation(RequestInfo req, QuotationBrowserData data, QuotationBrowserCalculationData calculationData);
    
}
