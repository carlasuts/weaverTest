package weaver.interfaces.sap;

import net.sf.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

/**
 * 2017-8-16 星期三
 * 
 * @author zong.yq
 * 
 *         在库重工oa传mes
 */
public class OaToMes_ZKCG_Action implements Action {

	private static final String url = "";
	private BaseBean baseBean = new BaseBean();

	JSONObject req = new JSONObject();
	JSONObject json = new JSONObject();
	String sql = "";
	RecordSet rs = new RecordSet();

	public void oaToMes(RequestInfo request) {
		String requsetId = request.getRequestid();// 获取当前流程的requsetId
		try {
			sql = "SELECT a.LOT_CODE,a.MATERIAL FROM FORMTABLE_MAIN_68_DT1 a INNER JOIN FORMTABLE_MAIN_68 b ON b.ID = a.MAINID WHERE b.REQUESTID = '"
					+ requsetId + "'";// 获取当前requestId的明细表1的内容
			rs.execute(sql);
			while (rs.next()) {
				json.put("userId", "OA");// 用户id 固定写死为OA
				json.put("factory", "FGS");// 工厂 固定写死为FGS
				json.put("lotId", rs.getString("LOT_CODE"));// 明细表1生产批号
				json.put("matId", rs.getString("MATERIAL"));// 明细表1料号
				json.put("matVer", "1");
				json.put("delCode", "NOSENDSAP");
				req.put("message", json);
				req.put("fromSystem", "TEST");
				req.put("functionName", "MES_TERMINATELOT");
				req.put("token", "TESTTOKEN");
				String retSrcs = HttpClientJson.readInterfacePost("http://172.16.59.54:8080/MesWebService/req",
						req.toString());// 向MES传输json对象
				baseBean.writeLog(retSrcs);// 抓取返回值
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public String execute(RequestInfo arg0) {
		return null;
	}

}
