/**
 * ****************************************************************************
 * System      : MessTest
 * Module      : weaver.interfaces.workflow.action.testDepartment.programList
 * File Name   : ProductNameVerifyA.java
 * Description : 程序一览表校验
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2017年9月5日     xu.sy     	修改表单ID
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action.testDepartment.programList;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.RequestInfo;

public class ProductNameVerifyA implements Action {
	private static int formId = 0;

	@Override
	public String execute(RequestInfo request) {
		formId = BillUtil.getFormId(Integer.parseInt(request.getWorkflowid()));
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();// 获取当且流程的id
			String status = "";
			// 获得流程是退回还是提交
			String src = request.getRequestManager().getSrc();
			if (src.equals("submit")) {// 提交流程
				status = "S";
			} else if (src.equals("reject")) {// 流程退回
				status = "E";
			}
			if (status.equals("E")) {
				sql = "SELECT SCWJ FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + rid + "'";
				rs.execute(sql);
				rs.next();
				String docid = rs.getString("SCWJ");
				baseBean.writeLog(docid);
				sql = "SELECT IMAGEFILENAME FROM DOCIMAGEFILE WHERE DOCID = '" + docid + "'";
				rs.execute(sql);
				rs.next();
				String imagefilename = rs.getString("IMAGEFILENAME");
				sql = "UPDATE formtable_main_" + formId + " SET SCWJ=NULL,THBZ=1,XZDYPMLIST=NULL,SBDYPMLIST=NULL,ZFDYPMLIST=NULL,"
						+ "BZXX = '" + imagefilename + "'" + " where requestid ='" + rid + "'";
				baseBean.writeLog("ProductNameVerifyA:" + sql);
				rs.executeSql(sql);
			}
			rs.execute(sql);
		} catch (Exception e) {
			request.getRequestManager().setMessageid("404");
			request.getRequestManager().setMessagecontent("系统异常，请联系管理员");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("ProductNameVerifyA error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}

}
