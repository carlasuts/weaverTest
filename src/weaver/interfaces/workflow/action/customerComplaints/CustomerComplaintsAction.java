/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.workflow.action.customerComplaints
 * File Name   : CustomerComplaintsAction.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年9月19日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action.customerComplaints;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.RequestInfo;

/**
 * @author zong.yq
 *
 */
public class CustomerComplaintsAction implements Action {
	private String sql = "";

	@Override
	public String execute(RequestInfo request) {
		BaseBean baseBean = new BaseBean();
		baseBean.writeLog("CustomerComplaintsAction开始执行");
		RecordSet rs = new RecordSet();
		String requestId = request.getRequestid();
		String workflowId = request.getWorkflowid();
		int formid = BillUtil.getFormId(Integer.parseInt(workflowId));

		sql = "SELECT RECEIVEDATE FROM WORKFLOW_CURRENTOPERATOR WHERE REQUESTID = '" + requestId
				+ "' and nodeid = '4161'";// P1节点的申请日期
		rs.execute(sql);
		rs.next();
		String receiveDate = rs.getString("RECEIVEDATE");
		String month = receiveDate.substring(5, 7);// 取到月份
		String year = receiveDate.substring(2, 4);// 年份后两位

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			cal.setTime(sdf.parse(receiveDate));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String week = year + String.valueOf(cal.get(Calendar.WEEK_OF_YEAR));
		
		baseBean.writeLog("月份: " + month);
		baseBean.writeLog("周次 " + week);

		sql = "UPDATE FORMTABLE_MAIN_" + formid + " SET MONTH = '" + month + "', WEEK = '" + week + "' WHERE REQUESTID = '" + requestId + "'";
		baseBean.writeLog("向主表中插入月份和周次:" + sql);
		rs.execute(sql);
		
		sql = "SELECT RELATEDOWNER, RESPONSIBLEDEPT FROM FORMTABLE_MAIN_" + formid + " WHERE REQUESTID = '" + requestId + "'";
		rs.execute(sql);
		rs.next();
		String RELATEDOWNER = rs.getString("RELATEDOWNER");
		String RESPONSIBLEDEPT = rs.getString("RESPONSIBLEDEPT");
		String[] names = RELATEDOWNER.split(",");
		String[] departs = RESPONSIBLEDEPT.split(",");
		String name = "";
		String depart = "";
		for (String string : names) {
			sql = "SELECT LASTNAME FROM HRMRESOURCE WHERE ID = '" + string + "'";
			rs.execute(sql);
			rs.next();
			String lastname = rs.getString("LASTNAME");
			name = name + lastname + ",";
		}
		for (String string : departs) {
			sql = "SELECT DEPARTMENTNAME FROM HRMDEPARTMENT WHERE ID = '" + string + "'";
			rs.execute(sql);
			rs.next();
			String departmentname = rs.getString("DEPARTMENTNAME");
			depart = depart + departmentname + ",";
		}
		name = name.substring(0, name.length() - 1);
		depart = depart.substring(0, depart.length() - 1);
		baseBean.writeLog("name: " + name);
		baseBean.writeLog("depart: " + depart);
		
		sql = "SELECT * FROM CUSTOMER_COMPLAINTS WHERE REQUESTID = '" + requestId + "'";
		rs.execute(sql);
		if (rs.next()) {
			sql = "UPDATE CUSTOMER_COMPLAINTS SET NAME = '" + name + "', DEPARTMENT = '" + depart + "' WHERE REQUESTID = '" + requestId + "'";
			rs.execute(sql);
		} else {
			sql = "INSERT INTO CUSTOMER_COMPLAINTS (REQUESTID, NAME, DEPARTMENT) VALUES ('" + requestId + "', '" + name + "', '" + depart + "')";
			rs.execute(sql);
		}
		
		return Action.SUCCESS;
	}

}
