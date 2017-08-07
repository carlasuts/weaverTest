package weaver.interfaces.sap;

import java.text.SimpleDateFormat;
import java.util.Date;

import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.RequestInfo;

public class TFMECINFSPEDAT implements Action {

	public String execute(RequestInfo request) {

		try {
			BaseBean e = new BaseBean();
			MainTableInfo maintableinfo = request.getMainTableInfo();
			e.writeLog("start");
			String sql = "";
			Date d = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nd = sf.format(d);
			String creator = request.getCreatorid();
			e.writeLog("=====================");
			String rid = request.getRequestid();
			e.writeLog("request" + rid);
			e.writeLog("----------------");
			DetailTable[] detailtable = request.getDetailTableInfo().getDetailTable();
			CINFSPEDAT spe = new CINFSPEDAT();
			spe.insert(detailtable[0], rid, maintableinfo, creator);
			e.writeLog("CINFSPEDAT接口数据处理");

			e.writeLog("end");

		} catch (java.lang.Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("TFMECINFSPEDAT error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}

}
