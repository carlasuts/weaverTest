package weaver.interfaces.workflow.action.recipe.cc;

import org.json.JSONObject;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.sap.HttpClientJson;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

public class RecipeAction_1 implements Action {

	private static final String url = "http://172.16.20.170:8080/MesWebService/reqems";

	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();

			String WIRECOUNT = "";
			String GOLDENCXZZRY = "";
			String RECIPEID = "";
			String EMSSPECNO = "";
			String JTXH = "";
			String JTHM = "";
			String OPERATION = "";
			String YHNR = "";
			String PDXH = "";
			String PDSM = "";
			String CHOPPERCHECK = "";
			String RULE_NAME = "";
			String RULE_NAMES = "";
			String PADLIMIT = "";
			String LEADLIMIT = "";
			String DOWNLIMIT = "";
			String PADLIMITDW = "";
			String LEADLIMITDW = "";
			String DOWNLIMITDW = "";
			String DESCRIPTION = "";// 备注信息
			String sql = "";

			Property[] properties = request.getMainTableInfo().getProperty();// 获取表单主字段信息
			for (int i = 0; i < properties.length; i++) {// 主表数据
				String name = properties[i].getName().toUpperCase();// 字段名
				String value = Util.null2String(properties[i].getValue());// 值
				if (name.equals("YHNR")) {
					YHNR = value;
				}
				if (name.equals("GOLDENCXZZRY")) {
					GOLDENCXZZRY = value;
				}
				if (name.equals("RECIPEID")) {
					RECIPEID = value;
				}
				if (name.equals("EMSSPECNO")) {
					EMSSPECNO = value;
				}
				if (name.equals("JTXH")) {
					JTXH = value;
				}
				if (name.equals("JTHM")) {
					JTHM = value;
				}
				if (name.equals("OPERATION")) {
					OPERATION = value;
				}
				if (name.equals("WIRECOUNT")) {
					WIRECOUNT = value;
				}
				if (name.equals("PDXH")) {
					PDXH = value;
				}
				if (name.equals("PDSM")) {
					PDSM = value;
				}
				if (name.equals("CHOPPERCHECK")) {
					CHOPPERCHECK = value;
				}
				if (name.equals("RULE_NAME")) {
					RULE_NAME = value;
				}
				if (name.equals("RULE_NAMES")) {
					RULE_NAMES = value;
				}
				if (name.equals("PADLIMIT")) {
					PADLIMIT = value;
				}
				if (name.equals("LEADLIMIT")) {
					LEADLIMIT = value;
				}
				if (name.equals("DOWNLIMIT")) {
					DOWNLIMIT = value;
				}
				if (name.equals("PADLIMITDW")) {
					PADLIMITDW = value;
				}
				if (name.equals("LEADLIMITDW")) {
					LEADLIMITDW = value;
				}
				if (name.equals("DOWNLIMITDW")) {
					DOWNLIMITDW = value;
				}
				if (name.equals("DESCRIPTION")) {
					DESCRIPTION = value;
				}
			}

			/* 备注信息 */
			String description = " ";
			/* WORKCODE */
			String peId = " ";
			/* RECIPE ID */
			String recipeId = " ";
			/* SPEC NO */
			String specNo = " ";
			/* OPERATION */
			String operation = " ";
			/* 机台型号 */
			String eqType = " ";
			/* 机台号码 */
			String eqId = " ";
			/* 劈刀型号 */
			String chopper = " ";
			/* 默认写死为N */
			String chopperCheck = " ";
			/* 通用rule */
			String commonRuleFlag = " ";
			/* 特殊rule */
			String specialRuleFlag = " ";
			/* 单位 */
			String padUnit = " ";
			/* 单位 */
			String leadUnit = " ";
			/* 单位 */
			String downUnit = " ";
			/* 丝数 */
			int wireCount = 0;
			/* 劈刀寿命 */
			int chopperLife = 0;
			/* 通用rule 值 */
			int commonRuleSeq = 0;
			/* 特殊rule 值 */
			int specialRuleSeq = 0;
			/* 值（double） */
			double padTolerance = 0;
			/* 值 */
			double leadTolerance = 0;
			/* 值 */
			double downTolerance = 0;
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
			String udpatetime = sdf.format(date);
			String workcode = "";

			// description = "更新程序";// 备注信息

			sql = "select workcode  from hrmresource where id= " + GOLDENCXZZRY;
			baseBean.writeLog("取工号: " + sql);
			rs.executeSql(sql);
			while (rs.next()) {
				peId = rs.getString("workcode");
			}
			recipeId = RECIPEID;// CU6560094T
			specNo = EMSSPECNO;// CU6560094T
			operation = OPERATION;// 6030
			eqType = JTXH;// KNS ICONN
			eqId = JTHM;// EAPSKW
			wireCount = Integer.parseInt(WIRECOUNT);// 32
			chopper = PDXH;// ABCD
			chopperLife = Integer.parseInt(PDSM);// 600000
			chopperCheck = "N";
			description = DESCRIPTION;

			if (!RULE_NAME.equals("") && !RULE_NAME.equals(" ")) {
				commonRuleSeq = Integer.parseInt(RULE_NAME);
				commonRuleFlag = "Y";
			} else {
				commonRuleFlag = "Y";
				commonRuleSeq = 0;
			}

			if (!RULE_NAMES.equals("") && !RULE_NAMES.equals(" ")) {
				specialRuleSeq = Integer.parseInt(RULE_NAMES);
				specialRuleFlag = "Y";
			} else {
				specialRuleFlag = "Y";
				specialRuleSeq = 0;
			}
			padTolerance = Double.parseDouble(PADLIMIT);
			leadTolerance = Double.parseDouble(LEADLIMIT);
			downTolerance = Double.parseDouble(DOWNLIMIT);

			baseBean.writeLog("padTolerance: " + padTolerance);
			baseBean.writeLog("leadTolerance: " + leadTolerance);
			baseBean.writeLog("downTolerance: " + downTolerance);

			if (PADLIMITDW == "1") {
				padUnit = "μm";
			} else {
				padUnit = "mil";
			}
			if (LEADLIMITDW == "1") {
				leadUnit = "μm";
			} else {
				leadUnit = "mil";
			}
			if (DOWNLIMITDW == "1") {
				downUnit = "μm";
			} else {
				downUnit = "mil";
			}

			JSONObject req = new JSONObject();
			req.put("fromSystem", "OA");
			req.put("functionName", "EMS_WBRECIPECONFIRM");
			req.put("token", "OATESTTOKEN");

			JSONObject message = new JSONObject();
			message.put("description", description);
			message.put("peId", peId);
			message.put("recipeId", recipeId);
			message.put("specNo", specNo);
			message.put("operation", operation);
			message.put("eqType", eqType);
			message.put("eqId", eqId);
			message.put("wireCount", wireCount);
			message.put("chopper", chopper);
			message.put("chopperLife", chopperLife);
			message.put("chopperCheck", chopperCheck);
			message.put("commonRuleFlag", commonRuleFlag);
			message.put("commonRuleSeq", commonRuleSeq);
			message.put("specialRuleFlag", specialRuleFlag);
			message.put("specialRuleSeq", specialRuleSeq);
			message.put("padTolerance", padTolerance);
			message.put("leadTolerance", leadTolerance);
			message.put("downTolerance", downTolerance);
			message.put("padUnit", padUnit);
			message.put("leadUnit", leadUnit);
			message.put("downUnit", downUnit);

			req.put("message", message);
			baseBean.writeLog("message: " + req.toString());
			baseBean.writeLog("****************************");
			baseBean.writeLog("RecipeAction_1 开始传输数据");
			String retSrcs = HttpClientJson.readInterfacePost(url, req.toString());
			baseBean.writeLog(retSrcs);
			baseBean.writeLog("RecipeAction_1 数据传输结束");
			baseBean.writeLog("RecipeAction_1 程序开始拉取返回结果。。。");
			JSONObject results = new JSONObject(retSrcs);
			baseBean.writeLog("RecipeAction_1 返回结果拉取成功！");
			String statusValue = results.get("statusValue").toString();
			baseBean.writeLog("statusValue: " + statusValue);
			String msg = results.get("msg").toString();
			if (!statusValue.equals("0")) {
				request.getRequestManager().setMessageid("Exception");
				request.getRequestManager().setMessagecontent("EMS调用失败，请联系管理员:" + msg);
				baseBean.writeLog("EMS调用失败，请联系管理员");
			} else {
				baseBean.writeLog("RecipeAction_1 success");
			}
		} catch (java.lang.Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("RecipeAction_1 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}
