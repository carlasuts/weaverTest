package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.Date;

import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.RequestInfo;

public class TFMECINFPATDAT implements Action {

	public String execute(RequestInfo request) {

		try {

			BaseBean e = new BaseBean();
			MainTableInfo maintableinfo = request.getMainTableInfo();
			e.writeLog("start");
			Date d = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String creator = request.getCreatorid();
			e.writeLog("=====================");
			String rid = request.getRequestid();
			e.writeLog("request" + rid);
			e.writeLog("----------------");
			DetailTable[] detailtable = request.getDetailTableInfo().getDetailTable();
			CINFPATDAT pat = new CINFPATDAT();
			pat.insert(detailtable[2], rid, maintableinfo, creator);
			e.writeLog("CINFPATDAT接口数据处理");

			e.writeLog("end");

		} catch (java.lang.Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("TFMECINFPATDAT error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}
