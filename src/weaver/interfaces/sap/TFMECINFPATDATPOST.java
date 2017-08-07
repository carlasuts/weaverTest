package weaver.interfaces.sap;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.text.*;
import java.math.*;

import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.Row;
import weaver.general.BaseBean;

public class TFMECINFPATDATPOST implements Action {

	public String execute(RequestInfo request) {

		try {

			BaseBean e = new BaseBean();
			MainTableInfo maintableinfo = request.getMainTableInfo();
			e.writeLog("TFMECINFPATDATPOST start");
			String sql = "";
			Date d = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nd = sf.format(d);
			// String creator = request.getCreatorid();
			String creator = request.getLastoperator();
			e.writeLog("=====================");
			String rid = request.getRequestid();
			e.writeLog("request" + rid);
			e.writeLog("----------------");
			DetailTable[] detailtable = request.getDetailTableInfo()
					.getDetailTable();
			CINFPATDATPOST pat = new CINFPATDATPOST();
			pat.setcinfpatdat(detailtable[2], rid, maintableinfo, creator);

			e.writeLog("end");

		} catch (java.lang.Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("TFMECINFPATDATPOST error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}
