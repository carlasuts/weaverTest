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
package weaver.interfaces.sap.reprocessinTFME.dao;

import java.util.List;

import weaver.interfaces.sap.reprocessinTFME.entity.ReprocessinTFMEDt2;
import weaver.interfaces.sap.reprocessinTFME.entity.ReprocessinTFMEDt3;

/**
 * 
 * @author zong.yq
 *
 */
public interface ReprocessInTFMEDao {

	public List<ReprocessinTFMEDt2> getReprocessInTFMEAsZero(String zero, String id, Integer formId, String customer);

	public List<ReprocessinTFMEDt2> getReprocessInTFMEAsYzx(String yzx, String id, Integer formId, String customer);

	public List<ReprocessinTFMEDt3> merge(Integer mergeMode, String id, Integer formId);

	public void init(String id, Integer formId);

}
