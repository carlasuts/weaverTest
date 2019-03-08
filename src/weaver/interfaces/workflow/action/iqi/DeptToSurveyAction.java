/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.workflow.action.iqi
 * File Name   : DeptToSurveyAction.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018��9��21��     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action.iqi;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 *
 */
public class DeptToSurveyAction implements Action {
	private String sql = "";

	@Override
	public String execute(RequestInfo request) {
		BaseBean baseBean = new BaseBean();
		baseBean.writeLog("DeptToSurveyAction��ʼִ��");
		RecordSet rs = new RecordSet();
		String requestId = request.getRequestid();
		String workflowId = request.getWorkflowid();
		int formId = BillUtil.getFormId(Integer.parseInt(workflowId));

		sql = "SELECT DEPT_TO_SURVEY FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
		baseBean.writeLog("��ѯ������ί�е����˵�ID: " + sql);
		rs.execute(sql);
		rs.next();
		String DEPT_TO_SURVEY = rs.getString("DEPT_TO_SURVEY");
		String[] names = DEPT_TO_SURVEY.split(",");
		String DEPTTOSURVEY = "";
		for (String name : names) {
			sql  = "SELECT LASTNAME FROM HRMRESOURCE WHERE ID = '" + name + "'";
			rs.execute(sql);
			rs.next();
			String lastname = rs.getString("LASTNAME");
			DEPTTOSURVEY = DEPTTOSURVEY + lastname + ",";
		}
		DEPTTOSURVEY = DEPTTOSURVEY.substring(0, DEPTTOSURVEY.length() - 1);
		baseBean.writeLog("DEPTTOSURVEY: " + DEPTTOSURVEY);
		
		sql = "SELECT * FROM IQI WHERE REQUESTID = '" + requestId + "'";
		rs.execute(sql);
		if (rs.next()) {// ���ڱ����ҵ���ǰrequestid
			sql = "UPDATE IQI SET DEPTTOSURVEY = '" + DEPTTOSURVEY + "' WHERE REQUESTID = '" + requestId + "'";
			rs.execute(sql);
		} else {
			sql = "INSERT INTO IQI (REQUESTID, DEPTTOSURVEY) VALUES ('" + requestId +"', '" + DEPTTOSURVEY + "')";
			rs.execute(sql);
		}

		return Action.SUCCESS;
	}

}
