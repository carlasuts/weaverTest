/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : weaver.interfaces.schedule
 * File Name   : SatisfactionSurveys.java
 * Description : Satisfaction plan task
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年8月8日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package weaver.interfaces.schedule;

import java.text.SimpleDateFormat;
import java.util.Date;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.RequestService;

/**
 * @author zong.yq
 *
 */
public class SatisfactionSurveys extends BaseCronJob {
	BaseBean baseBean = new BaseBean();
	String sql = "";

	public void execute() {
		RecordSet rs = new RecordSet();
		baseBean.writeLog("SatisfactionSurveys开始执行！");
		// 通过SQL查询出满足触发流程条件的数据
		String sql = "WITH BASE	AS (SELECT WR.WORKFLOWID AS WORKFLOWID,	WR.CREATER AS CREATER, COUNT (WR.REQUESTID) AS USE_QTY FROM USERS_SATISFACTION_RULE UR LEFT JOIN WORKFLOW_REQUESTBASE WR ON UR.WORKFLOWID = wr.WORKFLOWID GROUP BY WR.WORKFLOWID, WR.CREATER) SELECT BASE.* FROM BASE, USERS_SATISFACTION_RULE US WHERE BASE.WORKFLOWID = US.WORKFLOWID AND BASE.USE_QTY >= US.USE_QTY";
		rs.execute(sql);

		while (rs.next()) {
			String workflowId = rs.getString("WORKFLOWID");// 流程ID
			String creator = rs.getString("CREATER");// 创建者 24
			int qty_actual = rs.getInt("USE_QTY");// 实际创建条数

			sql = "SELECT STATUS FROM HRMRESOURCE WHERE ID = '" + creator + "'";
			baseBean.writeLog("查询此人是否失效sql: " + sql);
			RecordSet rs4 = new RecordSet();
			rs4.execute(sql);
			rs4.next();
			String status = rs4.getString("STATUS");
			if (Integer.valueOf(status) == 0 || Integer.valueOf(status) == 1) {// 此人员在OA系统中状态为有效
				sql = "SELECT * FROM USERS_SATISFACTION_INFO WHERE WORKFLOWID =  '" + workflowId + "' AND CREATOR = '"
						+ creator + "'";
				baseBean.writeLog("sql: " + sql);
				RecordSet rs1 = new RecordSet();
				rs1.execute(sql);
				if (!rs1.next()) {// 判断信息存储表,根据流程ID和申请人工号,如果不能查询到数据
					baseBean.writeLog("未查询到数据");
					Date date = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
					String time = sdf.format(date);
					// 触发流程
					String newRequestid = trigger(workflowId, creator);
					if (newRequestid != null || newRequestid != "") {
						sql = "INSERT INTO USERS_SATISFACTION_INFO (WORKFLOWID, CREATOR, USE_QTY, CREATE_TIME) VALUES ('"
								+ workflowId + "', '" + creator + "', " + qty_actual + ", '" + time + "')";
						rs1 = new RecordSet();
						rs1.execute(sql);
					} else {
						baseBean.writeLog("流程触发失败");
					}
				} else {// 如果能查到数据
					baseBean.writeLog("查询到数据");
					String endFlag = rs1.getString("END_FLAG");// 归档标记位
					baseBean.writeLog("endFlag: " + endFlag);
					String createFlag = rs1.getString("CREATE_FLAG");// 是否再次触发流程标记位
					baseBean.writeLog("createFlag: " + createFlag);
					int qty = rs1.getInt("USE_QTY");// 信息表中的
					baseBean.writeLog("qty: " + qty);
					String updateTime = rs1.getString("UPDATE_TIME");// 更新日期
					baseBean.writeLog("updateTime: " + updateTime);
					if (!createFlag.equals("N") && endFlag.equals("Y")) {
						sql = "SELECT USE_QTY FROM USERS_SATISFACTION_RULE WHERE WORKFLOWID = '" + workflowId + "'";
						RecordSet rs2 = new RecordSet();
						rs2.execute(sql);
						rs2.next();
						int qty_rule = rs2.getInt("USE_QTY");
						int result = qty_actual - qty;
						String currenttime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
						if (result >= qty_rule && !currenttime.equals(updateTime)) {
							// 触发流程
							baseBean.writeLog("查询到数据并且符合触发流程的条件");
							String newRequestid = trigger(workflowId, creator);
							if (newRequestid != null || newRequestid != "") {
								sql = "UPDATE USERS_SATISFACTION_INFO SET USE_QTY = '" + qty_actual
										+ "', END_FLAG ='N' WHERE WORKFLOWID = '" + workflowId + "' AND CREATOR = '"
										+ creator + "'";
								RecordSet rs3 = new RecordSet();
								rs3.execute(sql);
							} else {
								baseBean.writeLog("流程触发失败");
							}
						}
					}
				}
			}
		}
	}

	public String trigger(String workflowId, String creator) {
		RecordSet rs = new RecordSet();
		RequestInfo requestInfo = new RequestInfo();
		MainTableInfo mainTableInfo = new MainTableInfo();
		String newRequestid = "";
		sql = "SELECT WORKFLOWNAME FROM WORKFLOW_BASE WHERE ID = '" + workflowId + "'";
		rs.execute(sql);
		rs.next();
		String workflowName = rs.getString("WORKFLOWNAME");// 调查的流程的名称
		sql = "SELECT DEPARTMENTID FROM HRMRESOURCE WHERE ID = '" + creator + "'";
		rs.execute(sql);
		rs.next();
		String dept = rs.getString("DEPARTMENTID");
		baseBean.writeLog("workflowName:" + workflowName);
		String createTime = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

		Property[] propertyArray = new Property[5];
		propertyArray[0] = new Property();
		propertyArray[0].setName("FUNC");
		propertyArray[0].setValue(workflowName);

		propertyArray[1] = new Property();
		propertyArray[1].setName("SYSTEM");
		propertyArray[1].setValue("0");

		propertyArray[2] = new Property();
		propertyArray[2].setName("USERNAME");
		propertyArray[2].setValue(creator);

		propertyArray[3] = new Property();
		propertyArray[3].setName("DEPT");
		propertyArray[3].setValue(dept);

		propertyArray[4] = new Property();
		propertyArray[4].setName("FILL_DATE");
		propertyArray[4].setValue(createTime);

		mainTableInfo.setProperty(propertyArray);

		// 触发流程
		requestInfo.setCreatorid(creator);
		requestInfo.setWorkflowid("20106");// 正式环境 20106 测试环境 18921
		requestInfo.setDescription("用户满意度调查-OA-" + workflowName);// 标题为流程标题＋系统＋调查的流程

		requestInfo.setMainTableInfo(mainTableInfo);// 设置主表信息
		RequestService service = new RequestService();// 创建请求服务实例

		try {
			newRequestid = service.createRequest(requestInfo);
			baseBean.writeLog("用户满意度:" + newRequestid);
			return newRequestid;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}
