package weaver.interfaces.sap;

import weaver.general.BaseBean;
import weaver.interfaces.dao.CInfSpeDatDao;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class TFMEPOST implements Action {

	@Override
	public String execute(RequestInfo request) {

		BaseBean basebean = new BaseBean();
		try {
			basebean.writeLog("***TFMEPOST开始执行***");
			PostTest postTest = new PostTest();
			basebean.writeLog("开始执行PostTest内的oaToMes方法");
			postTest.oaToMes(request);
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
