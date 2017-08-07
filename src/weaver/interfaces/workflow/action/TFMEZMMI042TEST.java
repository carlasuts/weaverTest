package weaver.interfaces.workflow.action;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.*;

import java.text.SimpleDateFormat;
import java.util.*;
import weaver.interfaces.sap.ZMMI042;

public class TFMEZMMI042TEST implements Action {

	@Override
	public String execute(RequestInfo request) {
		String result = "";
		try {
			// 日志对象
			BaseBean e = new BaseBean();
			// 获取流程主表信息对象
			MainTableInfo maintableinfo = request.getMainTableInfo();

			String sql = "";
			Date d = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nd = sf.format(d);
			// 获取流程的请求id
			String rid = request.getRequestid();
			// 获取流程明细表信息对象
			DetailTable[] detailtable = request.getDetailTableInfo().getDetailTable();
			ZMMI042 zm042 = new ZMMI042();
			// 调用sap接口
			zm042.gylx(maintableinfo,rid);
			
			// 如果不想让流程提交
			request.getRequestManager().setMessagecontent("个人资产数量不足");
			request.getRequestManager().setMessageid("1022");
			
		} catch (Exception var11) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("TFMEZMMI042TEST error:" + var11.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return result;
	}

}
