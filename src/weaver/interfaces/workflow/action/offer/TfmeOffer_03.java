package weaver.interfaces.workflow.action.offer;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.util.BillUtil;
import weaver.soa.workflow.request.MainTableInfo;

public class TfmeOffer_03 {
	// 成本合计

	public void getcostofcombined(String rid, MainTableInfo maintableinfo, String workflowid) {

		int formid = BillUtil.getFormId(Integer.parseInt(workflowid));

		BaseBean baseBean = new BaseBean();
		RecordSet rs = new RecordSet();
		baseBean.writeLog("进入接口TfmeOffer03");

		// 组装成本
		// 芯片成本
		String sql = "";
		String mainid = "";// 明细表的 mainid
		sql = "select ID from formtable_main_" + formid + "  where requestid =" + rid;
		baseBean.writeLog("11111111111111");
		rs.executeSql(sql);
		while (rs.next()) {
			mainid = rs.getString("ID");
		}

		sql = "DELETE FROM FORMTABLE_MAIN_" + formid + " DT2 WHERE MAINID = '" + mainid + "'";
		rs = new RecordSet();
		rs.execute(sql);

		sql = "insert into formtable_main_" + formid + "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS) values (" + "'" + mainid
				+ "'," + "'金价波动100$'," + "'0'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);
		sql = "insert into formtable_main_" + formid + "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS) values (" + "'" + mainid
				+ "'," + "'加一个芯片'," + "'0'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);
		sql = "insert into formtable_main_" + formid + "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS) values (" + "'" + mainid
				+ "'," + "'铜价波动100$'," + "'0'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);
		sql = "insert into formtable_main_" + formid + "_dt2 (MAINID,NOTE,SUGGEST,PRINT_STATUS) values (" + "'" + mainid
				+ "'," + "'加一根键合丝'," + "'0'," + "'0'" + ")";
		rs = new RecordSet();
		rs.executeSql(sql);

	}
}
