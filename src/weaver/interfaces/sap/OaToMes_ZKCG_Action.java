package weaver.interfaces.sap;

import net.sf.json.JSONObject;
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
	JSONObject message = new JSONObject();

	public void oaToMes(RequestInfo requst) {
		
	}

	@Override
	public String execute(RequestInfo arg0) {
		return null;
	}

}
