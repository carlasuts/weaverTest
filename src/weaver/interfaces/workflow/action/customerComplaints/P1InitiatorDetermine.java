/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.workflow.action.customerComplaints
 * File Name   : P1InitiatorDetermine.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年9月20日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action.customerComplaints;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 *
 */
public class P1InitiatorDetermine implements Action {
	private String sql = "";

	@Override
	public String execute(RequestInfo request) {
		BaseBean baseBean = new BaseBean();
		baseBean.writeLog("P1InitiatorDetermine开始执行");
		RecordSet rs = new RecordSet();
		String requestId = request.getRequestid();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		try {
			sql = "SELECT MAX(GROUPID) GROUPID FROM WORKFLOW_CURRENTOPERATOR WHERE REQUESTID = '" + requestId
					+ "' AND NODEID = '4202'";
			rs.execute(sql);
			rs.next();
			String groupId = rs.getString("GROUPID");
			baseBean.writeLog("最大的groupid: " + groupId);

			sql = "SELECT RECEIVEDATE FROM WORKFLOW_CURRENTOPERATOR WHERE REQUESTID = '" + requestId
					+ "' AND NODEID = '4202' AND GROUPID = '" + groupId + "'";
			rs.execute(sql);
			rs.next();
			baseBean.writeLog("取P1主管审核节点接收时间sql: " + sql);
			String RECEIVEDATE = rs.getString("RECEIVEDATE");
			baseBean.writeLog("RECEIVEDATE: " + RECEIVEDATE);
			Date determineDate = sdf.parse(RECEIVEDATE);

			sql = "SELECT MAX(GROUPID) GROUPID FROM WORKFLOW_CURRENTOPERATOR WHERE REQUESTID = '" + requestId
					+ "' AND NODEID = '4161'";
			rs.execute(sql);
			rs.next();
			groupId = rs.getString("GROUPID");
			
			sql = "SELECT OPERATEDATE FROM WORKFLOW_CURRENTOPERATOR WHERE REQUESTID = '" + requestId
					+ "' AND NODEID = '4161' AND GROUPID = '" + groupId + "'";
			rs.execute(sql);
			rs.next();
			baseBean.writeLog("取P1提交时间");
			String OPERATEDATE = rs.getString("OPERATEDATE");
			baseBean.writeLog("OPERATEDATE: " + OPERATEDATE);
			Date p1OperateDate = sdf.parse(OPERATEDATE);

			// 8D回复周期
			String hour = String.valueOf((determineDate.getTime() - p1OperateDate.getTime()) / (1000 * 60 * 60));

			sql = "UPDATE CUSTOMER_COMPLAINTS SET HOUR8D = '" + hour + "' WHERE REQUESTID = '" + requestId + "'";
			baseBean.writeLog("更新单号为" + requestId + "的8D回复时间sql: " + sql);
			rs.execute(sql);
		} catch (ParseException e) {
			baseBean.writeLog("上面发生了错误");
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}

}
