package weaver.interfaces.mes.action;

import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class OaToMes_Mat_Post implements Action {

	@Override
	public String execute(RequestInfo request) {

		BaseBean basebean = new BaseBean();
		try {
			basebean.writeLog("***TFMEPOST开始执行***");
			OaToMes_Mat_Action oaToMes_Mat_Action = new OaToMes_Mat_Action();
			basebean.writeLog("开始执行OaToMes_MainData内的oaToMes方法");
			oaToMes_Mat_Action.oaToMes(request);
		} catch (Exception e) {
			basebean.writeLog("start log");
			basebean.writeLog("------------------------------------------------------------------------");
			basebean.writeLog("TFMEPOST error" + e.getMessage());
			basebean.writeLog("------------------------------------------------------------------------");
			basebean.writeLog("end log");
		}
		return Action.SUCCESS;
	}

}
