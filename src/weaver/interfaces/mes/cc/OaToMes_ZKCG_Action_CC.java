package weaver.interfaces.mes.cc;

import net.sf.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.sap.HttpClientJson;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 2017-8-16 星期三
 * 
 * @author zong.yq
 * 
 *         在库重工oa传mes
 */
public class OaToMes_ZKCG_Action_CC {

	private static int formId = 0;

	private static final String url = "http://172.16.60.96:8099/MesWebService/req";// http://172.16.60.96:8090/MesWebService/req(正式环境)
	private BaseBean baseBean = new BaseBean();

	JSONObject req = new JSONObject();
	JSONObject json = new JSONObject();
	String sql = "";
	RecordSet rs = new RecordSet();

	public void oaToMes(RequestInfo request) {
		baseBean.writeLog("oaToMes开始运行");
		formId = BillUtil.getFormId(Integer.parseInt(request.getWorkflowid()));
		String requsetId = request.getRequestid();// 获取当前流程的requsetId
		baseBean.writeLog("requestid:" + requsetId);
		try {
			sql = "SELECT a.LOT_CODE,a.MATERIAL FROM FORMTABLE_MAIN_" + formId + "_DT1 a INNER JOIN FORMTABLE_MAIN_"
					+ formId + " b ON b.ID = a.MAINID WHERE b.REQUESTID = '" + requsetId + "'";
			baseBean.writeLog(sql);
			rs.execute(sql);
			while (rs.next()) {
				json.put("userId", "OA");// 用户id 固定写死为OA
				json.put("factory", "FGS");// 工厂 固定写死为FGS
				json.put("lotId", rs.getString("LOT_CODE"));// 明细表1生产批号
				json.put("matId", rs.getString("MATERIAL"));// 明细表1料号
				json.put("matVer", "1");
				json.put("delCode", "NOSENDSAP");
				req.put("message", json);
				req.put("fromSystem", "OA");
				req.put("functionName", "MES_TERMINATELOT");
				req.put("token", "OATESTTOKEN");// AWK18VSE25SDNKLS3AET@EWL#LDG*!F
				String retSrcs = HttpClientJson.readInterfacePost(url, req.toString());// 向MES传输json对象
				baseBean.writeLog(retSrcs);// 抓取返回值
				org.json.JSONObject results = new org.json.JSONObject(retSrcs);
				String statusValue = results.get("statusValue").toString();
				int status = Integer.parseInt(statusValue);
				if (status != 0) {
					request.getRequestManager().setMessageid("Exception");
					request.getRequestManager().setMessagecontent("MES报废失败，" + results.get("msg").toString());
					baseBean.writeLog("MES报废失败，" + results.get("msg").toString());
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
