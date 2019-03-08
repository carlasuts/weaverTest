/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.sap.reprocessinTFME.action
 * File Name   : ReprocessinAction.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年9月7日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.sap.reprocessinTFME.action.cc;

import java.util.ArrayList;
import java.util.List;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.sap.reprocessinTFME.dao.cc.ReprocessInTFMEDaoImpl_CC;
import weaver.interfaces.sap.reprocessinTFME.dao.cc.ReprocessInTFMEDao_CC;
import weaver.interfaces.sap.reprocessinTFME.entity.ReprocessinTFMEDt2;
import weaver.interfaces.sap.reprocessinTFME.entity.ReprocessinTFMEDt3;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 *
 */
public class ReprocessinAction implements Action {

	private static int formId = 0;

	@Override
	public String execute(RequestInfo request) {
		ReprocessInTFMEDao_CC repDao = new ReprocessInTFMEDaoImpl_CC();
		formId = BillUtil.getFormId(Integer.parseInt(request.getWorkflowid()));
		BaseBean baseBean = new BaseBean();
		RecordSet rs = new RecordSet();

		String sql = "";
		String rid = request.getRequestid();// 获取当且流程的id

		sql = "SELECT ID,MERGEMODE,CUSTOMER FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = " + rid;
		rs.executeSql(sql);
		rs.next();
		String id = rs.getString("ID");
		String customer = rs.getString("CUSTOMER");

		repDao.init(id, formId);

		int mergeMode = rs.getInt("MERGEMODE");// 合并类型 0:不合并 1：按扩散批号合并 2：按组装批号合并 3：按箱号+扩散批号合并
		String lotId = "";
		List<String> lotIdList = new ArrayList<String>();
		sql = "SELECT LOT_CODE FROM FORMTABLE_MAIN_" + formId + "_DT1 WHERE MAINID = " + id;
		rs.execute(sql);
		while (rs.next()) {
			lotId = rs.getString("LOT_CODE");
			lotIdList.add(lotId);
		}
		String zero = "";
		String yzx = "";
		List<String> zeroList = new ArrayList<String>();
		List<String> yzxList = new ArrayList<String>();
		for (String l : lotIdList) {
			sql = "SELECT DISTINCT WXS,WAFER_LOT,ASSY_LOT FROM FORMTABLE_MAIN_" + formId + "_DT1 WHERE LOT_CODE = '" + l
					+ "' AND MAINID = '" + id + "'";
			baseBean.writeLog(sql);
			rs.executeSql(sql);
			while (rs.next()) {
				String wxs = rs.getString("WXS");// 外箱号
				if (wxs == null || wxs == "") {
					zero = l;
					zeroList.add(zero);
				} else {
					yzx = l;
					yzxList.add(yzx);
				}
			}
		}
		if (zeroList.size() != 0) {
			zero = custom(zeroList);
			List<ReprocessinTFMEDt2> reprocessInFGSSecondDetailAsZero = repDao.getReprocessInTFMEAsZero(zero, id,
					formId, customer);
		}
		if (yzxList.size() != 0) {
			yzx = custom(yzxList);
			baseBean.writeLog("开始执行有装箱代码");
			List<ReprocessinTFMEDt2> getReprocessInFGSSecondDetailAsYzx = repDao.getReprocessInTFMEAsYzx(yzx, id,
					formId, customer);
		}
		List<ReprocessinTFMEDt3> reprocessinTFMEDt3s = repDao.merge(mergeMode, id, formId);
		return Action.SUCCESS;
	}

	private static String custom(List<String> list) {
		String newList = "";
		for (int i = 0; i < list.size(); i++) {
			if (i == list.size() - 1) {
				newList = newList + "'" + list.get(i) + "'";
			} else if (i < list.size() - 1) {
				newList = newList + "'" + list.get(i) + "'" + ",";
			}
		}
		return newList;
	}

}
