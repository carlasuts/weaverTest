/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.workflow.action
 * File Name   : SatisfactionAction.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年8月9日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action;

import java.text.SimpleDateFormat;
import java.util.Date;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq 测试环境
 */
public class SatisfactionAction implements Action {

	@Override
	public String execute(RequestInfo request) {
		BaseBean baseBean = new BaseBean();
		try {
			baseBean.writeLog("SatisfactionAction 开始执行了！");
			RecordSet rs = new RecordSet();
			String requestId = request.getRequestid();
			String workflowId = request.getWorkflowid();
			int formId = BillUtil.getFormId(Integer.parseInt(workflowId));

			String sql = "SELECT * FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
			rs.execute(sql);
			rs.next();
			int system = Integer.parseInt(rs.getString("SYSTEM"));// 系统
			String creator = rs.getString("USERNAME");// 创建人
			String workflowName = rs.getString("FUNC");// 流程名
			String ifTrigger = rs.getString("IF_TRIGGER");
			String createFlag = "";
			if (ifTrigger.equals("0")) {
				createFlag = "Y";
			} else {
				createFlag = "N";
			}

			sql = "SELECT ID FROM WORKFLOW_BASE WHERE WORKFLOWNAME = '" + workflowName + "'";
			baseBean.writeLog("查询流程ID SQL: " + sql);
			rs.execute(sql);
			rs.next();
			String id = rs.getString("ID");
			baseBean.writeLog("workflowId: " + workflowId);
			// 以后加了多个系统 这边最好用switch case的方法去做判断
			if (system == 0) {// 0 为OA
				String updateTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
				sql = "UPDATE USERS_SATISFACTION_INFO SET CREATE_FLAG = '" + createFlag
						+ "', END_FLAG = 'Y', UPDATE_TIME = '" + updateTime + "' WHERE WORKFLOWID = '" + id
						+ "' AND CREATOR = '" + creator + "'";
				rs.execute(sql);
			}
		} catch (Exception e) {
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("SatisfactionAction error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}

}
