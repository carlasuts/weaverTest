/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.workflow.action.tranport
 * File Name   : TransportAction.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年8月29日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.workflow.action.transport;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author zong.yq
 *
 */
    public class TransportAction implements Action {

	@Override
	public String execute(RequestInfo request) {
		BaseBean baseBean = new BaseBean();
		baseBean.writeLog("TransportAction 开始执行...");
		RecordSet rs = new RecordSet();
		String requestId = request.getRequestid();
		String workflowId = request.getWorkflowid();
		int formId = Math.abs(request.getRequestManager().getFormid());

		String sql = "SELECT * FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
		rs.execute(sql);
		rs.next();
		// 临时、长期送货
		int iftemporary = rs.getInt("IFTEMPORARY");
		// 货运时间
		int longTime = rs.getInt("LONGTIME");
        // 货运公司
		String transCompany = rs.getString("TRANS_COMPANY");
		baseBean.writeLog("longTime: " + longTime);

		if (iftemporary != 0) {
			baseBean.writeLog("长期送货");
            // 判断是否为新建流程
			sql = "SELECT MAINREQUESTID FROM WORKFLOW_REQUESTBASE WHERE REQUESTID = '" + requestId + "'";
			rs.execute(sql);
			rs.next();
			String mainrequestid = rs.getString("MAINREQUESTID");
			if (mainrequestid == "") {
				baseBean.writeLog("此流程为新建流程");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				Date date = new Date();
				String time = sdf.format(date);
				BigInteger currentId = new BigInteger(time);
				sql = "UPDATE FORMTABLE_MAIN_" + formId + " SET EFFECTIVE_DAYS = 0 WHERE REQUESTID = '" + requestId
						+ "'";
				rs.execute(sql);
				sql = "SELECT CURRENTID FROM WORKFLOWSEQINDEX WHERE FLOWID='22106' AND PLANTOPT='1000' AND RULEDESC='FORWARDERLONGDATE' AND INDEXDESC = '"
						+ transCompany + "'";
				rs.execute(sql);
				if (rs.next()) {
                    // 如果sql能取到值 则更新currentid和长期送货时间 0为三个月 1为六个月
					baseBean.writeLog("当前货运公司已在WORKFLOWSEQINDEX表中存值了");
					sql = "UPDATE WORKFLOWSEQINDEX SET CURRENTID = " + currentId + ", SET INDEXDESCTWO = " + longTime
							+ " WHERE FLOWID='22106' AND PLANTOPT='1000' AND RULEDESC='FORWARDERLONGDATE' AND INDEXDESC = '"
							+ transCompany + "'";
					rs.execute(sql);
				} else {
					baseBean.writeLog("当前货运公司还未在WORKFLOWSEQINDEX表中存值");
					sql = "INSERT INTO WORKFLOWSEQINDEX(FLOWID, PLANTOPT, RULEDESC, INDEXDESC, CURRENTID, INDEXDESCTWO) VALUES (22106, '1000', 'FORWARDERLONGDATE', '"
							+ transCompany + "', " + currentId + ", " + longTime + ")";
					rs.execute(sql);
				}
			} else {
				baseBean.writeLog("此流程为触发流程");
				sql = "SELECT CURRENTID FROM WORKFLOWSEQINDEX WHERE FLOWID = '22106' AND PLANTOPT = '1000' AND RULEDESC = 'FORWARDERLONGDATE'  AND INDEXDESC = '"
						+ transCompany + "'";
				rs.execute(sql);
				rs.next();
				String currentId = rs.getString("CURRENTID");
				baseBean.writeLog("currentId: " + currentId);
				currentId = currentId.substring(0, 8);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				try {
					Date date = sdf.parse(currentId);
					String time = sdf.format(new Date());
					Date date1 = sdf.parse(time);
                    // 生效天数
					int days = (int) ((date1.getTime() - date.getTime()) / (1000 * 60 * 60 * 24));
					sql = "UPDATE FORMTABLE_MAIN_" + formId + " SET EFFECTIVE_DAYS = " + days + " WHERE REQUESTID = '"
							+ requestId + "'";
					rs.execute(sql);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		} else {
			baseBean.writeLog("临时送货");
		}
		return Action.SUCCESS;
	}

}