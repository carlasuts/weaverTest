/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.workflow.action.customerComplaints
 * File Name   : P1InitiatorDetermine.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018��9��20��     zong.yq     Create by Generator
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
		baseBean.writeLog("P1InitiatorDetermine��ʼִ��");
		RecordSet rs = new RecordSet();
		String requestId = request.getRequestid();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		try {
			sql = "SELECT MAX(GROUPID) GROUPID FROM WORKFLOW_CURRENTOPERATOR WHERE REQUESTID = '" + requestId
					+ "' AND NODEID = '4202'";
			rs.execute(sql);
			rs.next();
			String groupId = rs.getString("GROUPID");
			baseBean.writeLog("����groupid: " + groupId);

			sql = "SELECT RECEIVEDATE FROM WORKFLOW_CURRENTOPERATOR WHERE REQUESTID = '" + requestId
					+ "' AND NODEID = '4202' AND GROUPID = '" + groupId + "'";
			rs.execute(sql);
			rs.next();
			baseBean.writeLog("ȡP1������˽ڵ����ʱ��sql: " + sql);
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
			baseBean.writeLog("ȡP1�ύʱ��");
			String OPERATEDATE = rs.getString("OPERATEDATE");
			baseBean.writeLog("OPERATEDATE: " + OPERATEDATE);
			Date p1OperateDate = sdf.parse(OPERATEDATE);

			// 8D�ظ�����
			String hour = String.valueOf((determineDate.getTime() - p1OperateDate.getTime()) / (1000 * 60 * 60));

			sql = "UPDATE CUSTOMER_COMPLAINTS SET HOUR8D = '" + hour + "' WHERE REQUESTID = '" + requestId + "'";
			baseBean.writeLog("���µ���Ϊ" + requestId + "��8D�ظ�ʱ��sql: " + sql);
			rs.execute(sql);
		} catch (ParseException e) {
			baseBean.writeLog("���淢���˴���");
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}

}
