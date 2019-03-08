/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : com.rainbow.test
 * File Name   : TableData.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018�?11�?2�?     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action.test;

import weaver.general.BaseBean;
import weaver.hrm.User;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 *
 */
public class TableData implements Action {

	@Override
	public String execute(RequestInfo requestInfo) {
		BaseBean baseBean = new BaseBean();
		baseBean.writeLog("TableData开始运行...");
		System.out.println("进入TableData requestid = " + requestInfo.getRequestid());

		String requestId = requestInfo.getRequestid();
		baseBean.writeLog("requestId: " + requestId);
		String requestLevel = requestInfo.getRequestlevel();
		baseBean.writeLog("requestLevel: " + requestLevel);
		String src = requestInfo.getRequestManager().getSrc();
		baseBean.writeLog("src: " + src);
		String workflowId = requestInfo.getWorkflowid();
		baseBean.writeLog("workflowId: " + workflowId);
		String tableName = requestInfo.getRequestManager().getBillTableName();
		baseBean.writeLog("tableName: " + tableName);
		int billId = requestInfo.getRequestManager().getBillid();
		baseBean.writeLog("billId: " + billId);
		User user = requestInfo.getRequestManager().getUser();
		baseBean.writeLog("user: " + user);
		String requestName = requestInfo.getRequestManager().getRequestname();
		baseBean.writeLog("requestName: " + requestName);
		String remark = requestInfo.getRequestManager().getRemark();
		baseBean.writeLog("remark: " + remark);
		int formId = requestInfo.getRequestManager().getFormid();
		baseBean.writeLog("formId: " + formId);
		int isBill = requestInfo.getRequestManager().getIsbill();
		baseBean.writeLog("isBill: " + isBill);
		Property[] properties = requestInfo.getMainTableInfo().getProperty();
		for (Property property : properties) {
			baseBean.writeLog(property.getName());
			baseBean.writeLog(property.getValue());
		}
		return Action.SUCCESS;
	}

}
