package weaver.interfaces.workflow.action.offer;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

public class TfmeOffer01 implements Action {

	public String execute(RequestInfo request) {

		try {

			BaseBean e = new BaseBean();
			RecordSet rs = new RecordSet();
			MainTableInfo maintableinfo = request.getMainTableInfo();
			
			Property[] Property = maintableinfo.getProperty();
			String id;
			e.writeLog("Property"+Property);
			String 	QUOTATION_WAY ="";
			for(int ss = 0; ss < Property.length; ++ss) {
	            String dataDB = Property[ss].getName().toUpperCase();
	            id = Util.null2String(Property[ss].getValue());
	            if(dataDB.equals("QUOTATION_WAY")) {
	            	QUOTATION_WAY = id;
	            }

			}
			e.writeLog("start");
			e.writeLog("报价方式 QUOTATION_WAY" +QUOTATION_WAY);
			String sql = "";
			String workflowid = request.getWorkflowid();
			int formid =BillUtil.getFormId(Integer.parseInt(workflowid));
			e.writeLog("=====================");
			String rid = request.getRequestid();
			e.writeLog("request" + rid);
			e.writeLog("----------------");
			
			if(QUOTATION_WAY.equals("0")){
				TfmeOffer_01 offer = new TfmeOffer_01();
				offer.getcostofcombined( rid, maintableinfo,workflowid);
				sql ="update formtable_main_"+formid+" set OFFER_CATEGORY = TEST_QUOTATION_WAY_FAST where requestid ="+rid;
				rs.executeSql(sql);
			}

			e.writeLog("end");

		} catch (java.lang.Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("OFFER01 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}
