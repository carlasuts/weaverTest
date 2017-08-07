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

			CInfSpeDatDao cInfSpeDatDao = new CInfSpeDatDao();
			basebean.writeLog("CInfSpeDatDao接口开始执行");
			cInfSpeDatDao.setcinfspedat(request);
			basebean.writeLog("CInfSpeDatDao接口执行结束");
			// MainTableInfo maintableinfo = request.getMainTableInfo();
			// String creator = request.getCreatorid();
			// String rid = request.getRequestid();
			// DetailTable[] detailtable = request.getDetailTableInfo()
			// .getDetailTable();
			// PostTest pt = new PostTest();
			// basebean.writeLog("CInfSpeDatDao接口开始执行");
			// pt.setcinfspedat(detailtable[0], rid, maintableinfo);
			// basebean.writeLog("CInfSpeDatDao接口执行结束");
			basebean.writeLog("**********************************这是一条分割线φ(>ω<*)************************************");

			// basebean.writeLog("CINFPATDAT接口开始执行");
			// pt.setcinfpatdat(detailtable[2], rid, maintableinfo, creator);
			// basebean.writeLog("CINFPATDAT接口执行结束");
			// basebean.writeLog("**********************************这是一条分割线φ(>ω<*)************************************");
			//
			// basebean.writeLog("CINFFLWDAT接口开始执行");
			// pt.setcinfflwdat(detailtable[1], rid, maintableinfo, creator);
			// basebean.writeLog("CINFFLWDAT接口执行结束");
			// basebean.writeLog("**********************************这是一条分割线φ(>ω<*)************************************");
			//
			// basebean.writeLog("CINFBOMDAT接口开始执行");
			// pt.setcinfbomdat(detailtable[2], rid, maintableinfo, creator);
			// basebean.writeLog("CINFBOMDAT接口执行结束");

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
