/**
 * ****************************************************************************
 * System      : weaver
 * Module      : weaver.interfaces.dao.reprocessinFGS
 * File Name   : ReprocessInFGSDao.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年8月22日     peng.xu     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.mes.dao.reprocessinTFME;

import java.util.List;

import weaver.interfaces.mes.entity.reprocessinTFME.ReprocessInTFMEData;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author peng.xu
 *
 */
public interface ReprocessInTFMEDao {

	public List<ReprocessInTFMEData> getReprocessInFGS(RequestInfo request);
}
