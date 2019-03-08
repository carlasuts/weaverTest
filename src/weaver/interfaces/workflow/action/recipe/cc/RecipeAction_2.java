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
	// http://172.22.16.170:8080/MesWebService/reqems �紨

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
			
			Property[] properties = request.getMainTableInfo().getProperty();// ��ȡ�����ֶ���Ϣ
			for (int i = 0; i < properties.length; i++) {// ��������
				String name = properties[i].getName().toUpperCase();// �ֶ���
				String value = Util.null2String(properties[i].getValue());// ֵ
				// �Ż�����
				if (name.equals("YHNR")) {
					YHNR = value;
				}
				// Golden����������Ա:(PE)������limit��
				if (name.equals("GOLDENCXZZRY_GX")) {
					GOLDENCXZZRY_GX = value;
				}
				// ������/Recipe ID������limit��
				if (name.equals("CXM_GX")) {
					CXM_GX = value;
				}
				// ��̨�ͺţ�������limit��
				if (name.equals("JTXH_GX")) {
					JTXH_GX = value;
				}
				// Operation��������limit��
				if (name.equals("OPERATION_GX")) {
					OPERATION_GX = value;
				}
				// ͨ��Rule������limit��
				if (name.equals("RULE_NAME")) {
					RULE_NAME = value;
				}
				// ����Rule������limit��
				if (name.equals("RULE_NAMES")) {
					RULE_NAMES = value;
				}
				// pad limit������limit��
				if (name.equals("PAD_LIMIT")) {
					PAD_LIMIT = value;
				}
				// Lead Limit������limit��
				if (name.equals("LEAD_LIMIT")) {
					LEAD_LIMIT = value;
				}
				// Down Limit������limit��
				if (name.equals("DOWN_LIMIT")) {
					DOWN_LIMIT = value;
				}
				// pad limit ��λ
				if (name.equals("PADLIMITDW")) {
					PADLIMITDW = value;
				}
				// Lead Limit��λ
				if (name.equals("LEADLIMITDW")) {
					LEADLIMITDW = value;
				}
				// Down Limit��λ
				if (name.equals("DOWNLIMITDW")) {
					DOWNLIMITDW = value;
				}
				// ��ע��Ϣ
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
			// �������ҪTE�ٴ��ã������±�

			// description = "���³���";// ��ע��Ϣ
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
				padUnit = "��m";
			} else {
				padUnit = "mil";
			}
			if (LEADLIMITDW == "1") {
				leadUnit = "��m";
			} else {
				leadUnit = "mil";
			}
			if (DOWNLIMITDW == "1") {
				downUnit = "��m";
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
			baseBean.writeLog("RecipeAction_2 ��ʼ��������");
			String retSrcs = HttpClientJson.readInterfacePost(url, req.toString());
			baseBean.writeLog(retSrcs);
			baseBean.writeLog("RecipeAction_2 ���ݴ������");
			baseBean.writeLog("RecipeAction_2 ����ʼ��ȡ���ؽ��������");
			JSONObject results = new JSONObject(retSrcs);
			baseBean.writeLog("RecipeAction_2 ���ؽ����ȡ�ɹ���");
			String statusValue = results.get("statusValue").toString();
			String msg = results.get("msg").toString();
			if (!statusValue.equals("0")) {
				// ��Խڵ�󸽼Ӳ���������������ת
				request.getRequestManager().setMessageid("222222");
				request.getRequestManager().setMessagecontent("EMS����ʧ�ܣ�����ϵ����Ա:" + msg);
				baseBean.writeLog("EMS����ʧ�ܣ�����ϵ����Ա");
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
