package weaver.interfaces.workflow.action.recipe.cc;

import org.json.JSONObject;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.sap.HttpClientJson;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

public class RecipeAction_2 implements Action {

	private static final String url = "http://172.16.20.170:8080/MesWebService/reqems";
	// http://172.22.16.170:8080/MesWebService/reqems 崇川

	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();

			String YHNR = "";
			String GOLDENCXZZRY_GX = "";
			String CXM_GX = "";
			String JTXH_GX = "";
			String OPERATION_GX = "";
			String WIRECOUNT = "";
			String RULE_NAME = "";
			String RULE_NAMES = "";
			String PAD_LIMIT = "";
			String LEAD_LIMIT = "";
			String DOWN_LIMIT = "";
			String sql = "";
			String PADLIMITDW = "";
			String LEADLIMITDW = "";
			String DOWNLIMITDW = "";
			String DESCRIPTION = "";
			String EMSSPECNO = "";
			
			Property[] properties = request.getMainTableInfo().getProperty();// 获取表单主字段信息
			for (int i = 0; i < properties.length; i++) {// 主表数据
				String name = properties[i].getName().toUpperCase();// 字段名
				String value = Util.null2String(properties[i].getValue());// 值
				// 优化内容
				if (name.equals("YHNR")) {
					YHNR = value;
				}
				// Golden程序制作人员:(PE)（更新limit）
				if (name.equals("GOLDENCXZZRY_GX")) {
					GOLDENCXZZRY_GX = value;
				}
				// 程序名/Recipe ID（更新limit）
				if (name.equals("CXM_GX")) {
					CXM_GX = value;
				}
				// 机台型号：（更新limit）
				if (name.equals("JTXH_GX")) {
					JTXH_GX = value;
				}
				// Operation：（更新limit）
				if (name.equals("OPERATION_GX")) {
					OPERATION_GX = value;
				}
				// 通用Rule（更新limit）
				if (name.equals("RULE_NAME")) {
					RULE_NAME = value;
				}
				// 特殊Rule（更新limit）
				if (name.equals("RULE_NAMES")) {
					RULE_NAMES = value;
				}
				// pad limit（更新limit）
				if (name.equals("PAD_LIMIT")) {
					PAD_LIMIT = value;
				}
				// Lead Limit（更新limit）
				if (name.equals("LEAD_LIMIT")) {
					LEAD_LIMIT = value;
				}
				// Down Limit（更新limit）
				if (name.equals("DOWN_LIMIT")) {
					DOWN_LIMIT = value;
				}
				// pad limit 单位
				if (name.equals("PADLIMITDW")) {
					PADLIMITDW = value;
				}
				// Lead Limit单位
				if (name.equals("LEADLIMITDW")) {
					LEADLIMITDW = value;
				}
				// Down Limit单位
				if (name.equals("DOWNLIMITDW")) {
					DOWNLIMITDW = value;
				}
				// 备注信息
				if (name.equals("DESCRIPTION")) {
					DESCRIPTION = value;
				}
				// SPEC_NO
				if (name.equals("EMSSPECNO")) {
					EMSSPECNO = value;
				}
			}
			String description = " ";
			String peId = " ";
			String recipeId = " ";
			String operation = " ";
			String eqType = " ";
			String commonRuleFlag = " ";
			String specialRuleFlag = " ";
			String padUnit = " ";
			String leadUnit = " ";
			String downUnit = " ";
			String specNo = " ";
			int commonRuleSeq = 0;
			int specialRuleSeq = 0;
			double padTolerance = 0;
			double leadTolerance = 0;
			double downTolerance = 0;
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
			String udpatetime = sdf.format(date);
			String workcode = "";
			// 如果是需要TE再处置，插入新表

			// description = "更新程序";// 备注信息
			sql = "select workcode  from hrmresource where id= " + GOLDENCXZZRY_GX;
			rs.executeSql(sql);
			while (rs.next()) {
				peId = rs.getString("workcode");
			}
			specNo = EMSSPECNO;
			recipeId = CXM_GX;
			operation = OPERATION_GX;
			eqType = JTXH_GX;
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
			padTolerance = Double.parseDouble(PAD_LIMIT);
			leadTolerance = Double.parseDouble(LEAD_LIMIT);
			downTolerance = Double.parseDouble(DOWN_LIMIT);
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
			req.put("functionName", "EMS_WBRECIPEUPDATE");
			req.put("token", "OATESTTOKEN");
			JSONObject message = new JSONObject();
			message.put("description", description);
			message.put("peId", peId);
			message.put("recipeId", recipeId);
			message.put("specNo", specNo);
			message.put("operation", operation);
			message.put("eqType", eqType);
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
			baseBean.writeLog("RecipeAction_2 开始传输数据");
			String retSrcs = HttpClientJson.readInterfacePost(url, req.toString());
			baseBean.writeLog(retSrcs);
			baseBean.writeLog("RecipeAction_2 数据传输结束");
			baseBean.writeLog("RecipeAction_2 程序开始拉取返回结果。。。");
			JSONObject results = new JSONObject(retSrcs);
			baseBean.writeLog("RecipeAction_2 返回结果拉取成功！");
			String statusValue = results.get("statusValue").toString();
			String msg = results.get("msg").toString();
			if (!statusValue.equals("0")) {
				// 针对节点后附加操作，控制流程流转
				request.getRequestManager().setMessageid("222222");
				request.getRequestManager().setMessagecontent("EMS调用失败，请联系管理员:" + msg);
				baseBean.writeLog("EMS调用失败，请联系管理员");
			} else {
				baseBean.writeLog("RecipeAction_2 success");
			}

		} catch (java.lang.Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("RecipeAction_2 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}
