//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package weaver.interfaces.workflow.action;

import weaver.general.BaseBean;
import weaver.interfaces.sap.OAToSAP_ZKCG30;
import weaver.interfaces.workflow.action.Action;
import weaver.interfaces.workflowUtil.BillFieldUtil;
import weaver.soa.workflow.request.RequestInfo;

public class TFMEZKCZ30 implements Action {

	public String execute(RequestInfo request) {

		try {
			BaseBean e = new BaseBean();
			
			e.writeLog("制单接口action开始执行");
 
			String rid = request.getRequestid();
			OAToSAP_ZKCG30 zw = new OAToSAP_ZKCG30("ZWEE_SD30", rid, BillFieldUtil.getMainTable(request));
			zw.ZWEE_SD30(BillFieldUtil.getDetailTable(request, 2), request);
			e.writeLog("ZWEE_MM30接口数据处理");
			e.writeLog("end");

		} catch (Exception var11) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("TFMEZKCZ30 error:" + var11.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
			request.getRequestManager().setMessageid("Exception");
			request.getRequestManager().setMessagecontent("制单失败，请联系管理员:" + var11.getMessage());
		}

		return Action.SUCCESS;
	}
}
