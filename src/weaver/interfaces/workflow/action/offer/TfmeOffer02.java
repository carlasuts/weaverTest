package weaver.interfaces.workflow.action.offer;

import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.RequestInfo;

public class TfmeOffer02 implements Action {

	public String execute(RequestInfo request) {

		try {

			BaseBean e = new BaseBean();
			String workflowid = request.getWorkflowid();
			MainTableInfo maintableinfo = request.getMainTableInfo();
			e.writeLog("start");
			e.writeLog("=====================");
			String rid = request.getRequestid();
			e.writeLog("request" + rid);
			e.writeLog("----------------");
			TfmeOffer_02 offer = new TfmeOffer_02();
			offer.getcostofcombined( rid, maintableinfo,workflowid);


			e.writeLog("end");

		} catch (java.lang.Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("OFFER02 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}
