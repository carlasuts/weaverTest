/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.workflow.action.hrDepartment.overtime
 * File Name   : CallOverTime.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年2月6日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action.hrDepartment.overtime;

import net.sf.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.sap.HttpClientJson;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 *
 */
public class CallOverTime {

	private static final String url = "";// hr新考勤webService地址

	private BaseBean baseBean = new BaseBean();

	JSONObject req = new JSONObject();
	JSONObject json = new JSONObject();
	String sql = "";
	RecordSet rs = new RecordSet();

	public void CallOver(RequestInfo requst) {
		baseBean.writeLog("***Programming Starting***");
		String requestId = requst.getRequestid();
		try {
			sql = "" + requestId + "";
			rs.execute(sql);
			while (rs.next()) {
				json.put("HrNo", "");
				json.put("ApplyDate", "");
				json.put("TimeBegin", "");
				json.put("TimeEnd", "");
				json.put("HoursApply", "");
				json.put("Status", "");
				json.put("ChangeType", "");
				req.put("", req);
				req.put("", "");
				req.put("", "");
				req.put("", "");
				String retSrcs = HttpClientJson.readInterfacePost(url, req.toString());
				baseBean.writeLog(retSrcs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
