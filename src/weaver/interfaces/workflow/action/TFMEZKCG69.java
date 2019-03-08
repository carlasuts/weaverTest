//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package weaver.interfaces.workflow.action;

import weaver.general.BaseBean;
import weaver.interfaces.sap.OAToSAP_ZKCG69;
import weaver.interfaces.workflowUtil.BillFieldUtil;
import weaver.soa.workflow.request.RequestInfo;

public class TFMEZKCG69 implements Action {

	public String execute(RequestInfo request) {

		try {
			BaseBean e = new BaseBean();

			String rid = request.getRequestid();
			OAToSAP_ZKCG69 zw = new OAToSAP_ZKCG69("ZWEE_MM69", rid, BillFieldUtil.getMainTable(request));
			zw.ZWEE_MM69(BillFieldUtil.getDetailTable(request, 1),request);
			e.writeLog("ZWEE_MM69接口数据处理");
			e.writeLog("end");

		} catch (Exception var11) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("TFMEZKCG69 error:" + var11.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
			request.getRequestManager().setMessageid("Exception");
			request.getRequestManager().setMessagecontent("合并失败，请联系管理员:" + var11.getMessage());
		}

		return Action.SUCCESS;
	}
}
