//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package weaver.interfaces.workflow.action;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.RequestInfo;

public class FSTWF1186WORKCENTER implements Action {
	public FSTWF1186WORKCENTER() {
	}

	public String execute(RequestInfo request) {
		String result = "1";
		try {
			// 日志对象
			BaseBean e = new BaseBean();
			// 获取流程主表信息对象
			MainTableInfo maintableinfo = request.getMainTableInfo();

			String sql = "";

			String rid = request.getRequestid();
			String PackageCode = "";
			Property[] var12 = maintableinfo.getProperty();
			for (int rs = 0; rs < var12.length; ++rs) {
				String name = var12[rs].getName().toUpperCase();
				String value = Util.null2String(var12[rs].getValue());
				if (name.equals("PACKAGEOUTLINE")) {
					PackageCode = value;
					break;
				}
			}

			sql = "select id from formtable_main_78 where requestid='" + rid + "'";
			RecordSet rs = new RecordSet();
			rs.executeSql(sql);
			rs.next();
			String mainId = rs.getString("id");
			sql = "update formtable_main_78_dt2 dt2 set dt2.workcenter=("
					+ "select work_center_fk from MDM_WORK_CENTER_RULE " + "where pkg_outline_fk='" + PackageCode
					+ "' and oper_fk=dt2.oper and rownum=1) " + "where dt2.mainid='" + mainId + "'";
			e.writeLog(sql);
			rs.executeSql(sql);
		} catch (Exception var11) {
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("FSTWF1186WORKCENTER error:" + var11.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}

		return result;
	}
}
