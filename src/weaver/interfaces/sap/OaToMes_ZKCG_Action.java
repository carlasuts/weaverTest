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
			sql = "SELECT a.LOT_CODE,a.MATERIAL FROM FORMTABLE_MAIN_68_DT2 a INNER JOIN FORMTABLE_MAIN_68 b ON b.ID = a.MAINID WHERE b.REQUESTID = '"
					+ requsetId + "'";
			rs.execute(sql);
			while (rs.next()) {
				json.put("userId", "OA");
				json.put("factory", "FGS");
				json.put("lotId", rs.getString("LOT_CODE"));
				json.put("matId", rs.getString("MATERIAL"));
				json.put("matVer", "1");
				json.put("delCode", "NOSENDSAP");
				req.put("message", json);
				req.put("fromSystem", "TEST");
				req.put("functionName", "MES_TERMINATELOT");
				req.put("token", "TOKEN");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Override
	public String execute(RequestInfo arg0) {
		return null;
	}

}
