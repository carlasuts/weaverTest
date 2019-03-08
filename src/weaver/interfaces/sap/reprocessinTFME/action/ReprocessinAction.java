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
package weaver.interfaces.sap.reprocessinTFME.action;

import java.util.ArrayList;
import java.util.List;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.sap.reprocessinTFME.dao.ReprocessInTFMEDao;
import weaver.interfaces.sap.reprocessinTFME.dao.ReprocessInTFMEDaoImpl;
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
		ReprocessInTFMEDao repDao = new ReprocessInTFMEDaoImpl();
		formId = BillUtil.getFormId(Integer.parseInt(request.getWorkflowid()));
		BaseBean baseBean = new BaseBean();
		RecordSet rs = new RecordSet();

		String sql = "";
		String rid = request.getRequestid();// 获取当且流程的id

		sql = "SELECT ID,LOT_ID,MERGEMODE,CUSTOMER FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = " + rid;
		rs.executeSql(sql);
		rs.next();
		String id = rs.getString("ID");
		String customer = rs.getString("CUSTOMER");

		repDao.init(id, formId);

		String lotId = rs.getString("LOT_ID");
		int mergeMode = rs.getInt("MERGEMODE");// 合并类型 0:不合并 1：按扩散批号合并 2：按组装批号合并 3：按箱号+扩散批号合并
		String[] lotIdList = lotId.split(",");
		String zero = "";
		String yzx = "";
		List<String> zeroList = new ArrayList<String>();
		List<String> yzxList = new ArrayList<String>();
		List<String> waferLotList = new ArrayList<String>();
		for (String l : lotIdList) {
			sql = "SELECT DISTINCT LOT_CODE,WXS,WAFER_LOT,ASSY_LOT FROM FORMTABLE_MAIN_" + formId
					+ "_DT1 WHERE LOT_CODE = '" + l + "' AND MAINID = '" + id + "'";
			baseBean.writeLog(sql);
			rs.executeSql(sql);
			while (rs.next()) {
				String wxs = rs.getString("WXS");// 外箱号
				if (wxs == null || wxs == "") {
					zero = rs.getString("LOT_CODE");
					zeroList.add(zero);
				} else {
					yzx = rs.getString("LOT_CODE");
					yzxList.add(yzx);
				}
				waferLotList.add(rs.getString("WAFER_LOT"));
			}
		}
		for (int i = 0; i < waferLotList.size(); i++) {
			for (int j = waferLotList.size() - 1; j > i; j--) {
				if (waferLotList.get(j).equals(waferLotList.get(i))) {
					waferLotList.remove(j);
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
