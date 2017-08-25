/**
 * ****************************************************************************
 * System      : weaver
 * Module      : weaver.interfaces.dao.reprocessinFGS
 * File Name   : ReprocessInFGSDaoImpl.java
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

import java.util.ArrayList;
import java.util.List;

import weaver.conn.RecordSet;
import weaver.interfaces.mes.entity.reprocessinTFME.ReprocessInTFMEData;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author peng.xu
 *
 */
public class ReprocessInTFMEDaoImpl implements ReprocessInTFMEDao {

	@Override
	public List<ReprocessInTFMEData> getReprocessInFGS(RequestInfo request) {
		StringBuilder strBuilder = new StringBuilder();
		ReprocessInTFMEData repData = new ReprocessInTFMEData();
		List<ReprocessInTFMEData> repDataList = new ArrayList<ReprocessInTFMEData>();
		RecordSet rs = new RecordSet();

		try {
			String requsetId = request.getRequestid();// 获取当前流程的requsetId
			strBuilder.append(" SELECT a.LOT_CODE, a.MATERIAL "); 
			strBuilder.append(" FROM FORMTABLE_MAIN_68_DT1 a ");
			strBuilder.append(" INNER JOIN FORMTABLE_MAIN_68 b ON b.ID = a.MAINID "); 
			strBuilder.append(" WHERE b.REQUESTID = '" + requsetId + "'");
			rs.execute(strBuilder.toString());
			while (rs.next()) {
				repData.setLotCode(rs.getString("LOT_CODE"));
				repData.setMaterial(rs.getString("MATERIAL"));
				repDataList.add(repData);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return repDataList;
	}

}
