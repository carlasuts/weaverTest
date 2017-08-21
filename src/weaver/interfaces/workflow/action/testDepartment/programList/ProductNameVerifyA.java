package weaver.interfaces.workflow.action.testDepartment.programList;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.RequestInfo;

public class ProductNameVerifyA implements Action {

	@Override
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			String sql = "";
			String rid = request.getRequestid();// 获取当且流程的id
			String status = "";
			// 获得流程是退回还是提交
			String src = request.getRequestManager().getSrc();
			if (src.equals("submit")) {// 提交流程
				status = "S";
			} else if (src.equals("reject")) {// 流程退回
				status = "E";
			}
			if (status.equals("E")) {
				sql = "UPDATE formtable_main_110 SET XZSQIDH=NULL,XZBBH=NULL,SBIDH=NULL,SBIDBBH=NULL,SCWJ=NULL,BZXX=NULL,CUSTID=NULL,XZDYPMLIST=NULL,SBDYPMLIST=NULL,ZFIDH=NULL,ZFIDBBH=NULL,ZFDYPMLIST=NULL,BFBZ=NULL,SHR=NULL,THBZ=1 where requestid ="
						+ rid;
				baseBean.writeLog("ProductNameVerifyA:" + sql);
				rs.executeSql(sql);
			}
			sql = "SELECT SQR FROM FORMTABLE_MAIN_110";
			rs.execute(sql);
			rs.next();
			String SQR = rs.getString("SQR");
			if (SQR == null || SQR == "") {
				baseBean.writeLog("当期requestId" + rid + "中SQR为空");
//				sql = "DELETE FROM formtable_main_93 where requestid = " + rid;
			}
		} catch (Exception e) {
			request.getRequestManager().setMessageid("404");
			request.getRequestManager().setMessagecontent("系统异常，请联系管理员");
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("ProductNameVerifyA error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}

}
