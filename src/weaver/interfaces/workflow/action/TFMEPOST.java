package weaver.interfaces.workflow.action;

import weaver.general.BaseBean;
import weaver.interfaces.sap.CINFBOMDAT;
import weaver.interfaces.sap.CINFFLWDAT;
import weaver.interfaces.sap.CINFPATDAT;
import weaver.interfaces.sap.CINFSPEDAT;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.RequestInfo;

public class TFMEPOST implements Action {

	@Override
	public String execute(RequestInfo request) {

		BaseBean basebean = new BaseBean();
		try {
			MainTableInfo maintableinfo = request.getMainTableInfo();
			basebean.writeLog("***TFMEPOST开始执行***");
			String creator = request.getCreatorid();
			String rid = request.getRequestid();
			DetailTable[] detailtable = request.getDetailTableInfo().getDetailTable();
			
			basebean.writeLog("CINFSPEDAT接口开始执行");
			CINFSPEDAT spe = new CINFSPEDAT();
			spe.insert(detailtable[0], rid, maintableinfo, creator);
			basebean.writeLog("CINFSPEDAT接口执行结束");
			
			basebean.writeLog("**********************************华丽的分割线************************************");
			
			basebean.writeLog("CINFFLWDAT接口开始执行");
			CINFFLWDAT flw = new CINFFLWDAT();
			flw.setcinfflwdat(detailtable[1], maintableinfo, rid, creator);
			basebean.writeLog("CINFFLWDAT接口执行结束");
			
			basebean.writeLog("**********************************华丽的分割线************************************");
			
			basebean.writeLog("CINFBOMDAT接口开始执行");
			CINFBOMDAT bom = new CINFBOMDAT();
			bom.setcinfbomdat(detailtable[2], rid, maintableinfo, creator);
			basebean.writeLog("CINFBOMDAT接口执行结束");
			
			basebean.writeLog("**********************************华丽的分割线************************************");
			
			basebean.writeLog("CINFPATDAT接口开始执行");
			CINFPATDAT pat = new CINFPATDAT();
			pat.insert(detailtable[2], rid, maintableinfo, creator);
			basebean.writeLog("CINFPATDAT接口执行结束");
			
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
