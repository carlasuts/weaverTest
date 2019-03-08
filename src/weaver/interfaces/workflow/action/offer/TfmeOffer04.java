package weaver.interfaces.workflow.action.offer;

import java.text.SimpleDateFormat;
import java.util.Date;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.RequestInfo;

public class TfmeOffer04 implements Action {

	public String execute(RequestInfo request) {

		try {
			//更新报价类别
			BaseBean e = new BaseBean();
			RecordSet rs = new RecordSet();
			String workflowid = request.getWorkflowid();
			int formid =BillUtil.getFormId(Integer.parseInt(workflowid));
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
			String OFFER_CATEGORY="";
			sql ="select  QUOTATION_MODE from formtable_main_"+formid+"_dt1  where mainid =(select id  from formtable_main_"+formid+" where  COST_ELEMENT ='0' and requestid ="+rid+")";
			rs.executeSql(sql);
			while(rs.next()){
				OFFER_CATEGORY =rs.getString("QUOTATION_MODE");
			}
			 sql ="update formtable_main_"+formid+" set OFFER_CATEGORY = "+OFFER_CATEGORY+" where requestid ="+rid;
			 rs.executeSql(sql);
			e.writeLog("end");

		} catch (java.lang.Exception e) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("OFFER error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}
